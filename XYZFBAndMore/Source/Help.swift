//
//  Help.swift
//  XYZFBAndMore
//
//  Created by 张子豪 on 2019/12/11.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit


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







//let TitleArray = [
//    "VTLmaker":"<本团队>VTLMaker--动态照片制作大师".localized(),
//    "XYZManager":"<本团队>XYZManager--隐藏秘密的文件管理器".localized(),
//    "XYZQRCode":"<本团队>XYZQRCode--二维码生成扫描大管家".localized(),
//]
//
//var SelfBTNs = TitleArray.map { i in
//    return ConfigureBTN(title: i.1, popup: popup, App: APPList(rawValue: i.0)!)
//}
//
//let  落格输入法BTN =  SelfDefineBTN(title: "<来自友商>落格输入法--输入法空前不同".localized(), dismissOnTap: false) {
//    popup.shake()
//    XYZResponse.D点按马达震动反馈(style: .error)
//    afterDelay(1.4, closure: {
//        self.打开落格输入法X的AppStore()
//        popup.dismiss(animated: true, completion: nil)
//    })
//}
//
//SelfBTNs.append(落格输入法BTN)
//popup.addButtons(SelfBTNs)
//// Present dialog
//nav?.present(popup, animated: animated, completion: nil)
//}
//
//

//
//func 打开AppStore页面(AppSite:String,描述:String = "正在为您打开本开发者团队更多软件".localized() ,颜色:UIColor = UIColor.Succeeded) {
//    //        let urlxx = vtlmakerString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//    XYZHUD.弹出popUPView(标题: "请稍等".localized(), 描述: 描述, 颜色: 颜色)
//    Async.userInitiated {}.main {
//        guard let Appurl = URL(string: AppSite)  else{return}
//        UIApplication.shared.open(Appurl, options: [:], completionHandler: nil)
//    }
//}
//
//func 打开App的AppStore(App:APPList){
//    var AppString = ""
//    switch App {
//    case .VTLMaker      :AppString = "https://apps.apple.com/cn/app/id1245243577"
//    case .XYZManager    :AppString = "https://itunes.apple.com/cn/app/id1275597118"
//    case .XYZQRCode     :AppString = "https://itunes.apple.com/cn/app/id1455193186"
//    default:return
//    }
//    打开AppStore页面(AppSite: AppString)
//}

//        let 微信按钮 = SelfDefineBTN(title: "微信".localized(), dismissOnTap: false) {
//            popup.shake()
//            XYZResponse.D点按马达震动反馈(style: .error)
//            afterDelay(1.4, closure: {
//                self.打开微信按钮()
//                popup.dismiss(animated: true, completion: nil)
//            })
//        }
//        let 微信公众号按钮 = SelfDefineBTN(title: "微信公众号".localized(), dismissOnTap: false) {
//            popup.shake()
//            XYZResponse.D点按马达震动反馈(style: .error)
//            afterDelay(1.4, closure: {
//                self.打开微信公众号按钮()
//                popup.dismiss(animated: true, completion: nil)
//            })
//        }
//
//        let QQ按钮 = SelfDefineBTN(title: "QQ".localized(), dismissOnTap: false) {
//            popup.shake()
//            XYZResponse.D点按马达震动反馈(style: .error)
//            afterDelay(1.4, closure: {
//                self.打开QQ按钮()
//                popup.dismiss(animated: true, completion: nil)
//            })
//        }
//        // Create 微博按钮
//        let 微博按钮 = SelfDefineBTN(title: "微博".localized() ,dismissOnTap: false) {
//            popup.shake()
//            XYZResponse.D点按马达震动反馈(style: .error)
//            afterDelay(1.4, closure: {
//                self.打开微博按钮()
//                popup.dismiss(animated: true, completion: nil)
//            })
//        }
//        // Create 邮件按钮
//        let  邮件按钮 =  SelfDefineBTN(title: "Email".localized(), dismissOnTap: false) {
//            popup.shake()
//            XYZResponse.D点按马达震动反馈(style: .error)
//            afterDelay(1.4, closure: {
//                self.打开Email按钮()
//                popup.dismiss(animated: true, completion: nil)
//            })
//        }
// Add buttons to dialog
//        popup.addButtons([微信按钮,微信公众号按钮,QQ按钮,微博按钮,邮件按钮])//,更多软件按钮])

