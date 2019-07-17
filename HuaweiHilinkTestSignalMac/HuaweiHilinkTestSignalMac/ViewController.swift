//
//  ViewController.swift
//  HuaweiHilinkTestSignalMac
//
//  Created by Serge Ivanov on 18/07/2019.
//  Copyright © 2019 xserge. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var sinr: NSTextField!
    @IBOutlet weak var rsrp: NSTextField!
    @IBOutlet weak var rssi: NSTextField!
    @IBOutlet weak var rsrq: NSTextField!
    
    @IBOutlet weak var download: NSTextField!
    @IBOutlet weak var upload: NSTextField!
    
    let getInfo = GetInfo()
    var looped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func clickGetInfo(_ sender: Any) {
        func signalLoop() {
            getInfo.getSignal { data in
                self.sinr.stringValue = data["sinr"] ?? ""
                self.rsrp.stringValue = data["rsrp"] ?? ""
                self.rssi.stringValue = data["rssi"] ?? ""
                self.rsrq.stringValue = data["rsrq"] ?? ""
                
                if(self.looped) {
                    signalLoop()
                }
            }
            
            getInfo.getTraffic { data in
                let d = data["download"] ?? 0
                let u = data["upload"] ?? 0
                self.download.stringValue = String(format:"%.2f", Float(d) / (1024*1024))
                self.upload.stringValue = String(format:"%.2f", Float(u) / (1024*1024))
            }
        }
        
        if(!looped) {
            self.looped = true
            signalLoop()
        }
        else {
            looped = false
        }
    }


}

