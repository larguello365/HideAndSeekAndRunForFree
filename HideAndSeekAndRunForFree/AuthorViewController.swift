//
//  AuthorViewController.swift
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/6/25.
//

import UIKit

enum ParentalGateError: Error {
    case incorrectDrawingOrder(actualOrder: [Int])
    case notAllNumbersHit
}

class AuthorViewController: UIViewController, DrawingViewDelegate {

    @IBOutlet var one: UIImageView!
    @IBOutlet var two: UIImageView!
    @IBOutlet var three: UIImageView!
    @IBOutlet var four: UIImageView!
    @IBOutlet var five: UIImageView!
    
    var numberFrames: [(Int, CGRect)] = []
    var numberOrder: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        numberFrames = [
            (1, one.convert(one.bounds, to: view)),
            (2, two.convert(two.bounds, to: view)),
            (3, three.convert(three.bounds, to: view)),
            (4, four.convert(four.bounds, to: view)),
            (5, five.convert(five.bounds, to: view)),
        ]
        
        let drawingView = DrawingView(frame: view.bounds)
        drawingView.backgroundColor = .clear
        drawingView.delegate = self
        view.addSubview(drawingView)
        view.bringSubviewToFront(drawingView)
    }
    
    func drawingView(_ view: DrawingView, didUpdatePoints points: [CGPoint]) {
        guard let last = points.last else { return }
        
        for (number, frame) in numberFrames {
            if frame.contains(last) {
                // Only log a number if it hasn't been hit before
                if !numberOrder.contains(number) {
                    numberOrder.append(number)
                    print("Hit number \(number)")
                }
                break
            }
        }
    }
    
    func drawingViewDidFinishDrawing(_ view: DrawingView) {
        defer {
            view.clear()
            numberOrder.removeAll()
        }
        
        do {
            try validateDrawing()
            presentAuthorInfo()
        } catch {
            print("Drawing failed: \(error)")
            numberOrder.removeAll()
            view.clear()
        }
    }
    
    func validateDrawing() throws {
        if numberOrder.count < 5 {
            throw ParentalGateError.notAllNumbersHit
        }
        
        if numberOrder != [1, 2, 3, 4, 5] {
            throw ParentalGateError.incorrectDrawingOrder(actualOrder: numberOrder)
        }
    }
    
    func checkDrawingTapped() {
        do {
            try validateDrawing()
        } catch ParentalGateError.incorrectDrawingOrder(let actualOrder) {
            print("Incorrect order: \(actualOrder)")
        } catch {
            print("Unknown error: \(error)")
        }
    }
    
    func presentAuthorInfo() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let infoVC = storyboard.instantiateViewController(withIdentifier: "AuthorInfoViewController") as! AuthorInfoViewController
        navigationController?.pushViewController(infoVC, animated: true)
    }

}
