//
//  LeftViewController.swift
//  MoBaiHaHa
//
//  Created by 王涛 on 2017/7/25.
//  Copyright © 2017年 王涛. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView :UITableView!
    let heigh = UIScreen.main.bounds.size.height
    
    let width = UIScreen.main.bounds.size.width
    var dataSource = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = ["我的钱包","我的卡卷","我的行程","邀请好友","我的贴纸"]
        setupUI()
        self.view.backgroundColor = UIColor.white
    }

    func setupUI() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 250, height: heigh ), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.separatorStyle = .singleLineEtched
        let view = HeaderLeftView.init(frame: CGRect.init(x: 0, y: 0, width: 250, height: 160))
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        tableView.tableHeaderView = view
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        let lineView = UIView.init(frame:CGRect.init(x: 0, y: heigh - 50, width: 250, height: 1))
        lineView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.view.addSubview(lineView)
        
        let  settingButton = UIButton.init(type: .custom)
        settingButton.frame = CGRect.init(x:  30, y: lineView.frame.origin.y + 15, width: 40, height: 20)
        settingButton.setTitle("设置", for: .normal)
        settingButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        settingButton.setTitleColor(UIColor.black.withAlphaComponent(0.8), for: .normal)
        settingButton.addTarget(self, action: #selector(settingButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(settingButton)
        
        let  helpButton = UIButton.init(type: .custom)
        helpButton.frame = CGRect.init(x: 100, y: lineView.frame.origin.y + 15, width: 80, height: 20)
        helpButton.setTitle("用户指南", for: .normal)
        helpButton.setTitleColor(UIColor.black.withAlphaComponent(0.8), for: .normal)
        helpButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        helpButton.addTarget(self, action: #selector(settingButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(helpButton)
        
    }
    //MARK:按钮方法
    func settingButtonAction(sender:UIButton) {
        
    }
    
    func helpButtonAction(sender:UIButton) {
        
    }
    //MARK:UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    //MARK:UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = dataSource[indexPath.row] as? String
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.selectionStyle = .none
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
