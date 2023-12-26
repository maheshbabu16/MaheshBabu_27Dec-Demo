//
//  ImageTextFeildCell.swift
//  MaheshBabu-24Dec
//
//  Created by Mahesh babu on 24/12/23.
//

import UIKit

class ImageTextFeildCell: UITableViewCell {
   
    //MARK: - IB-Outlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var txtFeild: UITextField!
    @IBOutlet weak var buttonVieew: UIView!
    @IBOutlet weak var txtView: UIView!
    
    //MARK: - Outside Variables
    let toolbar = UIToolbar()
    var submitBlockHandler: (() -> Void)?
    //MARK: - Register cell
    static let reUseIdentifier = Constants.TableCellRegister.imageTextFeildCell
    static let nibName = UINib(nibName: ImageTextFeildCell.reUseIdentifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onClickDoneKeyBoard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        self.txtFeild.inputAccessoryView = toolbar
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func onClickDoneKeyBoard() {
        self.endEditing(true)
    }
    
    
    @IBAction func onClickSubmit(_ sender: Any) {
        self.onClickDoneKeyBoard()
        self.submitBlockHandler?()
    }
}
