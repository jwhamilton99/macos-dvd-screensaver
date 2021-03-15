//
//  DVDView.swift
//  DVD
//
//  Created by Justin Hamilton on 3/15/21.
//

import Foundation
import ScreenSaver

class DVDView: ScreenSaverView {
    var dvdX: CGFloat = 100
    var dvdY: CGFloat = 200
    var w: CGFloat = 200
    var h: CGFloat = 100
    var xSpeed: CGFloat = 3
    var ySpeed: CGFloat = 3
    
    var imgColor: NSColor = .red
    var dvdImage: NSImage?
    
    var fadeInCount: CGFloat = 0
    
    func randomizeColor() {
        self.imgColor = NSColor(red: CGFloat.random(in: 0.4...1.0), green: CGFloat.random(in: 0.4...1.0), blue: CGFloat.random(in: 0.4...1.0), alpha: 1.0)
    }
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        if let img = Bundle(for: type(of: self)).image(forResource: "dvd") {
            self.dvdImage = img
        }
        self.randomizeColor()
        self.w = self.bounds.width/10
        self.h = self.w/2
        self.dvdX = CGFloat.random(in: 0...self.bounds.width-self.w)
        self.dvdY = CGFloat.random(in: 0...self.bounds.height-self.h)
        
        let baseSpeed = self.bounds.width/500
        self.xSpeed = baseSpeed
        self.ySpeed = baseSpeed
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: NSRect) {
        let background = NSBezierPath(rect: self.bounds)
        NSColor.black.setFill()
        background.fill()
        
        if let img = self.dvdImage {
            let rect = NSRect(x: self.dvdX, y: self.dvdY, width: self.w, height: self.h)
            self.imgColor.setFill()
            rect.fill()
            img.draw(in: rect.insetBy(dx: -1, dy: -1), from: NSRect(x: 0, y: 0, width: img.size.width, height: img.size.height), operation: .destinationIn, fraction: 1.0*self.fadeInCount)
        } else {
            let rect = NSRect(x: self.dvdX, y: self.dvdY, width: self.w, height: self.h)
            self.imgColor.setFill()
            rect.fill()
        }
    }
    
    override func animateOneFrame() {
        super.animateOneFrame()
        self.dvdX+=self.xSpeed
        self.dvdY+=self.ySpeed
        
        if(self.dvdX+w >= bounds.width || self.dvdX <= 0) {
            self.xSpeed*=(-1)
            self.randomizeColor()
        }
        
        if(self.dvdY+h >= self.bounds.height || self.dvdY <= 0) {
            self.ySpeed*=(-1)
            self.randomizeColor()
        }
        
        if(self.fadeInCount <= 10) {
            self.fadeInCount+=0.1
        }
        
        setNeedsDisplay(self.bounds)
    }
}
