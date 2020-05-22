//
//  MoreApp.swift
//  XYZManager
//
//  Created by 张子豪 on 2018/12/17.
//  Copyright © 2018 张子豪. All rights reserved.
//

//---------苹果提供的库-----------------------//
import UIKit                                        //iOS基础库                                 //弹出Email框的库
import XYZHUD

//弹出框相关
public extension MoreAppObject{
    func 显示账号复制成功(标题:String,描述:String,颜色:UIColor,复制进剪贴板:String) {
        UIPasteboard.general.string = 复制进剪贴板
        XYZHUD.弹出popUPView(标题:标题, 描述:描述 , 颜色: 颜色)
    }
}

public class MoreAppObject: NSObject{
    public static var shared :MoreAppObject? = nil
    var nav:UINavigationController?
    public init(nav:UINavigationController?){
        self.nav = nav
    }
    
}



