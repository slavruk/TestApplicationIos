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
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var countryPickerView: UIView?
    @IBOutlet weak var countryPicker: CountryPicker?
    
    //MARK: Constants
    private let countResultVideo = 10
    
    //MARK: Variables
    var currentCountryName = "Ukraine"
    var currentCountryCode = "UA"
    var videoObjects: [VideoObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNavBar()
        setTableView()
        downloadViedoList()
        setCountryPicker()
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
    private func downloadViedoList() {
        LSActivityIndicator.showIndicator(fullScreen: true)
        ServerAPIManager.getVideosList(
            params: ["part": "snippet,contentDetails,statistics",
                     "chart": "mostPopular",
                     "maxResults": countResultVideo,
                     "regionCode": currentCountryCode,
                     "key": Constants.API.apiKey
            ])
        { (result, success, error) in
            LSActivityIndicator.hideIndicator()
            if success, let videoList = result as? VideoListModel {
                self.videoObjects.removeAll()
                for item in videoList.items ?? [] {
                    // If any property is absent, then complete the current iteration.
                    guard
                        let videoId = item.id,
                        let imageUrl = item.snippet?.thumbnails?.maxres?.url,
                        let title = item.snippet?.title,
                        let duration = item.contentDetails?.duration,
                        let viewsCount = Int(item.statistics?.viewCount ?? "0"),
                        let datePublished = item.snippet?.publishedAt
                        else { continue }
                    // Create an object that contains video properties.
                    let videoObject = VideoObject(viedoId: videoId, imageUrl: imageUrl, title: title, duration: duration, viewsCount: viewsCount, datePublished: datePublished)
                    self.videoObjects.append(videoObject)
                }
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
        downloadViedoList()
    }
}
