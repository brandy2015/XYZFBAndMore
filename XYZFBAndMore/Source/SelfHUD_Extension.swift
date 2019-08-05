
//
//  SelfHUD_Extension.swift
//  XYZFBAndMore
//
//  Created by 张子豪 on 2019/8/5.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit
import XYZHUD


class SelfHUD_Extension: NSObject {

}
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
