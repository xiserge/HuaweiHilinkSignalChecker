//
//  getInfo.swift
//  
//
//  Created by Serge Ivanov on 18/07/2019.
//

import Foundation
import Alamofire
import SwiftyXMLParser

class GetInfo {
    var baseUrl = "http://192.168.8.1"
    var sesInfo = ""
    var tokInfo = ""
    
    func getXml(url: String, success: @escaping (String) -> Void) {
        let headers = HTTPHeaders([
            "__RequestVerificationToken": self.tokInfo,
            "Cookie": self.sesInfo
            ])
        AF.request(self.baseUrl + url, headers: headers).responseString { response in
            switch(response.result) {
            case .success(let str):
                success(str)
            case .failure(_):
                success("")
            }
        }
    }
    
    func getTokens(success: @escaping (String, String) -> Void) {
        getXml(url: "/api/webserver/SesTokInfo") { str in
            let xml = try! XML.parse(str)
            self.sesInfo = xml.response.SesInfo.text ?? ""
            self.tokInfo = xml.response.TokInfo.text ?? ""
            success(xml.response.SesInfo.text ?? "", xml.response.TokInfo.text ?? "")
        }
    }
    
    func getSignal(success: @escaping (Dictionary<String, String>) -> Void) {
        var firstTry = true
        func getData() {
            getXml(url: "/api/device/signal") { str in
                let xml = try! XML.parse(str)
                let error = xml["error"].code.text
                if(error != nil) {
                    self.getTokens { _,_ in
                        if(firstTry) {
                            firstTry = false
                            getData()
                        }
                        else {
                            success([
                                "rsrq": error ?? "Error"
                            ])
                        }
                    }
                }
                else {
                    success([
                        "rsrq": xml.response.rsrq.text ?? "",
                        "rsrp": xml.response.rsrp.text ?? "",
                        "rssi": xml.response.rssi.text ?? "",
                        "sinr": xml.response.sinr.text ?? "",
                    ])
                }
            }
        }
        getData()
    }
    
    func getTraffic(success: @escaping (Dictionary<String, Int>) -> Void) {
        var firstTry = true
        func getData() {
            getXml(url: "/api/monitoring/traffic-statistics") { str in
                let xml = try! XML.parse(str)
                let error = xml["error"].code.text
                if(error != nil) {
                    self.getTokens { _,_ in
                        if(firstTry) {
                            firstTry = false
                            getData()
                        }
                        else {
                            success([:])
                        }
                    }
                }
                else {
                    success([
                        "download": xml.response.CurrentDownloadRate.int ?? 0,
                        "upload": xml.response.CurrentUploadRate.int ?? 0
                    ])
                }
            }
        }
        getData()
    }
}
