//
//  RootVC.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit
import CountryPicker

final class RootVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var countryPickerView: UIView?
    @IBOutlet weak var countryPicker: CountryPicker?
    @IBOutlet weak var downloadVideoListContainer: DownloadVideoListProtocol?
    @IBOutlet weak var videoInfoContainer: InfoVideoProtocol?
    
    //MARK: Constants
    let countResultVideo = 10
    
    //MARK: Variables
    var currentCountryName = "Ukraine"
    var currentCountryCode = "UA"
    var countVideosInList = 0
    var videoObjects: [VideoObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        setTitleNavBar()
        setTableView()
        setCountryPicker()
        setVideoList()
    }
    
    private func setTitleNavBar() {
        navigationItem.title = currentCountryName
    }
    
    private func setTableView() {
        tableView?.register(UINib(nibName: "RootTableViewCell", bundle: nil), forCellReuseIdentifier: "RootTableViewCell")
    }
    
    private func setCountryPicker() {
        let locale = Locale.current
        guard let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as! String? else { return }
        countryPicker?.countryPickerDelegate = self
        countryPicker?.showPhoneNumbers = false
        countryPicker?.setCountry(code)
    }
    
    private func setVideoList() {
        getVideoList(params: ["part": "snippet",
                              "maxResults": countResultVideo,
                              "regionCode": currentCountryCode,
                              "order": "viewCount",
                              "type": "video",
                              "key": Constants.API.apiKey ?? ""])
    }
    
    func getVideoList(params: [String: Any]) {
        downloadVideoListContainer?.downloadVideoList(params: params)
        { (success, relust, error)  in
            if success, let videoList = relust as? VideoListModel {
                self.countVideosInList = videoList.items.count
                self.updateSearchVideoList(videoList: videoList.items)
            } else {
                UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
            }
        }
    }
    
    func updateSearchVideoList(videoList items: [Item]) {
        self.videoObjects.removeAll()
        for item in items {
            // If any property is absent, then complete the current iteration.
            self.getVideoById(videoId: item.id.videoID)
        }
    }
    
    func getVideoById(videoId: String) {
        ServerAPIManager.getVideosById(
            params: ["part": "snippet,contentDetails,statistics",
                     "id" : videoId,
                     "key": Constants.API.apiKey ?? ""
            ])
        { (result, success, error) in
            if success, let videoInfo = result as? VideoInfoModel {
                // Create an object that contains video properties.
                //                    guard let videoObject = VideoObject(with: videoInfo) else { return }
                self.videoObjects.append(VideoObject(with: videoInfo))
                self.videoObjects = self.videoObjects.sorted {$0.viewsCount > $1.viewsCount}
                self.tableView?.reloadData()
            } else {
                UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
            }
        }
    }
    
    //MARK: Actions
    @IBAction func selectCountryAction(_ sender: Any) {
        countryPickerView?.isHidden = false
        setCountryPicker()
    }
    
    @IBAction func cancelToolBarAction(_ sender: Any) {
        countryPickerView?.isHidden = true
    }
    
    @IBAction func doneToolBarAction(_ sender: Any) {
        countryPickerView?.isHidden = true
        setTitleNavBar()
        getVideoList(params: [
                    "part": "snippet",
                    "maxResults": countResultVideo,
                    "regionCode": currentCountryCode,
                    "order": "viewCount",
                    "type": "video",
                    "key": Constants.API.apiKey ?? ""])
    }
}
