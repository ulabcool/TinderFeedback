//
//  TinderViewController.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import UIKit
import MDCSwipeToChoose

class TinderViewController: UIViewController {

    var viewModel: TinderViewModel!

    lazy var options: MDCSwipeToChooseViewOptions = {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = ""
        options.likedColor = UIColor.clear
        options.nopeText = ""
        options.nopeColor = UIColor.clear
        options.onPan = { state -> Void in
            if state?.thresholdRatio == 1 && state?.direction == .left {
                print("Photo deleted!")
            }
        }
        return options
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = TinderViewModel(feedbackModels: FeedbackStore.loadFeedback())

        view.backgroundColor = .red

        for i in 0..<self.viewModel.feedbackModels.count {
            addView(index: i)
        }

    }

    func addView(index: Int) {
        let swipeView = FeedbackTinderView(viewModel: viewModel.viewModelForIndex(index: index), frame: self.view.bounds, options: options)
        self.view.addSubview(swipeView!)

        swipeView?.translatesAutoresizingMaskIntoConstraints = false
        swipeView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        swipeView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        swipeView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        swipeView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
    }
}

extension TinderViewController: MDCSwipeToChooseDelegate {

    // This is called when a user didn't fully swipe left or right.
    func viewDidCancelSwipe(_ view: UIView) -> Void {
        print("Couldn't decide, huh?")
    }

    // Sent before a choice is made. Cancel the choice by returning `false`. Otherwise return `true`.
    func view(_ view: UIView, shouldBeChosenWith: MDCSwipeDirection) -> Bool {
        return true
    }

    // This is called when a user swipes the view fully left or right.
    func view(_ view: UIView, wasChosenWith: MDCSwipeDirection) -> Void {
        if wasChosenWith == .left {
            print("Photo deleted!")
        } else {
            print("Photo saved!")
        }
    }
}
