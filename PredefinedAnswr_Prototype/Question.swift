//
//  question.swift
//  PredefinedAnswr_Prototype
//  Created by Daniel Robertson on 08/11/2015.
//  Copyright © 2015 Daniel Robertson. All rights reserved.
//

import Foundation

class Question:NSObject {
    
    var title: String!
    var acceptedAnswers: [String]
    
    
    init(title:String, acceptedAnswers:[String]) {
        
        self.title = title
        self.acceptedAnswers = acceptedAnswers
        
        super.init()
    }
}