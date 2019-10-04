//
//  DetailHeroViewController.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 10/2/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import UIKit

class DetailHeroViewController: UIViewController {
    weak var scroll : UIScrollView?
    weak var nameLabel: UILabel?
    weak var portImage: UIImageView?
    weak var photoImage: UIImageView?
    weak var realNameLabel: UILabel?
    weak var heightLabel: UILabel?
    weak var powerLabel: UILabel?
    weak var abilitiesLabel: UILabel?
    weak var groupsLabel: UILabel?
    weak var contentStack : UIStackView?
    weak var realStack : UIStackView?
    weak var heightStack : UIStackView?
    weak var powerStack : UIView?
    weak var abilitiesStack : UIView?
    weak var groupsStack : UIView?
    weak var nameImage: UIImageView?
    weak var heightImage : UIImageView?
    weak var powerImage : UIImageView?
    weak var abilitiesImage : UIImageView?
    weak var groupsImage : UIImageView?
    
    var cache = CachedImage.sharedInstance
    
    var superHero : SuperHeroes?
    override func viewDidLoad() {
        super.viewDidLoad()
        builInterface()
    }
}

extension DetailHeroViewController {
    func builInterface() {
        self.view.backgroundColor = .white
        
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.alwaysBounceVertical = true
        self.view.addSubview(scroll)
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        let portImage = UIImageView(frame: .zero)
        portImage.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(portImage)
        
        NSLayoutConstraint.activate([
            portImage.topAnchor.constraint(equalTo: scroll.topAnchor),
            portImage.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            portImage.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            portImage.heightAnchor.constraint(equalToConstant: 175)
        ])
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = portImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        portImage.addSubview(blurEffectView)
        
        let photoImage = UIImageView(frame: .zero)
        photoImage.translatesAutoresizingMaskIntoConstraints = false
        photoImage.contentMode = .scaleAspectFill
        photoImage.layer.cornerRadius = 15
        photoImage.layer.borderWidth = 4
        photoImage.layer.borderColor = UIColor.white.cgColor
        photoImage.clipsToBounds = true
        scroll.addSubview(photoImage)
        
        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 50),
            photoImage.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            photoImage.widthAnchor.constraint(equalToConstant: 225),
            photoImage.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        nameLabel.textAlignment = .center
        nameLabel.text = superHero?.name
        
