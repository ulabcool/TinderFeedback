//
//  FeedbackTinderViewModel.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import Foundation

class FeedbackTinderViewModel {
    
    let model: ClueModel!
    var feedbackText: String
    var ratingImage: String
    var feedbackDate: String
    
    init(model: ClueModel) {
        self.model = model
        
        self.feedbackText = model.text
        self.feedbackDate = model.date
        
        var imageName = ""
        switch model.rating {
        case 1:
            imageName = "hate"
        case 2:
            imageName = "sad"
        case 3:
            imageName = "normal"
        case 4:
            imageName = "happy"
        default:
            imageName = "love"
        }
        
        self.ratingImage = imageName
    }
    
    

}
