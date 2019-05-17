//
//  RootVC+SearchBarDelegate.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 06/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit

extension RootVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var params: [String : Any] = [
            "part": "snippet",
            "maxResults": countResultVideo,
            "regionCode": currentCountryCode,
            "order": "viewCount",
            "type": "video",
            "key": Constants.API.apiKey]
//        if !searchText.isEmpty {
//            params["q"] = searchText
//            downloadViedoList(params: params)
//        } else {
//            params["q"] = nil
//            downloadViedoList(params: params)
//        }
    }
}
