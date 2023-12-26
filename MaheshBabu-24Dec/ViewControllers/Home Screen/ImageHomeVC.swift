//
//  ImageHomeVC.swift
//  MaheshBabu-24Dec
//
//  Created by Mahesh babu on 24/12/23.
//

import UIKit

class ImageHomeVC: UIViewController {
    
    //MARK: - IB-Outlets
    @IBOutlet weak var topHeaderLabel: UILabel!
    @IBOutlet weak var tblImageList: UITableView!
    
    
    //MARK: - Outside Variables
    
    let objImageViewModel = ImageHomeViewModel()
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        objImageViewModel.objImageVc = self

    }
   

}
