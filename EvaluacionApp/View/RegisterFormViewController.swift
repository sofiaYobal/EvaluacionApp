//
//  RegisterFormViewController.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 9/25/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import UIKit

class RegisterFormViewController: UIViewController {
    weak var titleLabel: UILabel?
    weak var scroll: UIScrollView?
    weak var contentView : UIView?
    weak var nameLabel : UILabel?
    weak var nameText : UITextField?
    weak var lastNameLabel : UILabel?
    weak var lastNameText: UITextField?
    weak var motherNameLabel: UILabel?
    weak var motherNameText: UITextField?
    weak var genderLabel: UILabel?
    weak var genderText : UITextField?
    weak var genderPicker: UIPickerView?
    weak var ageLabel: UILabel?
    weak var ageText : UITextField?
    weak var userLabel: UILabel?
    weak var userText: UITextField?
    weak var passwordLabel : UILabel?
    weak var passwordText : UITextField?
    weak var repeatLabel: UILabel?
    weak var repeatText: UITextField?
    //weak var registerButton : ButtonStile?
    weak var registerButton : UIButton?
    
    var name: String?
    var lastName: String?
    var motheLastName: String?
    var gender: String?
    var age: Int32?
    var user: String?
    var password: String?
    var repeatPassword: String?
    
    var genderArray : [String] = ["Femenino", "Masculino"]
    private let manager = CoreDataManager()
    
    override func loadView() {
        super.loadView()
        buildInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPickerView()
        self.initUI()
    }
    
    func initUI() {
        
    }
    
    func initPickerView(){
        genderPicker?.dataSource = self
        genderPicker?.delegate = self
    }
}


extension RegisterFormViewController {
    func valuesForm(){
        self.name = nameText?.text
        self.lastName = lastNameText?.text
        self.motheLastName = motherNameText?.text
        self.gender = genderText?.text
        self.age = Int32(ageText?.text ?? "0")
        self.user = userText?.text
        self.password = passwordText?.text
        self.repeatPassword = repeatText?.text
        
        print("name \(name ?? "")")
        print("lastName \(lastName ?? "")")
        print("motheLastName \(motheLastName ?? "")")
        print("gender \(gender ?? "")")
        print("age \(age ??  0)")
        print("user \(user ?? "")")
        print("password \(lastName ?? "")")
        print("repeatPassword \(repeatPassword ?? "")")
    }
    
