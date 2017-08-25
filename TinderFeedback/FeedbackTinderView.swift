//
//  FeedbackTinderView.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import UIKit
import MDCSwipeToChoose


class FeedbackTinderView: MDCSwipeToChooseView {

    var viewModel: FeedbackTinderViewModel!
    
    var labelFeedbackText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1.0)
        label.sizeToFit()
        label.font = UIFont(name: "Avenir-Book", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    var labelDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    var imageViewEmoji: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    init!(viewModel: FeedbackTinderViewModel, frame: CGRect, options: MDCSwipeToChooseViewOptions!) {
        super.init(frame: frame, options: options)
        
        backgroundColor = .white
        layer.cornerRadius = 10.0
        clipsToBounds = true

        self.addSubview(imageViewEmoji)
        self.addSubview(labelFeedbackText)
        addSubview(labelDate)
        
        labelFeedbackText.text = viewModel.feedbackText
        labelDate.text = viewModel.feedbackDate
        imageViewEmoji.image = UIImage(named: viewModel.ratingImage)
        
        imageViewEmoji.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageViewEmoji.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageViewEmoji.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageViewEmoji.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        
        labelFeedbackText.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        labelFeedbackText.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        labelFeedbackText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50).isActive = true
        labelFeedbackText.topAnchor.constraint(equalTo: imageViewEmoji.bottomAnchor, constant: 20).isActive = true
        
        labelDate.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        labelDate.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        labelDate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        labelDate.topAnchor.constraint(equalTo: labelFeedbackText.bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
