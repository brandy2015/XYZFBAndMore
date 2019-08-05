//
//  XYZAppStore.swift
//  XYZFBAndMore
//
//  Created by 张子豪 on 2019/8/5.
//  Copyright © 2019 张子豪. All rights reserved.
//
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

class XYZAppStore: NSObject {

}

//打开的按钮
public extension MoreAppObject{
    
    //----------------     //    配置显示关于我们的界面
    func 打开自有软件(title :String = "更多优质软件".localized(),message:String = "为您推荐我们团队以及友商的优质软件".localized(), image:UIImage? = UIImage(named: "MoreAppNeed"),animated: Bool = true) {
        XYZResponse.D点按马达震动反馈(style: .success)
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image, preferredWidth: 580)
        popup.buttonAlignment = .vertical//Button的排列方式
        popup.transitionStyle = .zoomIn  //飞入
        // Create 微信按钮
        SelfDefineBTN.appearance().tintColor = UIColor.green
        // Add buttons to dialog
        
        let TitleArray = [
            "VTLmaker":"<本团队>VTLMaker--动态照片制作大师".localized(),
            "XYZManager":"<本团队>XYZManager--隐藏秘密的文件管理器".localized(),
            "XYZQRCode":"<本团队>XYZQRCode--二维码生成扫描大管家".localized(),
        ]
        
        var SelfBTNs = TitleArray.map { i in
            return ConfigureBTN(title: i.1, popup: popup, App: APPList(rawValue: i.0)!)
        }
        
        let  落格输入法BTN =  SelfDefineBTN(title: "<来自友商>落格输入法--输入法空前不同".localized(), dismissOnTap: false) {
            popup.shake()
            XYZResponse.D点按马达震动反馈(style: .error)
            afterDelay(1.4, closure: {
                self.打开落格输入法X的AppStore()
                popup.dismiss(animated: true, completion: nil)
            })
        }
        
        SelfBTNs.append(落格输入法BTN)
        popup.addButtons(SelfBTNs)
        // Present dialog
        nav?.present(popup, animated: animated, completion: nil)
    }
    
    
    func ConfigureBTN(title:String,popup:PopupDialog,App:APPList) -> PopupDialogButton {
        return SelfDefineBTN(title: title, dismissOnTap: false) {
            popup.shake()
            XYZResponse.D点按马达震动反馈(style: .error)
            afterDelay(1.4, closure: {
                self.打开App的AppStore(App: App)
                popup.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    func 打开AppStore页面(AppSite:String,描述:String = "正在为您打开本开发者团队更多软件".localized() ,颜色:UIColor = UIColor.Succeeded) {
        //        let urlxx = vtlmakerString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        XYZHUD.弹出popUPView(标题: "请稍等".localized(), 描述: 描述, 颜色: 颜色)
        Async.userInitiated {}.main {
            guard let Appurl = URL(string: AppSite)  else{return}
            UIApplication.shared.open(Appurl, options: [:], completionHandler: nil)
        }
    }
    
    func 打开App的AppStore(App:APPList){
        var AppString = ""
        switch App {
            case .VTLMaker      :AppString = "https://apps.apple.com/cn/app/id1245243577"
            case .XYZManager    :AppString = "https://itunes.apple.com/cn/app/id1275597118"
            case .XYZQRCode     :AppString = "https://itunes.apple.com/cn/app/id1455193186"
            default:return
        }
        打开AppStore页面(AppSite: AppString)
    }
    
    func 在AppStore评论(id:String)  {
        let 我的App地址 = "itms-apps://itunes.apple.com/cn/app/id\(id)?mt=8&action=write-review"
        XYZJump.To.在AppStore评论(AppURLString: 我的App地址)
    }
    
    func 打开落格输入法X的AppStore()  {
        let vtlmakerString = "https://apps.apple.com/cn/app/id1373102819"
        self.打开AppStore页面(AppSite: vtlmakerString, 描述: "正在为您打开友商优质软件".localized(), 颜色: .darkGray)
        print("打开落格输入法")
    }
    
    
    
    
}
