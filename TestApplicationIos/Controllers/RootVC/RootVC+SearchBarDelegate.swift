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
        let params = VideoListRequest(
            maxResults: countResultVideo,
            regionCode: currentCountryCode,
            q: "")
        if !searchText.isEmpty {
            params.q = searchText
//            params["q"] = searchText
            getVideoList(params: params)
        } else {
            params.q = nil
//            params["q"] = nil
            getVideoList(params: params)
        }
    }
}
