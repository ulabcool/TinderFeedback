//
//  ConnectViewController.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {

    @IBOutlet weak var buttonConnect: UIButton!
    @IBOutlet weak var imageViewLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonConnect.setTitle("Connect", for: .normal)
        buttonConnect.layer.cornerRadius = 3.0
        buttonConnect.layer.borderWidth = 2.0
        buttonConnect.layer.borderColor = UIColor.white.cgColor
        buttonConnect.backgroundColor = UIColor(white: 1, alpha: 0.2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func connectAction(_ sender: Any) {
        NetworkManager.login(login: "adil", password: "bougamza").then { clue in
            print(clue.text)
            }.catch { _ in
                print("not right !")
        }
//        let tinderVC = TinderViewController()
//        present(tinderVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
