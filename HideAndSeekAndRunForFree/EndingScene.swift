//
//  EndingScene.swift
//  HideAndSeekAndRunForFree
//
//  Created by Lester Arguello on 4/7/25.
//

import SpriteKit

class EndingScene: SKScene {

    override func didMove(to view: SKView) {
        // Add ground
        let ground = SKSpriteNode(color: .green, size: CGSize(width: size.width, height: 100))
        ground.position = CGPoint(x: size.width / 2, y: 50)
        addChild(ground)

        // Add Grant on horse
        let grantHorse = SKSpriteNode(imageNamed: "grant-horse") // image in assets
        grantHorse.position = CGPoint(x: -grantHorse.size.width, y: ground.position.y + 80)
        addChild(grantHorse)

        // Move him across the screen
        let moveAction = SKAction.moveTo(x: size.width + grantHorse.size.width, duration: 8.0)
        let waveAction = SKAction.sequence([
            SKAction.rotate(byAngle: .pi / 16, duration: 0.1),
            SKAction.rotate(byAngle: -.pi / 16, duration: 0.1)
        ])
        let repeatWave = SKAction.repeatForever(waveAction)
        grantHorse.run(repeatWave) // Gives a whimsical jiggle

        grantHorse.run(moveAction)
        
        // Optional: Add some floating flags or clouds
        let flag = SKSpriteNode(imageNamed: "flag")
        flag.position = CGPoint(x: size.width - 80, y: size.height - 100)
        addChild(flag)
        flag.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.moveBy(x: 0, y: 10, duration: 0.5),
            SKAction.moveBy(x: 0, y: -10, duration: 0.5)
        ])))
    }
}
