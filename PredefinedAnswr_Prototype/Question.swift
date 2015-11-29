//
//  question.swift
//  PredefinedAnswr_Prototype
//  Created by Daniel Robertson on 08/11/2015.
//  Copyright © 2015 Daniel Robertson. All rights reserved.
//

import Foundation

class Question:NSObject {
    
    var title: String!
    var acceptedAnswers: [String]?
    var correctResponce: String
    var needsKeyboard: Bool
    var wilBeSaved: Bool
    var image: String!
    
    init(title:String, acceptedAnswers:[String]?, correctResponce:String, needsKeyboard:Bool, willBeSaved:Bool, image:String) {
        
        self.title = title
        self.acceptedAnswers = acceptedAnswers
        self.correctResponce = correctResponce
        self.needsKeyboard = needsKeyboard
        self.wilBeSaved = willBeSaved
        self.image = image
        super.init()
    }
}