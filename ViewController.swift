//
//  ViewController.swift
//  How many letters did i write
//
//  Created by Furkan Ceylan on 25.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let writeTextView = UITextView()
    var timer = Timer()
    let timeLabel = UILabel()
    var counte = 0
    let checkButton = UIButton()
    let resultLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counte = 15
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        writeTextView.text = ""
        writeTextView.textColor = .black
        writeTextView.backgroundColor = .white
        writeTextView.textAlignment = .left
        writeTextView.frame = CGRect(x: (width * 0.5) - (width * 0.9 / 2), y: height * 0.1, width: width * 0.9, height: height * 0.5)
        writeTextView.layer.cornerRadius = 4
        view.addSubview(writeTextView)
        
        timeLabel.text = "Time : \(timer)"
        timeLabel.textColor = .white
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.frame = CGRect(x: (width * 0.5) - (width * 0.8 / 2), y: height * 0.7 - 19, width: width * 0.8, height: 38)
        view.addSubview(timeLabel)
        
        resultLabel.text = ""
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        resultLabel.frame = CGRect(x: (width * 0.5) - (width * 0.8 / 2), y: height * 0.74 - 19, width: width * 0.8, height: 38)
        view.addSubview(resultLabel)
        
        checkButton.setTitle("Check It", for: UIControl.State.normal)
        checkButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        checkButton.layer.cornerRadius = 4
        checkButton.frame = CGRect(x: width * 0.5 - (width * 0.3 / 2), y: height * 0.8 - 17, width: width * 0.3, height: 34)
        checkButton.backgroundColor = UIColor(red: 205/255, green: 194/255, blue: 174/255, alpha: 0.5)
        checkButton.addTarget(self, action: #selector(checkClick), for: UIControl.Event.touchUpInside)
        
        view.addSubview(checkButton)
        
        view.backgroundColor = .gray
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    
    @objc func timerFunc(){
        timeLabel.text = "Time : \(counte)"
        counte -= 1
        if counte < 0{
            timeLabel.text = "Time is Over"
            timer.invalidate()
            resultLabel.text = "You wrote \(self.writeTextView.text.count) letters"
            overMessage()
        }
    }
    
    @objc func checkClick(){
        self.resultLabel.text = "You wrote \(self.writeTextView.text.count) letters"
    }
    
    @objc func overMessage(){
        let alertMessage = UIAlertController(title: "Is Over", message: "Do you want to try again ?", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { alertMessage in
            self.counte = 15
            self.writeTextView.text = ""
            self.resultLabel.text = ""
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunc), userInfo: nil, repeats: true)
        }
        let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.default) { alertMessage in
            self.writeTextView.isUserInteractionEnabled = false
        }
        alertMessage.addAction(okButton)
        alertMessage.addAction(noButton)
        
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


}

