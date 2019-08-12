//
//  SecondViewController.swift
//  TKFoundationModule_Example
//
//  Created by 聂子 on 2019/3/7.
//  Copyright © 2019年 CocoaPods. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    private var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
         self.timer = Timer.ns.scheduledTimerWithTimerInterval(interval: 0.1, repeats: true) { (_) in
            print("test")
        }
        RunLoop.current.add(timer!, forMode: .default)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    deinit {
        self.timer?.invalidate()
        self.timer = nil
        print("deinit")
    }
}
