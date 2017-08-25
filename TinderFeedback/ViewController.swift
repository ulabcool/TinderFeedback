//
//  ViewController.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

class ViewController: UIViewController {

    lazy var options: MDCSwipeToChooseViewOptions = {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "Keep"
        options.likedColor = UIColor.blue
        options.nopeText = "Delete"
        options.nopeColor = UIColor.red
        options.onPan = { state -> Void in
            if state?.thresholdRatio == 1 && state?.direction == .left {
                print("Photo deleted!")
            }
        }
        return options
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        for _ in 0...5 {
            addView()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addView() {
        let swipeView = MDCSwipeToChooseView(frame: self.view.bounds, options: options)
        //        view?.imageView.image = UIImage(named: "photo.png")
        
        swipeView?.backgroundColor = .green
        self.view.addSubview(swipeView!)
        swipeView?.layer.cornerRadius = 6.0
        swipeView?.clipsToBounds = true
        
        let label = UILabel()
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = "some text here"
        swipeView?.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: (swipeView?.leftAnchor)!, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: (swipeView?.rightAnchor)!, constant: -20).isActive = true
        label.bottomAnchor.constraint(equalTo: (swipeView?.bottomAnchor)!, constant: -50).isActive = true
        label.topAnchor.constraint(equalTo: (swipeView?.topAnchor)!, constant: 50).isActive = true

        
        
        
        swipeView?.translatesAutoresizingMaskIntoConstraints = false
        swipeView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        swipeView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        swipeView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        swipeView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }
}

extension ViewController: MDCSwipeToChooseDelegate {

    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(_ view: UIView) -> Void {
        print("Couldn't decide, huh?")
    }

    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(_ view: UIView, shouldBeChosenWith: MDCSwipeDirection) -> Bool {
        return true
//        if shouldBeChosenWith == .left {
//            return true
//        } else {
//            // Snap the view back and cancel the choice.
//            UIView.animate(withDuration: 0.16, animations: { () -> Void in
//                view.transform = CGAffineTransform.identity
//                view.center = view.superview!.center
//            })
//            return false
//        }
    }

    // This is called when a user swipes the view fully left or right.
    func view(_ view: UIView, wasChosenWith: MDCSwipeDirection) -> Void {
//        addView()
        if wasChosenWith == .left {
            print("Photo deleted!")
        } else {
            print("Photo saved!")
        }
    }
}
