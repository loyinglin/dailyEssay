//
//  HomeViewController.swift
//  TimeFlies
//
//  Created by 林伟池 on 16/4/7.
//  Copyright © 2016年 林伟池. All rights reserved.
//

import Foundation

let lyCommentDefault = "ly"

class SwiftHomeViewController: UIViewController, ModalViewControllerDelegate {
    static let constSelectTime = "open_select_time_board"
    
    @IBOutlet var myBirthDay:UILabel?
    @IBOutlet var myDeadDay:UILabel?
    @IBOutlet var myDay:UILabel?
    @IBOutlet var mySecond:UILabel?
    @IBOutlet var myValueSlider:UISlider?
    @IBOutlet var myKnobPlaceholder:UIView?
    
    var myTimer:Timer?
    var myKnobControl:RWKnobControl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInit()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "HomeModalChange"), object: nil, queue: nil) { (notify) -> Void in
            self.viewInit()
        }
        onTimer("" as AnyObject)
        myKnobControl = RWKnobControl(frame: self.myKnobPlaceholder!.bounds)
        self.myKnobPlaceholder?.addSubview(myKnobControl!)
        
        myKnobControl?.lineWidth = 4.0
        myKnobControl?.pointerLength = 8.0
        
        view.tintColor = UIColor.lightGray
        
        myKnobControl?.addObserver(self, forKeyPath: "value", options: .new, context: nil)
        
        myKnobControl?.addTarget(self, action: #selector(SwiftHomeViewController.handleValueChanged(_:)), for: .valueChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewInit() {
        myBirthDay?.text = String(format:NSLocalizedString("今天是生命中的第%d天", comment: lyCommentDefault), HomeModel.instance().getDaysNow())
        
        myDeadDay?.text = String(format: NSLocalizedString("还有%d天", comment: lyCommentDefault), HomeModel.instance().getDaysLeft())
        let per:Float = Float(HomeModel.instance().getDaysLeft()) / (365 * 70.0)
        myValueSlider?.value = 1.0 - per
        myKnobControl?.setValue(CGFloat(1.0 - per), animated: true)

        let current = Date(timeIntervalSinceNow: 0)
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = NSLocalizedString("yyyy年MM月dd日", comment: lyCommentDefault)
        myDay?.text = dataFormatter.string(from: current)
    }
    

    //MARK: view init

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewInit()
        addTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        myTimer?.invalidate()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    deinit {
        print("dealloc \(self)")
    }

    func addTimer() {
        myTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(SwiftHomeViewController.onTimer(_:)), userInfo: self, repeats: true)
    }

    func onTimer(_ sender: AnyObject) {
        let current = Date(timeIntervalSinceNow: 0)
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "HH:mm:ss"
        mySecond?.text = dataFormatter.string(from: current)
    }
    
    //MARK: UI
    @IBAction func onSwipe(_ sender: UISwipeGestureRecognizer) {
        tabBarController?.selectedIndex = 1
        tabBarController?.tabBar((tabBarController?.tabBar)!, didSelect: (tabBarController?.tabBar.items![1])!)
    }
    
    @IBAction func onSwipeRight(_ sender: UISwipeGestureRecognizer) {
//        tabBarController?.selectedIndex = 3
    }
    
    @IBAction func handleValueChanged(_ sender: AnyObject) {
        if (sender as? NSObject) == self.myValueSlider {
            myKnobControl?.value = CGFloat((myValueSlider?.value)!)
        }
        if (sender as? NSObject) == self.myKnobControl {
            myValueSlider?.value = Float((myKnobControl?.value)!)
        }
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if object as? NSObject == myKnobControl && keyPath! == "value" {
            myDeadDay?.text = String(format: NSLocalizedString("还有%d天", comment: lyCommentDefault), Int(365.0 * 70.0 * (1.0 - (myKnobControl?.value)!)))
            var date = HomeModel.instance().getBirthDate()
            date = Date(timeInterval: Double(365.0 * 70 * (myKnobControl?.value)! * 24 * 3600), since: date!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = NSLocalizedString("yyyy年MM月dd日", comment: lyCommentDefault)
            
            myDay?.text = dateFormatter.string(from: date!)
        }
    }

    //MARK: delegate
    func dismissViewController(_ mcv: TimeSelectController) {
        dismiss(animated: true) { () -> Void in
            
        }
    }
}
