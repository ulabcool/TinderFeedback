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
    var currentFeedbackIndex = 0

    let buttonSize: CGFloat = 70
    let stackViewSpacing: CGFloat = 10

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

    lazy var stackivew: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = UIColor.gray
        sv.distribution = .equalSpacing
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    let buttonHate: UIButton = {
        let imageName = "cross"
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        button.setImage(UIImage(named: imageName), for: .normal)
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 35.0
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let buttonLove: UIButton = {
        let imageName = "heart"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 35.0
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let buttonShare: UIButton = {
        let imageName = "share"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 35.0
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = TinderViewModel(feedbackModels: FeedbackStore.loadFeedback())

        let lastFeedback = self.viewModel.feedbackModels.last
        setupBackgroundFor(feedback: lastFeedback!)

        // add options stack view
        view.addSubview(stackivew)
        let stackViewWidth = (buttonSize * 3) + (stackViewSpacing * 3)
        stackivew.widthAnchor.constraint(equalToConstant: stackViewWidth).isActive = true
        stackivew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackivew.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        stackivew.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true

        addOptionsView()

        for i in 0..<self.viewModel.feedbackModels.count {
            addView(index: i)
        }
    }

    func addOptionsView() {
        stackivew.addArrangedSubview(buttonHate)
        stackivew.addArrangedSubview(buttonShare)
        stackivew.addArrangedSubview(buttonLove)


        buttonHate.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        buttonHate.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true

        buttonShare.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        buttonShare.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true

        buttonLove.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        buttonLove.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true

    }

    func addView(index: Int) {
        let swipeView = FeedbackTinderView(viewModel: viewModel.viewModelForIndex(index: index), frame: self.view.bounds, options: options)
        self.view.addSubview(swipeView!)

        swipeView?.translatesAutoresizingMaskIntoConstraints = false
        swipeView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        swipeView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        swipeView?.bottomAnchor.constraint(equalTo: stackivew.topAnchor, constant: -30).isActive = true
        swipeView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
    }


    func setupBackgroundFor(feedback: FeedbackModel) {
        view.backgroundColor = Utils.colorForRating(rating: feedback.rating)
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
        setupBackgroundFor(feedback: viewModel.feedbackModels[currentFeedbackIndex])
        currentFeedbackIndex += 1

        if wasChosenWith == .left {
            print("Photo deleted!")
        } else {
            print("Photo saved!")
        }
    }
}
