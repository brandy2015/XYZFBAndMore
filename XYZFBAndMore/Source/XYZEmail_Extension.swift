//
//  XYZEmail_Extension.swift
//  XYZFBAndMore
//
//  Created by 张子豪 on 2019/8/5.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit
import XYZHUD
import SoHow
import MessageUI


class XYZEmail_Extension: NSObject {

}

//Email相关

public extension ContactUSObjcet{
    
    func 打开Email按钮()  {
        XYZHUD.弹出popUPView(标题: "请稍等".localized(), 描述: "正在为您打开Email".localized(), 颜色: UIColor.Succeeded)
        afterDelay(1) {self.显示email显示框()}
    }
    
    func showSendMailErrorAlert() {
        UIPasteboard.general.string = "XYZTechFeedBack@gmail.com";
        XYZHUD.弹出popUPView(标题: "无法发送邮件".localized(), 描述: "未设置邮箱，设置后再尝试发送;或者用您的邮箱App发送，Email已经复制到剪贴板".localized(), 颜色: UIColor.Failed)
    }
    
    //email实现
    func configuredMailComposeViewController(收件人s:[String] = ["XYZTechFeedBack@gmail.com"],邮件主题:String = "VTLMaker反馈".localized()) -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController();
        mailComposeVC.mailComposeDelegate = self
        // 设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(收件人s)//收件人
        //邮件主题
        mailComposeVC.setSubject(("\(UIDevice.appName)" + "反馈"))
        mailComposeVC.setMessageBody("\n" + "<具体问题写在下面,您具体遇到了什么问题>".localized() + "\n" + "\n\n\n\n\n\n\n\n\n\n" + "<具体问题写在上面>".localized() + "\n\n " + "系统版本：".localized() + "\(  UIDevice.deviceSystemVer)" + "\n " + "设备型号：".localized() + "\(  UIDevice.deviceModel)" + "\n" + " App 的版本号".localized() + "\(  UIDevice.VersionNum)" + "\n" + "App 的 build 版本" + "\(  UIDevice.BuildVersionNum)" + "\n" + " App 的名称".localized() + "\(  UIDevice.appName)", isHTML: false)
        return mailComposeVC
    }
    
    
    func 显示email显示框()  {
        if MFMailComposeViewController.canSendMail() {
            // 注意这个实例要写在 if block 里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
            mailComposeViewController = configuredMailComposeViewController()
            nav?.present(mailComposeViewController, animated: true, completion: nil)
        } else {showSendMailErrorAlert()}
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
            case MFMailComposeResult.cancelled.rawValue :     print("取消发送")
            case MFMailComposeResult.sent.rawValue      :     print("发送成功");XYZHUD.弹出popUPView(标题: "发送成功".localized(), 描述: "邮件已经成功发送给开发者".localized(), 颜色: UIColor.Succeeded)
            default:break
        }
        mailComposeViewController.dismiss(animated: true, completion: nil)
    }
}
