//
//  MoreApp.swift
//  XYZManager
//
//  Created by 张子豪 on 2018/12/17.
//  Copyright © 2018 张子豪. All rights reserved.
//

//---------苹果提供的库-----------------------//
import UIKit                                        //iOS基础库
//import MessageUI                                    //弹出Email框的库
//-----------------自有库--------------------------//
import SoHow                                        //自有库
//---------------------第三方的库------------------------//
import PopupDialog                                  //关于我们页面的弹出依赖
import XYZColor
import Localize_Swift
import Async
import XYZHUD
import XYZResponse



public class MoreAppObject: NSObject{
    public static var shared :MoreAppObject? = nil
    public var nav:UINavigationController?
    public init(nav:UINavigationController?){
        self.nav = nav
    }
    
}


//弹出框相关
public extension MoreAppObject{
    func 显示账号复制成功(标题:String,描述:String,颜色:UIColor,复制进剪贴板:String) {
        UIPasteboard.general.string = 复制进剪贴板
        XYZHUD.弹出popUPView(标题:标题, 描述:描述 , 颜色: 颜色)
    }
}


////----------------     //    配置显示关于我们的界面
//public func 打开其他软件(animated: Bool = true) {
//    XYZResponse.D点按马达震动反馈(style: .success)
//    //        impactFeedback(style: .success)
//    // Prepare the popup assets
//    let title = "更多优质软件".localized()
//    let message = "为您推荐我们团队以及友商的优质软件".localized()
//
//    let image = UIImage(named: "MoreAppNeed")
//
//    // Create the dialog
//    let popup = PopupDialog(title: title, message: message, image: image, preferredWidth: 580)
//
//    popup.buttonAlignment = .vertical//Button的排列方式
//    popup.transitionStyle = .zoomIn  //飞入
//
//    // Create 微信按钮
//    SelfDefineBTN.appearance().tintColor = UIColor.green
//    // Add buttons to dialog
//    let   XYZManagerBTN =  SelfDefineBTN(title: "<本团队>XYZManager--隐藏秘密的文件管理器".localized(), dismissOnTap: false) {
//        popup.shake()
//        //            impactFeedback(style: .error)
//        XYZResponse.D点按马达震动反馈(style: .error)
//        afterDelay(1.4, closure: {
//            self.打开XYZManager的AppStore()//self.打开vtlmaker的AppStore()
//            popup.dismiss(animated: true, completion: nil)
//        })
//    }
//
//    let  落格输入法BTN =  SelfDefineBTN(title: "<来自友商>落格输入法--输入法空前不同".localized(), dismissOnTap: false) {
//        popup.shake()
//        //            impactFeedback(style: .error)
//        XYZResponse.D点按马达震动反馈(style: .error)
//        afterDelay(1.4, closure: {
//            self.打开落格输入法X的AppStore()
//            popup.dismiss(animated: true, completion: nil)
//        })
//    }
//
//
//    popup.addButtons([XYZManagerBTN,落格输入法BTN])
//    // Present dialog
//    nav?.present(popup, animated: animated, completion: nil)
//}
