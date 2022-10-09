//
//  DetailViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 7.10.2022.
//

import UIKit
import SDWebImage
import RxSwift
final class DetailViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var developerName: UILabel!
   
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var gameName: UILabel!
    
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    private var bag = DisposeBag()
    private var network = NetworkService()
    var slug = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        binding()
    }
  
    
    func binding() {
       
        network.fetchGameDetails(gameID: slug)
        network.detailBehavior.bind { gamedetail in
            self.gameName.text = gamedetail.name
            self.descriptionLbl.text = gamedetail.description_raw
            self.releaseDate.text = gamedetail.released
            self.ratingLbl.text = "\(String(describing: gamedetail.rating))"
            self.mainImage.sd_setImage(with: URL(string: gamedetail.background_image!))
        }.disposed(by: bag)
        
        
    }

}
