//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Li An on 3/11/15.
//  Copyright (c) 2015 LA. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    
    @IBOutlet weak var faceView: FaceView! {
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    private struct Constants{
        static let HappinessGestureScals: CGFloat = 4
    }
    
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state{
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScals)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
                
                
            }
        default: break
        }
        
        
    }
    
    
    var happiness: Int = 50 { // 0 = very sad, 100 = ecstatic
        didSet{
            happiness = min(max(happiness, 0),100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    
    func updateUI(){
        faceView.setNeedsDisplay()
    }
    
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
}
