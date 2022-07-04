//
//  TimerViewController.swift
//  MC2-Group6
//
//  Created by Elvina Jacia on 27/06/22.
//

import UIKit
import UserNotifications


class TimerViewController: UIViewController {
    
    
    //outlet
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeSubtitle: UILabel!
    @IBOutlet weak var timeDesc: UILabel!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    
    //variable
    

    //Timer
    var timer = Timer()
    var isTimerStarted = false
    
    
    //def
    var chosenTime = 0
    var selectedTime = ""
    var pomodoroInterval = 0
    
    
    //Circle progress bar
    let foreLineProgressLayer = CAShapeLayer()
    let backLineProgressLayer = CAShapeLayer()
    let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    var isAnimationStart = false
    
    //Var imageview icon
    var imageIcon: UIImageView!
    let focusIcon = UIImage(named:"focusIcon")
    let breakIcon = UIImage(named:"breakIcon")
    
    //Notification
    let notifCenter  = UNUserNotificationCenter.current()
    var selectedContent = UNMutableNotificationContent()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let gear = UIImage(systemName: "gearshape")
        let settingView = UIImageView(image: gear)
        settingView.isUserInteractionEnabled = true
        let taps = UITapGestureRecognizer(target: self, action: #selector(goToSetting))
        settingView.addGestureRecognizer(taps)
        let settingItem = UIBarButtonItem(customView: settingView)
        navigationItem.rightBarButtonItem = settingItem
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        chosenTime = defaultFocusTime
        selectedTime = "Focus Time"
        focusTimeList()
        playButton.layer.cornerRadius = 5
        changePauseToPlay()
        drawBackLayer()

        let iconSize: CGFloat = self.view.frame.height > 735 ? 130 : 110
        imageIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
        imageIcon.center = CGPoint(x: view.frame.midX, y: view.frame.midY-40)
        imageIcon.contentMode = .scaleAspectFit
        view.addSubview(imageIcon)
        imageIcon.image = focusIcon
        imageIcon.tintColor = UIColor.white
        
        askForPermission()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        chosenTime = defaultFocusTime
        selectedTime = "Focus Time"
        focusTimeList()
        stopBtnAction(stopButton)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }


    @objc func goToSetting() {
        self.performSegue(withIdentifier: "goToSetting", sender: UIButton.self() )
    }
    
    @IBAction func playBtnAction(_ sender: UIButton) {
        
        if !isTimerStarted{
            startTimer()
            isTimerStarted = true
        
            if selectedTime == "Focus Time"{
                drawFocusForeLayer()
            } else{
                drawBreakForeLayer()
            }
            startResumeAnimation()
            changePlayToPause()
            setNotification()
    
        }else{
            timer.invalidate()
            isTimerStarted = false
          
            pauseAnimation()
            changePauseToPlay()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
        
    }
    
    
    @IBAction func stopBtnAction(_ sender: UIButton) {
        timer.invalidate()
        stopAnimation()

        if selectedTime == "Focus Time"{
            chosenTime = defaultFocusTime
            focusTimeList()
        } else if selectedTime == "Short Break"{
            chosenTime = defaultShortBreakTime
            shortBreakTimeList()
        } else if selectedTime == "Long Break"{
            chosenTime = defaultLongBreakTime
            longBreakTimeList()
        }
    
        changePauseToPlay()
        isTimerStarted = false
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
    }
    
        func changePauseToPlay(){
            playButton.setTitle("Play", for: .normal)
            playButton.setImage(UIImage(systemName: "play.fill")?.withTintColor(.darkBlue, renderingMode: .alwaysOriginal), for: .normal)
            playButton.backgroundColor = UIColor.systemGray5
            playButton.setTitleColor(UIColor.darkBlue, for: .normal)
        }
        
        func changePlayToPause(){
            playButton.setTitle("Pause", for: .normal)
            playButton.setImage(UIImage(systemName: "pause.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
            playButton.setTitleColor(UIColor.white, for: .normal)
            playButton.backgroundColor = UIColor.clear
            playButton.layer.borderWidth = 1.5
            playButton.layer.borderColor = UIColor.white.cgColor
        }

    
        func startTimer(){
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimeLabel)), userInfo: nil, repeats: true)
        }
        
