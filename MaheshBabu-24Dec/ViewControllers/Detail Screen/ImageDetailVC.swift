//
//  ImageDetailVC.swift
//  MaheshBabu-24Dec
//
//  Created by Mahesh babu on 24/12/23.
//

import UIKit

class ImageDetailVC: UIViewController {
  
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var btnCollectionView: UICollectionView!
    @IBOutlet weak var btnBack: UIButton!
    
    var buttonNumber: Int?
    var buttonValue: Int?
    let objImageDetail = ImageDetailViewModel()
    var imageBlockHandler:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objImageDetail.objDetailVc = self
        self.navigationController?.navigationBar.isHidden = true
        
    }
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
