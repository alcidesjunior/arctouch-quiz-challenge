//
//  QuizScoreHelper.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 14/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import Foundation

class QuizScoreHelper{
    
    var scores = [String]()
    var remoteAnswers = [String]()
    
    init(scores: [String], remoteAnswers: [String]){
        self.scores = scores
        self.remoteAnswers = remoteAnswers
    }
    
    func getScores()->Int{
        return self.scores.count
    }
    
    func getAllAnswers()->Int{
        return self.remoteAnswers.count
    }
    
    func isWinner()->Bool{
        if getScores() == getAllAnswers(){
            return true
        }
        return false
    }
}
