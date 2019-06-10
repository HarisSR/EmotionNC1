//
//  ViewController.swift
//  EmotionNC1
//
//  Created by Haris Shobaruddin Roabbni on 20/05/19.
//  Copyright © 2019 Haris Shobaruddin Robbani. All rights reserved.
//

import UIKit
import SAConfettiView
class ViewController: UIViewController {
    
    var confetti: SAConfettiView!
    var xCoordinate: CGFloat!
    var yCoordinate: CGFloat!
    var firstClickObjc: Bool!
    var found: Bool! = false
    
    var imgMask = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let maskView = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
    var mainView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstClickObjc = false
        // timer
        spreadedObj()
        addMainView()
        addMaskObjc()
    }
    
    func addMainView(){
        let widthDevice = view.frame.width
        let heightDevice = view.frame.height
        
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: widthDevice, height: heightDevice))
        mainView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.addSubview(mainView)
        
        let mainViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(mainViewClicked(_:)))
        mainViewTapGesture.delegate = self as? UIGestureRecognizerDelegate
        mainView.addGestureRecognizer(mainViewTapGesture)
        
    }
    
    func addMaskObjc(){
        imgMask.frame = CGRect(x: xCoordinate, y: yCoordinate, width: 50, height: 50)
        imgMask.layer.cornerRadius = 25
        imgMask.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        imgMask.alpha = 0.1
        mainView.addSubview(imgMask)
        
        let imgMaskTapGesture = UITapGestureRecognizer(target: self, action: #selector(imgMaskClicked(_:)))
        imgMaskTapGesture.delegate = self as? UIGestureRecognizerDelegate
        imgMask.addGestureRecognizer(imgMaskTapGesture)
    }
    
    func circleTouch(x: CGFloat, y: CGFloat, isTouched: Bool) {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = mainView.bounds
        
        let myCirecle = UIView(frame: CGRect(x: x - 50, y: y - 50, width: 100, height: 100))
        let circleEffect = UIView(frame: CGRect(x: x - 50, y: y - 50, width: 100, height: 100))
        
        circleEffect.layer.cornerRadius = 50
        circleEffect.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        let circlePAth = UIBezierPath(ovalIn: myCirecle.frame)
        let path = UIBezierPath(rect: mainView.bounds)
        path.append(circlePAth)
        
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.path = path.cgPath
        
        if isTouched == true {
            if found == false {
                self.mainView.layer.mask = maskLayer
                self.mainView.addSubview(circleEffect)
                
                
                
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    circleEffect.bounds = CGRect(x: x - 50, y: y - 50, width: 140, height: 140)
                    circleEffect.alpha = 0
                    circleEffect.layer.cornerRadius = 70
                }) { (isFinished) in
                    circleEffect.removeFromSuperview()
                }
            }
        }
    }
    
    func spreadedObj() {
        let randCoordinateX = CGFloat.random(in: 1...350)
        let randCoordinateY = CGFloat.random(in: 1...800)
        xCoordinate = randCoordinateX
        yCoordinate = randCoordinateY
        
        let img = UIImage(named: "item_oval")!
        let bgView = UIImageView(image: img)
        bgView.frame = CGRect(x: randCoordinateX, y: randCoordinateY, width: 50, height: 50)
        self.view.addSubview(bgView)
    }
    
    func fallingLeaf() {
        confetti = SAConfettiView(frame: view.bounds)
        confetti.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                           UIColor(red:1.0, green:0.78, blue:0.36, alpha:1.0),
                           UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                           UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                           UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)
        ]
        confetti.type = .Image(UIImage(named: "brown_leaf")!)
        mainView.addSubview(confetti)
        confetti.startConfetti()
    }
    
    func randBackground() {
        let colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                           UIColor(red:1.0, green:0.78, blue:0.36, alpha:1.0),
                           UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                           UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                           UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)
        ]
        let randColor = Int(arc4random_uniform(UInt32 (colors.count)))
        mainView.backgroundColor = colors[randColor]
    }
    
    @objc func mainViewClicked(_ sender: UIView) {
        // do clicked process here
        firstClickObjc = false
    }
    
    @objc func imgMaskClicked(_ sender: UIView) {
        // do clicked process here
        let randRed = CGFloat.random(in: 0...1)
        let randGreen = CGFloat.random(in: 0...1)
        let randBlue = CGFloat.random(in: 0...1)
        let randColor = UIColor(displayP3Red: randRed, green: randGreen, blue: randBlue, alpha: 1.0)
        
        if firstClickObjc == true {
            imgMask.backgroundColor = randColor
            mainView.layer.mask = nil
            self.found = true
            fallingLeaf()
            
            UIView.animate(withDuration: 2, delay: 0, animations: {
                self.mainView.backgroundColor = randColor
                self.view.backgroundColor = randColor
            }) { (isFinihed) in
                
            }
        }else{
            self.found = false
            firstClickObjc = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: view)
        print(location.x)
        
        circleTouch(x: location.x, y: location.y, isTouched: true)
    }
    

}

