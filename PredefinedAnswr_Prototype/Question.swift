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
    var needsKeyboard: Bool
    var wilBeSaved: Bool
    
    init(title:String, acceptedAnswers:[String]?, needsKeyboard: Bool, willBeSaved: Bool) {
        
        self.title = title
        self.acceptedAnswers = acceptedAnswers
        self.needsKeyboard = needsKeyboard
        self.wilBeSaved = willBeSaved
        super.init()
    }
}