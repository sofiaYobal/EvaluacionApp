//
//  LoginViewController.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 9/25/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    weak var loginContent:   UIView?
    weak var userImage:      UIImageView?
    weak var userLabel:      UILabel?
    weak var userText :      UITextField?
    weak var passwordLabel:  UILabel?
    weak var passwordText:   UITextField?
    weak var loginButton:    UIButton?
    weak var lineImage:      UIImageView?
    weak var registerButton: UIButton?
    
    var usuario : String?
    var password : String?
    
    private let manager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildInterface()
        self.userImage?.tintColor = .blue
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension LoginViewController {
    func cleanFields() {
        userText?.text = ""
        passwordText?.text = ""
    }
    
    func validateFields(){
        usuario.self = userText?.text
        password.self = passwordText?.text
        
        if usuario == ""{
            let alertController = UIAlertController(title: "¡Advertencia!", message: "Debes ingresar tu usuario", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        if password == "" {
            let alertController = UIAlertController(title: "¡Advertencia!", message: "Debes ingresar tu contraseña", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        let request = manager.fetchUsers(username: usuario ?? "", password: password ?? "")
        if request == true {
            let superHeroTable = SuperHeroTableViewController()
            self.navigationController?.pushViewController(superHeroTable, animated: true)
            cleanFields()
            let alertController = UIAlertController(title: "¡Bienvenido!", message: "¡Aqui sabras mas de tus super héroes favoritos!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "¡Advertencia!", message: "Usuario o contraseña incorrectos", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func registerAction(sender: UIButton!) {
        let registerController = RegisterFormViewController()
        self.navigationController?.pushViewController(registerController, animated: true)
        cleanFields()
    }
    
    @objc func loginAction(sender: UIButton){
        validateFields()
    }
}

extension LoginViewController {
    func buildInterface(){
        
        self.view.applyGradient(colours: [ColoresStruct.blueBack1, ColoresStruct.blueBack2, ColoresStruct.blueBack3], locations: [0.0, 0.5, 1.0])
        
        let userImage = UIImageView(frame: .zero)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.image = UIImage(named: "bo")
        
        self.view.addSubview(userImage)
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            userImage.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            userImage.widthAnchor.constraint(equalToConstant: 220),
            userImage.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let loginContent = UIView(frame: .zero)
        loginContent.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginContent)
        
        NSLayoutConstraint.activate([
            loginContent.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20),
            loginContent.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            loginContent.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant:  5),
            loginContent.heightAnchor.constraint(equalToConstant: 220)
        ])
        
        let userLabel = UILabel(frame: .zero)
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.text = "Usuario"
        userLabel.textColor = .white
        loginContent.addSubview(userLabel)
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: loginContent.topAnchor, constant: 10),
            userLabel.trailingAnchor.constraint(equalTo: loginContent.trailingAnchor, constant: -10),
            userLabel.leadingAnchor.constraint(equalTo: loginContent.leadingAnchor, constant: 10),
            userLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        let userText = UITextField(frame: .zero)
        userText.translatesAutoresizingMaskIntoConstraints = false
        userText.backgroundColor = ColoresStruct.blueBack4
        userText.textColor = UIColor.white
        loginContent.addSubview(userText)
        
        NSLayoutConstraint.activate([
            userText.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 5),
            userText.trailingAnchor.constraint(equalTo: loginContent.trailingAnchor, constant: -10),
            userText.leadingAnchor.constraint(equalTo: loginContent.leadingAnchor, constant: 10),
            userText.heightAnchor.constraint(equalToConstant: 30)])
        
        let passwordLabel = UILabel(frame: .zero)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Contraseña"
        passwordLabel.textColor = .white
        loginContent.addSubview(passwordLabel)
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: userText.bottomAnchor, constant: 10),
            passwordLabel.trailingAnchor.constraint(equalTo: loginContent.trailingAnchor, constant: -10),
            passwordLabel.leadingAnchor.constraint(equalTo: loginContent.leadingAnchor, constant: 10),
            passwordLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        let passwordText = UITextField(frame: .zero)
        passwordText.isSecureTextEntry = true
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.backgroundColor = ColoresStruct.blueBack4
        passwordText.textColor = .white
        loginContent.addSubview(passwordText)
        
        NSLayoutConstraint.activate([
            passwordText.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordText.trailingAnchor.constraint(equalTo: loginContent.trailingAnchor, constant: -10),
            passwordText.leadingAnchor.constraint(equalTo: loginContent.leadingAnchor, constant: 10),
            passwordText.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let loginButton = UIButton(frame: .zero)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Iniciar Sesión", for: .normal)
        loginButton.addTarget(self, action: #selector(loginAction), for: UIControl.Event.touchUpInside)
        loginContent.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: loginContent.trailingAnchor, constant: -10),
            loginButton.leadingAnchor.constraint(equalTo: loginContent.leadingAnchor, constant: 10),
            //loginButton.bottomAnchor.constraint(equalTo: loginContent.bottomAnchor, constant: -20)
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        let lineImage = UIImageView(frame: .zero)
        lineImage.translatesAutoresizingMaskIntoConstraints = false
        lineImage.image = UIImage(named: "line")
        self.view.addSubview(lineImage)
        
        NSLayoutConstraint.activate([
            lineImage.topAnchor.constraint(equalTo: loginContent.bottomAnchor, constant: 10),
            lineImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            lineImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lineImage.heightAnchor.constraint(equalToConstant: 30)])
        
        let registerButton = UIButton(frame: .zero)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Registrase", for: .normal)
        registerButton.backgroundColor = .red
        registerButton.addTarget(self, action: #selector(registerAction), for: UIControl.Event.touchUpInside)
        registerButton.tag = 1
        self.view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: lineImage.bottomAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            registerButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            registerButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        self.userImage = userImage
        self.loginContent = loginContent
        self.userLabel = userLabel
        self.userText = userText
        self.passwordLabel = passwordLabel
        self.passwordText = passwordText
        self.loginButton = loginButton
        self.lineImage = lineImage
        self.registerButton = registerButton
        
        self.loginButton?.applyGradient(colors: [UIColor.red.cgColor, UIColor.yellow.cgColor])
        self.registerButton?.applyGradient(colors: [UIColor.red.cgColor, UIColor.yellow.cgColor])
    }
}

extension UIView {
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2
        
        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
}



