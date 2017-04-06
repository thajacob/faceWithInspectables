//
//  faceView.swift
//  one
//
//  Created by jakub skrzypczynski on 04/04/2017.
//  Copyright © 2017 test project. All rights reserved.
//

import UIKit
@IBDesignable
class faceView: UIView
{
    @IBInspectable
    var scale: CGFloat = 0.9
    @IBInspectable
    var eyeOpen: Bool = true
    @IBInspectable
    var mouthCurvature: Double = 1.0
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0
    
    @IBInspectable
    var color: UIColor = UIColor.blue
    
    
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
        
    }
    
    
    private var  skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
        
        
    }
    
    private enum Eye {
        case left
        case right
        
        
    }
    
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath
    {
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffest = skullRadius / Ratios.skullRadiusToEyeOffest
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffest
            eyeCenter.x += ((eye == .left) ? -1 :1 ) * eyeOffest
            return eyeCenter
        }
        let eyeRadius = skullRadius / Ratios.skullRadiustoEyeRadius
        let eyeCenter = centerOfEye(eye)
       
        let path: UIBezierPath
        if eyeOpen {
         path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
                path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.skullRadiusToMouthWidth
        let mouthHight = skullRadius / Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.skullRadiusToMouthOffset
        
        
        let mouthRect = CGRect(
            x: skullCenter.x - mouthWidth / 2,
            y: skullCenter.y + mouthOffset,
            width: mouthWidth,
            height: mouthHight)
        
        
        let smileOffset = CGFloat(max(-1,min(mouthCurvature,1))) * mouthRect.height
        
        
        let start = CGPoint(x: mouthRect.minX, y:mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3, y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)
        
        
        
        let path = UIBezierPath()
        
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        
        return path
    }
    
    
    
    
        
    private func pathForSkull() -> UIBezierPath
    {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        path.lineWidth = lineWidth
        
        return path
        
    }
    
    
    override func draw(_ rect: CGRect) {
        
        
        
        color.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
        
        
    }
    
    private struct Ratios {
        static let skullRadiusToEyeOffest: CGFloat = 3
        static let skullRadiustoEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
    }
    
        
        
        
        
    }
    
    


