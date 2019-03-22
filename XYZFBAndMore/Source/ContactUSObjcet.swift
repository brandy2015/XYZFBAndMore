//------------------------------弹出关于我们页面的封装库-------------------------------//
//  ContactUSObjcet.swift
//  VTLMaker
//
//  Created by 张子豪 on 2018/6/13.
//  Copyright © 2018年 张子豪. All rights reserved.
//
//-----------------------------------苹果提供的库------------------------------------//
import UIKit                                        //iOS基础库
import MessageUI                                    //弹出Email框的库
//-----------------------------------自有库-----------------------------------------//
import SoHow                                        //自有库
//-----------------------------------第三方的库--------------------------------------//
import PopupDialog                                  //关于我们页面的弹出依赖
import XYZColor
import Localize_Swift
import XYZResponse

public class ContactUSObjcet: NSObject,MFMailComposeViewControllerDelegate {
//    ContactUSObjcet.shared.
    static public var shared = ContactUSObjcet(nav: UINavigationController())
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
                    self.打开失败(描述: "您可能没有安装微博App,正在为您打开网页版微博".localized())
                    afterDelay(5) {
                        UIApplication.shared.open(URL(string: "https://m.weibo.cn/u/5716230621")!, options: [:], completionHandler: nil)
                    }
                }else if 打开的是 == "微信"{
                    self.打开失败(描述: "您可能没有安装微信App".localized())
                }else if 打开的是 == "QQ"{
                    self.打开失败(描述: "您可能没有安装QQ".localized())
                }
                return
            }
            //3.打开对应应用程序
            //这是一个过期的方法,因为我们只需要跳转某一个应用所以直接用这个方法,
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    public func 显示账号复制成功(标题:String,描述:String,颜色:UIColor,复制进剪贴板:String) {
        UIPasteboard.general.string = 复制进剪贴板
        弹出popUPView(标题:标题, 描述:描述 , 颜色: 颜色)
    }
    public func 打开失败(描述: String) {
        弹出popUPView(标题: "打开失败".localized(), 描述: 描述, 颜色: UIColor.Failed)
    }
    public func 显示成功View() {
        弹出popUPView(标题: "反馈成功".localized(), 描述: "我会尽快回复您的邮件，您的反馈对软件的改进很重要".localized(), 颜色: UIColor.Succeeded)
    }
    
    //----------------     //    配置显示关于我们的界面
    public func 显示关于我们的界面(animated: Bool = true) {
//        impactFeedback(style: .success)
        XYZResponse.D点按马达震动反馈(style: .success)
        // Prepare the popup assets
        let title = "联系方式".localized()
        let message = "您可以通过以下途径反馈给我们".localized()
        let image = UIImage(named: "colorful")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image, preferredWidth: 580)
        
        popup.buttonAlignment = .vertical//Button的排列方式
        popup.transitionStyle = .zoomIn  //飞入
        
        // Create 微信按钮
        SelfDefineBTN.appearance().tintColor = UIColor.green
        let 微信按钮 = SelfDefineBTN(title: "微信".localized(), dismissOnTap: false) {
            popup.shake()
//            impactFeedback(style: .error)
            XYZResponse.D点按马达震动反馈(style: .error)
            afterDelay(1.4, closure: {
                self.打开微信按钮()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        let 微信公众号按钮 = SelfDefineBTN(title: "微信公众号".localized(), dismissOnTap: false) {
            popup.shake()
//            impactFeedback(style: .error)
            XYZResponse.D点按马达震动反馈(style: .error)
            afterDelay(1.4, closure: {
                self.打开微信公众号按钮()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        
        
        let QQ按钮 = SelfDefineBTN(title: "QQ".localized(), dismissOnTap: false) {
            popup.shake()
            XYZResponse.D点按马达震动反馈(style: .error)
//            impactFeedback(style: .error)
            afterDelay(1.4, closure: {
                self.打开QQ按钮()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        // Create 微博按钮
        let 微博按钮 = SelfDefineBTN(title: "微博".localized() ,dismissOnTap: false) {
            popup.shake()
            XYZResponse.D点按马达震动反馈(style: .error)
//            impactFeedback(style: .error)
            afterDelay(1.4, closure: {
                self.打开微博按钮()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        
        // Create 邮件按钮
        let  邮件按钮 =  SelfDefineBTN(title: "Email".localized(), dismissOnTap: false) {
            popup.shake()
            XYZResponse.D点按马达震动反馈(style: .error)
//            impactFeedback(style: .error)
            afterDelay(1.4, closure: {
                self.打开Email按钮()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        
        // Add buttons to dialog
        popup.addButtons([微信按钮,微信公众号按钮,QQ按钮,微博按钮,邮件按钮])//,更多软件按钮])
        // Present dialog
        nav?.present(popup, animated: animated, completion: nil)
    }
    //email实现
    public func configuredMailComposeViewController(收件人s:[String] = ["zhangqianbrandy2012@gmail.com"],邮件主题:String = "XYZManager") -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController();
        mailComposeVC.mailComposeDelegate = self
        // 设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(收件人s)//收件人
        //邮件主题
        mailComposeVC.setSubject(邮件主题)
        mailComposeVC.setMessageBody("\n" + "<具体问题写在下面,您具体遇到了什么问题>".localized() + "\n" + "\n\n\n\n\n\n\n\n\n\n" + "<具体问题写在上面>".localized() + "\n\n " + "系统版本：".localized() + "\(  UIDevice.设备显示().1)" + "\n " + "设备型号：\(  UIDevice.设备显示().2)" + "\n" + " App 的版本号".localized() + "\(  UIDevice.获取版本信息().0)" + "\n" + "App 的 build 版本" + "\(  UIDevice.获取版本信息().1)" + "\n" + " App 的名称".localized() + "\(  UIDevice.获取版本信息().2)", isHTML: false)
        return mailComposeVC
    }
    public func 打开Email按钮()  {
        弹出popUPView(标题: "请稍等".localized(), 描述: "正在为您打开Email".localized(), 颜色: UIColor.Succeeded)
        afterDelay(1) {self.显示email显示框()}
    }
    public func showSendMailErrorAlert() {
        UIPasteboard.general.string = "zhangqianbrandy2012@gmail.com";
        弹出popUPView(标题: "无法发送邮件".localized(), 描述: "未设置邮箱，设置后再尝试发送;或者用您的邮箱App发送，Email已经复制到剪贴板".localized(), 颜色: UIColor.Failed)
    }
    
    public func 打开XYZManager的AppStore()  {
        let XYZManagerString = "https://itunes.apple.com/cn/app/vtlmaker/id1245243577?mt=8"
        self.ToAnotherWeb更多软件按钮(with: XYZManagerString, 描述: "正在为您打开本开发者团队更多软件".localized())
        print("打开更多APP")
    }
    public func ToAnotherWeb更多软件按钮(with PathString:String,描述:String,延迟时间:Double = 1,颜色:UIColor = UIColor.Succeeded) {
        弹出popUPView(标题: "请稍等".localized(), 描述: 描述, 颜色: 颜色)
        afterDelay(延迟时间) {
            if let url = URL(string: PathString) {
                UIApplication.shared.open(url, options: [:],completionHandler: { (success) in
                })
            }
        }
    }
    
   
    
    
    public func 显示email显示框()  {
        if MFMailComposeViewController.canSendMail() {
            // 注意这个实例要写在 if block 里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
            mailComposeViewController = configuredMailComposeViewController()
            nav?.present(mailComposeViewController, animated: true, completion: nil)
        } else {showSendMailErrorAlert()}
    }
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
            case MFMailComposeResult.cancelled.rawValue :     print("取消发送")
            case MFMailComposeResult.sent.rawValue      :     print("发送成功")
                弹出popUPView(标题: "发送成功".localized(), 描述: "邮件已经成功发送给开发者".localized(), 颜色: UIColor.Succeeded)
            default:break
        }
        mailComposeViewController.dismiss(animated: true, completion: nil)
    }
}
@discardableResult
func 弹出popUPView(延迟时间:Double = 0.5,标题:String = "成功",描述:String = "成功了",颜色:UIColor = UIColor(red: 73/255, green: 210/255, blue: 67/255, alpha:0.5)) -> CustomPopupViewController {
    let rootViewController = CustomPopupViewController()
    rootViewController.isTop = true
    rootViewController.titleString = 标题
    rootViewController.descriptionString = 描述
    rootViewController.CustomPopupViewbackgroundColor = 颜色
    afterDelay(延迟时间) {
        PopupWindowManager.shared.changeKeyWindow(rootViewController: rootViewController)
    }
    return rootViewController
}

//按钮属性
public final class SelfDefineBTN: PopupDialogButton {
    override public func setupView() {
        //        defaultFont           = .boldSystemFont(ofSize: 16)
        defaultTitleColor     = .black
        //        defaultButtonColor    = .white
        //        defaultSeparatorColor = .clear
        super.setupView()
    }
}

//打开的按钮
extension ContactUSObjcet{
    
    public func 打开微博按钮() {
        let urlString = "https://m.weibo.cn/status/4271057118713030?display=0&retcode=6102"
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:],  completionHandler: { (success) in})
        }
    }
    public func 打开微信按钮()  {
        显示账号复制成功(标题: "在微信中搜索微信号".localized(), 描述: "XYZTECH（已复制进剪贴板）".localized(), 颜色: UIColor.WeChat, 复制进剪贴板: "XYZTECH")
        openURL(URLString: "wechat://", 打开的是: "微信")
        print("SoHowTec");
    }
    public func 打开微信公众号按钮()  {
        
        显示账号复制成功(标题: "在微信中搜索公众号".localized(), 描述: "XYZTechX（小豪学科技，已复制进剪贴板）".localized(), 颜色: UIColor.WeChat, 复制进剪贴板: "XYZTechX")
        openURL(URLString: "wechat://", 打开的是: "微信")
        print("XYZTechX");
    }
    
    public func 打开QQ按钮()  {
        显示账号复制成功(标题: "QQ号为".localized(), 描述: "2957949165（已复制进剪贴板）", 颜色: UIColor.black, 复制进剪贴板: "2957949165")
        openURL(URLString: "mqq://", 打开的是: "QQ")
        print("SoHowTec");
    }
}

extension ContactUSObjcet{
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
