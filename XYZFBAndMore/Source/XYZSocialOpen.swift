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
