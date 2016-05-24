//
//  HapinessViewController.swift
//  Happiness
//
//  Created by Onder Kalaci on 21/05/16.
//  Copyright © 2016 Onder Kalaci. All rights reserved.
//

import UIKit

class HapinessViewController: UIViewController, FaceViewDataSource
{
    
    /* 0 = very sad, 100 = most happiest */
    var hapiness: Int = 90
    {
        didSet
        {
            hapiness = min(max(hapiness, 0), 100)
            updateUI()
        }
    }
    
    @IBAction func ChangeHapiness(gesture: UIPanGestureRecognizer)
    {
        switch gesture.state
        {
            case .Ended:
                fallthrough
            case .Changed:
                let translation = gesture.translationInView(faceView)
                let happinessChange = -Int(translation.y / 4)
            
                if happinessChange != 0
                {
                    hapiness += happinessChange
                    gesture.setTranslation(CGPointZero, inView: faceView)
                }
            
            default:
                break
        }
        
    }
 
    @IBOutlet weak var faceView: HapinessUIView!
    {
        didSet
        {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:" ))
        }
    }

    
    func updateUI()
    {
        faceView.setNeedsDisplay()
    }
    
    func smilenessForFaceView(sender: HapinessUIView) -> Double?
    {
        return Double(hapiness - 50) / 50
    }
}
