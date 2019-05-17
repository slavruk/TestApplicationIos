//
//  RootVC+UITableViewDelegate.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 04/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit

extension RootVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootTableViewCell", for: indexPath) as! RootTableViewCell
        cell.selectionStyle = .none
//        if videoObjects.count > indexPath.row {
//            cell.videoObject = videoObjects[indexPath.row]
//            cell.configure()
//        }
        return cell
    }
}
