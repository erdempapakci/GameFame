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
  
  
    private var network = NetworkService()
    private var bag = DisposeBag()
    
    var slug = String()
    var url = String()
    var trailer = [GameTrailer]()
    let likeButton : LikeButton = {
            let button = LikeButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
            return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        bindingUI()
        bindingGenresCollectionView()
        bindingImageCollectionView()
        setViewConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = 6
    }
  
    func setViewConstraints() {
            view.addSubview(likeButton)
            likeButton.translatesAutoresizingMaskIntoConstraints = false
            likeButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
            likeButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
        }
        
        @objc func handleLikeButton() {
            likeButton.flipLikeState()
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
      
        network.fetchGameDetails(gameID: slug)
        genresCollectionView.rx.setDelegate(self).disposed(by: bag)
        
        network.genresBehavior.bind(to: genresCollectionView.rx.items(cellIdentifier: "GenresCollectionViewCell", cellType: GenresCollectionViewCell.self)) {
            section, item, cell in
            
            cell.genreLabel.text = item.name
            
            print(item.name)
            
        }.disposed(by: bag)
     }
    
    private func bindingImageCollectionView() {
         network.fetchGameScreenShots(gameID: slug)
         imageCollectionView.rx.setDelegate(self).disposed(by: bag)
         network.screenShotBehavior.bind(to: imageCollectionView.rx.items(cellIdentifier: "ScreenShotCollectionViewCell",cellType: ScreenShotCollectionViewCell.self)) {
             section,item,cell in
             
             cell.SSImage.sd_setImage(with: URL(string: item.image))
             
         }.disposed(by: bag)
      
     }
     
    private func bindingUI() {
        
         network.fetchGameDetails(gameID: slug)
         network.detailBehavior.bind { gamedetail in
             self.gameName.text = gamedetail.name
             self.websiteLbl.text = gamedetail.website
             self.developerName.text = gamedetail.developers.first?.name
             self.descriptionLbl.text = gamedetail.description_raw
             self.releaseDate.text = gamedetail.released
             self.publisherLbl.text = gamedetail.publishers.first?.name
             self.ratingLbl.text =  String(gamedetail.rating ?? 0)
             
             print(gamedetail.slug)
             self.mainImage.sd_setImage(with: URL(string: gamedetail.background_image!))
         }.disposed(by: bag)
     
     }
    
    private func getPlatformURL() {
        
        network.fetchGameStores(gameID: slug)
        network.platformsBehavior.bind { platform in
            self.url = platform.first!.url
            
        }.disposed(by: bag)
    }
 
}

