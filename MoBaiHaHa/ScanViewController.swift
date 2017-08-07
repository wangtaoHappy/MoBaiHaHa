//
//  ScanViewController.swift
//  MoBaiHaHa
//
//  Created by 王涛 on 2017/7/28.
//  Copyright © 2017年 王涛. All rights reserved.
//

import UIKit
import AVFoundation
import CoreBluetooth.CBCentralManager

class ScanViewController: UIViewController,UIImagePickerControllerDelegate,AVCaptureMetadataOutputObjectsDelegate,CBCentralManagerDelegate,CBPeripheralDelegate {

    //设备
    var device : AVCaptureDevice!
    //捕捉会话
    var session : AVCaptureSession!
    //输入
    var input : AVCaptureDeviceInput!
    //输出
    var output : AVCaptureMetadataOutput!
    //预览
    var preViewlyer : AVCaptureVideoPreviewLayer!
    
    var centralManager : CBCentralManager!
    
    var peripheralsArray = NSMutableArray()
    
    
    //外部设备
    
    var discoveredPeripheral :CBPeripheral!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "扫描开锁"
//        if cameraAvisible() {
//            print("相机不可用")
//            return
//        }
        
//        setup()
        blueTooth()
    }
    
    func blueTooth() {
    
        centralManager = CBCentralManager.init(delegate: self, queue: nil, options: nil)

        /**
         If you specify nil first parameter, then the central manager returns all found peripherals, and no matter how its support service.In a real application, you typically specify a CBUUID array of objects, each object represents a peripheral advertising service of universal unique identifier (UUID).When you specify service UUID array, the central administrator only return notice these services of peripherals, allowing only scan you might be interested in equipment.UUID and CBUUID represent their object in the UUID recognition of services and features for a more detailed discussion.
        */
        
    }
    
    func cameraAvisible() -> Bool {
        var flag : Bool
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            flag = true
        } else {
            flag = false
        }
        
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType:AVMediaTypeVideo)
        if authStatus == AVAuthorizationStatus.restricted || authStatus == AVAuthorizationStatus.denied{
            flag = false
        }else {
        
            flag = true
        }
        return flag
    }
    
    func setup() {
        device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        session = AVCaptureSession.init()
        //设置高质量的输入输出
        session.sessionPreset = AVCaptureSessionPresetHigh
        do {
            try input = AVCaptureDeviceInput.init(device: device)
        } catch  let error as NSError{
            print((error))
        }
        output = AVCaptureMetadataOutput.init()
        //添加输入输出设备
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        //设置代理并在主线程中刷新UI
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        preViewlyer = AVCaptureVideoPreviewLayer.init(session: session)
        preViewlyer.frame = self.view.bounds
        self.view.layer.insertSublayer(preViewlyer, at: 0)
        session.startRunning()
    }
    //扫描完成提示声
    func playTipSound() {
        
        var soundID :SystemSoundID = 0
        let path = Bundle.main.path(forResource: "6005", ofType: "mp3")
        AudioServicesCreateSystemSoundID(NSURL.fileURL(withPath: path!) as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID);
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    func scanCompelet(result:NSString) {
        playTipSound()
        session.stopRunning()
        preViewlyer.removeFromSuperlayer()
        print("message:\(result)")
    }
    
    //MARK:AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        var conten = ""
        let metadataObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        conten = (metadataObject.stringValue! as NSString) as String
        if conten.characters.count > 1 {
            scanCompelet(result: conten as NSString)
        }
    }

    //MARK:CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("CBCentralManagerStateUnknown")
        case .resetting:
            print("CBCentralManagerStateResetting")
        case .unsupported:
            print("CBCentralManagerStateUnsupported")
        case .unauthorized:
            print("CBCentralManagerStateUnauthorized")
        case .poweredOff:
            print("CBCentralManagerStatePoweredOff")
        case .poweredOn:
            print("CBCentralManagerStatePoweredOn")
        }
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("peripheral:\(String(describing: peripheral.name))")
        if peripheral.name == "mambo 2" {
            peripheralsArray.add(peripheral.name!)
            self.discoveredPeripheral = peripheral
        }

    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Peripheral connected")
        peripheral.delegate = self
        centralManager.stopScan()
        centralManager.connect(peripheral, options: nil)
        self.discoveredPeripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("---发现服务调用次方法-")
        
        for s in peripheral.services!{
            peripheral.discoverCharacteristics(nil, for: s)
            print(s.uuid.uuidString)
        }
    }
}
