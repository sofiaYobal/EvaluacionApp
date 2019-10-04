//
//  SuperHeroTableViewCell.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 10/1/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import UIKit

class SuperHeroTableViewCell: UITableViewCell {
    weak var mainContainer: UIView?
    weak var heroImage: UIImageView?
    weak var namelabel: UILabel?
    weak var namenRequest: UILabel?
    weak var realNamelabel: UILabel?
    weak var realNameRequest: UILabel?
    let cache = CachedImage.sharedInstance
    
    var superHero : SuperHeroes? {
        didSet {
            if let superValues = self.superHero {
                print("Esta aqui")
                self.namenRequest?.text = superValues.name ?? "Sin nombre"
                self.realNameRequest?.text = superValues.realName ?? "Sin nombre real"
                cache.downloadImage(endPoint: superValues.photo ?? "") { (imagen) in
                    DispatchQueue.main.async {
                        self.heroImage?.image = imagen
                    }
                } 
            }
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension SuperHeroTableViewCell {
    func buildCell() {
        
        let mainContainer = UIView(frame: .zero)
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.layer.cornerRadius = 10
        mainContainer.layer.borderWidth = 1
        mainContainer.layer.borderColor = ColoresStruct.blueBack2.cgColor
        mainContainer.clipsToBounds = true
        self.addSubview(mainContainer)
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            mainContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            mainContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            mainContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:  15),
            mainContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
        
        let heroImage = UIImageView(frame: .zero)
        heroImage.translatesAutoresizingMaskIntoConstraints = false
        heroImage.contentMode = .scaleAspectFill
        heroImage.layer.cornerRadius = 15
        heroImage.clipsToBounds = true
        mainContainer.addSubview(heroImage)
        
        NSLayoutConstraint.activate([
            heroImage.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 5),
            heroImage.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 10),
            heroImage.heightAnchor.constraint(equalToConstant: 120),
            heroImage.widthAnchor.constraint(equalTo: mainContainer.widthAnchor, multiplier: 0.45),
            heroImage.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor, constant: -5)
        ])
        
        let namenRequest = UILabel(frame: .zero)
        namenRequest.translatesAutoresizingMaskIntoConstraints = false
        namenRequest.numberOfLines = 0
        namenRequest.lineBreakMode = .byWordWrapping
        namenRequest.textColor = ColoresStruct.blueBack1
        namenRequest.textAlignment = .center
        namenRequest.font = UIFont(name: "HelveticaNeue", size: 20)
        mainContainer.addSubview(namenRequest)
        
        NSLayoutConstraint.activate([
            namenRequest.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 15),
            namenRequest.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            namenRequest.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            namenRequest.widthAnchor.constraint(equalTo: mainContainer.widthAnchor, multiplier: 0.52)
        ])
        
        let realNamelabel = UILabel(frame: .zero)
        realNamelabel.translatesAutoresizingMaskIntoConstraints = false
        realNamelabel.text = "Nombre real: "
        realNamelabel.textColor = .gray
        realNamelabel.textAlignment = .center
        realNamelabel.font = UIFont(name: "HelveticaNeue", size: 15)
        mainContainer.addSubview(realNamelabel)
        
        NSLayoutConstraint.activate([
            realNamelabel.topAnchor.constraint(equalTo: namenRequest.bottomAnchor, constant: 10),
            realNamelabel.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            realNamelabel.heightAnchor.constraint(equalToConstant: 25),
            realNamelabel.widthAnchor.constraint(equalTo: mainContainer.widthAnchor, multiplier: 0.52)
        ])
        
        let realNameRequest = UILabel(frame: .zero)
        realNameRequest.translatesAutoresizingMaskIntoConstraints = false
        realNameRequest.numberOfLines = 0
        realNameRequest.lineBreakMode = .byWordWrapping
        realNameRequest.textColor = .gray
        realNameRequest.textAlignment = .center
        realNameRequest.font = UIFont(name: "HelveticaNeue", size: 18)
        mainContainer.addSubview(realNameRequest)
        
        NSLayoutConstraint.activate([
            realNameRequest.topAnchor.constraint(equalTo: realNamelabel.bottomAnchor, constant: 2),
            realNameRequest.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            realNameRequest.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            realNameRequest.widthAnchor.constraint(equalTo: mainContainer.widthAnchor, multiplier: 0.52)
        ])
        
        self.mainContainer = mainContainer
        self.heroImage = heroImage
        self.namenRequest = namenRequest
        self.realNamelabel = realNamelabel
        self.realNameRequest = realNameRequest
    }
}
