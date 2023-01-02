//
//  ViewController.swift
//  LeadSdoit
//
//  Created by Илья Петров on 01.01.2023.
//

import UIKit

final class ViewController: UIViewController {

    //MARK: -Outlets
    @IBOutlet private var starFairyButton: UIButton!
    @IBOutlet private var lightningButton: UIButton!
    @IBOutlet private var candleButton: UIButton!
    @IBOutlet private var popularView: UIView!
    @IBOutlet private var allGamesView: UIView!
    @IBOutlet private var lineTitlePopularImageView: UIImageView!
    @IBOutlet private var lineTitleAllGamesImageView: UIImageView!
    @IBOutlet private var popularLable: UILabel!
    @IBOutlet private var allGamesLable: UILabel!
    @IBOutlet private var coinsLable: UILabel!
    
    //MARK: - Properties
    private var bankBalance = 1000
    
    private let slotImagesFairy = [UIImage(named: "FairySlotspack1"), UIImage(named: "FairySlotspack2"), UIImage(named: "FairySlotspack3"), UIImage(named: "FairySlotspack4"), UIImage(named: "FairySlotspack5"), UIImage(named: "FairySlotspack6"), UIImage(named: "FairySlotspack7"), UIImage(named: "FairySlotspack8"), UIImage(named: "FairySlotspack9")]
    
    private let slotImagesLightning = [UIImage(named: "LightningSlotspack1"), UIImage(named: "LightningSlotspack2"), UIImage(named: "LightningSlotspack3"), UIImage(named: "LightningSlotspack4"), UIImage(named: "LightningSlotspack5"), UIImage(named: "LightningSlotspack6"), UIImage(named: "LightningSlotspack7"), UIImage(named: "LightningSlotspack8"), UIImage(named: "LightningSlotspack9")]
    
    private let slotImagesСandle = [UIImage(named: "СandleSlotspack1"), UIImage(named: "СandleSlotspack2"), UIImage(named: "СandleSlotspack3"), UIImage(named: "СandleSlotspack4"), UIImage(named: "СandleSlotspack5"), UIImage(named: "СandleSlotspack6"), UIImage(named: "СandleSlotspack7"), UIImage(named: "СandleSlotspack8"), UIImage(named: "СandleSlotspack9")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
    }
    
    private func createViews() {
        let tapRecognizerPopularView = UITapGestureRecognizer(target: self, action: #selector(popularViewAction))
        popularView.addGestureRecognizer(tapRecognizerPopularView)
        
        let tapRecognizerAllGamesView = UITapGestureRecognizer(target: self, action: #selector(allGamesViewAction))
        allGamesView.addGestureRecognizer(tapRecognizerAllGamesView)
        
        coinsLable.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coinsLable.text = "\(Int(bankBalance))"
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return [.portrait]
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return [.portrait]
    }

    @IBAction private func starFairyButtonAction(_ sender: Any) {
        let gameVC = GameVC.instantiateFromStoryboard()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.modalTransitionStyle = .coverVertical
        gameVC.slotImages = slotImagesFairy as! [UIImage]
        gameVC.bankBalance = bankBalance
        gameVC.onBankBalance =  { [weak self] valueBankBalance in
            guard let self = self else { return }
            self.bankBalance = valueBankBalance
        }
        present(gameVC, animated: true, completion: nil)
    }
    
    @IBAction private func lightningButtonAction(_ sender: Any) {
        let gameVC = GameVC.instantiateFromStoryboard()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.modalTransitionStyle = .coverVertical
        gameVC.slotImages = slotImagesLightning as! [UIImage]
        gameVC.bankBalance = bankBalance
        gameVC.onBankBalance =  { [weak self] valueBankBalance in
            guard let self = self else { return }
            self.bankBalance = valueBankBalance
        }
        present(gameVC, animated: true, completion: nil)
    }
    
    @IBAction private func candleButtonAction(_ sender: Any) {
        let gameVC = GameVC.instantiateFromStoryboard()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.modalTransitionStyle = .coverVertical
        gameVC.slotImages = slotImagesСandle as! [UIImage]
        gameVC.bankBalance = bankBalance
        gameVC.onBankBalance =  { [weak self] valueBankBalance in
            guard let self = self else { return }
            self.bankBalance = valueBankBalance
        }
        present(gameVC, animated: true, completion: nil)
    }
    
    
    @objc private func popularViewAction() {
        popularLable.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        allGamesLable.textColor = UIColor(red: 0.443, green: 0.439, blue: 0.463, alpha: 1)
        
        popularLable.font = .boldSystemFont(ofSize: 20)
        allGamesLable.font = .systemFont(ofSize: 20)
        
        lineTitlePopularImageView.isHidden = false
        lineTitleAllGamesImageView.isHidden = true
        
        starFairyButton.isHidden = false
        lightningButton.isHidden = true
        candleButton.isHidden = true
    }
    
    @objc private func allGamesViewAction() {
        allGamesLable.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        popularLable.textColor = UIColor(red: 0.443, green: 0.439, blue: 0.463, alpha: 1)
        
        lineTitlePopularImageView.isHidden = true
        lineTitleAllGamesImageView.isHidden = false
        
        popularLable.font = .systemFont(ofSize: 20)
        allGamesLable.font = .boldSystemFont(ofSize: 20)
        
        starFairyButton.isHidden = false
        lightningButton.isHidden = false
        candleButton.isHidden = false
    }
}

