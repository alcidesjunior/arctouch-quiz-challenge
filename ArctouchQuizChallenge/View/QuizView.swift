//
//  QuizView.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import UIKit

extension UIFont {
    static var large = UIFont(name: "SFProDisplay-Bold", size: 34)
    static var body = UIFont(name: "SFProDisplay-Regular", size: 17)
    static var button = UIFont(name: "SFProDisplay-Semibold", size: 17)
}

final class QuizView: UIView{
    
    lazy var safeArea = self.layoutMarginsGuide
    var updatedConstraint: CGFloat = 0
    var coverBottomConstraint: NSLayoutConstraint!
    var titleTopConstraint: NSLayoutConstraint!
    
    lazy var loadingView: UIView = {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.style = .large
        view.color = .white
        return view
    }()
    
    lazy var loadingText: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .button
        view.text = "Loading..."
        view.textColor = .white
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .large
        view.numberOfLines = 0
        return view
    }()
    
    lazy var wordTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.attributedPlaceholder = NSAttributedString(string: "Insert Word...",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        view.borderStyle = .none
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: "customGray")
        view.textColor = .black
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.size.height))
        view.leftViewMode = .always
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.tableFooterView = UIView()
        return view
    }()
    
    lazy var coverBottomView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(named: "customGray")
        return view
    }()
    
    lazy var scoreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "00/00"
        view.font = .large
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "00:00"
        view.font = .large
        return view
    }()
    
    lazy var startButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.titleLabel?.font = .button
        view.setTitle("Start", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(named: "customOrange")
        view.layer.cornerRadius = 8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        settingNotificationCenter()
        registerCell()
        titleLabel.font = UIFont.large
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScoreLabel(did: Int, of: Int){
        var didString = String(did)
        if did < 10{
            didString = "0\(did)"
        }
        self.scoreLabel.text = "\(didString)/\(of)"
    }
    
    func setTimerLabel(totalTime: String = "00:00"){
        self.timeLabel.text = totalTime
    }
    
    fileprivate func registerCell(){
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    fileprivate func settingNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            guard let keyboardSize = notification.userInfo?  [UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                else { return }

            let keyboardHeight = keyboardSize.height
            let padding: CGFloat = 0
            self.updatedConstraint = -(keyboardHeight - safeAreaInsets.bottom + padding)
            UIView.animate(withDuration: 0.5) {
                self.coverBottomConstraint.constant = self.updatedConstraint
                
                if self.coverBottomConstraint.isActive{
                    NSLayoutConstraint.deactivate([self.coverBottomConstraint])
                    NSLayoutConstraint.activate([self.coverBottomConstraint])
                }
                
                if self.titleTopConstraint.isActive{
                    if UIDevice.current.orientation.isLandscape{
                        self.titleTopConstraint.constant = -10
                        NSLayoutConstraint.deactivate([self.titleTopConstraint])
                        NSLayoutConstraint.activate([self.titleTopConstraint])
                    }else{
                        self.titleTopConstraint.constant = 44
                        NSLayoutConstraint.deactivate([self.titleTopConstraint])
                        NSLayoutConstraint.activate([self.titleTopConstraint])
                    }
                }
                self.layoutIfNeeded()
            }
        }

        @objc func keyboardWillHide(notification: NSNotification) {
            UIView.animate(withDuration: 0.5) {
                self.coverBottomConstraint.constant = 0
                if self.coverBottomConstraint.isActive{
                    NSLayoutConstraint.deactivate([self.coverBottomConstraint])
                    NSLayoutConstraint.activate([self.coverBottomConstraint])
                }
                
                if self.titleTopConstraint.isActive{
                    self.titleTopConstraint.constant =  44
                    NSLayoutConstraint.deactivate([self.titleTopConstraint])
                    NSLayoutConstraint.activate([self.titleTopConstraint])
                    
                }
                self.layoutIfNeeded()
            }
        }
    
    func showActivityIndicator(_ active: Bool){
        if active{
            loadingView.isHidden = false
        }else{
            loadingView.isHidden = true
        }
        self.activityIndicator.startAnimating()
    }
}

