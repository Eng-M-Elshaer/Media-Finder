//
//  MediaCell.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/11/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

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
    
    //MARK:- Actions
    @IBAction func imageBtnTapped(_ sender: UIButton) {
        let imageFrameX = artWorkImageView.frame.origin.x
        self.artWorkImageView.frame.origin.x += 4
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, animations: {
            self.artWorkImageView.frame.origin.x -= 8
            self.artWorkImageView.frame.origin.x = imageFrameX
        }, completion: nil)
    }
}

//MARK:- Private Methods
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
            } else if media.artistName == nil {
                titleLabel.text = media.trackName
                detailsLabel.text = media.artistName
            } else {
                titleLabel.text = media.artistName
                detailsLabel.text = media.longDescription
            }
        }
    }
}
