//
//  RootVC.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 03/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit
import CountryPicker
import PromiseKit

protocol RootVCProtocol {
    var videoObjects: [VideoObject] { get }
    var countVideosInList: Int { get }
    func getVideoList(params: VideoListRequest)
    func getVideoById(videoId: String)
    func updateSearchVideoList(videoList items: [Item])
}

extension Item {
    func getVideo(from container: InfoVideoProtocol) -> Promise<VideoInfoModel> {
        return container.getVideoById(requestURL: Constants.API.getVideoById, params: VideoInfoRequest(id: id.videoID))
    }
}

extension VideoListRequest {
    func downloadVideoList(from container: VideoListProtocol) -> Promise<VideoListModel> {
        return container.downloadVideoList(requestURL: Constants.API.searchViedos, params: self)
    }
}

final class RootVC: UIViewController, RootVCProtocol {
    
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var countryPickerView: UIView?
    @IBOutlet weak var countryPicker: CountryPicker?
    
    var videoListContainer: VideoListProtocol?
    var videoInfoContainer: InfoVideoProtocol?
    
    //MARK: Constants
    let countResultVideo = 10
    
    //MARK: Variables
    var currentCountryName = "Ukraine"
    var currentCountryCode = "UA"
    var countVideosInList = 0
    var videoObjects: [VideoObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoListContainer = VideoListContainer()
        videoInfoContainer = VideoInfoContainer()
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
        getVideoList(params: VideoListRequest(
            maxResults: countResultVideo,
            regionCode: currentCountryCode,
            q: ""))
    }
    
    func getVideoList(params: VideoListRequest) {
        guard let infoContainer = videoInfoContainer else { return }
        guard let listContainer = videoListContainer else { return }
        params.downloadVideoList(from: listContainer).then {
            when(fulfilled: $0.items.map { $0.getVideo(from: infoContainer) })
        }.done { a in
            self.videoObjects = a.map { VideoObject(with: $0) }
            self.videoObjects.sort { $0.viewsCount > $1.viewsCount }
            self.tableView?.reloadData()
        }.catch { error in
            UIHelper.showConfirmationAlertWith(title: "Error", message: error.localizedDescription, inViewController: self)
        }
    }
    
//    func getVideoList(params: VideoListRequest) {
//        guard let infoContainer = videoInfoContainer else { return }
//        guard let listContainer = videoListContainer else { return }
//        listContainer.downloadVideoList(requestURL: Constants.API.searchViedos, params: params).done { (videoList: VideoListModel) in
//            let a = videoList.items.map { infoContainer.getVideoById(requestURL: Constants.API.getVideoById, params: VideoInfoRequest(id: $0.id.videoID)) }
//            when(fulfilled: a).done { a in
//                print(a)
//                self.videoObjects = a.map{ VideoObject(with: $0) }
//                self.videoObjects.sort { $0.viewsCount > $1.viewsCount }
//                self.tableView?.reloadData()
//            }.catch { error in
//                UIHelper.showConfirmationAlertWith(title: "Error", message: error.localizedDescription, inViewController: self)
//            }
////            when(resolved: a).done { a in
////                self.videoObjects = a.map{$0.}
////            }
////            when(resolved: )// self.getVideoById(videoId: item.id.videoID))
//        }.catch { error in
//            UIHelper.showConfirmationAlertWith(title: "Error", message: error.localizedDescription, inViewController: self)
//        }
//
//
//
////        videoListContainer?.downloadVideoList(requestURL: Constants.API.searchViedos, params: params)
////            .done { videoList in
////                self.updateSearchVideoList(videoList: videoList.items)
////            }.catch { error in
////                UIHelper.showConfirmationAlertWith(title: "Error", message: error.localizedDescription, inViewController: self)
////        }
//    }

    func updateSearchVideoList(videoList items: [Item]) {
        self.videoObjects.removeAll()
        for item in items {
            // If any property is absent, then complete the current iteration.
            self.getVideoById(videoId: item.id.videoID)
        }
    }
    
    func getVideoById(videoId: String) {
        videoInfoContainer?.getVideoById(requestURL: Constants.API.getVideoById, params: VideoInfoRequest(id: videoId))
            .done { videoInfo in
                self.videoObjects.append(VideoObject(with: videoInfo))
                self.videoObjects = self.videoObjects.sorted {$0.viewsCount > $1.viewsCount}
                self.tableView?.reloadData()
            }.catch { error in
                UIHelper.showConfirmationAlertWith(title: "Error", message: error.localizedDescription, inViewController: self)
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
        getVideoList(params: VideoListRequest(
            maxResults: countResultVideo,
            regionCode: currentCountryCode,
            q: ""))
    }
}
