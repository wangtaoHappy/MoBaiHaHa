//
//  HeaderLeftView.swift
//  MoBaiHaHa
//
//  Created by 王涛 on 2017/7/27.
//  Copyright © 2017年 王涛. All rights reserved.
//

import UIKit

class HeaderLeftView: UIView {
    
    var userImageView : UIImageView!
    var nameLabel :UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        userImageView = UIImageView.init(frame: CGRect.init(x: 10, y: 25, width: 40, height: 40))
        userImageView.image = UIImage.init(named: "header.jpg")
        self.addSubview(userImageView)
        nameLabel = UILabel.init(frame: CGRect.init(x: 70, y: 25, width: 100, height: 30))
        nameLabel.text = "183****5734"
        self.addSubview(nameLabel)
        for i in 0...2 {
            let label = self.customLabel(frame: CGRect.init(x: 20 + 80 * i, y: 100, width: 70, height: 50), topText: "920", downText: "里程(公里)")
            self.addSubview(label)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func customLabel(frame:CGRect,topText:String,downText:String) -> UILabel {
        let conLabel = UILabel.init(frame: frame)
        let topL = UILabel.init(frame: CGRect.init(x: 0, y: 5, width: 60, height: 20))
        topL.textColor = UIColor.orange
        
        topL.text = topText
        let downL = UILabel.init(frame: CGRect.init(x: 0, y: 25, width: 60, height: 20))
        downL.textColor = UIColor.gray
        downL.text = downText
        
        topL.textAlignment = .center
        downL.textAlignment = .center
        topL.font = UIFont.boldSystemFont(ofSize: 17)
        downL.font = UIFont.systemFont(ofSize: 10)
        conLabel.addSubview(topL)
        conLabel.addSubview(downL)
        return conLabel
    }

}

