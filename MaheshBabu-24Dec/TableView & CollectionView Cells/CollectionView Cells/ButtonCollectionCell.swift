//
//  ButtonCollectionCell.swift
//  MaheshBabu-24Dec
//
//  Created by Mahesh babu on 25/12/23.
//

import UIKit

class ButtonCollectionCell: UICollectionViewCell {

    //MARK: - IB-Outlets

    @IBOutlet weak var btnNew: UIButton!
    
    //MARK: - Outside Variables
    var btnBlockHandler: (() -> Void)?
    
    //MARK: - Register cell
    static let reUseIdentifier = Constants.CollCellRegister.buttonCollectionCell
    static let nibName = UINib(nibName: ButtonCollectionCell.reUseIdentifier, bundle: nil)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onClickButton(_ sender: Any) {
        self.btnBlockHandler?()
    }
}
