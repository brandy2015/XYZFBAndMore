
//
//  SelfHUD_Extension.swift
//  XYZFBAndMore
//
//  Created by 张子豪 on 2019/8/5.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit
import XYZHUD

 
//HUD
public extension ContactUSObjcet{
    func 显示账号复制成功(标题:String,描述:String,颜色:UIColor,复制进剪贴板:String) {
        UIPasteboard.general.string = 复制进剪贴板
        XYZHUD.弹出popUPView(标题:标题, 描述:描述 , 颜色: 颜色)
    }
    func 打开失败(描述: String) {
        XYZHUD.弹出popUPView(标题: "打开失败".localized(), 描述: 描述, 颜色: UIColor.Failed)
    }
    func 显示成功View() {
        XYZHUD.弹出popUPView(标题: "反馈成功".localized(), 描述: "我会尽快回复您的邮件，您的反馈对软件的改进很重要".localized(), 颜色: UIColor.Succeeded)
    }
}
private extension UIColor{
    class var Succeeded: UIColor {
        return UIColor(red: 73/255, green: 210/255, blue: 67/255, alpha:0.5)
    }
    class var Failed: UIColor {
        return UIColor(red: 238/255, green: 48/255, blue: 7/255, alpha:0.5)
    }
    class var Converting: UIColor {
        return UIColor(red: 126/255, green: 219/255, blue: 212/255, alpha:0.5)
    }
    class var WeiBo: UIColor {
        return UIColor(red: 247/255, green: 148/255, blue: 34/255, alpha:0.8)
    }
    class var WeChat: UIColor {
        return UIColor(red: 13/255, green: 190/255, blue: 38/255, alpha:0.8)
    }
    class var GIFOut: UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha:0.8)
    }
    class var GIFSize: UIColor {
        return UIColor(red: 247/255, green: 200/255, blue: 96/255, alpha:0.8)
    }
}
