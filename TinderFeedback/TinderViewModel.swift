//
//  TinderViewModel.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import Foundation

class TinderViewModel {

    var feedbackModels: [FeedbackModel]!
    
    init(feedbackModels: [FeedbackModel]) {
        self.feedbackModels = feedbackModels
    }
    
    func viewModelForIndex(index: Int) -> FeedbackTinderViewModel {
        let vm = FeedbackTinderViewModel(model: feedbackModels[index])
        return vm
    }

}
