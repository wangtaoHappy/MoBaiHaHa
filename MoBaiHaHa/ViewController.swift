//
//  ViewController.swift
//  MoBaiHaHa
//
//  Created by 王涛 on 2017/7/25.
//  Copyright © 2017年 王涛. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate{

    public var mainVC  =  MainViewController()
    let heigh = UIScreen.main.bounds.size.height

    let weith = UIScreen.main.bounds.size.width
    
    var leftVC : LeftViewController?
    let messageVC = MessageViewController()
    let searchVC = SearchViewController()
    var leftV = UIView()
    
    var mapView : MKMapView!
    
    let locationManager = CLLocationManager()
    
    var location : CLLocation!
    //MARK: 生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.orange]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        changeNavbar()
      
        self.leftVC = self.mainVC.leftVC

        setupUI()
        addMap()
        addButton()
    }
    //MARK:UI添加
    func addMap() {
        self.mapView = MKMapView.init(frame: CGRect.init(x: 0, y: 64, width: weith, height: heigh))
        self.view.addSubview(self.mapView)
        self.mapView.mapType = .standard
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 50
         locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func addLocation() {
        let latDelta = 0.05
        let lonDelta = 0.05
        let currentLocationSpan = MKCoordinateSpan.init(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let center = self.location
        let currentregion = MKCoordinateRegion.init(center: (center?.coordinate)!, span: currentLocationSpan)
        self.mapView.setRegion(currentregion, animated: true)
       
    }
    
    func addButton() {
        let refreshButton = UIButton.init(type: .custom)
        let locationButton = UIButton.init(type: .custom)
        let redpacketButton = UIButton.init(type: .custom)
        let serviceButton = UIButton.init(type: .custom)
        refreshButton.frame = CGRect.init(x: 30, y: heigh - 80, width: 30, height: 30)
        refreshButton .setImage(UIImage.init(named:"aa"), for: .normal)
        refreshButton.addTarget(self, action: #selector(refreshButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(refreshButton)
        
        locationButton.frame = CGRect.init(x: 30, y: heigh - 50, width: 30, height: 30)
        locationButton .setImage(UIImage.init(named:"bb"), for: .normal)
        locationButton.addTarget(self, action: #selector(locationButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(locationButton)
        
        redpacketButton.frame = CGRect.init(x: weith - 60, y: heigh - 80, width: 30, height: 30)
        redpacketButton .setImage(UIImage.init(named:"cc"), for: .normal)
        redpacketButton.addTarget(self, action: #selector(redpacketButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(redpacketButton)
        
        serviceButton.frame = CGRect.init(x: weith - 60, y: heigh - 50, width: 30, height: 30)
        serviceButton .setImage(UIImage.init(named:"cc"), for: .normal)
        serviceButton.addTarget(self, action: #selector(serviceButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(serviceButton)
        //button图文并排
        let searchButton = UIButton.init(type: .custom)
        searchButton.frame = CGRect.init(x: 0, y: 0, width: 150, height: 50)
        searchButton.center =  CGPoint.init(x: self.view.center.x, y: self.view.center.y + 245)
        searchButton.backgroundColor = UIColor.black
        searchButton.layer.cornerRadius = 25

        searchButton.setImage(UIImage.init(named: "search.png"), for: .normal)
        searchButton.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right:10)
        searchButton.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 20, bottom: 0, right: 10)
        searchButton.setTitle("开始扫描", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(searchButton)
    }
    
    func setupUI() {
        leftV = (self.leftVC?.view)!
        leftV.frame = CGRect.init(x: -250, y: 0, width: 250, height: heigh)
        leftV.backgroundColor = UIColor.gray
        let ges = UISwipeGestureRecognizer.init(target: self, action: #selector(swip(ges:)))
        ges.direction = .left
        
        let tapGes = UITapGestureRecognizer.init(target: self, action: #selector(tapGes(ges:)))
        leftV.addGestureRecognizer(tapGes)
        leftV.addGestureRecognizer(ges)
    }
    
    func changeNavbar() {
        self.title = "摩  拜  单  车"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.orange]
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        //添加按钮
        //left按钮
        let leftBarItem = UIBarButtonItem.init(image: UIImage.init(named: "dd.png"), style: .plain, target: self, action: #selector(leftBarItemAction))
        self.navigationItem.leftBarButtonItem = leftBarItem
        
        //right
        let searchBarItem = UIBarButtonItem.init(image: UIImage.init(named: "aa.png"), style: .plain, target: self, action: #selector(searchBarItemAction))
        let messageBarItem = UIBarButtonItem.init(image: UIImage.init(named: "bb.png"), style: .plain, target: self, action: #selector(messageBarItemAction))
        self.navigationItem.rightBarButtonItems = [searchBarItem,messageBarItem]
        //子页面返回按钮不带文字
        let item = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
    }
    //MARK:手势方法
    func swip(ges:UISwipeGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
          self.leftV.frame = CGRect.init(x: -250, y: 0, width: 250, height: self.heigh)
        }
    }
    
    func tapGes(ges:UIPanGestureRecognizer) {
        
        self.leftV.frame = CGRect.init(x: -250, y: 0, width: 250, height: self.heigh)
        
        self.navigationController?.pushViewController(searchVC, animated: true)
    }

    //MARK:底部按钮方法
    func refreshButtonAction(sender:UIButton) {
        
    }
    
    func locationButtonAction(sender:UIButton) {
        
    }
    
    func redpacketButtonAction(sender:UIButton) {
        
    }
    
    func serviceButtonAction(sender:UIButton) {
        
    }
    
    func searchButtonAction(sender:UIButton) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:导航栏按钮方法
    func leftBarItemAction() {
        UIView.animate(withDuration: 0.3) {
            self.leftV.frame = CGRect.init(x: 0, y: 0, width: 250, height: self.heigh)
        }
    }

    func searchBarItemAction() {
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func messageBarItemAction() {
        self.navigationController?.pushViewController(messageVC, animated: true)
    }

    //MARK:定位代理方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
        addLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    //MARK:MapView代理方法
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        //MKUserLocation 大头数据模型 只要遵守了MKAnnotation就是大头针数据模型
        //获取用户的大头针数据模型
        userLocation.title = "lolo"
        userLocation.subtitle = "meoyoula"
        //获取用户当前的中心位置
        let center = userLocation.location?.coordinate
        mapView.setCenter(center!, animated: true)
        
        //改变显示区域
        let span = MKCoordinateSpanMake(0.162493481087147, 0.10857004327103)
        let region = MKCoordinateRegionMake(center!, span)
        mapView.setRegion(region, animated: true)
    }

    
}

