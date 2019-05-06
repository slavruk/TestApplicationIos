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
    
    //MARK: Constants
    let countResultVideo = 10
    
    //MARK: Variables
    var currentCountryName = "Ukraine"
    var currentCountryCode = "UA"
    var videoObjects: [VideoObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNavBar()
        setTableView()
        setCountryPicker()
        downloadViedoList(params: [
            "part": "snippet",
            "maxResults": countResultVideo,
            "regionCode": currentCountryCode,
            "order": "viewCount",
            "type": "video",
            "key": Constants.API.apiKey])
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
    
    /*
     Gets a list of videos according to the search criteria.
     */
    func downloadViedoList(params: [String: Any]) {
        LSActivityIndicator.showIndicator(fullScreen: false)
        ServerAPIManager.getVideosList(
            params: params)
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
                self.videoObjects.removeAll()
                for item in videoList.items {
                    // If any property is absent, then complete the current iteration.
                    self.getVideoById(videoId: item.id.videoID)
                }
            } else {
                UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
            }
        }
    }
    
    private func getVideoById(videoId: String) {
        ServerAPIManager.getVideosById(
            params: ["part": "snippet,contentDetails,statistics",
                     "id" : videoId,
                     "key": Constants.API.apiKey
            ])
        { (result, success, error) in
            if success, let video = result as? VideoModel {
                guard
                    let videoId = video.items?[0].id,
                    let imageUrl = video.items?[0].snippet.thumbnails.maxres?.url,
                    let title = video.items?[0].snippet.title,
                    let duration = video.items?[0].contentDetails.duration,
                    let viewsCount = Int(video.items?[0].statistics?.viewCount ?? "0"),
                    let datePublished = video.items?[0].snippet.publishedAt
                    else { return }
                // Create an object that contains video properties.
                let videoObject = VideoObject(viedoId: videoId, imageUrl: imageUrl , title: title , duration: duration, viewsCount: viewsCount , datePublished: datePublished )
                self.videoObjects.append(videoObject)
                DispatchQueue.main.async {
                    self.reloadTableView()
                }
                
            } else {
                UIHelper.showConfirmationAlertWith(title: "Error", message: error, action: nil, inViewController: self)
            }
        }
    }
    
    private func reloadTableView() {
        // Sort video by the number of views.
        self.videoObjects = self.videoObjects.sorted {$0.viewsCount > $1.viewsCount}
        self.tableView?.reloadData()
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
        downloadViedoList(params: [
            "part": "snippet",
            "maxResults": countResultVideo,
            "regionCode": currentCountryCode,
            "order": "viewCount",
            "type": "video",
            "key": Constants.API.apiKey])
    }
}
