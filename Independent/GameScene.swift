//
//  GameScene.swift
//  Coin man
//
//  Created by Yoni Geer on 4/16/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var playercar: SKSpriteNode?
    var ceiling: SKSpriteNode?
    var ground: SKSpriteNode?
    var scorelabel:SKLabelNode?
    var playagain:SKLabelNode?
    var truck: SKLabelNode?
    var endscorelabel: SKLabelNode?
    var finalscore: SKLabelNode?
    
    var cointtimer:Timer?
    var trucktimer:Timer?
    let coinmancategory:UInt32=0x1<<1
    let oilcategory:UInt32=0x1<<2
    let bombcategory:UInt32=0x1<<3
    let ceilingandgroundcategory:UInt32=0x1<<4
    let truckcategory: UInt32=0x1<<5
    
    var on=0
    var score=0
    var tank=50
    
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate=self
        
        
        playercar=childNode(withName: "playercar") as? SKSpriteNode
        playercar?.physicsBody?.categoryBitMask=coinmancategory
        playercar?.physicsBody?.contactTestBitMask=oilcategory | truckcategory
        playercar?.physicsBody?.collisionBitMask=ceilingandgroundcategory
        
        ground?.physicsBody?.collisionBitMask=coinmancategory
        
        
        ceiling=childNode(withName: "ceiling") as? SKSpriteNode
        ceiling?.physicsBody?.categoryBitMask=ceilingandgroundcategory
        
        ground=childNode(withName: "ground") as? SKSpriteNode
        ground?.physicsBody?.categoryBitMask=ceilingandgroundcategory
        
        scorelabel=childNode(withName: "scorelabel") as? SKLabelNode
        starttimers()
        
        
    }
    
    
    func starttimers(){
        cointtimer=Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            self.createcoin()
        })
        trucktimer=Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (timer) in
            self.createtruck()
        })
    }
    
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        playercar?.physicsBody?.applyForce(CGVector(dx: 0 , dy: 30000))
        on=1
        let touch=touches.first
        if let location=touch?.location(in: self){
            let thenodes=nodes(at: location)
            for node in thenodes{
                if node.name=="playagain"{
                    score=0
                    node.removeFromParent()
                    endscorelabel?.removeFromParent()
                    finalscore?.removeFromParent()
                    scene?.isPaused=false
                    scorelabel?.text?="Score: \(score)"
                    starttimers()
                }
            }
        }
        
    }
    
    
    func createcoin(){
        let oil=SKSpriteNode(imageNamed: "oil")
        oil.physicsBody=SKPhysicsBody(rectangleOf: oil.size)
        oil.physicsBody?.affectedByGravity=false
        oil.physicsBody?.categoryBitMask=oilcategory
        oil.physicsBody?.contactTestBitMask=oilcategory
        oil.physicsBody?.collisionBitMask=0
        
        
        let maxx=size.height/2 - oil.size.height/2
        let minx = -(size.height/2 + oil.size.height/2)
        let range=maxx-minx
        let coiny = maxx - CGFloat(arc4random_uniform(UInt32(range)))
        
        addChild(oil)
        
        oil.position=CGPoint(x: size.width/2+oil.size.width, y: coiny)
        let moveleft=SKAction.moveBy(x: -size.height-oil.size.height, y: 0 , duration: 5)
        oil.run(SKAction.sequence([moveleft, SKAction.removeFromParent()]))
    }
    func createtruck(){
        let truck=SKSpriteNode(imageNamed: "truck")
        truck.physicsBody=SKPhysicsBody(rectangleOf: truck.size)
       // let oneRevolution:SKAction = SKAction.rotate(byAngle: -45, duration: 1)
        truck.size=CGSize(width: 200, height: 100)
        truck.physicsBody?.affectedByGravity=false
        truck.physicsBody?.categoryBitMask=truckcategory
        truck.physicsBody?.contactTestBitMask=truckcategory
        truck.physicsBody?.collisionBitMask=0
        
        
        let maxx=size.height/2 - truck.size.height/2
        let minx = -(size.height/2 + truck.size.height/2)
        let range=maxx-minx
        let coiny = maxx - CGFloat(arc4random_uniform(UInt32(range)))
        
        addChild(truck)
        
        truck.position=CGPoint(x: size.width/2, y: coiny)
        let moveleft=SKAction.moveBy(x: -size.width, y: 0 , duration: 5)
        truck.run(SKAction.sequence([moveleft, SKAction.removeFromParent()]))
    }
    
    func gameover(){
        scene?.isPaused=true
        cointtimer?.invalidate()
        trucktimer?.invalidate()
        
        endscorelabel=SKLabelNode(text: "Score: ")
        endscorelabel?.position=CGPoint(x: 0, y: 200)
        endscorelabel?.fontSize=100
        addChild(endscorelabel!)
        
        finalscore=SKLabelNode(text: "\(score)")
        finalscore?.position=CGPoint(x: 0, y: 0)
        finalscore?.fontSize=200
        addChild(finalscore!)
        
        let playagain = SKSpriteNode(imageNamed:"playagain")
        playagain.position=CGPoint(x: 0, y: -200)
        playagain.name="playagain"
        addChild(playagain)
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
       
       
        print(contact.bodyA.categoryBitMask)
        if (contact.bodyA.categoryBitMask == oilcategory){
           // print("hello")
             score+=1
             contact.bodyA.node?.removeFromParent()
        }
        print(contact.bodyB.categoryBitMask)
        if (contact.bodyB.categoryBitMask == oilcategory){
             //print("hellob")
             score+=1
            contact.bodyB.node?.removeFromParent()
        }
        
        if (contact.bodyA.categoryBitMask == truckcategory){
           gameover()
        }
        print(contact.bodyB.categoryBitMask)
        if (contact.bodyB.categoryBitMask == truckcategory){
            gameover()
        }
         scorelabel?.text?="Score: \(score)"
        
        
    }
}
