//
//  XYZTableView.swift
//  SoHow
//
//  Created by 张子豪 on 2019/3/13.
//  Copyright © 2019 张子豪. All rights reserved.
//

import UIKit

class XYZTableView: NSObject {

}

//不选中
//tableView.allowsSelection = true

//估计高度
//tableView.estimatedRowHeight = 400
//tableView.rowHeight = UITableView.automaticDimension



public extension IndexPath {
    public static func fromRow(_ row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}

public extension UITableView {
    public func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
        beginUpdates()
        deleteRows(at: deletions.map(IndexPath.fromRow), with: .automatic)
        insertRows(at: insertions.map(IndexPath.fromRow), with: .automatic)
        reloadRows(at: updates.map(IndexPath.fromRow), with: .automatic)
        endUpdates()
    }
}