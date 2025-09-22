//
//  DrawingView.swift
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/7/25.
//

import UIKit

protocol DrawingViewDelegate: AnyObject {
    func drawingView(_ view: DrawingView, didUpdatePoints points: [CGPoint])
    func drawingViewDidFinishDrawing(_ view: DrawingView)
}

class DrawingView: UIView {
    private var lines: [CGPoint] = []
    weak var delegate: DrawingViewDelegate?
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        lines.append(point)
        delegate?.drawingView(self, didUpdatePoints: lines)
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.drawingViewDidFinishDrawing(self)
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext(), lines.count > 1 else { return }
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(5)
        context.setLineCap(.round)
        
        context.beginPath()
        context.move(to: lines.first!)
        for point in lines.dropFirst() {
            context.addLine(to: point)
        }
        context.strokePath()
    }
    
    func getPoints() -> [CGPoint] {
        return lines
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
}
