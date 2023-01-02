//
//  GameVC.swift
//  LeadSdoit
//
//  Created by Илья Петров on 01.01.2023.
//

import UIKit

final class GameVC: UIViewController, StoryboardInstantiable  {
    
    //MARK: - Outlets
    @IBOutlet private var backHomeButton: UIButton!
    @IBOutlet private var spinButton: UIButton!
    @IBOutlet private var decreaseBet: UIButton!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var increaseBet: UIButton!
    @IBOutlet private var bankBalanceLable: UILabel!
    @IBOutlet private var currentBetLabel: UILabel!
    
    //MARK: - Properties
    var slotImages = [UIImage]()
    var bankBalance = 0
    private var currentBet = 50
    private var cellIdentifier = "SlotCellCollectionViewCell"
    public var onBankBalance: ((Int) -> Void)?
    
    //MARK: -Actions
    @IBAction private func increaseBetAction(_ sender: Any) {
        increaseBet(amount: 10)
    }
    @IBAction private func decreaseBetAction(_ sender: Any) {
        decreaseBet(amount: 10)
    }
    @IBAction private func spinButtonAction(_ sender: Any) {
        if bankBalance == 0 {
            createAlertNotMoney()
            
        } else if bankBalance >= currentBet {
            placeBet(amount: currentBet)
            bankBalanceLable.text = "\(bankBalance)"
            onBankBalance?(bankBalance)
            collectionView.reloadData()
            
        } else {
            createAlertNotMoney()
        }
    }
    @IBAction private func backHomeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setupCollection()
    }
    
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        createViews()
    }
    
    private func createViews() {
        currentBetLabel.text = "\(currentBet)"
        bankBalanceLable.text = "\(bankBalance)"
                
        currentBetLabel.layer.cornerRadius = 3
        currentBetLabel.layer.borderWidth = 1
        currentBetLabel.layer.borderColor = UIColor(red: 0.918, green: 0.255, blue: 0.255, alpha: 1).cgColor
        
        decreaseBet.layer.cornerRadius = 3
        decreaseBet.layer.borderWidth = 1
        decreaseBet.layer.borderColor = UIColor(red: 0.918, green: 0.255, blue: 0.255, alpha: 1).cgColor
        
        increaseBet.layer.cornerRadius = 3
        increaseBet.layer.borderWidth = 1
        increaseBet.layer.borderColor = UIColor(red: 0.918, green: 0.255, blue: 0.255, alpha: 1).cgColor
    }

    private func placeBet(amount: Int) {
        if amount <= bankBalance {
            currentBet = amount
            bankBalance -= amount
        } else {
            createAlertNotMoney()
        }
    }
    
    private func decreaseBet(amount: Int) {
        if currentBet - amount >= 10 {
            currentBet -= amount
        } else {
            currentBet = 10
        }
        currentBetLabel.text = "\(currentBet)"
    }
    
    private func increaseBet(amount: Int) {
        if currentBet + amount <= bankBalance {
            currentBet += amount
        } else {
            currentBet = bankBalance
        }
        currentBetLabel.text = "\(currentBet)"
    }
    
    
    private func createAlertNotMoney() {
        let alert = UIAlertController(title: "Not enough money", message: "You don't have enough money on your balance sheet", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: { _ in
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return [.landscapeLeft, .landscapeRight]
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeLeft, .landscapeRight]
    }
   
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension GameVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SlotCellCollectionViewCell
        
        let randomIndex = Int.random(in: 0..<slotImages.count)
        let slotImage = slotImages[randomIndex]

        cell.setupWith(image: slotImage)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GameVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.105, height: UIScreen.main.bounds.width * 0.105)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionViewr: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
