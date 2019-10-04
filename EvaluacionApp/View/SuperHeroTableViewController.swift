//
//  SuperHeroTableViewController.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 9/30/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import UIKit
import Alamofire

class SuperHeroTableViewController: UIViewController {
    weak var superHeroTable : UITableView?
    weak var vSpinner : UIView?
    var superHeroes : [SuperHeroes]?
    
    override func loadView() {
        super.loadView()
        builInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        service()
    }
    
    func initTableView() {
        self.superHeroTable?.dataSource = self
        self.superHeroTable?.delegate = self
        self.superHeroTable?.register(SuperHeroTableViewCell.self, forCellReuseIdentifier: SuperHeroTableViewCell.identifier)
    }
    
}

extension SuperHeroTableViewController: UITableViewDelegate, UITableViewDataSource {
    @objc func exitAction(sender: UIButton!){           self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.superHeroes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SuperHeroTableViewCell.identifier, for: indexPath) as? SuperHeroTableViewCell, let superHeroes = self.superHeroes  else{
            return UITableViewCell ()
        }
        
        let superHero = superHeroes[indexPath.row]
        cell.superHero = superHero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailHeroViewController()
        detailViewController.superHero = superHeroes?[indexPath.row]
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func service() {
        Alamofire.request("https://api.myjson.com/bins/bvyob", method: .get, encoding: URLEncoding.default) .responseJSON{ response in
            if let request = response.data {
                print(request.description)
                let decoder = JSONDecoder()
                do {
                    let heroResponds =  try decoder.decode(SuperHeroeResponse.self, from: request)
                    self.superHeroes = heroResponds.superheroes
                    self.superHeroTable?.reloadData() // recarga los datos
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension SuperHeroTableViewController{
    func builInterface(){
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = ColoresStruct.blueBack1
        navigationController?.navigationBar.tintColor = .white
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        let exitButton = UIButton.init(type: .custom)
        exitButton.setImage(UIImage.init(named: "exit.png"), for: UIControl.State.normal)
        exitButton.addTarget(self, action: #selector(exitAction), for: UIControl.Event.touchUpInside)
        exitButton.frame = CGRect.init(x: 0, y: 0, width: 20, height: 20)
        let barButton = UIBarButtonItem.init(customView: exitButton)
        let currWidth = barButton.customView?.widthAnchor.constraint(equalToConstant: 30)
        currWidth?.isActive = true
        let currHeight = barButton.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = barButton
        
        self.view.applyGradient(colours: [ColoresStruct.blueBack1, ColoresStruct.blueBack2, ColoresStruct.blueBack3], locations: [0.0, 0.5, 1.0])
        
        let superHeroTable = UITableView(frame: .zero, style: .plain)
        superHeroTable.translatesAutoresizingMaskIntoConstraints = false
        superHeroTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.view.addSubview(superHeroTable)
        
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: superHeroTable.topAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: superHeroTable.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: superHeroTable.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: superHeroTable.trailingAnchor),
        ])
        self.superHeroTable = superHeroTable
    }
}

extension SuperHeroTableViewController {
    func showSpinner(onView : UIView) {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func removeSpinner() {
        dismiss(animated: false, completion: nil)
    }
}