        scroll.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: photoImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        let contentStack = UIStackView(frame: .zero)
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        scroll.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            contentStack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            contentStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            contentStack.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 1.0),
            contentStack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -10)
        ])
        
        let realStack = UIStackView(frame: .zero)
        realStack.axis = .horizontal
        contentStack.addArrangedSubview(realStack)
        
        let nameImage = UIImageView(frame: .zero)
        nameImage.translatesAutoresizingMaskIntoConstraints = false
        nameImage.image = UIImage(named: "name")
        nameImage.contentMode = .scaleAspectFit
        realStack.addArrangedSubview(nameImage)
        
        NSLayoutConstraint.activate([
            nameImage.centerYAnchor.constraint(equalTo: realStack.centerYAnchor),
            nameImage.leadingAnchor.constraint(equalTo: realStack.leadingAnchor, constant: 5),
            nameImage.heightAnchor.constraint(equalToConstant: 70),
            nameImage.widthAnchor.constraint(equalTo: realStack.widthAnchor, multiplier: 0.30)
        ])
        
        let realNameLabel = UILabel(frame: .zero)
        realNameLabel.translatesAutoresizingMaskIntoConstraints = false
        realNameLabel.text = "Su nombre real es " + (superHero?.realName ?? "")
        realNameLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        realNameLabel.textColor = .gray
        realNameLabel.numberOfLines = 0
        realNameLabel.lineBreakMode = .byWordWrapping
        realStack.addArrangedSubview(realNameLabel)
        
        NSLayoutConstraint.activate([
            realNameLabel.topAnchor.constraint(equalTo: realStack.topAnchor, constant: 5),
            realNameLabel.trailingAnchor.constraint(equalTo: realStack.trailingAnchor, constant: -15),
            realNameLabel.leadingAnchor.constraint(equalTo: nameImage.leadingAnchor),
            realNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            realNameLabel.widthAnchor.constraint(equalTo: realStack.widthAnchor, multiplier: 0.70)
        ])
        
        let heightStack = UIStackView(frame: .zero)
        heightStack.axis = .horizontal
        contentStack.addArrangedSubview(heightStack)
        
        let heightImage = UIImageView(frame: .zero)
        heightImage.translatesAutoresizingMaskIntoConstraints = false
        heightImage.image = UIImage(named: "height")
        heightImage.contentMode = .scaleAspectFit
        heightStack.addArrangedSubview(heightImage)
        
        NSLayoutConstraint.activate([
            heightImage.centerYAnchor.constraint(equalTo: heightStack.centerYAnchor),
            heightImage.leadingAnchor.constraint(equalTo: heightStack.leadingAnchor, constant: 10),
            heightImage.heightAnchor.constraint(equalToConstant: 70),
            heightImage.widthAnchor.constraint(equalTo: heightStack.widthAnchor, multiplier: 0.30)
        ])
        
        let heightLabel = UILabel(frame: .zero)
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.text = "Su estatatura es de " + (superHero?.height ?? "")
        heightLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        heightLabel.textColor = .gray
        heightLabel.numberOfLines = 0
        heightLabel.lineBreakMode = .byWordWrapping
        heightStack.addArrangedSubview(heightLabel)
        
        NSLayoutConstraint.activate([
            heightLabel.topAnchor.constraint(equalTo: heightStack.topAnchor, constant: 5),
            heightLabel.trailingAnchor.constraint(equalTo: heightStack.trailingAnchor, constant: -15),
            heightLabel.leadingAnchor.constraint(equalTo: heightImage.leadingAnchor),
            heightLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            heightLabel.widthAnchor.constraint(equalTo: heightStack.widthAnchor, multiplier: 0.70)
        ])
        
        let powerStack = UIView(frame: .zero)
        powerStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.addArrangedSubview(powerStack)
        
        NSLayoutConstraint.activate([
            powerStack.topAnchor.constraint(equalTo: heightStack.bottomAnchor, constant: 10),
            powerStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            powerStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            powerStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
        ])
        
        let powerImage = UIImageView(frame: .zero)
        powerImage.translatesAutoresizingMaskIntoConstraints = false
        powerImage.image = UIImage(named: "power")
        powerImage.contentMode = .scaleAspectFit
        powerStack.addSubview(powerImage)
        
        NSLayoutConstraint.activate([
            powerImage.centerYAnchor.constraint(equalTo: powerStack.centerYAnchor),
            powerImage.leadingAnchor.constraint(equalTo: powerStack.leadingAnchor, constant: 10),
            powerImage.heightAnchor.constraint(equalToConstant: 70),
            powerImage.widthAnchor.constraint(equalTo: powerStack.widthAnchor, multiplier: 0.30)
        ])
        
        let powerLabel = UILabel(frame: .zero)
        powerLabel.translatesAutoresizingMaskIntoConstraints = false
        powerLabel.text = "Sus poderes son,  " + (superHero?.power ?? "")
        powerLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        powerLabel.textColor = .gray
        powerLabel.numberOfLines = 0
        powerLabel.lineBreakMode = .byWordWrapping
        powerStack.addSubview(powerLabel)
        
        NSLayoutConstraint.activate([
            powerLabel.topAnchor.constraint(equalTo: powerStack.topAnchor, constant: 5),
            powerLabel.trailingAnchor.constraint(equalTo: powerStack.trailingAnchor, constant: -15),
            powerLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            powerLabel.widthAnchor.constraint(equalTo: powerStack.widthAnchor, multiplier: 0.65),
            powerLabel.bottomAnchor.constraint(equalTo: powerStack.bottomAnchor)
        ])
        
        
        let abilitiesStack = UIView(frame: .zero)
        abilitiesStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.addArrangedSubview(abilitiesStack)
        
        NSLayoutConstraint.activate([
            abilitiesStack.topAnchor.constraint(equalTo: powerStack.bottomAnchor, constant: 10),
            abilitiesStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            abilitiesStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            abilitiesStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
        ])
        
        let abilitiesImage = UIImageView(frame: .zero)
        abilitiesImage.translatesAutoresizingMaskIntoConstraints = false
        abilitiesImage.image = UIImage(named: "abilities")
        abilitiesImage.contentMode = .scaleAspectFit
        abilitiesStack.addSubview(abilitiesImage)
        
        NSLayoutConstraint.activate([
            abilitiesImage.centerYAnchor.constraint(equalTo: abilitiesStack.centerYAnchor),
            abilitiesImage.leadingAnchor.constraint(equalTo: abilitiesStack.leadingAnchor, constant: 10),
            abilitiesImage.heightAnchor.constraint(equalToConstant: 70),
            abilitiesImage.widthAnchor.constraint(equalTo: abilitiesStack.widthAnchor, multiplier: 0.30)
        ])
        
        let abilitiesLabel = UILabel(frame: .zero)
        abilitiesLabel.translatesAutoresizingMaskIntoConstraints = false
        abilitiesLabel.text = "Las habilidades que tiene son, " + (superHero?.abilities ?? "")
        abilitiesLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        abilitiesLabel.textColor = .gray
        abilitiesLabel.numberOfLines = 0
        abilitiesLabel.lineBreakMode = .byWordWrapping
        abilitiesStack.addSubview(abilitiesLabel)
        
        NSLayoutConstraint.activate([
            abilitiesLabel.topAnchor.constraint(equalTo: abilitiesStack.topAnchor, constant: 5),
            abilitiesLabel.trailingAnchor.constraint(equalTo: abilitiesStack.trailingAnchor, constant: -15),
            abilitiesLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            abilitiesLabel.widthAnchor.constraint(equalTo: abilitiesStack.widthAnchor, multiplier: 0.65),
            abilitiesLabel.bottomAnchor.constraint(equalTo: abilitiesStack.bottomAnchor)
        ])
        
        let groupsStack = UIView(frame: .zero)
        groupsStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.addArrangedSubview(groupsStack)
        
        NSLayoutConstraint.activate([
            groupsStack.topAnchor.constraint(equalTo: abilitiesStack.bottomAnchor, constant: 10),
            groupsStack.trailingAnchor.constraint(equalTo: contentStack.trailingAnchor),
            groupsStack.leadingAnchor.constraint(equalTo: contentStack.leadingAnchor),
            groupsStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
        ])
        
        let groupsImage = UIImageView(frame: .zero)
        groupsImage.translatesAutoresizingMaskIntoConstraints = false
        groupsImage.image = UIImage(named: "groups")
        groupsImage.contentMode = .scaleAspectFit
        groupsStack.addSubview(groupsImage)
        
        NSLayoutConstraint.activate([
            groupsImage.centerYAnchor.constraint(equalTo: groupsStack.centerYAnchor),
            groupsImage.leadingAnchor.constraint(equalTo: groupsStack.leadingAnchor, constant: 10),
            groupsImage.heightAnchor.constraint(equalToConstant: 70),
            groupsImage.widthAnchor.constraint(equalTo: groupsStack.widthAnchor, multiplier: 0.30)
        ])
        
        let groupsLabel = UILabel(frame: .zero)
        groupsLabel.translatesAutoresizingMaskIntoConstraints = false
        groupsLabel.text = "Los grupos a los que pertenece son " + (superHero?.groups ?? "")
        groupsLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        groupsLabel.textColor = .gray
        groupsLabel.numberOfLines = 0
        groupsLabel.lineBreakMode = .byWordWrapping
        groupsStack.addSubview(groupsLabel)
        
        
        NSLayoutConstraint.activate([
            groupsLabel.topAnchor.constraint(equalTo: groupsStack.topAnchor, constant: 5),
            groupsLabel.trailingAnchor.constraint(equalTo: groupsStack.trailingAnchor, constant: -15),
            groupsLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            groupsLabel.widthAnchor.constraint(equalTo: groupsStack.widthAnchor, multiplier: 0.65),
            groupsLabel.bottomAnchor.constraint(equalTo: groupsStack.bottomAnchor)
        ])
        
        self.scroll = scroll
        self.nameLabel = nameLabel
        self.portImage = portImage
        self.photoImage = photoImage
        self.nameImage = nameImage
        self.contentStack = contentStack
        self.realStack = realStack
        self.nameImage = nameImage
        self.realNameLabel = realNameLabel
        self.heightStack = heightStack
        self.heightImage = heightImage
        self.heightLabel = heightLabel
        self.powerStack = powerStack
        self.powerImage = powerImage
        self.powerLabel = powerLabel
        self.abilitiesStack  = abilitiesStack
        self.abilitiesImage = abilitiesImage
        self.abilitiesLabel = abilitiesLabel
        self.groupsStack = groupsStack
        self.groupsImage = groupsImage
        self.groupsLabel = groupsLabel
        
        cache.downloadImage(endPoint: superHero?.photo ?? "") { (image) in
            self.photoImage?.image = image
            self.portImage?.image = image
        }
    }
}

