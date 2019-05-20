//
//  RootVC.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit
import CountryPicker

class RootVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var countryPickerView: UIView?
    @IBOutlet weak var countryPicker: CountryPicker?
    @IBOutlet weak var downloadVideoListManager: DownloadVideoListProtocol?
    @IBOutlet weak var infoVideoObject: InfoVideoObject?
    
    //MARK: Constants
    let countResultVideo = 10
    
    //MARK: Variables
    var currentCountryName = "Ukraine"
    var currentCountryCode = "UA"
    var countVideosInList = 0
    var videoObjects: [VideoObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNavBar()
        setTableView()
        setCountryPicker()
        getVideoList()
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
    
    private func getVideoList() {
        downloadVideoListManager?.downloadVideoList(params: [
            "part": "snippet",
            "maxResults": countResultVideo,
            "regionCode": currentCountryCode,
            "order": "viewCount",
            "type": "video",
            "key": Constants.API.apiKey])
        { (success, error) in
            if success {
                guard let videoList = self.downloadVideoListManager?.videolist else { return }
                self.countVideosInList = videoList.count
                self.videoObjects.removeAll()
                for video in videoList {
                    self.getVideoById(videoId: video.id.videoID)
                }
            } else {
                UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
            }
        }
    }
    
    func updateSearchVideoList(videoList items: [Item]) {
        //        videoList = items
        //        self.videoList.removeAll()
        //        for item in items {
        //            print(item)
        // If any property is absent, then complete the current iteration.
        //            self.getVideoById(videoId: item.id.videoID)
        //        }
    }
    
    func getVideoById(videoId: String) {
        ServerAPIManager.getVideosById(
            params: ["part": "snippet,contentDetails,statistics",
                     "id" : videoId,
                     "key": Constants.API.apiKey
            ])
        { (result, success, error) in
            if success, let videoInfo = result as? VideoModel {
                // Create an object that contains video properties.
                //                    guard let videoObject = VideoObject(with: videoInfo) else { return }
                self.videoObjects.append(VideoObject(with: videoInfo))
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            } else {
                UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
            }
        }
    }
    
    //    func reloadTableView() {
    //        // Sort video by the number of views.
    //        self.videoObjects = self.videoObjects.sorted {$0.viewsCount > $1.viewsCount}
    //        self.tableView?.reloadData()
    //    }
    
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
        //        downloadViedoList(params: [
        //            "part": "snippet",
        //            "maxResults": countResultVideo,
        //            "regionCode": currentCountryCode,
        //            "order": "viewCount",
        //            "type": "video",
        //            "key": Constants.API.apiKey])
    }
}
