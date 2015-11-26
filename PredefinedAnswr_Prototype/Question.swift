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
    
    init(title:String, acceptedAnswers:[String]?, correctResponce:String, needsKeyboard: Bool, willBeSaved: Bool) {
        
        self.title = title
        self.acceptedAnswers = acceptedAnswers
        self.correctResponce = correctResponce
        self.needsKeyboard = needsKeyboard
        self.wilBeSaved = willBeSaved
        super.init()
    }
}