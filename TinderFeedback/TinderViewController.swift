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
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.25)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.layer.cornerRadius = 35.0
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let buttonLove: UIButton = {
        let imageName = "heart"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.25)
        button.layer.cornerRadius = 35.0
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let buttonShare: UIButton = {
        let imageName = "share"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.backgroundColor = UIColor(white: 1.0, alpha: 0.25)
        button.layer.cornerRadius = 35.0
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let labelTitleEnd: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 35)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "That's it for now!"

        return label
    }()

    let labelMessageEnd: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Light", size: 19)
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your visitors are grateful\nfor your attention"

        return label
    }()

    let labelFeedbackCount: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 18)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Utils.colorForRating(rating: 5)
        // add end labels
        view.addSubview(labelFeedbackCount)
        view.addSubview(labelTitleEnd)
        view.addSubview(labelMessageEnd)

        labelFeedbackCount.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        labelFeedbackCount.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelFeedbackCount.heightAnchor.constraint(equalToConstant: 60).isActive = true
        labelFeedbackCount.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true

        labelMessageEnd.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        labelMessageEnd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelMessageEnd.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        labelMessageEnd.heightAnchor.constraint(equalToConstant: 60).isActive = true

        labelTitleEnd.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        labelTitleEnd.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelTitleEnd.bottomAnchor.constraint(equalTo: labelMessageEnd.topAnchor, constant: -10).isActive = true
        labelTitleEnd.heightAnchor.constraint(equalToConstant: 40).isActive = true

        // add options stack view
        view.addSubview(stackivew)
        let stackViewWidth = (buttonSize * 3) + (stackViewSpacing * 3)
        stackivew.widthAnchor.constraint(equalToConstant: stackViewWidth).isActive = true
        stackivew.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackivew.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        stackivew.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true

        addOptionsView()

        loadClues()

    }

    func loadClues() {
        FeedbackStore.loadFeedback().then { clues in
            self.viewModel = TinderViewModel(feedbackModels: clues)
            let lastFeedback = self.viewModel.feedbackModels.last

            DispatchQueue.main.async {
                self.setupBackgroundFor(feedback: lastFeedback!)
                for i in 0..<self.viewModel.feedbackModels.count {
                    self.addView(index: i)
                }
            }
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
        swipeView?.topAnchor.constraint(equalTo: labelFeedbackCount.bottomAnchor, constant: 10).isActive = true
    }

    func setupBackgroundFor(feedback: ClueModel) {
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

        currentFeedbackIndex += 1

        if wasChosenWith == .left {
            print("Photo deleted!")
        } else {
            print("Photo saved!")
        }


        if currentFeedbackIndex >= self.viewModel.feedbackModels.count {
            stackivew.alpha = 0.0
            labelFeedbackCount.alpha = 0.0
        } else {
            let remainingClues = viewModel.feedbackModels.count - currentFeedbackIndex
            labelFeedbackCount.text = "You got \(remainingClues) new clues"
            setupBackgroundFor(feedback: viewModel.feedbackModels[remainingClues - 1])
        }
    }
}
