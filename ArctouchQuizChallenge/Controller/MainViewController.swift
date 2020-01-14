//
//  MainViewController.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let networkManager = NetWorkManager()
    let quizView = QuizView()
    var remoteAnwers = [String]()
    var myAnswers = [String]()
    var countDown: Timer!
    var totalTime = 300
    var timerHelper: TimerHelper? = nil
    
    override func loadView() {
        self.view = quizView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupDataView()
        self.quizView.tableView.delegate = self
        self.quizView.tableView.dataSource = self
        self.quizView.wordTextField.delegate = self
        self.timerHelper = TimerHelper(totalTime: self.totalTime, label: self.quizView.timeLabel)
        self.timerHelper?.globalResetDelegate = self
        self.quizView.startButton.addTarget(self, action: #selector(startCountDown), for: .touchUpInside)
        
    }
    
    fileprivate func getScore()->Int{
        return self.myAnswers.count
    }
    
    fileprivate func getAllAnswers()->Int{
        return self.remoteAnwers.count
    }
    
    fileprivate func changeStartButtonTitle(text: String) {
        self.quizView.startButton.setTitle(text, for: .normal)
    }
    /// This function do:
    ///- Reset myAnswers variable
    ///- Reload tableview data
    ///- Reset ScoreLabel
    fileprivate func resetScores() {
        self.myAnswers.removeAll()
        self.quizView.tableView.reloadData()
        self.quizView.setScoreLabel(did: self.getScore(), of: self.getAllAnswers())
    }
    
    
    @objc fileprivate func startCountDown(){
        if self.timerHelper?.wasStarted == false {
            self.timerHelper?.startTimer()
            changeStartButtonTitle(text: "Reset")
        }else{
            self.timerHelper?.endTimer(reset: true)
            self.changeStartButtonTitle(text: "Start")
            resetScores()
        }
    }
    ///- Setting a new value for titleLabel
    /// - Parameters:
    ///     - title: String
    private func settingTitle(_ title: String){
        self.quizView.titleLabel.text = title
    }
    ///- Making a remote request and appending data to variable remoteAnswers
    fileprivate func setupDataView(){
        self.quizView.showActivityIndicator(true)
        self.networkManager.get(T: QuizModel.self, service: .quiz) { (result) in
                    switch result{
                    case .success(let quizResult):
                        DispatchQueue.main.async {
                            self.quizView.showActivityIndicator(false)
                            guard let question = quizResult.question else{
                                print("Error when try unwrap question")
                                return
                            }
                            self.settingTitle(question)
                            guard let answers = quizResult.answer else{
                                print("Error when try unwrap answers")
                                return
                            }
                            self.remoteAnwers = answers
                            self.quizView.setScoreLabel(did: self.getScore(), of: self.getAllAnswers())
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
    }
    ///- Check if user won
    func isWinner()->Bool{
        if getScore() == getAllAnswers(){
            return true
        }
        return false
    }
    ///- Function to show some alert to user
    /// - Parameters:
    ///     - title: String
    ///     - text: String
    ///     - buttonTitle: String
    func alert(title: String, text: String, buttonTitle: String){
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: GlobalResetProcotol{
    ///- This function check if user won and show some message and then reset time and change button text
    func resetRightNow() {
        
        if isWinner(){
            let alertMessage = "Good job! You found all the answers on time. Keep up with the great work."
            alert(title: "Congratulations", text: alertMessage, buttonTitle: "Play Again")
        }else{
            let alertMessage = "Sorry, time is up! You got \(getScore()) out of \(getAllAnswers()) answers."
            alert(title: "Time finished", text: alertMessage, buttonTitle: "Try Again")
        }
        
        self.timerHelper?.endTimer(reset: true)
        self.changeStartButtonTitle(text: "Start")
        resetScores()
    }
}

