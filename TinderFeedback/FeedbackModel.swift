//
//  FeedbackModel.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import Foundation

class ClueModel {
    var clueId: String
    var text: String
    var rating: Int
    var date: String
    
    init(clueId: String, rating: Int, text: String, date: String) {
        self.clueId = clueId
        self.text = text
        self.rating = rating
        self.date = date
    }
}
