//
//  RootTableViewCell.swift
//  TestApplicationIos
//
//  Created by Stas Lavruk on 04/05/2019.
//  Copyright © 2019 Stas Lavruk. All rights reserved.
//

import UIKit
import Kingfisher

class RootTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var previewImageView: UIImageView?
    @IBOutlet weak var nameVideLabel: UILabel?
    @IBOutlet weak var videoDurationLabel: UILabel?
    @IBOutlet weak var viewsCountLabel: UILabel?
    @IBOutlet weak var datePublishedLabel: UILabel?
    
    //MARK: Variables
    weak var videoObject: VideoObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImageView?.image = nil
        nameVideLabel?.text = ""
        videoDurationLabel?.text = ""
        viewsCountLabel?.text = ""
    }
    
    /*
     Assigns the properties of the video from the object to the outlets.
     */
    func configure() {
        guard let videoObject = videoObject else { return }
        nameVideLabel?.text = videoObject.title
        videoDurationLabel?.text = "\(videoObject.duration.convertYTFormattedDuration()) duration"
        viewsCountLabel?.text = "\(videoObject.viewsCount) views"
        
        let datePublished = videoObject.datePublished
        // Cut the date from the resulting string, and convert to the specified format.
        let formattedDateString = Date().convertDateFormat(datePublished.trim(firstIndex: datePublished.startIndex, offset: 10))
        datePublishedLabel?.text = "\(formattedDateString) date of download"
        loadImage()
        
    }
    
    private func loadImage() {
        guard let imageUrl = videoObject?.imageUrl else { return }
        previewImageView?.kf.setImage(with: URL(string: imageUrl), placeholder: nil, options: [
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
            ])
    }
    
    //MARK: Actions
    /*
     When clicking on the video, check if the YouTube application is available on the device,
     if there is something to invite the user to open the video in the application,
     if not, then open the video in the browser.
     */
    @IBAction func cellClickedAction(_ sender: Any) {
        guard let youtubeId = videoObject?.viedoId else { return }
        var url = URL(string:"youtube://\(youtubeId)")
        if !UIApplication.shared.canOpenURL(url!)  {
            url = URL(string:"http://www.youtube.com/watch?v=\(youtubeId)")!
        }
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}
