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
//import SoHow                                        //自有库
//---------------------第三方的库------------------------//
import PopupDialog                                  //关于我们页面的弹出依赖
 
import Localize_Swift
//import Async
import XYZHUD
//import XYZResponse

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
            "VTLMaker":"<本团队>VTLMaker--动态照片制作大师".localized(),
            "XYZManager":"<本团队>XYZManager--隐藏秘密的文件管理器".localized(),
            "XYZQRCode":"<本团队>XYZQRCode--二维码生成扫描大管家".localized(),
        ]
        
        var SelfBTNs = TitleArray.map { i in
            return ConfigureBTN(title: i.1, popup: popup, App: APPList(rawValue: i.0)!)
        }
        
        let  落格输入法BTN =  SelfDefineBTN(title: "<来自友商>落格输入法--输入法空前不同".localized(), dismissOnTap: false) {
            popup.shake()
            XYZResponse.D点按马达震动反馈(style: .error)
            self.afterDelay(1.4, closure: {
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
            self.afterDelay(1.4, closure: {DispatchQueue.main.async {
                self.打开App的AppStore(App: App)
                popup.dismiss(animated: true, completion: nil)
            }})
        }
    }
    
    func 打开AppStore页面(AppSite:String,描述:String = "正在为您打开本开发者团队更多软件".localized() ,颜色:UIColor = UIColor(red: 73/255, green: 210/255, blue: 67/255, alpha:0.5)) {
        //        let urlxx = vtlmakerString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        XYZHUD.弹出popUPView(标题: "请稍等".localized(), 描述: 描述, 颜色: 颜色)
        DispatchQueue.main.async {
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
    
    //延迟调用
    func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
        let when = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    
    
    class XYZResponse: NSObject {
        /// 创建枚举
        public enum FeedbackType: Int {case light,medium,heavy,success,warning,error,none}
        /// 创建类方法，随时调用
        public static func D点按马达震动反馈(style: FeedbackType) {
            let generator = UINotificationFeedbackGenerator()
            switch style {
            case .light:
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            case .medium:
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            case .heavy:
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            case .success: generator.notificationOccurred(.success)
            case .warning: generator.notificationOccurred(.warning)
            case .error  : generator.notificationOccurred(.error)
            default:break
            }
        }
    }


}

private class XYZJump: NSObject {
    public static var To = XYZJump()
    
    //MARK: -跳转到系统相册 - Jump to System Album
    /// 跳转到系统相册 - Jump to System Album
    /// - Parameters:
    ///   - a: not
    ///   - b: not
    public func Album() {decodejump(To: "cGhvdG9zLXJlZGlyZWN0Oi8v")}
    public func iBooks(){saveJump(To: "ibooks://")}
    public func Music() {saveJump(To: "music://")}
    public func Videos(){saveJump(To: "videos://")}
    public func SMS(To Num:String)   {
        saveJump(To: "sms://" + Num)
    }
    public func EMail(To Emails:[String])  {
        var eMails = ""
        for i in Emails{
            eMails += i + ","
        }
        saveJump(To: "mailto://" + eMails)
    }
    
    public func Tel(To Num:String)   {saveJump(To: "tel://" + Num)}
    //    备忘录
    public func Note()  {saveJump(To: "mobilenotes://")}
    public func Maps()  {saveJump(To: "maps://")}
    public func Safari(URLString:String)  {
        if URLString.contains("https://"){
            saveJump(To: URLString )
        }else if URLString.contains("http://"){
            saveJump(To: URLString )
        }else{
            saveJump(To: "https://" + URLString )
        }
    }
    public func AppStore(AppURLString:String? = nil)  {
        if let AppURL = AppURLString,AppURL.contains("https"){
            guard let x = URL(string: AppURL) else{return};print(x)
            UIApplication.shared.open(x, options: Dictionary(), completionHandler: nil)
        }else{saveJump(To: "itms-apps://")}
    }
    public func Setting()  {
        guard let Setting = URL(string: UIApplication.openSettingsURLString) else{return}
        DispatchQueue.main.async {
            UIApplication.shared.open(Setting, options: Dictionary(), completionHandler: nil)
        }
        
    }
    
    
    public func 在AppStore评论(AppURLString:String)  {
        if let AppURL = URL(string: AppURLString), UIApplication.shared.canOpenURL(AppURL) {
            UIApplication.shared.open(AppURL, options: [:]) { (succeed) in
                if succeed{
                    print("已经打开")
                }else{
                    print("打开不开")
                }
            }
            
            
        }
    }
    
    
    
    
    //跳转到日历
    public func Calendar(){saveJump(To: "calshow://")}
    //跳转到提醒事项
    public func Reminder(){
        if #available(iOS 13.0, *) {
            
            //高于 iOS 13.0
            saveJump(To: "x-apple-reminderkit://")
        } else {
            
            //低于 iOS 13.0
            saveJump(To: "x-apple-reminder://")
        }
        
        
        
        
    }
    
    //    public func ()  {saveJump(To: )}
    //    public func ()  {saveJump(To: )}
    //    public func ()  {saveJump(To: )}
    //    public func ()  {saveJump(To: )}
    
    
    
    
    
    //需要商榷
    //    TOUCHID
    public func TOUCHID()  {
        decodejump(To: "QXBwLVByZWZzOnJvb3Q9VE9VQ0hJRF9QQVNTQ09ERQ==")
    }
    
    
    
    
    
    public func saveJump(To code:String) {
        guard let x = URL(string: code) else{return}
        
        UIApplication.shared.open(x, options: Dictionary(), completionHandler: nil)
    }
    
    private func decodejump(To code:String) {
        //跳转
        let urlStr = decode(code)
        if let url = URL(string:urlStr) {
            if #available(iOS 10.0, *) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: Dictionary(), completionHandler: nil)
                }
            } else { UIApplication.shared.openURL(url)}}
    }
    
    //base64解码
    private func decode(_ string: String) -> String {
        let data = Data(base64Encoded: string, options: [])
        let decodedStr = String(data: data ?? Data(), encoding: .utf8)
        return decodedStr ?? ""
    }
    
    
    // FIXME:要解决的BUG
}

//第三方软件 需要添加白名单
extension XYZJump{
    
    
    func Wechat()   {saveJump(To: "weixin://")}
    func TaoBao()   {saveJump(To:"taobao://") }
    func 大众点评()  {saveJump(To:"dianping:// ") }
    func Weibo()    {saveJump(To:"sinaweibo://") }
    func 名片全能王() {saveJump(To:"camcard://") }
    func Alipay()   {saveJump(To:"alipay://") }
    func 豆瓣fm()    {saveJump(To:"doubanradio://") }
    func 京东()      {saveJump(To:"jdmoble://") }
    func 人人()      {saveJump(To:"renren://") }
    func 知乎()      {saveJump(To:"zhihu://") }
    func 优酷()      {saveJump(To:"youku://") }
    func QQ()       {saveJump(To:"mqq://") }
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
