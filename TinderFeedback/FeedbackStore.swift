//
//  FeedbackStore.swift
//  TinderFeedback
//
//  Created by Adil Bougamza on 25/08/2017.
//  Copyright © 2017 Adil Bougamza. All rights reserved.
//

import Foundation


class FeedbackStore {
    class func loadFeedback() -> [FeedbackModel] {
        let feedbackModels = [
            FeedbackModel(rating: 1, text: "I’m struggling to view all the feedback, and a message appears saying that the page doesn’t exist", date: "08 August 2017, 14:29:03"),
            
            FeedbackModel(rating: 5, text: "Very user-friendly and easy to use. Also very competent and engaging Support.", date: "15 August 2017, 12:04:07"),
            
            FeedbackModel(rating: 3, text: "It would be super useful to have a 'preview' option directly from the hamburger dots menu. Now I have to go into Edit mode to see what the survey looks like", date: "06 June 2017, 11:08:07"),
            
            FeedbackModel(rating: 4, text: "Hi there, I just requested a demo, but I'm really after some price indication and compliance information in regards to user data collection of those leaving feedback - I'm asking this on behalf of a public service organisation in the UK (Transport for London / tfl.gov.uk ) Kind regards, Elmer Zinkhann", date: "11 April 2017, 14:29:03"),
            
            FeedbackModel(rating: 2, text: "I would like an easy way to respond to the user's feedback. It seems you used to provide this, but now I don't see how to quickly reply without copying the email address and opening my email client.", date: "09 May 2017, 19:21:07")
        ]

        return feedbackModels
    }
}
