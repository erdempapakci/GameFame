//
//  SlideModel.swift
//  GameFame
//
//  Created by Erdem Papakçı on 27.10.2022.
//

import UIKit

struct Slide {
    let maintitle: String
    let title: String
    let animationName: String
    let buttonColor: UIColor
    let buttonTitle: String
    static let collection: [Slide] = [
        .init(maintitle: "Find your best",title: "Game Fame It offers you a platform with trailers, screenshots, purchase links and all information.", animationName: "Onboarding2", buttonColor: .black, buttonTitle: "Next"),
        .init(maintitle: "One tap makes you happier", title: "Get one-click access to games all over the world", animationName: "Onboarding3", buttonColor: .black, buttonTitle: "Enough Talking")
    ]
}
