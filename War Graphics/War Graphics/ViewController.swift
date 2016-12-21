//
//  ViewController.swift
//  War Graphics
//
//  Created by Student on 2016-12-15.
//  Copyright © 2016 Student. All rights reserved.
//

import Cocoa
import SpriteKit


class ViewController: NSViewController {
    
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene  = GameScene(size: CGSize(width: 1080, height: 800))
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        
        
    }
    
}


