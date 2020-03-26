//
//  GameScene.swift
//  PauseGameDemo
//
//  Created by Kyle Wilson on 2020-03-26.
//  Copyright © 2020 Xcode Tips. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var kirby: SKSpriteNode!
    var kirbyFrames: [SKTexture] = []
    
    var pauseButton: SKSpriteNode!
    var resumeButton: SKSpriteNode!
    
    let gameLayer = SKNode()
    let pauseLayer = SKNode()
    
    override func didMove(to view: SKView) {
        createPauseButton()
        createAnimation()
        makeKirby()
        runAnimation()
        addChild(gameLayer)
        addChild(pauseLayer)
    }
    
    func createPauseButton() {
        pauseButton = SKSpriteNode(imageNamed: "pause-button")
        pauseButton.size = CGSize(width: 75, height: 75)
        pauseButton.position = CGPoint(x: frame.midX, y: frame.midY + 175)
        pauseButton.name = "PauseButton"
        pauseLayer.addChild(pauseButton)
    }
    
    func createResumeButton() {
        resumeButton = SKSpriteNode(imageNamed: "resume-button")
        resumeButton.size = CGSize(width: 75, height: 75)
        resumeButton.position = CGPoint(x: frame.midX, y: frame.midY + 175)
        resumeButton.name = "ResumeButton"
        pauseLayer.addChild(resumeButton)
    }
    
    func makeKirby() {
        let firstFrameTexture = kirbyFrames[0]
        kirby = SKSpriteNode(texture: firstFrameTexture)
        kirby.size = CGSize(width: 100, height: 100)
        kirby.position = CGPoint(x: frame.midX, y: frame.midY + 300)
        gameLayer.addChild(kirby)
    }
    
    func createAnimation() {
        let animation = SKTextureAtlas(named: "kirby")
        var frames: [SKTexture] = []
        
        let numImages = animation.textureNames.count
        for i in 1...numImages {
            let textureName = "kirby-\(i)"
            frames.append(animation.textureNamed(textureName))
        }
        kirbyFrames = frames
    }
    
    func runAnimation() {
        kirby.run(SKAction.repeatForever(SKAction.animate(with: kirbyFrames, timePerFrame: 0.1)))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            let nodeUserTapped = atPoint(pointOfTouch)
            
            if nodeUserTapped.name == "PauseButton" {
                if (self.gameLayer.isPaused == false) {
                    self.gameLayer.isPaused = true
                    pauseButton.removeFromParent()
                    createResumeButton()
                }
            }
            
            if nodeUserTapped.name == "ResumeButton" {
                if (self.gameLayer.isPaused == true) {
                    self.gameLayer.isPaused = false
                    resumeButton.removeFromParent()
                    createPauseButton()
                }
            }
        }
    }
}
