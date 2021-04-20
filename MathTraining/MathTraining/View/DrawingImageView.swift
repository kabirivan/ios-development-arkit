//
//  DrawingImageView.swift
//  MathTraining
//
//  Created by Xavier Aguas on 4/18/21.
//

import UIKit

class DrawingImageView: UIImageView {

    weak var delegate: ViewController?
    var currentTouchPosition: CGPoint?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        
    }
    */
    
    
    func draw(from start: CGPoint, to end: CGPoint){
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        
        self.image = renderer.image { ctx in
            self.image?.draw(in: self.bounds)
            
            // Define parameter for CGContext image
            UIColor.blue.setStroke()
            ctx.cgContext.setLineCap(.round)
            ctx.cgContext.setLineWidth(9)
            
            
            // Draw strine line from start to end
            ctx.cgContext.move(to: start)
            ctx.cgContext.addLine(to: end)
            ctx.cgContext.strokePath()
            
            

        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        super.touchesBegan(touches, with: event)
        self.currentTouchPosition = touches.first?.location(in: self)
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
                
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        
        super.touchesMoved(touches, with: event)
        
        guard let newTouchPoint = touches.first?.location(in: self) else { return }
        guard let previousTouchPoint = self.currentTouchPosition else { return  }
        
        draw(from: previousTouchPoint, to: newTouchPoint)
        self.currentTouchPosition = newTouchPoint
            
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        
        super.touchesEnded(touches, with: event)
        self.currentTouchPosition = nil
        
        perform(#selector(numberDrawnOnScreen), with: nil, afterDelay: 0.5)
        
    }
    
    @objc func numberDrawnOnScreen(){
        
        
        
        
    }

}
