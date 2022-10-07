//
//  DetailViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 7.10.2022.
//

import UIKit
import RxSwift
class DetailViewController: UIViewController {

    @IBOutlet weak var developerName: UILabel!
    @IBOutlet weak var gameName: UILabel!
    
    var game = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        gameName.text = game
    }
  

}
