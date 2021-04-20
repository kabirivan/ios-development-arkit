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
        
        guard let image = self.image else { return }
        
        let drawRect = CGRect(x: 0, y:0, width: 28, height: 28)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let renderer = UIGraphicsImageRenderer(bounds: drawRect , format: format)
        
        let imageWithWhiteBackground = renderer.image {ctx in
            
            UIColor.white.setFill()
            ctx.fill(bounds)
            image.draw(in: drawRect)
        }
        
        // Convert an UIImage from CG to CI
        let ciImage = CIImage(cgImage: imageWithWhiteBackground.cgImage!)
        
        // Invert colors
        
        if let  filter = CIFilter(name: "CIColorInvert"){
            // Define CIImage to be filtered
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
            // Create context to apply filter
            let context = CIContext(options: nil)
            
            if let outputImage = filter.outputImage{
                // Try converting CGImage
                if let imageRef = context.createCGImage(outputImage, from: ciImage.extent){
                    let resultImage = UIImage(cgImage: imageRef)
                    
                    self.delegate?.numberDrawn(resultImage)
                }
                
                
            }
            
            
        }
    }

}
