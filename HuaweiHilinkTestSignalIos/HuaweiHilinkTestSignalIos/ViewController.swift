//
//  ViewController.swift
//  HuaweiHilinkTestSignalIos
//
//  Created by Serge Ivanov on 18/07/2019.
//  Copyright © 2019 xserge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rsrq: UILabel!
    @IBOutlet weak var sinr: UILabel!
    @IBOutlet weak var rsrp: UILabel!
    @IBOutlet weak var rssi: UILabel!
    @IBOutlet weak var speed: UILabel!
    
    @IBOutlet var mainView: UIView!
    
    var tapGesture = UITapGestureRecognizer()
    
    var looped = false
    let getInfo = GetInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.loadData(_:)))
        mainView.addGestureRecognizer(tap)
        mainView.isUserInteractionEnabled = true
    }
    
    @objc func loadData(_ sender: Any) {
        func signalLoop() {
            getInfo.getSignal { data in
                self.sinr.text = data["sinr"] ?? ""
                self.rsrp.text = data["rsrp"] ?? ""
                self.rssi.text = data["rssi"] ?? ""
                self.rsrq.text = data["rsrq"] ?? ""
                
                if(self.looped) {
                    signalLoop()
                }
            }
        }
        
        func trafficLoop() {
            getInfo.getTraffic { data in
                let d = data["download"] ?? 0
                let u = data["upload"] ?? 0
                
                self.speed.text = String(format:"%.2f/%.2f", Float(d * 8) / (1024*1024),Float(u * 8) / (1024*1024))
                
                if(self.looped) {
                    trafficLoop()
                }
            }
        }
        
        if(!looped) {
            self.looped = true
            signalLoop()
            trafficLoop()
        }
        else {
            looped = false
        }
    }


}

