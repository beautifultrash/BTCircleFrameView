
//
//  HSFrameRotationView.swift
//  HSSquareFrameRotation
//
//  Created by song on 2017. 5. 10..
//  Copyright © 2017년 song. All rights reserved.
//

import UIKit

@IBDesignable


class HSCircleFrameRotationView: UIView, CAAnimationDelegate {
    
    @IBInspectable var frameColor: UIColor?
    @IBInspectable var frameWidth: CGFloat = 0.0
    @IBInspectable var subFrames: Int = 0
    
    var subFrameList = [CALayer]()
    var circlePath: UIBezierPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initCircelPath(radius: 10.0)
        addSubFrames()
    }
    
    func initCircelPath(radius: CGFloat) {
        circlePath = UIBezierPath.init(arcCenter: self.center,
                                       radius: radius,
                                       startAngle: 0.0,
                                       endAngle: .pi * 2.0,
                                       clockwise: true)
    }
    
    func clearSubLayers() {
        for subLayer in self.layer.sublayers! {
            subLayer.removeFromSuperlayer()
        }
    }
    
    func addSubFrames() {
        for _ in 0...subFrames {
            let subLayer = CALayer.init(layer: self.layer)
            subLayer.frame = self.bounds
            subLayer.borderColor = frameColor?.cgColor
            subLayer.borderWidth = frameWidth
            subLayer.cornerRadius = subLayer.bounds.width / 2.0
            subFrameList.append(subLayer)
            self.layer.addSublayer(subLayer)
        }
    }
    
    func beginRotate() {
        
        for index in 0...subFrames {
            let subLayer = subFrameList[index]
            rotate360Degrees(target: subLayer, duration: 2.0, index: index)
        }
    }
    
    func rotate360Degrees(target: CALayer, duration: CFTimeInterval = 1.0, index: Int) {
        let frameDuration: Double = duration / Double(subFrames + 1)
        let rotateAnimation = CABasicAnimation(keyPath: "path")
//        rotateAnimation.pa
        rotateAnimation.duration = duration
        rotateAnimation.beginTime = CACurrentMediaTime() + (Double(index) * frameDuration) / 8.0
        rotateAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.83, 0.07, 0.385, 0.8)
        rotateAnimation.delegate = self
        target.add(rotateAnimation, forKey: nil)
    }
}