    func validateForm() -> Bool{
        valuesForm()
        var box: String? = ""
        
        if self.repeatPassword == "" {
            box = "repetir contraseña"
        }
        
        if self.password == "" {
            box = "contraseña"
        }
        
        if self.user == ""{
            box = "usuario"
        }
        
        if self.age == 0 {
            box = "edad"
        }
        
        if self.gender == "" {
            box = "genero"
        }
        
        if self.motheLastName == "" {
            box = "apellido materno"
        }
        
        if self.lastName == "" {
            box = "apellido paterno"
        }
        
        if self.name == ""{
            box = "nombre"
        }
        
        if box != "" {
            
            let alertController = UIAlertController(title: "¡Advertencia!", message: "Debes ingresar el campo " + (box ?? "Campo vacio"), preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        let isValid = isValidPassword(password: password)
        if !isValid {
            let alertController = UIAlertController(title: "¡Advertencia!", message: "La constraseña debe contener letras mayusculas y minusculas, numeros, cacteres especiales y un tamaño minimo de ocho", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        let userRepeat = manager.fetchUserRepeat(user: self.user ?? "")
        if userRepeat == true{
            let alertController = UIAlertController(title: "¡Advertencia!", message: "El usuario ya esta siendo utilizado", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        if password != repeatPassword {
            let alertController = UIAlertController(title: "¡Advertencia!", message: "Las contraseñas no coinciden", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    /*^                                                          -Start Anchor.
     (?=.*[A-Z].*[A-Z])                            -Ensure string has two uppercase letters.
     (?=.[$@$#!%?&])                                -Ensure string has one special character.
     (?=.*[0-9].*[0-9])                              -Ensure string has two digits.
     (?=.*[a-z].*[a-z].?*[a-z])                 -Ensure string has three lowercase letters.
     {8,}                                                         -Ensure password length is 8.
     $                                                          -End Anchor. */
    
    func isValidPassword(password :String?) -> Bool {
        guard password != nil else {
            return false
        }
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    func ClearFields(){
        nameText?.text = ""
        lastNameText?.text = ""
        motherNameText?.text = ""
        genderText?.text = "Femenino"
        ageText?.text = ""
        userText?.text = ""
        passwordText?.text = ""
        repeatText?.text = ""
    }
    
    func register(){
        
        if validateForm() == true {
            
            manager.createUser(name: self.name ?? "", lastName: self.lastName ?? "", motherLast: motheLastName ?? "", gender: self.gender ?? "", age: Int32(self.age ?? 0), usuario: self.user ?? "", password: self.password ?? "") { [weak self] in
            }
            
            ClearFields()
            
            let alertController = UIAlertController(title: "¡Exito!", message: "Usuario registrado correctamente", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            return
        }
    }
    
    @objc func registerAction(sender: UIButton!){
        
        register()
    }
}

extension RegisterFormViewController {
    func buildInterface(){
        navigationController?.navigationBar.barTintColor = ColoresStruct.blueBack1
        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.isNavigationBarHidden = false
        
        self.view.applyGradient(colours: [ColoresStruct.blueBack1, ColoresStruct.blueBack2, ColoresStruct.blueBack3], locations: [0.0, 0.5, 1.0])
        
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scroll)
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Registrar"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            contentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentView.heightAnchor.constraint(equalToConstant: 450)
        ])
        
        let nameLabel = UILabel(frame: .zero)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Nombre"
        nameLabel.textColor = .white
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        let nametext = UITextField(frame: .zero)
        nametext.translatesAutoresizingMaskIntoConstraints = false
        nametext.backgroundColor = ColoresStruct.blueBack4
        nametext.textColor = UIColor.white
        contentView.addSubview(nametext)
        
        NSLayoutConstraint.activate([
            nametext.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nametext.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nametext.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nametext.heightAnchor.constraint(equalToConstant: 30)])
        
        let lastNameLabel = UILabel(frame: .zero)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.text = "Apellido paterno:"
        lastNameLabel.textColor = .white
        contentView.addSubview(lastNameLabel)
        
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: nametext.bottomAnchor, constant: 10),
            lastNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lastNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.495),
            lastNameLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        
        let motherNameLabel = UILabel(frame: .zero)
        motherNameLabel.translatesAutoresizingMaskIntoConstraints = false
        motherNameLabel.text = "Apellido materno:"
        motherNameLabel.textColor = .white
        contentView.addSubview(motherNameLabel)
        
        NSLayoutConstraint.activate([
            motherNameLabel.topAnchor.constraint(equalTo: nametext.bottomAnchor, constant: 10),
            motherNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            motherNameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.495),
            motherNameLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let lastNametext = UITextField(frame: .zero)
        lastNametext.translatesAutoresizingMaskIntoConstraints = false
        lastNametext.backgroundColor = ColoresStruct.blueBack4
        lastNametext.textColor = UIColor.white
        contentView.addSubview(lastNametext)
        
        NSLayoutConstraint.activate([
            lastNametext.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 5),
            lastNametext.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lastNametext.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.49),
            lastNametext.heightAnchor.constraint(equalToConstant: 30)])
        
        let motherNameText = UITextField(frame: .zero)
        motherNameText.translatesAutoresizingMaskIntoConstraints = false
        motherNameText.backgroundColor = ColoresStruct.blueBack4
        motherNameText.textColor = UIColor.white
        contentView.addSubview(motherNameText)
        
        NSLayoutConstraint.activate([
            motherNameText.topAnchor.constraint(equalTo: motherNameLabel.bottomAnchor, constant: 5),
            motherNameText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            motherNameText.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.49),
            motherNameText.heightAnchor.constraint(equalToConstant: 30)])
        
        let genderLabel = UILabel(frame: .zero)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.text = "Genero:"
        genderLabel.textColor = .white
        contentView.addSubview(genderLabel)
        
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: lastNametext.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genderLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.49),
            genderLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        let agelabel = UILabel(frame: .zero)
        agelabel.translatesAutoresizingMaskIntoConstraints = false
        agelabel.text = "Edad"
        agelabel.textColor = .white
        contentView.addSubview(agelabel)
        
        NSLayoutConstraint.activate([
            agelabel.topAnchor.constraint(equalTo: motherNameText.bottomAnchor, constant: 10),
            agelabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            agelabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.49),
            agelabel.heightAnchor.constraint(equalToConstant: 25)])
        
        let genderText = UITextField(frame: .zero)
        genderText.translatesAutoresizingMaskIntoConstraints = false
        genderText.backgroundColor = ColoresStruct.blueBack4
        genderText.textColor = UIColor.white
        genderText.text = "Femenino"
        contentView.addSubview(genderText)
        
        NSLayoutConstraint.activate([
            genderText.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 5),
            genderText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genderText.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.49),
            genderText.heightAnchor.constraint(equalToConstant: 30)])
        
        let genderPicker = UIPickerView()
        genderText.inputView = genderPicker
        
        let ageText = UITextField(frame: .zero)
        ageText.translatesAutoresizingMaskIntoConstraints = false
        ageText.keyboardType = UIKeyboardType.numberPad
        ageText.backgroundColor = ColoresStruct.blueBack4
        ageText.textColor = UIColor.white
        contentView.addSubview(ageText)
        
        NSLayoutConstraint.activate([
            ageText.topAnchor.constraint(equalTo: agelabel.bottomAnchor, constant: 5),
            ageText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ageText.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.49),
            ageText.heightAnchor.constraint(equalToConstant: 30)])
        