        @objc func updateTimeLabel(){
            if chosenTime < 1{
                changePauseToPlay()
                timer.invalidate()
                stopAnimation()
        
                if selectedTime == "Focus Time"{
                pomodoroInterval += 1
                }
            
            if selectedTime == "Focus Time"{
                timeSubtitle.text = "Focus Time"
                timeDesc.text = "Do your task now"
                
                if pomodoroInterval == defaultLongBreakAfter{
                    timeSubtitle.text = "Break Time"
                    timeDesc.text = "Drink some water & take a nap"
                    
                    selectedTime = "Long Break"
                    chosenTime = defaultLongBreakTime
                    longBreakTimeList()

                    pomodoroInterval = 0
                    
                    drawBreakForeLayer()
                    imageIcon.image = breakIcon

                } else if pomodoroInterval < defaultLongBreakAfter{
                    timeSubtitle.text = "Break Time"
                    timeDesc.text = "Drink some water & take a nap"
                    
                    selectedTime = "Short Break"
                    chosenTime = defaultShortBreakTime
                    shortBreakTimeList()
              
                    drawBreakForeLayer()
                    imageIcon.image = breakIcon
                }
                    
            } else if selectedTime == "Short Break"{
                timeSubtitle.text = "Focus Time"
                timeDesc.text = "Do your task now"
       
                selectedTime = "Focus Time"
                chosenTime = defaultFocusTime
                focusTimeList()
      
                drawFocusForeLayer()
                imageIcon.image = focusIcon
                

            } else if selectedTime == "Long Break"{
                timeSubtitle.text = "Focus Time"
                timeDesc.text = "Do your task now"
           
                selectedTime = "Focus Time"
                chosenTime = defaultFocusTime
                focusTimeList()
       
                drawFocusForeLayer()
                imageIcon.image = focusIcon
            }
            isTimerStarted = false
        }
        else{
            chosenTime -= 1
            timeLabel.text = timeFormat()
        }
    }
    
