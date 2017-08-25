//
//  FeedbackModel.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import Foundation

class FeedbackModel {
    var text: String
    var rating: Int
    var date: String
    
    init(rating: Int, text: String, date: String) {
        self.text = text
        self.rating = rating
        self.date = date
    }
}
