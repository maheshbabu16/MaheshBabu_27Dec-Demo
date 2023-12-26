//
//  ImageHomeViewModel.swift
//  MaheshBabu-24Dec
//
//  Created by Mahesh babu on 24/12/23.
//

import Foundation
import UIKit
import Network

class ImageHomeViewModel: NSObject {
    
    enum RowType: Int, CaseIterable {
        case textFeild = 0
        case imagesRow = 1
        
    }
    
    //MARK: - OutSide Variables
    var objImageVc: ImageHomeVC? { didSet { self.setUpUI() } }
    var refreshControl:UIRefreshControl!
    var isPullToRefreseh: Bool = false
    var arrImageList:[ImageModelClass] = []
    var arrImages :[ImageData] = []
    let monitor = NWPathMonitor()
    var placeHolderValue: String?
    
    //MARK: - Functions
    
    func checkNetworkConnection() {
        
        self.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied{
                print("Connected")
            }else{
                let msgM = Constants.TextStrings.self
                
                DispatchQueue.main.async {
                    self.showAlert(strMessage: msgM.networkError,
                                   strTitle: msgM.connectionLostTitle,
                                   strBtnTitle: msgM.ok
                    )}
                
                print("Connection Failed")
            }
            
            print(path.isExpensive)
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    func setUpUI(){
        if !(placeHolderValue == nil){
            if let intPlaceHolder = Int(placeHolderValue ?? "0"){
                self.apiCall(inputNumber: intPlaceHolder)
            }
            
        }
       
            self.checkNetworkConnection()
        
        if refreshControl == nil{
            refreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: "")
            refreshControl.tintColor = UIColor.textColor
            refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
            objImageVc?.tblImageList.addSubview(refreshControl)
        }
                
        objImageVc?.tblImageList.delegate = self
        objImageVc?.tblImageList.dataSource = self
        objImageVc?.tblImageList.register(ImageTextFeildCell.nibName, forCellReuseIdentifier: ImageTextFeildCell.reUseIdentifier)
        
    }
    
    //MARK: - Pull to refresh
    @objc func refresh(_ sender:AnyObject)
    {
        isPullToRefreseh = true
        self.checkNetworkConnection()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.objImageVc?.tblImageList.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func showAlert(strMessage: String?, strTitle:String?, strBtnTitle: String?){
        
        let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: strBtnTitle, style: UIAlertAction.Style.destructive, handler: nil))
        objImageVc?.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - API Calling
    func apiCall(inputNumber: Int?){
        
        guard let paramNumber = inputNumber , paramNumber >= 0 else { return }
        debugPrint(paramNumber)
        
        let urlString = Constants.API.apiUrl + "size=\(paramNumber)"
        guard let url = URL(string: urlString )  else{ return }
        
        let decoder = JSONDecoder()
        let request = URLRequest(url: url)
        
        self.objImageVc?.activityIndicator?.startAnimating()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }
            else{
                
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Response String: \(responseString ?? Constants.TextStrings.apiErrorMessage)")
                    
                    do {
                        let result = try decoder.decode([ImageModelClass].self, from: data)
                        print(result)
                        if result[0].status == 1{
                            
                            self.arrImageList = result
                            self.arrImages = result[0].data
                            
                            DispatchQueue.main.async {
                                self.objImageVc?.tblImageList.reloadData()
                            }
                        }
                        
                        
                    } catch {
                        print("<----------\(urlString)---------->")
                        print("Decoding error: \(error.localizedDescription)")
                    }
                }

            }
            
            DispatchQueue.main.async {
                self.objImageVc?.activityIndicator?.stopAnimating()
                self.objImageVc?.activityIndicator?.hidesWhenStopped = true
            }
            
        }.resume()
        
    }
    func navigateToSecondScreen(strNumberInput: Int) {

        guard let vc = Constants.Storyboards.main.instantiateViewController(identifier: "ImageDetailVC") as? ImageDetailVC else { return }
        
        vc.buttonNumber = strNumberInput
        
        vc.imageBlockHandler = {
            if let strPlaceHolder =  vc.buttonValue {
                self.placeHolderValue = "\(strPlaceHolder)"
            }
            self.objImageVc?.tblImageList.reloadData()
        }
         objImageVc?.navigationController?.pushViewController(vc, animated: true)
    }

    
}


//MARK: - TableView Meathods
extension ImageHomeViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = RowType(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch rowType {
        case .textFeild:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ImageTextFeildCell.reUseIdentifier, for: indexPath) as? ImageTextFeildCell {
               
                
                if let strText = placeHolderValue{
                    if (strText.isEmpty) {
                        cell.txtFeild.placeholder = Constants.TextStrings.placeHolderText
                    } else {
                        let newStrText = "\(Constants.TextStrings.buttonInfo) \(strText)"
                        cell.txtFeild.placeholder = newStrText
                    }
                }
                
                cell.submitBlockHandler = {
                    
                    if !(cell.txtFeild.text == ""){
                        if let inputDigit = Int(cell.txtFeild.text ?? "") {
                            self.navigateToSecondScreen(strNumberInput: inputDigit)
                            cell.txtFeild.text = ""
                        }
                    } else {
                        let txtMsg = Constants.TextStrings.self
                        self.showAlert(strMessage: txtMsg.inputErrorText, strTitle: txtMsg.alert, strBtnTitle: txtMsg.ok)
                        
                    }
                }
                
                cell.txtFeild.keyboardType = .numberPad
                cell.lblTitle.text = Constants.TextStrings.placeHolderText
                cell.lblTitle.font = Constants.Fonts.headerLabelFont
                cell.btnGo.layer.cornerRadius = cell.btnGo.frame.height / 2
                cell.btnGo.backgroundColor = UIColor.textFeildColor
                cell.txtFeild.backgroundColor = UIColor.clear
                cell.txtView.layer.cornerRadius  = cell.txtView.frame.height / 2
                cell.txtView.backgroundColor = UIColor.textFeildColor
                return cell
            }
        break
            
        case .imagesRow:
            break
            
        }
        return UITableViewCell()
    }
    
}
    
