//
//  ImageDetailViewModel.swift
//  MaheshBabu-24Dec
//
//  Created by Mahesh babu on 24/12/23.
//

import Foundation
import UIKit

class ImageDetailViewModel: NSObject {
    
    //MARK: - OutSide Variables
    var objDetailVc: ImageDetailVC? { didSet { self.setUpUI() } }
    
    func setUpUI(){
        objDetailVc?.btnBack.backgroundColor = UIColor.textFeildColor
        objDetailVc?.btnBack.layer.cornerRadius = (objDetailVc?.btnBack.frame.size.height ?? 40) / 2
        objDetailVc?.lblHeaderTitle.text = Constants.TextStrings.backTitle
        
        objDetailVc?.btnCollectionView.delegate = self
        objDetailVc?.btnCollectionView.dataSource = self
        
        objDetailVc?.btnCollectionView.register(ButtonCollectionCell.nibName, forCellWithReuseIdentifier: ButtonCollectionCell.reUseIdentifier)
        
    }
    
   
}
extension ImageDetailViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numberObj = objDetailVc?.buttonNumber {
            return numberObj
        } else { return 0}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionCell.reUseIdentifier, for: indexPath) as? ButtonCollectionCell {
            
            let btnSize = (cell.frame.size.height - 20) / 2
            let buttonNumber = indexPath.row + 1
            let btnTitleNew = ("Button \(buttonNumber)")
            
            cell.btnNew.layer.cornerRadius = btnSize
            cell.btnNew.setTitle(btnTitleNew, for: .normal)
            cell.btnNew.titleLabel?.font = Constants.Fonts.btnTextFont
            cell.btnNew.titleLabel?.textColor = UIColor.textColor
            cell.btnBlockHandler = {
                self.objDetailVc?.buttonValue = buttonNumber
                self.objDetailVc?.imageBlockHandler?()
                self.objDetailVc?.navigationController?.popViewController(animated: true)

            }
            
            return cell
        }

        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width) / 3
        return CGSize(width: size, height: size)
    }
}
