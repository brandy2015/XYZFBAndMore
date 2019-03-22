//
//  MoreApp.swift
//  XYZManager
//
//  Created by 张子豪 on 2018/12/17.
//  Copyright © 2018 张子豪. All rights reserved.
//

//---------苹果提供的库-----------------------//
import UIKit                                        //iOS基础库
import MessageUI                                    //弹出Email框的库
//-----------------自有库--------------------------//
import SoHow                                        //自有库
//---------------------第三方的库------------------------//
import PopupDialog                                  //关于我们页面的弹出依赖
import XYZColor
import Localize_Swift
import Async
import XYZResponse
import XYZHUD

public class MoreAppObject: NSObject,MFMailComposeViewControllerDelegate {
    //    ContactUSObjcet.shared.
    static public var shared = MoreAppObject(nav: UINavigationController())
    public var nav:UINavigationController?
    public var maildelegate : MFMailComposeViewControllerDelegate?
    public init(nav:UINavigationController?){self.nav = nav}
    public var mailComposeViewController : MFMailComposeViewController!
    
    
    
    //跳转打开微信、微博、Email
    
    public func openURL(URLString : String,打开的是:String,延迟:Double = 4) {
        afterDelay(延迟) {
            //1.获取对应应用程序的url
            guard let url = URL(string: URLString) else {return}
            //2.判断url是否可以打开
            guard UIApplication.shared.canOpenURL(url) else {
                if 打开的是 == "微博"{
                    
                    XYZHUD.打开失败(描述: "您可能没有安装微博App,正在为您打开网页版微博".localized())
                    
                    afterDelay(5) {
                        UIApplication.shared.open(URL(string: "https://m.weibo.cn/u/5716230621")!, options: [:], completionHandler: nil)
                    }
                }else if 打开的是 == "微信"{
                    XYZHUD.打开失败(描述: "您可能没有安装微信App".localized())
                }else if 打开的是 == "QQ"{
                    XYZHUD.打开失败(描述: "您可能没有安装QQ".localized())
                }
                return
            }
            //3.打开对应应用程序
            //这是一个过期的方法,因为我们只需要跳转某一个应用所以直接用这个方法,
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    
    //----------------     //    配置显示关于我们的界面
    public  func 打开其他软件(animated: Bool = true) {
        
        XYZResponse.D点按马达震动反馈(style: .success)
        
        // Prepare the popup assets
        let title = "更多优质软件".localized()
        let message = "为您推荐我们团队以及友商的优质软件".localized()
        
        let image = UIImage(named: "MoreAppNeed")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image, preferredWidth: 580)
        
        popup.buttonAlignment = .vertical//Button的排列方式
        popup.transitionStyle = .zoomIn  //飞入
        
        // Create 微信按钮
        SelfDefineBTN.appearance().tintColor = UIColor.green
        // Add buttons to dialog
        let  VTLMakerBTN =  SelfDefineBTN(title: "<本团队>VTLMaker--关于Live图片有它就够了".localized(), dismissOnTap: false) {
            popup.shake()
            //            impactFeedback(style: .error)
            XYZResponse.D点按马达震动反馈(style: .error)
            afterDelay(1.4, closure: {
                self.打开vtlmaker的AppStore()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        
        let   XYZManagerBTN =  SelfDefineBTN(title: "<本团队>XYZManager--隐藏秘密的文件管理器".localized(), dismissOnTap: false) {
            popup.shake()
        
            XYZResponse.D点按马达震动反馈(style: .error)
            afterDelay(1.4, closure: {
                self.打开XYZManager的AppStore()//self.打开vtlmaker的AppStore()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        
        let  落格输入法BTN =  SelfDefineBTN(title: "<来自友商>落格输入法--输入法空前不同".localized(), dismissOnTap: false) {
            popup.shake()
            XYZResponse.D点按马达震动反馈(style: .error)
            
            afterDelay(1.4, closure: {
                self.打开落格输入法X的AppStore()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        
        
        popup.addButtons([VTLMakerBTN,XYZManagerBTN])//,落格输入法BTN])
        // Present dialog
        nav?.present(popup, animated: animated, completion: nil)
    }
    
    
    
    
    public func ToAnotherWeb更多软件按钮(with PathString:String,描述:String,颜色:UIColor = UIColor.Succeeded) {
        XYZHUD.弹出popUPView(标题: "请稍等".localized(), 描述: 描述, 颜色: 颜色)
        Async.userInitiated {}.main {
            if let url = URL(string: PathString) {
                UIApplication.shared.open(url, options: [:],completionHandler: { (Succeeded) in
                })
            }
        }
    }
    
    
}


//打开的按钮
extension MoreAppObject{
    
    public func 打开XYZManager的AppStore()  {
        let vtlmakerString = "https://itunes.apple.com/cn/app/id1275597118"
        self.ToAnotherWeb更多软件按钮(with: vtlmakerString, 描述: "正在为您打开本开发者团队更多软件".localized())
        print("XYZManager下载页")
    }
    
    
    public func 打开vtlmaker的AppStore()  {
        let vtlmakerString = "https://itunes.apple.com/cn/app/vtlmaker/id1245243577?mt=8"
        self.ToAnotherWeb更多软件按钮(with: vtlmakerString, 描述: "正在为您打开本开发者团队更多软件".localized())
        print("VTLMaker下载页")
    }
    public func 打开落格输入法X的AppStore()  {
        
        let vtlmakerString = "https://itunes.apple.com/cn/app/落格输入法-x/id1373102819?mt=8"
        let urlxx = vtlmakerString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        self.ToAnotherWeb更多软件按钮(with: urlxx, 描述: "正在为您打开友商优质软件".localized())
        print("打开落格输入法")
    }
}



extension MoreAppObject{
    //----------------      //关于我们的页面的属性调整
    public func 灰色属性()  {
        
        // Customize dialog appearance
        let pv = PopupDialogDefaultView.appearance()
        pv.titleFont    = UIFont(name: "HelveticaNeue-Light", size: 16)!
        pv.titleColor   = .white
        pv.messageFont  = UIFont(name: "HelveticaNeue", size: 14)!
        pv.messageColor = UIColor(white: 0.8, alpha: 1)
        
        // Customize the container view appearance
        let pcv = PopupDialogContainerView.appearance()
        pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
        pcv.cornerRadius    = 2
        pcv.shadowEnabled   = true
        pcv.shadowColor     = .black
        
        // Customize overlay appearance
        let ov = PopupDialogOverlayView.appearance()
        ov.blurEnabled     = true
        ov.blurRadius      = 30
        ov.liveBlurEnabled = true
        ov.opacity         = 0.7
        ov.color           = .black
        
        // Customize default button appearance
        let db = DefaultButton.appearance()
        db.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        db.titleColor     = .white
        db.buttonColor    = UIColor.white//UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
        
        // Customize cancel button appearance
        let cb = CancelButton.appearance()
        cb.titleFont      = UIFont(name: "HelveticaNeue-Medium", size: 14)!
        cb.titleColor     = UIColor(white: 0.6, alpha: 1)
        cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
        cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
    }
}

//弹出框相关
extension MoreAppObject{
    public func 显示账号复制成功(标题:String,描述:String,颜色:UIColor,复制进剪贴板:String) {
        UIPasteboard.general.string = 复制进剪贴板
        XYZHUD.弹出popUPView(标题:标题, 描述:描述 , 颜色: 颜色)
    }
}
