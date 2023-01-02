//
//  SlotCellCollectionViewCell.swift
//  LeadSdoit
//
//  Created by Илья Петров on 01.01.2023.
//

import UIKit

final class SlotCellCollectionViewCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var slotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWith(image: UIImage) {
        slotImageView.image = image
    }
}
