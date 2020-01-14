//
//  WordText+MainViewController.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import UIKit

extension MainViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.quizView.wordTextField.resignFirstResponder()
    }
    
    fileprivate func scrollTableViewRow() {
        if (self.myAnswers.count - 1) > 1{
            let indexPath = NSIndexPath(item: self.myAnswers.count - 1, section: 0)
            self.quizView.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.middle, animated: true)
        }
    }
    
    fileprivate func setNewTableRow(_ text: String) {
        self.myAnswers.append(text.capitalizingFirstLetter())
        self.quizView.tableView.reloadData()
        self.quizView.wordTextField.text = ""
        scrollTableViewRow()
        let asserts = self.myAnswers.count
        let totalRemoteAnswers = self.remoteAnwers.count
        self.quizView.setScoreLabel(did: asserts, of: totalRemoteAnswers)
    }
    
    fileprivate func wordTextToTableView(_ textField: UITextField) {
        if let text = textField.text{
            if self.remoteAnwers.contains(text.lowercased()){
                if self.myAnswers.contains(text.capitalizingFirstLetter()) == false{
                    setNewTableRow(text)
                    if isWinner(){
                        let alertMessage = "Good job! You found all the answers on time. Keep up with the great work."
                        alert(title: "Congratulations", text: alertMessage, buttonTitle: "Play Again")
                    }
                }else{
                    self.quizView.wordTextField.backgroundColor = UIColor(named: "customOrange")
                    UIView.animate(withDuration: 0.6) {
                        self.quizView.wordTextField.backgroundColor = UIColor(named: "customOrange")
                    }
                }
            }
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.timerHelper!.wasStarted {
            wordTextToTableView(textField)
        }
    }
    
    
}