        let userLabel = UILabel(frame: .zero)
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        userLabel.text = "Usuario"
        userLabel.textColor = .white
        contentView.addSubview(userLabel)
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: ageText.bottomAnchor, constant: 10),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        let userText = UITextField(frame: .zero)
        userText.translatesAutoresizingMaskIntoConstraints = false
        userText.backgroundColor = ColoresStruct.blueBack4
        userText.textColor = UIColor.white
        contentView.addSubview(userText)
        
        NSLayoutConstraint.activate([
            userText.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 5),
            userText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userText.heightAnchor.constraint(equalToConstant: 30)])
        
        let passwordLabel = UILabel(frame: .zero)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.text = "Contraseña"
        passwordLabel.textColor = .white
        contentView.addSubview(passwordLabel)
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: userText.bottomAnchor, constant: 10),
            passwordLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            passwordLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            passwordLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        let passwordText = UITextField(frame: .zero)
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.backgroundColor = ColoresStruct.blueBack4
        passwordText.textColor = UIColor.white
        passwordText.isSecureTextEntry = true
        contentView.addSubview(passwordText)
        
        NSLayoutConstraint.activate([
            passwordText.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            passwordText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            passwordText.heightAnchor.constraint(equalToConstant: 30)])
        
        let repeatLabel = UILabel(frame: .zero)
        repeatLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatLabel.text = "Repetir contraseña"
        repeatLabel.textColor = .white
        contentView.addSubview(repeatLabel)
        
        NSLayoutConstraint.activate([
            repeatLabel.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 10),
            repeatLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            repeatLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            repeatLabel.heightAnchor.constraint(equalToConstant: 25)])
        
        let repeatText = UITextField(frame: .zero)
        repeatText.translatesAutoresizingMaskIntoConstraints = false
        repeatText.backgroundColor = ColoresStruct.blueBack4
        repeatText.textColor = UIColor.white
        repeatText.isSecureTextEntry = true
        contentView.addSubview(repeatText)
        
        NSLayoutConstraint.activate([
            repeatText.topAnchor.constraint(equalTo: repeatLabel.bottomAnchor, constant: 10),
            repeatText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            repeatText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            repeatText.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        let registerButton = UIButton(frame: .zero)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Registrar", for: .normal)
        registerButton.addTarget(self, action: #selector(registerAction) , for: UIControl.Event.touchUpInside)
        self.view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 30),
            registerButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            registerButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            registerButton.heightAnchor.constraint(equalToConstant: 45)])
        
        self.titleLabel = titleLabel
        self.contentView =  contentView
        self.nameLabel = nameLabel
        self.nameText = nametext
        self.lastNameLabel = lastNameLabel
        self.motherNameLabel = motherNameLabel
        self.lastNameText = lastNametext
        self.motherNameText = motherNameText
        self.genderLabel = genderLabel
        self.ageLabel = agelabel
        self.genderText = genderText
        self.genderPicker = genderPicker
        self.ageText = ageText
        self.userLabel = userLabel
        self.userText = userText
        self.passwordLabel = passwordLabel
        self.passwordText = passwordText
        self.repeatLabel = repeatLabel
        self.repeatText = repeatText
        self.registerButton = registerButton
        
        self.registerButton?.applyGradient(colors: [UIColor.red.cgColor, UIColor.yellow.cgColor])
        
    }
}

extension RegisterFormViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderText?.text = genderArray[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

