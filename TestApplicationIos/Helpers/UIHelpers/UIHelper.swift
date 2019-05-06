//
//  UIHelper.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 06/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit

class UIHelper {
    
    class func showConfirmationAlertWith(title: String?,
                                         message: String?,
                                         action: (() -> ())? = nil,
                                         inViewController viewController: UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { (alertAction) in
                                        action?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
