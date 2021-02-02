//
//  UIViewController+Alert.swift
//  WoozzangMemo
//
//  Created by Woochan Park on 2021/02/02.
//

import UIKit

extension UIViewController {
  func alert (title: String = "알림", message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
  }
}
