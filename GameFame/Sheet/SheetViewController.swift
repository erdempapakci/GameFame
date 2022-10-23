//
//  SheetViewController.swift
//  GameFame
//
//  Created by Erdem Papakçı on 12.10.2022.
//

import UIKit

class SheetViewController: UIViewController, UISheetPresentationControllerDelegate{

    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
        
    }
    var newsUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPresentationView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {

        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    private func setPresentationView() {
        
        sheetPresentationController.delegate = self
       
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [
            .medium()
        ]
        sheetPresentationController.selectedDetentIdentifier = .medium
        let interaction = UIContextMenuInteraction(delegate: self)
        newsImage.addInteraction(interaction)
        newsImage.isUserInteractionEnabled = true
        
    }
    
    private func createContextMenu() -> UIMenu {
            let urlAction = UIAction(title: "Go to Adress", image: UIImage(systemName: "link")) { _ in
                if let url = URL(string: self.newsUrl) {
                    UIApplication.shared.open(url, completionHandler: nil)
                }
            }
        
            return UIMenu(title: "More", children: [urlAction])
        }
  
}
extension SheetViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ -> UIMenu? in
            return self.createContextMenu()
        }
        
    }
}

