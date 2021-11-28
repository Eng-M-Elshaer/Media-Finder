//
//  MediaCell.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/11/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit
import SDWebImage

class MediaCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var artWorkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    // MARK:- Lifecyele Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Public Methods
    func configCell(type: MediaType, media: Media){
        setupCell(type: type, media: media)
    }
}

extension MediaCell {
    private func setupCell(type: MediaType, media: Media){
        setupImageView(mediaUrl: media.artworkUrl)
        setupCellData(type: type, media: media)
    }
    private func setupImageView(mediaUrl: String){
        artWorkImageView.sd_setImage(with: URL(string: mediaUrl), placeholderImage: UIImage(named: Images.placeholder))
    }
    private func setupCellData(type: MediaType, media: Media){
        switch type {
        case .movie:
            titleLabel.text = media.trackName
            detailsLabel.text = media.longDescription
        case .tvShow:
            titleLabel.text = media.artistName
            detailsLabel.text = media.longDescription
        case .music:
            titleLabel.text = media.trackName
            detailsLabel.text = media.artistName
        case .all:
            if media.longDescription == nil {
                titleLabel.text = media.trackName
                detailsLabel.text = media.artistName
            } else {
                titleLabel.text = media.artistName
                detailsLabel.text = media.longDescription
            }
        }
    }
}