    func timeFormat()-> String{
        let minutes = Int(chosenTime) / 60 % 60
        let seconds = Int(chosenTime) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func focusTimeList(){
        if chosenTime == 300{
            timeLabel.text = "05:00"
        } else if chosenTime == 600{
            timeLabel.text = "10:00"
        } else if chosenTime == 900{
            timeLabel.text = "15:00"
        } else if chosenTime == 1200{
            timeLabel.text = "20:00"
        } else if chosenTime == 1500 {
            timeLabel.text = "25:00"
        } else if chosenTime == 1800{
            timeLabel.text = "30:00"
        } else if chosenTime == 2100{
            timeLabel.text = "35:00"
        } else if chosenTime == 2400{
            timeLabel.text = "40:00"
        } else if chosenTime == 2700{
            timeLabel.text = "45:00"
        } else if chosenTime == 3000{
            timeLabel.text = "50:00"
        } else if chosenTime == 3300{
            timeLabel.text = "55:00"
        } else if chosenTime == 3600{
            timeLabel.text = "60:00"
        } //nambah buat nyoba doang
        else if chosenTime == 10{
            timeLabel.text = "00:10"
        }
       
    }
    
    func shortBreakTimeList(){
        if chosenTime == 60{
            timeLabel.text = "01:00"
        } else if chosenTime == 120{
            timeLabel.text = "02:00"
        } else if chosenTime == 180{
            timeLabel.text = "03:00"
        } else if chosenTime == 240{
            timeLabel.text = "04:00"
        } else if chosenTime == 300 {
            timeLabel.text = "05:00"
        } else if chosenTime == 360 {
            timeLabel.text = "06:00"
        } else if chosenTime == 420 {
            timeLabel.text = "07:00"
        } else if chosenTime == 480 {
            timeLabel.text = "08:00"
        } else if chosenTime == 540 {
            timeLabel.text = "09:00"
        } else if chosenTime == 600 {
            timeLabel.text = "10:00"
        }
    }
    
    func longBreakTimeList(){
        if chosenTime == 1200{
            timeLabel.text = "20:00"
        } else if chosenTime == 1500{
            timeLabel.text = "25:00"
        } else if chosenTime == 1800{
            timeLabel.text = "30:00"
        } else if chosenTime == 2100{
            timeLabel.text = "35:00"
        } else if chosenTime == 2400 {
            timeLabel.text = "40:00"
        } else if chosenTime == 2700 {
            timeLabel.text = "45:00"
        } else if chosenTime == 3000 {
            timeLabel.text = "50:00"
        } else if chosenTime == 3300 {
            timeLabel.text = "55:00"
        } else if chosenTime == 3600 {
            timeLabel.text = "60:00"
        }
    }
    
    func drawBackLayer(){
        let rads: CGFloat = self.view.frame.height > 735 ? 115 : 90
        backLineProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY-40), radius: rads, startAngle: -90.degreeToRadian, endAngle: 270.degreeToRadian, clockwise: true).cgPath
        backLineProgressLayer.strokeColor = UIColor.softBlue.cgColor
        backLineProgressLayer.fillColor = UIColor.clear.cgColor
        backLineProgressLayer.lineWidth = 8
        view.layer.addSublayer(backLineProgressLayer)
    }

    func drawFocusForeLayer(){
        let rads: CGFloat = self.view.frame.height > 735 ? 115 : 90
        foreLineProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY-40), radius: rads, startAngle: -90.degreeToRadian, endAngle: 270.degreeToRadian, clockwise: true).cgPath
        foreLineProgressLayer.strokeColor = UIColor.orangeFocus.cgColor
        foreLineProgressLayer.fillColor = UIColor.clear.cgColor
        foreLineProgressLayer.lineWidth = 8
        view.layer.addSublayer(foreLineProgressLayer)
    }

    func drawBreakForeLayer(){
        let rads: CGFloat = self.view.frame.height > 735 ? 115 : 90
        foreLineProgressLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX, y: view.frame.midY-40), radius: rads, startAngle: -90.degreeToRadian, endAngle: 270.degreeToRadian, clockwise: true).cgPath
        foreLineProgressLayer.strokeColor = UIColor.blueBreak.cgColor
        foreLineProgressLayer.fillColor = UIColor.clear.cgColor
        foreLineProgressLayer.lineWidth = 8
        view.layer.addSublayer(foreLineProgressLayer)
        
    }

    func startResumeAnimation(){
        if !isAnimationStart{
            startAnimation()
        }else{
            resumeAnimation()
        }
        
    }
    
    func startAnimation(){
        resetAnimation()
        foreLineProgressLayer.strokeEnd = 0.0
        progressAnimation.keyPath = "strokeEnd"
        progressAnimation.fromValue = 0
        progressAnimation.toValue = 1
        progressAnimation.duration = CFTimeInterval(chosenTime)
        progressAnimation.isRemovedOnCompletion = false
        progressAnimation.isAdditive = true
        progressAnimation.fillMode = CAMediaTimingFillMode.forwards
        foreLineProgressLayer.add(progressAnimation, forKey: "strokeEnd")
        isAnimationStart = true
        
    }
    
    func resetAnimation(){
        foreLineProgressLayer.speed = 1.0
        foreLineProgressLayer.timeOffset = 0.0
        foreLineProgressLayer.beginTime = 0.0
        foreLineProgressLayer.strokeEnd = 0.0
        isAnimationStart = false
    }
    
    func pauseAnimation(){
        let pauseTime = foreLineProgressLayer.convertTime(CACurrentMediaTime(), from: nil)
        foreLineProgressLayer.speed = 0.0
        foreLineProgressLayer.timeOffset = pauseTime
    }
    
    func resumeAnimation(){
        let pausedTime = foreLineProgressLayer.timeOffset
        foreLineProgressLayer.speed = 1.0
        foreLineProgressLayer.timeOffset = 0.0
        foreLineProgressLayer.beginTime = 0.0
        
        let timeSincePause = foreLineProgressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        foreLineProgressLayer.beginTime = timeSincePause
    }
    
    func stopAnimation(){
        foreLineProgressLayer.speed = 0.0
        foreLineProgressLayer.timeOffset = 0.0
        foreLineProgressLayer.beginTime = 0.0
        foreLineProgressLayer.strokeEnd = 0.0
        isAnimationStart = false
    }
   
    func askForPermission(){
        notifCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if(!granted){
                print("Permission Denied")
            }
        }
    }
    
    
    func setNotification(){
        notifCenter.getNotificationSettings{ (settings) in
            DispatchQueue.main.async{ [self] in
                if settings.authorizationStatus == .authorized {
                let focusNotifContent = UNMutableNotificationContent()
                focusNotifContent.title = "Time's up"
                focusNotifContent.body = "Enjoy your break time!"
                if defaultNotifSound == "ON"{
                    focusNotifContent.sound = UNNotificationSound.default
                } else{
                    focusNotifContent.sound = nil
                }
                let breakNotifContent = UNMutableNotificationContent()
                breakNotifContent.title = "Time's up"
                breakNotifContent.body = "Let's continue your task!"
                if defaultNotifSound == "ON"{
                    breakNotifContent.sound = UNNotificationSound.default
                } else{
                    breakNotifContent.sound = nil
                }
                 
                let timeIntervalInSecond = chosenTime
                let timeIntervalNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeIntervalInSecond), repeats: false)
        
                let uuidString = UUID().uuidString
                if selectedTime == "Focus Time"{
                    selectedContent = focusNotifContent
                } else {
                    selectedContent = breakNotifContent
                }
                
                let notifRequest = UNNotificationRequest(identifier: uuidString , content: selectedContent, trigger: timeIntervalNotificationTrigger)
           
                self.notifCenter.add(notifRequest) { (error) in
                    if(error != nil){
                        print("Error " + error.debugDescription)
                        return
                    }
                }
                }
            }
        }
    }
}


extension Int{
    var degreeToRadian : CGFloat{
        return CGFloat(self) * .pi/180
    }
}



