//
//  DetailViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 7.10.2022.
//

import UIKit
import SDWebImage
import RxSwift
import AVFoundation
import AVKit
import RealmSwift

final class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var LottieView: CardView!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var publisherLbl: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var developerName: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var descriptionView: CardView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var trailerButton: UIButton!
    
    lazy var realm = try! Realm()
    private var bag = DisposeBag()
    private var viewModel = DetailViewModel()
    private var saveModel = SavedViewModel()
    
    var imageUrl = String()
    var slug = String()
    var url = String()
    
    private var trailerString = String()
    
    private let likeButton : LikeButton = {
        let button = LikeButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handleLikeButton() {
        
        likeButton.flipLikeState()
        saveModel.saveGameToRealm(slug: slug, imageUrl: imageUrl)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trailerButton.isHidden = true
        registerCells()
        executeLoading()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        likeButton.isContains(with: slug)
        likeButton.getImage()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 6
    }
    
    @IBAction func mp4Clicked(_ sender: Any) {
        
        guard let url = URL(string: trailerString) else {return}
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
            player.volume = 0.5
        }
    }
    private  func setViewConstraints() {
        
        view.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.contentMode = .scaleAspectFill
        likeButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
        
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    @IBAction func openURLClicked(_ sender: Any) {
        getPlatformURL()
        let urlString = url
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, completionHandler: nil)
        }
    }
    private func registerCells(){
        imageCollectionView.register(UINib(nibName: "ScreenShotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenShotCollectionViewCell")
        
        genresCollectionView.register(UINib(nibName: "GenresCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenresCollectionViewCell")
        bindingUI()
        bindingGenresCollectionView()
        bindingImageCollectionView()
        setViewConstraints()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.imageCollectionView.contentOffset, size: self.imageCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.imageCollectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
    
}
// DATA BINDING WITH RX
extension DetailViewController {
    
    private func bindingGenresCollectionView() {
        
        viewModel.fetchDetails(slug: slug)
        genresCollectionView.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.genresBehavior.bind(to: genresCollectionView.rx.items(cellIdentifier: "GenresCollectionViewCell", cellType: GenresCollectionViewCell.self)) {
            section, item, cell in
            
            cell.genreLabel.text = item.name
            cell.stopLoading()
            
            
        }.disposed(by: bag)
    }
    
    private func bindingImageCollectionView() {
        
        viewModel.fetchGameScreenShots(slug: slug)
        imageCollectionView.rx.setDelegate(self).disposed(by: bag)
        viewModel.screenShotBehavior.bind(to: imageCollectionView.rx.items(cellIdentifier: "ScreenShotCollectionViewCell",cellType: ScreenShotCollectionViewCell.self)) {
            section,item,cell in
            
            cell.SSImage.sd_setImage(with: URL(string: item.image))
            cell.stopLoading()
        }.disposed(by: bag)
        
    }
    
    private func bindingUI() {
        viewModel.fetchGameTrailers(slug: slug)
        viewModel.trailerBehavior.bind { trailer in
            self.trailerString = trailer.max
            if self.trailerString != "" {
                self.trailerButton.isHidden = false
            }
            
        }.disposed(by: bag)
        
        
        viewModel.fetchDetails(slug: slug)
        viewModel.detailBehavior.bind { gamedetail in
            
            self.gameName.text = gamedetail.name
            self.websiteLbl.text = gamedetail.website
            self.developerName.text = gamedetail.developers.first?.name
            self.descriptionLbl.text = gamedetail.description_raw
            self.releaseDate.text = gamedetail.released
            self.publisherLbl.text = gamedetail.publishers.first?.name
            self.ratingLbl.text =  String(gamedetail.rating ?? 0)
            self.imageUrl = gamedetail.background_image ?? ""
            self.mainImage.sd_setImage(with: URL(string: gamedetail.background_image!))
            self.stopLoading()
        }.disposed(by: bag)
        
    }
    
    private func getPlatformURL() {
        
        viewModel.fetchGameStores(slug: slug)
        viewModel.platformsBehavior.bind { platform in
            self.url = platform.first!.url
            
        }.disposed(by: bag)
    }
    
}

// SHIMMER LOADING

extension DetailViewController {
    
    private func executeLoading() {
        
        self.gameName.startDSLoading()
        self.websiteLbl.startDSLoading()
        self.developerName.startDSLoading()
        self.descriptionLbl.startDSLoading()
        self.releaseDate.startDSLoading()
        self.publisherLbl.startDSLoading()
        self.ratingLbl.startDSLoading()
        
        
    }
    func stopLoading() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2, execute: {
            
            self.gameName.stopDSLoading()
            self.websiteLbl.stopDSLoading()
            self.developerName.stopDSLoading()
            self.descriptionLbl.stopDSLoading()
            self.releaseDate.stopDSLoading()
            self.publisherLbl.stopDSLoading()
            self.ratingLbl.stopDSLoading()
            
        })
        
    }
}

