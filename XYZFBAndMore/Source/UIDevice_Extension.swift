//
//  UIDevice_Extension.swift
//  XYZManager
//
//  Created by 张子豪 on 2018/12/6.
//  Copyright © 2018 张子豪. All rights reserved.
//

import UIKit
import SoHow
class UIDevice_Extension: NSObject {

}

extension UIDevice{
    public static func 设备显示() -> (deviceName:String,systemVersion:String,deviceModel:String,deviceUUID:String) {
        let deviceName = UIDevice.current.name// 获取设备名称
        let systemVersion = UIDevice.current.systemVersion // 获取系统版本号
        let deviceModel = UIDevice.current.DeviceType
            
//            返回设备信息().设备类型//UIDevice.current.model   // 获取设备的型号
        let deviceUUID = UIDevice.current.identifierForVendor?.uuidString// 获取设备唯一标识符
        return (deviceName,systemVersion,deviceModel,deviceUUID!)
    }
    public static func 获取版本信息() -> (String,String,String) {
        let infoDic = Bundle.main.infoDictionary
        print(infoDic as Any)
        
        // 获取 App 的版本号
        let appVersion = infoDic?["CFBundleShortVersionString"] as! String
        // 获取 App 的 build 版本
        let appBuildVersion = infoDic?["CFBundleVersion"] as! String
        // 获取 App 的名称
        let appName = infoDic?["CFBundleDisplayName"] as? String
        return (appVersion,appBuildVersion,appName ?? "XYZManager")
    }

}


