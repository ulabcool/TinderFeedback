//
//  ConnectViewController.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {

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

    let margin: CGFloat = 34

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonConnect.setTitle("Connect To Usbailla", for: .normal)

        view.addSubview(imageViewLogo)
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        imageViewLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        imageViewLogo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewLogo.heightAnchor.constraint(equalToConstant: 100).isActive = true

        view.addSubview(textFieldEmail)
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textFieldEmail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        textFieldEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        textFieldEmail.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textFieldEmail.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor, constant: 25).isActive = true

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func connectAction(_ sender: Any) {
        let userEmail = textFieldEmail.text
        let userPassword = textFieldPassword.text
        // Network request
        NetworkManager.login(login: userEmail!, password: userPassword!).then { clue in
            print(clue.text)

            DispatchQueue.main.async {
                let tinderVC = TinderViewController()
                self.present(tinderVC, animated: true, completion: nil)
            }
        }.catch { _ in
            print("not right !")
        }


    }
}
