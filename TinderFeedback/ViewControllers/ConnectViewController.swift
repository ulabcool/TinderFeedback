//
//  ConnectViewController.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {

    var networkManager: NetworkManager!

    var buttonConnect: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 6.0
        button.layer.borderWidth = 3.0
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColor(white: 1, alpha: 0.2)
        button.titleLabel?.font = Utils.clueBoldFont(size: 17)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    var imageViewLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "clue")
        iv.contentMode = .scaleAspectFit

        return iv
    }()

    var textFieldEmail: UITextField = {
        let tf = UITextField()
        tf.placeholder = "E-mail"
        tf.layer.borderWidth = 3.0
        tf.layer.cornerRadius = 6.0
        tf.layer.borderColor = Utils.focusColor().cgColor

        tf.backgroundColor = .white

        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        tf.leftView = padding
        tf.leftViewMode = .always

        tf.font = Utils.clueBoldFont(size: 15.0)
        tf.textColor = Utils.textFieldColor()
        return tf
    }()
    var textFieldPassword: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.placeholder = "Password"
        tf.layer.borderWidth = 3.0
        tf.layer.cornerRadius = 6.0
        tf.layer.borderColor = Utils.focusColor().cgColor

        tf.backgroundColor = .white

        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        tf.leftView = padding
        tf.leftViewMode = .always

        tf.font = Utils.clueBoldFont(size: 15.0)
        tf.textColor = Utils.textFieldColor()
        return tf
    }()

    var labelError: UILabel = {
        let label = UILabel()
        label.font = Utils.clueFont(size: 15)
        label.textColor = .white
        label.backgroundColor = Utils.errorColor()
        label.textAlignment = .center
        label.text = "Email/Password is not correct! Try again"
        return label
    }()

    let activityIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    }()

    let margin: CGFloat = 34

    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager = NetworkManager()
        // Do any additional setup after loading the view.
        buttonConnect.setTitle("Connect To Usbailla", for: .normal)

        view.addSubview(imageViewLogo)
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        imageViewLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        imageViewLogo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.addSubview(labelError)
        labelError.translatesAutoresizingMaskIntoConstraints = false
        labelError.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        labelError.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        labelError.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelError.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor, constant: 10).isActive = true
        labelError.alpha = 0.0
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: labelError.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: labelError.centerYAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.stopAnimating()

        view.addSubview(textFieldEmail)
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textFieldEmail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        textFieldEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        textFieldEmail.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFieldEmail.topAnchor.constraint(equalTo: labelError.bottomAnchor, constant: 10).isActive = true

        view.addSubview(textFieldPassword)
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        textFieldPassword.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        textFieldPassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 20).isActive = true

        view.addSubview(buttonConnect)
        buttonConnect.translatesAutoresizingMaskIntoConstraints = false
        buttonConnect.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        buttonConnect.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        buttonConnect.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonConnect.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 20).isActive = true

        buttonConnect.addTarget(self, action: #selector(connectAction(_:)), for: .touchUpInside)


//        textFieldPassword.text = "bougamza"
//        textFieldEmail.text = "adil"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func connectAction(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        let userEmail = textFieldEmail.text
        let userPassword = textFieldPassword.text
        self.view.endEditing(true)
        // Network request
        networkManager.login(login: userEmail!, password: userPassword!).then { clue in
            print(clue.text)

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                let tinderVC = TinderViewController()
                self.present(tinderVC, animated: true, completion: nil)
            }
        }.catch { _ in

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.labelError.alpha = 1.0
            }
            print("not right !")
        }
    }
}
