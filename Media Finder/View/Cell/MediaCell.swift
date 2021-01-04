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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Public Methods
    func configCell(type: MediaType, media: Media){
        
        artWorkImageView.sd_setImage(with: URL(string: media.artworkUrl), placeholderImage: UIImage(named: "placeholder.png"))
        
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
