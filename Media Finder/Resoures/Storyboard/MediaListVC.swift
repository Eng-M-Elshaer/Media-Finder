//
//  MediaListVC.swift
//  Media Finder
//
//  Created by Mohamed Elshaer on 6/11/20.
//  Copyright © 2020 Mohamed Elshaer. All rights reserved.
//

import UIKit
import AVKit
import SDWebImage

class MediaListVC: UIViewController {
    
    // MARK: - Outlets.
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mediaSegment: UISegmentedControl!
    @IBOutlet weak var noDataImageView: UIImageView!
    
    // MARK:- Properties
    var mediaArr = [Media]()
    var mediaType: MediaType = .all
    var mediaKind = MediaType.all.rawValue
    let email = UserDefultsManger.shared().email
    var image: UIView!
    
    // MARK: - Lifecycle Methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupView()
    }
    
    // MARK: - Actions.
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        segmentedChangedAction(sender)
    }
}

// MARK: - TableView DataSource.
extension MediaListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mediaArr.count == 0 {
            self.noDataImageView.isHidden = false
            return 0
        }
        self.noDataImageView.isHidden = true
        return mediaArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.mediaCell, for: indexPath) as? MediaCell else {return UITableViewCell()}
        cell.configCell(type: mediaType, media: mediaArr[indexPath.row])
        return cell
    }
}

// MARK: - TableView Delegate.
extension MediaListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = mediaArr[indexPath.row].previewUrl {
            if let artworkUrl = mediaArr[indexPath.row].artworkUrl {
                privewUrl(url: url, artworkUrl: artworkUrl)
            }
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let theCell = cell as! MediaCell
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        theCell.artWorkImageView.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.7) {
            theCell.artWorkImageView.layer.transform = CATransform3DIdentity
        }
    }
}

// MARK: - Search Bar.
extension MediaListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        bindData(term: searchText, media: mediaType.rawValue)
        tableView.reloadData()
    }
}

// MARK: - Private Methods.
extension MediaListVC {
    private func setupView(){
        setNavView()
        setTableRowHight()
        getMediaFromDB()
        setSegmanet()
    }
    private func setNavView(){
        self.navigationItem.title = ViewControllerTitle.mediaList
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: ViewControllerTitle.profile, style: .plain, target: self, action: #selector(goToProvileVC))
    }
    private func getMediaFromDB(){
        if let data = SQLiteManger.shared().getMediaDataFromDB(email: email)?.0 {
            if let media = Coder.decodMedia(userData: data){
                if let type = SQLiteManger.shared().getMediaDataFromDB(email: email)?.1 {
                    mediaArr = media
                    mediaKind = type
                    tableView.reloadData()
                }
            }
        }
    }
    private func setSegmanet() {
        switch mediaKind {
        case MediaType.tvShow.rawValue:
            mediaType = .tvShow
            mediaSegment.selectedSegmentIndex = 1
        case MediaType.movie.rawValue:
            mediaType = .movie
            mediaSegment.selectedSegmentIndex = 3
        case MediaType.music.rawValue:
            mediaType = .music
            mediaSegment.selectedSegmentIndex = 2
        default:
            mediaType = .all
            mediaSegment.selectedSegmentIndex = 0
        }
    }
    private func setTableRowHight(){
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    @objc private func goToProvileVC(){
        let sb = UIStoryboard(name: StoryBoard.main, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ViewController.profileVC ) as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func bindData(term: String, media: String) {
        APIManager.getDataFromAPI(term: term, media: media) { (error, mediaData) in
            if let error = error {
                print(error.localizedDescription)
            } else if let mediaData = mediaData {
                self.mediaArr = mediaData
                if let media = Coder.encodMedia(media: mediaData) {
                    if self.mediaArr.count > 0 {
                        SQLiteManger.shared().insertInMediaTable(email: self.email, mediaData: media,
                                                                 type: self.mediaType.rawValue)
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    private func setImageForAVPlayer(cell:MediaCell) -> UIView {
        return cell.artWorkImageView
    }
    private func privewUrl(url: String, artworkUrl: String){
        let url = URL(string: url)
        let player = AVPlayer(url: url!)
        let vc = AVPlayerViewController()
        vc.player = player
//        vc.contentOverlayView?.addSubview(image)
        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    private func setup(){
        UserDefultsManger.shared().isLogedIn = true
        SQLiteManger.shared().createMediaTable()
        tableView.register(UINib(nibName: CustomCell.mediaCell, bundle: nil), forCellReuseIdentifier: CustomCell.mediaCell)
    }
    private func segmentedChangedAction(_ sender: UISegmentedControl){
        let index = sender.selectedSegmentIndex
        switch index {
        case 1:
            self.mediaType = .tvShow
        case 2:
            self.mediaType = .music
        case 3:
            self.mediaType = .movie
        default:
            self.mediaType = .all
        }
        guard let searchText = searchBar.text, searchText != "" else {
            return
        }
        bindData(term: searchText, media: mediaType.rawValue)
    }
}
