//
//  XYZSocialOpen.swift
//  XYZFBAndMore
//
//  Created by 张子豪 on 2019/8/5.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit                                        //iOS基础库
import MessageUI                                    //弹出Email框的库
//-----------------------------------自有库-----------------------------------------//
import SoHow                                        //自有库
//-----------------------------------第三方的库--------------------------------------//
import PopupDialog                                  //关于我们页面的弹出依赖
import XYZColor
import Localize_Swift
import XYZHUD
import XYZResponse


//打开的按钮
public extension ContactUSObjcet{
    //-------------- 配置显示关于我们的界面
    func 显示关于我们的界面(animated: Bool = true,只包扩微博和Email:Bool = true) {
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
        
        var SocialArray = [String : String]()
        if 只包扩微博和Email{
            SocialArray = [
                                "微博"        :"WeiBo",
                                "Email"      :"Email",
            ]
        }else{
            SocialArray = [     "微信"        :"Wechat",
                                "微信公众号"   :"WeChatPublic",
                                "QQ"         :"QQ",
                                "微博"        :"WeiBo",
                                "Email"      :"Email",
            ]
        }
        
        
        let BTNs = SocialArray.map { i in
            return ConfigureBTN(title: i.0.localized(), popup: popup, BTNForWhat: XYZSocialType(rawValue: i.1)!)
        }
         popup.addButtons(BTNs)
        nav?.present(popup, animated: animated, completion: nil)
    }
    
    func ConfigureBTN(title:String,popup:PopupDialog,BTNForWhat:XYZSocialType) -> PopupDialogButton {
        return SelfDefineBTN(title: title, dismissOnTap: false) {
            popup.shake()
            XYZResponse.D点按马达震动反馈(style: .error)
            afterDelay(1.4, closure: {
                switch BTNForWhat{
                    case .Wechat        :       self.打开微信按钮()
                    case .WeChatPublic  :       self.打开微信公众号按钮()
                    case .WeiBo         :       self.打开微博按钮()
                    case .QQ            :       self.打开QQ按钮()
                    case .Email         :       self.打开Email按钮()
                }
                popup.dismiss(animated: true, completion: nil)
            })
        }
    }
    func 打开微博按钮(urlString :String = "https://m.weibo.cn/status/4271057118713030?display=0&retcode=6102") {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:],  completionHandler: { (success) in})
        }
    }
    func 打开微信按钮()  {
        显示账号复制成功(标题: "在微信中搜索微信号".localized(), 描述: "XYZTECH（已复制进剪贴板）".localized(), 颜色: UIColor.WeChat, 复制进剪贴板: "XYZTECH")
        openURL(URLString: "wechat://", 打开的是: "微信")
        print("XYZTECH");
    }
    func 打开微信公众号按钮()  {
        显示账号复制成功(标题: "在微信中搜索公众号".localized(), 描述: "XYZTechX（小豪学科技，已复制进剪贴板）".localized(), 颜色: UIColor.WeChat, 复制进剪贴板: "XYZTechX")
        openURL(URLString: "wechat://", 打开的是: "微信")
        print("XYZTechX");
    }
    
    func 打开QQ按钮()  {
        显示账号复制成功(标题: "QQ号为".localized(), 描述: "2957949165（已复制进剪贴板）", 颜色: UIColor.black, 复制进剪贴板: "2957949165")
        openURL(URLString: "mqq://", 打开的是: "QQ")
        print("SoHowTec");
    }

    
}

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

