//
//  RootVC+CountryPickerDelegate.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 06/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit
import CountryPicker

extension RootVC: CountryPickerDelegate {
    
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        currentCountryName = name
        currentCountryCode = countryCode
    }
}
