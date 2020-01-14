//
//  TimerHelper.swift
//  ArctouchQuizChallenge
//
//  Created by Alcides Junior on 13/01/20.
//  Copyright © 2020 Alcides Junior. All rights reserved.
//

import UIKit
/// Protocol used for trigger some action when time end
protocol GlobalResetProcotol{
    func resetRightNow()
}

/// This class is a helper for manage some functions to timer
class  TimerHelper{
    
    var countDown: Timer!
    var totalTime: Int
    var currentTime: Int
    var label: UILabel
    var wasStarted: Bool = false
    var globalResetDelegate: GlobalResetProcotol? = nil
    
    init(totalTime: Int, label: UILabel){
        self.totalTime = totalTime
        self.currentTime = totalTime
        self.label = label
        setLabelTime(value: currentTime)
    }
    
    func startTimer(){
        self.countDown = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        self.wasStarted = true
    }
    
    fileprivate func setLabelTime(value: Int){
        self.label.text = "\(timerFormatted(value))"
    }
    
    @objc fileprivate func updateTime(){
        self.setLabelTime(value: currentTime)
        
        if self.currentTime != 0{
            self.currentTime -= 1
        }else{
            self.endTimer()
        }
    }
    
    
    func endTimer(reset: Bool = false){
        if reset{
           setLabelTime(value: totalTime)
           self.currentTime = totalTime
        }else{
            globalResetDelegate?.resetRightNow()
        }
        self.wasStarted = false
        countDown.invalidate()
        
    }
    /// This function works converting integer value to time format
    fileprivate func timerFormatted(_ totalSeconds: Int)->String{
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
///Used only for tests!
#if DEBUG
extension TimerHelper{
    internal func testTimerFormatted(_ totalSeconds: Int)->String{
        self.timerFormatted(totalSeconds)
    }
    
    internal func testSetLabel(value: Int){
        self.setLabelTime(value: value)
    }
}
#endif
