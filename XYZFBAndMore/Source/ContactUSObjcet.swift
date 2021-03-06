//------------------------------弹出关于我们页面的封装库-------------------------------//
//  ContactUSObjcet.swift
//  XYZMaker
//
//  Created by 张子豪 on 2018/6/13.
//  Copyright © 2018年 张子豪. All rights reserved.
//
//-----------------------------------苹果提供的库------------------------------------//
import UIKit                                        //iOS基础库
import MessageUI                                    //弹出Email框的库
//-----------------------------------自有库-----------------------------------------//
//import SoHow                                        //自有库
import Localize_Swift                               //本地化库

public class ContactUSObjcet: NSObject,MFMailComposeViewControllerDelegate{

    public static var shared :ContactUSObjcet? = nil
     var nav:UINavigationController?
     var maildelegate : MFMailComposeViewControllerDelegate?
     var mailComposeViewController : MFMailComposeViewController!

    public init(nav:UINavigationController?){
        self.nav = nav
        
    }
    
    //跳转打开微信、微博、Email
    public func openURL(URLString : String,打开的是:String,延迟:Double = 1) {
        afterDelay(延迟) {
            DispatchQueue.main.async {
                guard let url = URL(string: URLString) , UIApplication.shared.canOpenURL(url) else {
                    switch 打开的是{
                    case "微博":
                        self.打开失败(描述: "您可能没有安装微博App,正在为您打开网页版微博".localized())
                        self.afterDelay(5) { UIApplication.shared.open(URL(string: "https://m.weibo.cn/u/5716230621")!, options: [:], completionHandler: nil)}
                    case "微信":self.打开失败(描述: "您可能没有安装微信App".localized())
                    case "QQ":self.打开失败(描述: "您可能没有安装QQ".localized())
                    default:print("没有东西")}
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
        }
    }
    
    //延迟调用
    func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
        let when = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
    
}
