//
//  Constants.swift
//  MaheshBabu-24Dec
//
//  Created by Mahesh babu on 24/12/23.
//

import Foundation
import UIKit

class Constants{
    
    //MARK: - Constant + Stroyboard
    
    struct Storyboards {
        static let main = UIStoryboard(name: "Main", bundle: nil)
    }
    
    struct API {
        static let apiUrl = "http://staging-server.in/android-task/api.php?"
    }
    
    struct TableCellRegister {
        static let imageTextFeildCell = "ImageTextFeildCell"
    }
    struct CollCellRegister {
        static let buttonCollectionCell = "ButtonCollectionCell"
    }
    
    //MARK: - Constant + Text
    
    struct TextStrings {
        static let showMore         =  "Show More"
        static let welcomeText      =  "Welcome"
        static let apiErrorMessage  =  "Unable to convert data to string"
        static let apiErrorText     =  "Something went wrong"
        static let apiLoadingText   =  "Loading..."
        static let placeHolderText  =  "Enter a number"
        static let inputErrorText   =  "Please input a number"
        static let ok               =  "Ok"
        static let alert            =  "Alert"
        static let networkError     =  "Please check your connection and try again."
        static let connectionLostTitle =  "Connection Lost"
        static let backTitle         =  "Back"
        static let buttonInfo        =  "You have clicked button"
    }
    
    //MARK: - Constant + Fonts
    
    struct Fonts {
        static let textHeaderFont   =   UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let btnTextFont      =   UIFont.systemFont(ofSize: 14, weight: .bold)
        static let headerLabelFont  =   UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
}

   //MARK: - Constant + UI Color Extensions

extension UIColor{
    
    static let textColor            =   UIColor(named: "textColor")
    static let pineGreen            =   UIColor(named: "pineColor")
    static let darkBlue             =   UIColor(named: "newBlue")
    static let pineBlueClr          =   UIColor(named: "pineBlue")
    static let limeGreenClr         =   UIColor(named: "limeGreen")
    static let textFeildColor       =   UIColor(named: "textColor")?.withAlphaComponent(0.15)
    
}
