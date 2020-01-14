//
//  Constraints+QuizView.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import UIKit
extension QuizView: CodeView{
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(wordTextField)
        addSubview(tableView)
        addSubview(coverBottomView)
        coverBottomView.addSubview(scoreLabel)
        coverBottomView.addSubview(timeLabel)
        coverBottomView.addSubview(startButton)
        addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(loadingText)
    }
    
    func setupConstraints() {
        loadingView
            .magicCenterX(0, safeAreaLayoutGuide.centerXAnchor)
            .magicCenterY(0, safeAreaLayoutGuide.centerYAnchor)
            .magicWidth(98)
            .magicHeight(100)

        activityIndicator
            .magicCenterX(0, loadingView.centerXAnchor)
            .magicCenterY(0, loadingView.centerYAnchor)

        loadingText
            .magicTop(8, activityIndicator.bottomAnchor)
            .magicCenterX(0, loadingView.centerXAnchor)

        //storing titleTopConstraint to use when orientation is landscape and change your top constraint
        self.titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 44)
        NSLayoutConstraint.activate([self.titleTopConstraint])
        titleLabel
            .magicLeading(16,safeAreaLayoutGuide.leadingAnchor)
            .magicTrailing(16,safeAreaLayoutGuide.trailingAnchor)

        wordTextField
            .magicTop(16, titleLabel.bottomAnchor)
            .magicLeading(16, safeAreaLayoutGuide.leadingAnchor)
            .magicTrailing(16, safeAreaLayoutGuide.trailingAnchor)
            .magicHeight(40)

        tableView
            .magicTop(0, wordTextField.bottomAnchor)
            .magicLeading(16, safeAreaLayoutGuide.leadingAnchor)
            .magicTrailing(16, safeAreaLayoutGuide.trailingAnchor)

       coverBottomView
            .magicTop(0, tableView.bottomAnchor)
            .magicLeading(0,leadingAnchor)
            .magicTrailing(0,trailingAnchor)
        //storing coverBottomConstraint to use when orientation is landscape and change your top constraint
        self.coverBottomConstraint = coverBottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        NSLayoutConstraint.activate([self.coverBottomConstraint])

        scoreLabel
            .magicTop(0,coverBottomView.topAnchor)
            .magicLeading(16, safeArea.leadingAnchor)
            

        timeLabel
            .magicTop(0,coverBottomView.topAnchor)
            .magicCenterY(0, scoreLabel.centerYAnchor)
            .magicTrailing(16, safeArea.trailingAnchor)

        startButton
            .magicTop(16, scoreLabel.bottomAnchor)
            .magicBottom(16, coverBottomView.bottomAnchor)
            .magicTrailing(16, safeArea.trailingAnchor)
            .magicLeading(16, safeArea.leadingAnchor)
            .magicHeight(40)

    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}

