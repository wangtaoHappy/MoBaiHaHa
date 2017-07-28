//
//  MainViewController.swift
//  MoBaiHaHa
//
//  Created by 王涛 on 2017/7/26.
//  Copyright © 2017年 王涛. All rights reserved.
//

import UIKit



class MainViewController: UIViewController {

    public var leftVC = LeftViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        //self.view.addSubview(self.leftVC.view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
