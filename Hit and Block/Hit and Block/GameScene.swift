//
//  GameScene.swift
//  Hit and Block
//
//  Created by Apple on 02/08/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main =  SKSpriteNode()
    var topLbl = SKLabelNode()
    var bottomLbl = SKLabelNode()
    var sparks = SKEmitterNode()
    
    var score = [Int]()
    
    
    override func didMove(to view: SKView) {
       
        self.scene!.scaleMode = .aspectFit
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        topLbl = self.childNode(withName: "TopLabel") as! SKLabelNode
        bottomLbl = self.childNode(withName: "BottomLabel") as! SKLabelNode
        sparks = self.childNode(withName: "ball")?.childNode(withName: "Sparks") as! SKEmitterNode
        GameBegin()
        
        ball.physicsBody?.applyImpulse(CGVector(dx:-30 , dy: -30))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        
    }
    
    func GameBegin (){
        score = [0,0]
        bottomLbl.text = "\(score[0])"
        topLbl.text = "\(score[1])"
    }
    
    func addScore (playerWhoWon: SKSpriteNode){
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx:30 , dy: 30))
        } else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx:-30 , dy: -30))
        }
        bottomLbl.text = "\(score[0])"
        topLbl.text = "\(score[1])"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0))
            }
            
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
                if location.y < 0 {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
            } else {
                main.run(SKAction.moveTo(x: location.x, duration: 0))
            }
            
        }
    }
    
    func vectorComp(point1: CGPoint, point2:CGPoint)-> CGVector {
        var movement = CGVector(
            dx: point1.x - point2.x,
            dy: point1.y - point2.y
        )
        movement.dy = movement.dy * 0.5
        return movement
    }
    
    func BallHit(){
        
    }
    
    override func update(_ currentTime: TimeInterval) {
//        if ball.position.y <= -508.2 && ball.position.y >= -508.4{
//            if (ball.position.x > main.position.x - 50 && ball.position.x < main.position.x + 50 ){
//                print(ball.position.y)
//                let action = vectorComp(point1: ball.position, point2: main.position)
//                print("action dx ",action.dx,"action dy ",action.dy, ball.position.x , main.position.x )
//                ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//                ball.physicsBody?.applyImpulse(action)
//            }
                
            
            
//        }
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.9))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.6))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
            break
        case .god:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.1))
            break
        case .player2:
            break
            
        }
        
        sparks.xAcceleration = -2*(ball.physicsBody?.velocity.dx)!
        sparks.yAcceleration = -2*(ball.physicsBody?.velocity.dy)!
        
        
        
        if ball.position.y <= main.position.y - 300 {
            addScore(playerWhoWon: enemy)
        } else if ball.position.y >= enemy.position.y + 300 {
            addScore(playerWhoWon: main)
        }
            
    }
}
