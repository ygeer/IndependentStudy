//
//  GameScene.swift
//  Independent
//
//  Created by Yoni Geer on 5/1/18.
//  Copyright © 2018 Yoni Geer. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Parse

class GameScene: SKScene, SKPhysicsContactDelegate {
    var background = SKSpriteNode(imageNamed: "road.jpg")
    
    
    var playercar: SKSpriteNode?
    var ceiling: SKSpriteNode?
    var ground: SKSpriteNode?
    var scorelabel:SKLabelNode?
    var playagain:SKLabelNode?
    var police: SKLabelNode?
    var endscorelabel: SKLabelNode?
    var finalscore: SKLabelNode?
    
    var oiltimer:Timer?
    var cartimer:Timer?
    var linetimer:Timer?
    
    let coinmancategory:UInt32=0x1<<1
    let oilcategory:UInt32=0x1<<2
    let bombcategory:UInt32=0x1<<3
    let ceilingandgroundcategory:UInt32=0x1<<4
    let truckcategory: UInt32=0x1<<5
    
    
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
        
        oiltimer=Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            self.createoil()
        })
        cartimer=Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (timer) in
            self.createpolice()
        })
        linetimer=Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
            self.createline()
        })
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch=touches.first
        let location=touch?.location(in: self)
        playercar?.position.x=(location?.x)!
        playercar?.position.y=(location?.y)! + (playercar?.size.height)!
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
        //when the gameover and final score label and icon appear to restart
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
    
    func touchDown(atPoint pos : CGPoint) {
     print("down")
     playercar?.position=(pos)
     }
    
    func touchMoved(toPoint pos : CGPoint) {
        print("down")
        playercar?.position=pos
        playercar?.position.y=pos.y+((playercar?.size.height)!*2)
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    
    
// --------------Creations, Collisions and Gameover--------------------------------\\
    func createoil(){
        let oil=SKSpriteNode(imageNamed: "oil")
        oil.physicsBody=SKPhysicsBody(rectangleOf: oil.size)
        oil.physicsBody?.affectedByGravity=false
        oil.physicsBody?.categoryBitMask=oilcategory
        oil.physicsBody?.contactTestBitMask=oilcategory
        oil.physicsBody?.collisionBitMask=0
        
        
        let maxx=size.width/2 - oil.size.width/2
        let minx = -(size.width/2 + oil.size.width/2)
        let range=maxx-minx
        let coiny = maxx - CGFloat(arc4random_uniform(UInt32(range)))
        
        addChild(oil)
        
        oil.position=CGPoint(x: coiny, y: size.height/2+oil.size.width)
        let moveleft=SKAction.moveBy(x: 0, y: -size.height-oil.size.height , duration: 5)
        oil.run(SKAction.sequence([moveleft, SKAction.removeFromParent()]))
    }
    
    func createpolice(){
        let police=SKSpriteNode(imageNamed: "policecar")
        police.physicsBody=SKPhysicsBody(rectangleOf: police.size)
    
        police.size=CGSize(width: 100, height: 200)
        police.physicsBody?.affectedByGravity=false
        police.physicsBody?.categoryBitMask=truckcategory
        police.physicsBody?.contactTestBitMask=truckcategory
        police.physicsBody?.collisionBitMask=0
        
        
        let maxx=size.width/2 - police.size.width/2
        let minx = -(size.width/2 + police.size.width/2)
        let range=maxx-minx
        let coiny = maxx - CGFloat(arc4random_uniform(UInt32(range)))
        
        addChild(police)
        
        police.position=CGPoint(x: coiny, y: size.height/2)
        let moveleft=SKAction.moveBy(x:0 , y: -size.height, duration: 5)
        police.run(SKAction.sequence([moveleft, SKAction.removeFromParent()]))
    }
    
    func createline(){
        let yellowline=SKSpriteNode(imageNamed: "StreetLine")
        yellowline.size=CGSize(width: 50, height: 100)
        yellowline.physicsBody?.affectedByGravity=false
        yellowline.physicsBody?.collisionBitMask=0
        yellowline.zPosition = -7
        
        let whiteline=SKSpriteNode(imageNamed: "whiteline")
        whiteline.size=CGSize(width: 25, height: 50)
        whiteline.physicsBody?.affectedByGravity=false
        whiteline.physicsBody?.collisionBitMask=0
        whiteline.zPosition = -7
        
        let whiteline2=SKSpriteNode(imageNamed: "whiteline")
        whiteline2.size=CGSize(width: 25, height: 50)
        whiteline2.physicsBody?.affectedByGravity=false
        whiteline2.physicsBody?.collisionBitMask=0
        whiteline2.zPosition = -5
        
        addChild(yellowline)
        addChild(whiteline)
        addChild(whiteline2)
        
        yellowline.position=CGPoint(x: 0, y: size.height/2)
        
        whiteline.position=CGPoint(x: size.width/4, y: size.height/2)
        whiteline2.position=CGPoint(x: -size.width/4, y: size.height/2)
        
        let movedown=SKAction.moveBy(x:0 , y: -size.height, duration: 3)
        
        yellowline.run(SKAction.sequence([movedown, SKAction.removeFromParent()]))
        print("white")
        whiteline.run(SKAction.sequence([movedown, SKAction.removeFromParent()]))
        print("white2")
        whiteline2.run(SKAction.sequence([movedown, SKAction.removeFromParent()]))
    }
    
    func gameover(){
        scene?.isPaused=true
        oiltimer?.invalidate()
        cartimer?.invalidate()
        linetimer?.invalidate()
        
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
        
        let user=PFUser.current()
        user!["TopScore"]=score
        user?.saveInBackground()
        
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
            contact.bodyA.node?.removeFromParent()
            gameover()
            
        }
        print(contact.bodyB.categoryBitMask)
        if (contact.bodyB.categoryBitMask == truckcategory){
            contact.bodyB.node?.removeFromParent()
            gameover()
            
        }
        scorelabel?.text?="Score: \(score)"
        
        
    }
}


