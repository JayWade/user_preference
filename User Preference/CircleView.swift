//
//  CircleView.swift
//  User Preference
//
//  Created by Jason Ash on 10/15/14.
//  Copyright (c) 2014 JayWade. All rights reserved.
//

import UIKit

class CircleView: UIView {
	
	var colorName = "red"
	var radius = 100
	
	private var colorDictionary = ["red" : UIColor.redColor(), "orange" : UIColor.orangeColor(), "yellow" : UIColor.yellowColor()]
	private var color = UIColor.redColor()

	
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
		let context = UIGraphicsGetCurrentContext()
		
		let circleRect = makeCircleRect(CGFloat(radius))
		
		color = colorDictionary[colorName]!
		
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
		
		CGContextFillEllipseInRect(context, circleRect)
		CGContextStrokeEllipseInRect(context, circleRect)
    }
	
	func makeCircleRect(radius : CGFloat) -> CGRect {
		let centerX = bounds.size.width / 2
		let centerY = bounds.size.height / 2
		let originX = centerX - radius
		let originY = centerY - radius
		let rect = CGRectMake(originX, originY, radius * 2, radius * 2)
		return rect
	}
}
