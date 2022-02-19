//
//  ProgressView.swift
//  Naqliah Client
//
//  Created by Mohamed Akl on 19/12/2021.
//

import UIKit
enum DrawType {
    case verification
    case orderCycle
}
extension UIViewController{
    func drawBgShape(drawType:DrawType, shape:CAShapeLayer, view: UIView , label: UILabel) {
        var radius: CGFloat = 0
        switch drawType {
        case .verification:
            radius = 33
        case .orderCycle:
            radius = 55
        }
        shape.path = UIBezierPath(arcCenter: CGPoint(x: label.frame.midX , y: label.frame.midY), radius: radius, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        
        shape.strokeColor = UIColor.lightGray.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = 2.5
        view.layer.addSublayer(shape)
    }
    
    func drawTimeLeftShape(drawType:DrawType, shape:CAShapeLayer, view: UIView , label: UILabel) {
        
        var radius: CGFloat = 0
        switch drawType {
        case .verification:
            radius = 33
        case .orderCycle:
            radius = 55
        }
        shape.path = UIBezierPath(arcCenter: CGPoint(x: label.frame.midX , y: label.frame.midY), radius: radius, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        shape.strokeColor = UIColor.mainColor.cgColor
        //black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = 2.5
        view.layer.addSublayer(shape)
    }
}
