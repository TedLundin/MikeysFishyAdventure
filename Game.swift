// 
// Game.swift
// Mikey's Fishy Adventure
//
// Created by Teddy Lundin on 1/22/18
// 

import SpriteKit
import UIKit

struct ColliderType {
    static let MIKEY: UInt32 = 0x1 << 5
    static let STOPPERS: UInt32 = 0x1 << 6
    static let BADDIES: UInt32 = 0x1 << 10
    static let COLLECTIBLES: UInt32 = 0x1 << 1
}

class Game: SKScene, SKPhysicsContactDelegate {
    let worldNode = SKNode()
    let counterNode = SKNode()
    var Ocean = SKSpriteNode()
    var Sky = SKSpriteNode()
    var UnderwaterThing = SKSpriteNode()
    var UnderwaterThing2 = SKSpriteNode()
    var UnderwaterThing3 = SKSpriteNode()
    var frontMountains = SKSpriteNode()
    var MikeyTextureAtlas = SKTextureAtlas()
    var MikeyTextureArray = [SKTexture]()
    var Mikey = SKSpriteNode()
    var Whale = SKSpriteNode()
    var SeaStar = SKSpriteNode()
    var Piranha = SKSpriteNode()
    var Swordfish = SKSpriteNode()
    var GreatWhite = SKSpriteNode()
    var Turtle = SKSpriteNode()
    var Chicken = SKSpriteNode()
    var Crab = SKSpriteNode()
    var Squid = SKSpriteNode()
    var Clam = SKSpriteNode()
    var Jellyfish = SKSpriteNode()
    var Stingray = SKSpriteNode()
    var Eel = SKSpriteNode()
    var TopStopper = SKSpriteNode()
    var BottomStopper = SKSpriteNode()
    let MikeyCamera = SKCameraNode()
    var Seaweed = SKSpriteNode()
    var Ground = SKSpriteNode(imageNamed: "Ground")
    var BackBlue = SKSpriteNode()
    var explosion = SKSpriteNode()
    var explosionTextureAtlas = SKTextureAtlas()
    var explosionTextureArray = [SKTexture]()
    /*var ChickenTextureAtlas = SKTextureAtlas()
     var ChickenTextureArray = [SKTexture]()
     var ClamTextureAtlas = SKTextureAtlas()
     var ClamTextureArray = [SKTexture]()
     var CrabTextureAtlas = SKTextureAtlas()
     var CrabTextureArray = [SKTexture]()
     var EelTextureAtlas = SKTextureAtlas()
     var EelTextureArray = [SKTexture]()
     var GreatWhiteTextureAtlas = SKTextureAtlas()
     var GreatWhiteTextureArray = [SKTexture]()
     var JellyfishTextureAtlas = SKTextureAtlas()
     var JellyfishTextureArray = [SKTexture]()
     var PiranhaTextureAtlas = SKTextureAtlas()
     var PiranhaTextureArray = [SKTexture]()
     var SeaStarTextureAtlas = SKTextureAtlas()
     var SeaStarTextureArray = [SKTexture]()
     var SquidTextureAtlas = SKTextureAtlas()
     var SquidTextureArray = [SKTexture]()
     var StingrayTextureAtlas = SKTextureAtlas()
     var StingrayTextureArray = [SKTexture]()
     var SwordfishTextureAtlas = SKTextureAtlas()
     var SwordfishTextureArray = [SKTexture]()
     var TurtleTextureAtlas = SKTextureAtlas()
     var TurtleTextureArray = [SKTexture]()
     var WhaleTextureAtlas = SKTextureAtlas()
     var WhaleTextureArray = [SKTexture]()*/
    var ratzYouDied = SKSpriteNode()
    var K = SKSpriteNode()
    var kButton = SKSpriteNode()
    var pause = SKSpriteNode()
    var pauseButton = SKSpriteNode()
    var unpause = SKSpriteNode()
    var unpauseButton = SKSpriteNode()
    var pausedString = SKSpriteNode()
    var goldfish = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    static var score = 0
    var goldfishAmountLabel = SKLabelNode()
    static var goldfishAmount = 0
    var lifeLabel = SKLabelNode()
    var lifeAmount = 0
    let gameYellow = UIColor(red: 1.0, green: 240/255, blue: 0.0, alpha: 1.0)
    var nodesToRemove = [SKNode]()
    let whaleExplosion = SKEmitterNode()
    let seaStarExplosion = SKEmitterNode()
    let piranhaExplosion = SKEmitterNode()
    let swordfishExplosion = SKEmitterNode()
    let greatWhiteExplosion = SKEmitterNode()
    let turtleExplosion = SKEmitterNode()
    let crabExplosion = SKEmitterNode()
    let chickenExplosion = SKEmitterNode()
    let squidExplosion = SKEmitterNode()
    let clamExplosion = SKEmitterNode()
    let jellyfishExplosion = SKEmitterNode()
    let stingrayExplosion = SKEmitterNode()
    let eelExplosion = SKEmitterNode()
    var life = SKSpriteNode()
    static var gamePaused = UserDefaults().bool(forKey: "GAMEPAUSED")
    
    override func didMove(to view: SKView) {
        Game.gamePaused = false
        UserDefaults.standard.setValue(Game.gamePaused, forKey: "GAMEPAUSED")
        Game.score = 0
        Game.goldfishAmount = 0
        
        if VehicleStore.mikeySelected {
            lifeAmount = 1
        } else if VehicleStore.bikeSelected {
            lifeAmount = 3
        } else if VehicleStore.carSelected {
            lifeAmount = 6
        } else if VehicleStore.trainSelected {
            lifeAmount = 11
        } else if VehicleStore.submarineSelected {
            lifeAmount = 16
        }
        
        self.addChild(worldNode)
        self.addChild(counterNode)
        
        MikeyCamera.position = CGPoint(x: (scene?.size.width)! / 2, y: (scene?.size.height)! / 2)
        self.addChild(MikeyCamera)
        self.camera = MikeyCamera
        
        placeBottomOcean()
        placeTopStopper()
        placeBottomStopper()
        placeGround()
        createUnderwaterThing()
        placeTopOcean()
        createScoreLabel()
        createGoldfishAmountLabel()
        createK()
        createKButton()
        createLifeLabel()
        createGoldfish()
        physicsWorld.speed = 1.25
        
        if VehicleStore.mikeySelected {
            let MikeTextureAtlas = SKTextureAtlas(named: "NewMikey")
            for i in 1...MikeyTextureAtlas.textureNames.count {
                let name = "Mikey\(i)"
                MikeyTextureArray.append(SKTexture(imageNamed: name))
            }
            Mikey = SKSpriteNode(imageNamed: MikeyTextureAtlas.textureNames[0])
            Mikey.size = CGSize(width: (self.scene!.size.width) * 0.072044334975369, height: (self.scene!.size.width) * 0.072044334975369)
            Mikey.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            Mikey.position = CGPoint(x: (self.scene!.size.width) * 0.13136288998358, y: -(self.frame.size.height) / 2 - 100)
            Mikey.zPosition = 2.5
            worldNode.addChild(Mikey)
            Mikey.run(SKAction.repeatForever(SKAction.animate(with: MikeyTextureArray, timePerFrame: 0.07)))
            let mikeyRange = SKRange(lowerLimit: (self.scene!.size.width) * 0.13136288998358)
            let mikeyConstraints = SKConstraint.positionX(mikeyRange)
            Mikey.constraints = [ mikeyConstraints ]
            let MikeyTexture = SKTexture(imageNamed: "Mikey")
            Mikey.physicsBody = SKPhysicsBody(texture: MikeyTexture, size: Mikey.size)
            physicsWorld.gravity.dy *= 0.3
            Mikey.physicsBody?.affectedByGravity = true
            Mikey.physicsBody?.allowsRotation = false
            Mikey.physicsBody?.restitution = 0
            Mikey.physicsBody?.categoryBitMask = ColliderType.MIKEY
            Mikey.physicsBody?.contactTestBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.isDynamic = true
            Mikey.physicsBody?.mass = 150
        } else if VehicleStore.bikeSelected {
            MikeyTextureAtlas = SKTextureAtlas(named: "MikeyWithBike")
            for i in 1...MikeyTextureAtlas.textureNames.count {
                let name = "BikeWithMikey\(i)"
                MikeyTextureArray.append(SKTexture(imageNamed: name))
            }
            Mikey = SKSpriteNode(imageNamed: MikeyTextureAtlas.textureNames[0])
            Mikey.size = CGSize(width: (self.scene!.size.width) * 0.090311986863711, height: (self.scene!.size.width) * 0.088669950738916)
            Mikey.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            Mikey.position = CGPoint(x: (self.scene!.size.width) * 0.13136288998358, y: -(self.frame.size.height) / 2 - 100)
            Mikey.zPosition = 2.5
            worldNode.addChild(Mikey)
            Mikey.run(SKAction.repeatForever(SKAction.animate(with: MikeyTextureArray, timePerFrame: 0.077)))
            let mikeyRange = SKRange(lowerLimit: (self.scene!.size.width) * 0.13136288998358)
            let mikeyConstraints = SKConstraint.positionX(mikeyRange)
            Mikey.constraints = [ mikeyConstraints ]
            let bikeWithMikeyTexture = SKTexture(imageNamed: "BikeWithMikey")
            Mikey.physicsBody = SKPhysicsBody(texture: bikeWithMikeyTexture, size: CGSize(width: Mikey.size.width, height: Mikey.size.height))
            physicsWorld.gravity.dy *= 0.25
            Mikey.physicsBody?.affectedByGravity = true
            Mikey.physicsBody?.allowsRotation = false
            Mikey.physicsBody?.restitution = 0
            Mikey.physicsBody?.categoryBitMask = ColliderType.MIKEY
            Mikey.physicsBody?.contactTestBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.collisionBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.isDynamic = true
            Mikey.physicsBody?.mass = 150
        } else if VehicleStore.carSelected {
            Mikey = SKSpriteNode(imageNamed: "CarWithMikey")
            Mikey.size = CGSize(width: (self.scene!.size.width) * 0.221674876847291, height: (self.scene!.size.width) * 0.123152709359606)
            Mikey.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            Mikey.position = CGPoint(x: (self.scene!.size.width) * 0.13136288998358, y: -(self.frame.size.height) / 2 - 100)
            Mikey.zPosition = 2.5
            worldNode.addChild(Mikey)
            let mikeyRange = SKRange(lowerLimit: (self.scene!.size.width) * 0.13136288998358)
            let mikeyConstraints = SKConstraint.positionX(mikeyRange)
            Mikey.constraints = [ mikeyConstraints ]
            let carWithMikeyTexture = SKTexture(imageNamed: "BikeWithMikey")
            Mikey.physicsBody = SKPhysicsBody(texture: carWithMikeyTexture, size: CGSize(width: Mikey.size.width, height: Mikey.size.height))
            physicsWorld.gravity.dy *= 0.25
            Mikey.physicsBody?.affectedByGravity = true
            Mikey.physicsBody?.allowsRotation = false
            Mikey.physicsBody?.restitution = 0
            Mikey.physicsBody?.categoryBitMask = ColliderType.MIKEY
            Mikey.physicsBody?.contactTestBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.collisionBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.isDynamic = true
            Mikey.physicsBody?.mass = 150
        } else if VehicleStore.trainSelected {
            MikeyTextureAtlas = SKTextureAtlas(named: "TrainWithMikey")
            for i in 1...MikeyTextureAtlas.textureNames.count {
                let name = "TrainWithMikey\(i)"
                MikeyTextureArray.append(SKTexture(imageNamed: name))
            }
            Mikey = SKSpriteNode(imageNamed: MikeyTextureAtlas.textureNames[0])
            Mikey.size = CGSize(width: (self.scene!.size.width) * 0.279146141215107, height: (self.scene!.size.width) * 0.197044334975369)
            Mikey.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            Mikey.position = CGPoint(x: (self.scene!.size.width) * 0.139573070607553, y: -(self.frame.size.height) / 2 - 250)
            Mikey.zPosition = 2.5
            worldNode.addChild(Mikey)
            Mikey.run(SKAction.repeatForever(SKAction.animate(with: MikeyTextureArray, timePerFrame: 0.07)))
            let mikeyRange = SKRange(lowerLimit: (self.scene!.size.width) * 0.13136288998358)
            let mikeyConstraints = SKConstraint.positionX(mikeyRange)
            Mikey.constraints = [ mikeyConstraints ]
            let trainWithMikeyTexture = SKTexture(imageNamed: "TrainWithMikey")
            Mikey.physicsBody = SKPhysicsBody(texture: trainWithMikeyTexture, size: CGSize(width: Mikey.size.width, height: Mikey.size.height))
            physicsWorld.gravity.dy *= 0.25
            Mikey.physicsBody?.affectedByGravity = true
            Mikey.physicsBody?.allowsRotation = false
            Mikey.physicsBody?.restitution = 0
            Mikey.physicsBody?.categoryBitMask = ColliderType.MIKEY
            Mikey.physicsBody?.contactTestBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.collisionBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.isDynamic = true
            Mikey.physicsBody?.mass = 150
        } else if VehicleStore.submarineSelected {
            MikeyTextureAtlas = SKTextureAtlas(named: "SubmarineWithMikey")
            for i in 1...MikeyTextureAtlas.textureNames.count {
                let name = "SubmarineWithMikey\(i)"
                MikeyTextureArray.append(SKTexture(imageNamed: name))
            }
            Mikey = SKSpriteNode(imageNamed: MikeyTextureAtlas.textureNames[0])
            Mikey.size = CGSize(width: (self.scene!.size.width) * 0.279146141215107, height: (self.scene!.size.width) * 0.164203612479475)
            Mikey.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            Mikey.position = CGPoint(x: (self.scene!.size.width) * 0.139573070607553, y: -(self.frame.size.height) / 2 - 100)
            Mikey.zPosition = 2.5
            worldNode.addChild(Mikey)
            Mikey.run(SKAction.repeatForever(SKAction.animate(with: MikeyTextureArray, timePerFrame: 0.07)))
            let mikeyRange = SKRange(lowerLimit: (self.scene!.size.width) * 0.13136288998358)
            let mikeyConstraints = SKConstraint.positionX(mikeyRange)
            Mikey.constraints = [ mikeyConstraints ]
            let submarineWithMikeyTexture = SKTexture(imageNamed: "SubmarineWithMikey")
            Mikey.physicsBody = SKPhysicsBody(texture: submarineWithMikeyTexture, size: CGSize(width: Mikey.size.width, height: Mikey.size.height))
            physicsWorld.gravity.dy *= 0.25
            Mikey.physicsBody?.affectedByGravity = true
            Mikey.physicsBody?.allowsRotation = false
            Mikey.physicsBody?.restitution = 0
            Mikey.physicsBody?.categoryBitMask = ColliderType.MIKEY
            Mikey.physicsBody?.contactTestBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.collisionBitMask = ColliderType.BADDIES
            Mikey.physicsBody?.isDynamic = true
            Mikey.physicsBody?.mass = 150
        }
        
        spawnSeaCreature(animal: "Crab", wMul: 0.200738916256158, hMul: 0.172413793103448)
        spawnSeaCreature(animal: "Turtle", wMul: 0.272577996715928, hMul: 0.164203612479475)
        spawnSeaCreature(animal: "Chicken", wMul: 0.082101806239737, hMul: 0.082101806239737)
        spawnSeaCreature(animal: "GreatWhite", wMul: 0.477011494252874, hMul: 0.28735632183908)
        spawnSeaCreature(animal: "Swordfish", wMul: 0.408866995073892, hMul: 0.197044334975369)
        spawnSeaCreature(animal: "Piranha", wMul: 0.098522167487685, hMul: 0.082101806239737)
        spawnSeaCreature(animal: "SeaStar", wMul: 0.061576354679803, hMul: 0.061576354679803)
        spawnSeaCreature(animal: "Whale", wMul: 1.022167487684729, hMul: 0.61576354679803)
        spawnSeaCreature(animal: "Squid", wMul: 0.34072249589491, hMul: 0.328407224958949)
        spawnSeaCreature(animal: "Clam", wMul: 0.164203612479475, hMul: 0.164203612479475)
        spawnSeaCreature(animal: "Jellyfish", wMul: 0.172413793103448, hMul: 0.172413793103448)
        spawnSeaCreature(animal: "Stingray", wMul: 0.28735632183908, hMul: 0.205254515599343)
        spawnSeaCreature(animal: "Eel", wMul: 0.246305418719212, hMul: 0.102627257799672)
        spawnGoldfish()
        createAnimalExplosion(image: "BumWhale4", explosion: whaleExplosion, numParticles: 800)
        createAnimalExplosion(image: "BumSeaStar1", explosion: seaStarExplosion, numParticles: 250)
        createAnimalExplosion(image: "BumPiranha4", explosion: piranhaExplosion, numParticles: 250)
        createAnimalExplosion(image: "BumSwordfish4", explosion: swordfishExplosion, numParticles: 350)
        createAnimalExplosion(image: "BumGreatWhite4", explosion: greatWhiteExplosion, numParticles: 450)
        createAnimalExplosion(image: "BumCrab4", explosion: crabExplosion, numParticles: 250)
        createAnimalExplosion(image: "BumChicken4", explosion: chickenExplosion, numParticles: 250)
        createAnimalExplosion(image: "BumTurtle4", explosion: turtleExplosion, numParticles: 250)
        createAnimalExplosion(image: "BumSquid4", explosion: squidExplosion, numParticles: 400)
        createAnimalExplosion(image: "BumClam4", explosion: clamExplosion, numParticles: 250)
        createAnimalExplosion(image: "BumJellyfish4", explosion: jellyfishExplosion, numParticles: 250)
        createAnimalExplosion(image: "BumStingray4", explosion: stingrayExplosion, numParticles: 250)
        createAnimalExplosion(image: "BumEel4", explosion: eelExplosion, numParticles: 250)
        
        reverseGravity()
        
        let generateBadCreaturesRun = SKAction.perform(#selector(Game.generateBadCreatures), onTarget: self)
        worldNode.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: TimeInterval(randomBetweenNumbers(firstNumber: 0.25, secondNumber: 0.3))), generateBadCreaturesRun])))
        
        let generateGoldfishRun = SKAction.perform(#selector(Game.generateGoldfish), onTarget: self)
        worldNode.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: TimeInterval(randomBetweenNumbers(firstNumber: 0.8, secondNumber: 2))), generateGoldfishRun])))
        
        createPause()
        createPauseButton()
        createUnpause()
        createUnpauseButton()
        createLife()
        
        let increaseScore = SKAction.perform(#selector (Game.increaseScoreBy3), onTarget: self)
        worldNode.run(SKAction.repeatForever(SKAction.sequence([SKAction.wait(forDuration: 0.5), increaseScore])))
        
        let cameraRange = SKRange(lowerLimit: -(self.scene?.size.width)! * 2.594706798131811, upperLimit: -(self.frame.size.height) / 2)
        let cameraConstraints = SKConstraint.positionY(cameraRange)
        MikeyCamera.constraints = [ cameraConstraints ]
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        MikeyCamera.position.y = Mikey.position.y
        pause.position.y = MikeyCamera.position.y + ((self.scene!.size.height) / 2) - ((self.scene!.size.height) * 0.106666666666667)
        pauseButton.position.y = MikeyCamera.position.y + ((self.scene!.size.height) / 2) - ((self.scene!.size.height) * 0.106666666666667)
        unpause.position.y = MikeyCamera.position.y
        unpauseButton.position.y = MikeyCamera.position.y
        scoreLabel.position.y = MikeyCamera.position.y + ((self.scene!.size.height) / 2) - ((self.scene!.size.height) * 0.016420361247947)
        goldfishAmountLabel.position.y = MikeyCamera.position.y + ((self.scene!.size.height) / 2) - ((self.scene!.size.height) * 0.07799671592775)
        K.position.y = MikeyCamera.position.y
        kButton.position.y = MikeyCamera.position.y
        lifeLabel.position.y = MikeyCamera.position.y + ((self.scene!.size.height) / 2) - ((self.scene!.size.height) * 0.120689655172414)
        life.position.y = MikeyCamera.position.y + ((self.scene!.size.height) / 2) - ((self.scene!.size.height) * 0.135467980295567)
        goldfish.position.y =  MikeyCamera.position.y + ((self.scene!.size.height) / 2) - ((self.scene!.size.height) * 0.094417077175698)
        if UserDefaults().bool(forKey: "GAMEPAUSED") {
            worldNode.isPaused = true
            counterNode.isPaused = true
            physicsWorld.speed = 0
            unpauseButton.zPosition = 8
            unpause.zPosition = 8
            unpause.alpha = 1.0
            pauseButton.zPosition = -2
            pause.zPosition = -2
            pause.alpha = 0.0
        } else {
            worldNode.isPaused = false
            counterNode.isPaused = false
            physicsWorld.speed = 1
            unpauseButton.zPosition = -2
            unpause.zPosition = -2
            unpause.alpha = 0.0
            pauseButton.zPosition = 8
            pause.zPosition = 8
            pause.alpha = 1.0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reverseGravity()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        reverseGravity()
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if pauseButton.contains(location) {
                Game.gamePaused = true
                UserDefaults.standard.setValue(Game.gamePaused, forKey: "GAMEPAUSED")
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if unpauseButton.contains(location) {
                Game.gamePaused = false
                UserDefaults.standard.setValue(Game.gamePaused, forKey: "GAMEPAUSED")
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if kButton.contains(location) && lifeAmount == 0 {
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene)
                }
            }
        }
    }
    
    @objc func increaseScoreBy1() {
        Game.score += 1
        scoreLabel.text = String(Game.score)
    }
    
    @objc func increaseScoreBy3() {
        Game.score += 3
        scoreLabel.text = String(Game.score)
    }
    
    func increaseGoldfishAmount() {
        Game.goldfishAmount += 1
        goldfishAmountLabel.text = String(Game.goldfishAmount)
    }
    
    func decreaseLifeAmount() {
        lifeAmount -= 1
        lifeLabel.text = String(lifeAmount)
    }
    
    func increaseTotalGoldfishAmount() {
        MainMenu.totalGoldfishAmount += 1
    }
    
    func createScoreLabel() {
        scoreLabel.fontName = "Futura-MediumItalic"
        scoreLabel.fontSize = 144
        scoreLabel.fontColor = gameYellow
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        scoreLabel.position = CGPoint(x: ((self.scene!.size.width) * 0.082101806239737), y: -((self.scene!.size.width) * 0.016420361247947))
        scoreLabel.zPosition = 100
        scoreLabel.text = String(Game.score)
        counterNode.addChild(scoreLabel)
    }
    
    func createGoldfishAmountLabel() {
        goldfishAmountLabel.fontName = "Futura-MediumItalic"
        goldfishAmountLabel.fontSize = 96
        goldfishAmountLabel.fontColor = gameYellow
        goldfishAmountLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        goldfishAmountLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        goldfishAmountLabel.position = CGPoint(x: ((self.scene!.size.width) * 0.121100164203612), y: -((self.scene!.size.width) *  0.07799671592775))
        goldfishAmountLabel.zPosition = 100
        goldfishAmountLabel.text = "0"
        counterNode.addChild(goldfishAmountLabel)
    }
    
    func createLifeLabel() {
        lifeLabel.fontName = "Futura-MediumItalic"
        lifeLabel.fontSize = 96
        lifeLabel.fontColor = gameYellow
        lifeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        lifeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        lifeLabel.position = CGPoint(x: ((self.scene!.size.width) * 0.124794745484401), y: -((self.scene!.size.width) *  0.1206896551/2414))
        lifeLabel.zPosition = 100
        lifeLabel.text = String(lifeAmount)
        counterNode.addChild(lifeLabel)
    }
    
    func createLife() {
        life = SKSpriteNode(imageNamed: "Life")
        life.size = CGSize(width: (self.scene!.size.width) * 0.041050903119869, height: (self.scene!.size.width) * 0.041050903119869)
        life.position = CGPoint(x: (self.scene!.size.width) * 0.145320197044335, y: -((self.scene!.size.width) * 0.135467980295567))
        life.zPosition = 100
        self.addChild(life)
    }
    
    func createGoldfish() {
        goldfish = SKSpriteNode(imageNamed: "BumGoldfish")
        goldfish.size = CGSize(width: (self.scene!.size.width) * 0.041050903119869, height: (self.scene!.size.width) * 0.032840722495895)
        goldfish.position = CGPoint(x: ((self.scene!.size.width) * 0.098522167487685), y: -((self.scene!.size.width) * 0.094417077175698))
        goldfish.zPosition = 100
        goldfish.zRotation = -0.45
        self.addChild(goldfish)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == ColliderType.MIKEY && contact.bodyB.categoryBitMask == ColliderType.BADDIES {
            func createExplosionCopy(explosion: SKEmitterNode) {
                let explosionCopy = explosion.copy() as! SKEmitterNode
                explosionCopy.position = (contact.bodyB.node?.position)!
                self.addChild(explosionCopy)
            }
            if contact.bodyB.node?.name == "whaleCopy" {
                createExplosionCopy(explosion: whaleExplosion)
            }
            if contact.bodyB.node?.name == "seaStarCopy" {
                createExplosionCopy(explosion: seaStarExplosion)
            }
            if contact.bodyB.node?.name == "piranhaCopy" {
                createExplosionCopy(explosion: piranhaExplosion)
            }
            if contact.bodyB.node?.name == "swordfishCopy" {
                createExplosionCopy(explosion: swordfishExplosion)
            }
            if contact.bodyB.node?.name == "greatWhiteCopy" {
                createExplosionCopy(explosion: greatWhiteExplosion)
            }
            if contact.bodyB.node?.name == "crabCopy" {
                createExplosionCopy(explosion: crabExplosion)
            }
            if contact.bodyB.node?.name == "chickenCopy" {
                createExplosionCopy(explosion: chickenExplosion)
            }
            if contact.bodyB.node?.name == "turtleCopy" {
                createExplosionCopy(explosion: turtleExplosion)
            }
            if contact.bodyB.node?.name == "squidCopy" {
                createExplosionCopy(explosion: squidExplosion)
            }
            if contact.bodyB.node?.name == "clamCopy" {
                createExplosionCopy(explosion: clamExplosion)
            }
            if contact.bodyB.node?.name == "jellyfishCopy" {
                createExplosionCopy(explosion: jellyfishExplosion)
            }
            if contact.bodyB.node?.name == "stingrayCopy" {
                createExplosionCopy(explosion: stingrayExplosion)
            }
            if contact.bodyB.node?.name == "eelCopy" {
                createExplosionCopy(explosion: eelExplosion)
            }
            contact.bodyB.node?.removeFromParent()
            decreaseLifeAmount()
            if lifeAmount == 0 {
                Game.gamePaused = true
                UserDefaults.standard.setValue(Game.gamePaused, forKey: "GAMEPAUSED")
                createExplosion()
                createRatzYouDied()
                K.zPosition = 30
                kButton.zPosition = 30
                K.alpha = 1.0
            }
        }
        
        if contact.bodyA.categoryBitMask == ColliderType.BADDIES && contact.bodyB.categoryBitMask == ColliderType.MIKEY {
            func createExplosionCopy(explosion: SKEmitterNode) {
                let explosionCopy = explosion.copy() as! SKEmitterNode
                explosionCopy.position = (contact.bodyA.node?.position)!
                self.addChild(explosionCopy)
            }
            if contact.bodyA.node?.name == "whaleCopy" {
                createExplosionCopy(explosion: whaleExplosion)
            }
            if contact.bodyA.node?.name == "seaStarCopy" {
                createExplosionCopy(explosion: seaStarExplosion)
            }
            if contact.bodyA.node?.name == "piranhaCopy" {
                createExplosionCopy(explosion: piranhaExplosion)
            }
            if contact.bodyA.node?.name == "swordfishCopy" {
                createExplosionCopy(explosion: swordfishExplosion)
            }
            if contact.bodyA.node?.name == "greatWhiteCopy" {
                createExplosionCopy(explosion: greatWhiteExplosion)
            }
            if contact.bodyA.node?.name == "crabCopy" {
                createExplosionCopy(explosion: crabExplosion)
            }
            if contact.bodyA.node?.name == "chickenCopy" {
                createExplosionCopy(explosion: chickenExplosion)
            }
            if contact.bodyA.node?.name == "turtleCopy" {
                createExplosionCopy(explosion: turtleExplosion)
            }
            if contact.bodyA.node?.name == "squidCopy" {
                createExplosionCopy(explosion: squidExplosion)
            }
            if contact.bodyA.node?.name == "clamCopy" {
                createExplosionCopy(explosion: clamExplosion)
            }
            if contact.bodyA.node?.name == "jellyfishCopy" {
                createExplosionCopy(explosion: jellyfishExplosion)
            }
            if contact.bodyA.node?.name == "stingrayCopy" {
                createExplosionCopy(explosion: stingrayExplosion)
            }
            if contact.bodyA.node?.name == "eelCopy" {
                createExplosionCopy(explosion: eelExplosion)
            }
            contact.bodyA.node?.removeFromParent()
            decreaseLifeAmount()
            if lifeAmount == 0 {
                Game.gamePaused = true
                UserDefaults.standard.setValue(Game.gamePaused, forKey: "GAMEPAUSED")
                createExplosion()
                createRatzYouDied()
                K.zPosition = 30
                kButton.zPosition = 30
                K.alpha = 1.0
            }
        }
        
        if contact.bodyA.categoryBitMask == ColliderType.MIKEY && contact.bodyB.categoryBitMask == ColliderType.COLLECTIBLES {
            contact.bodyB.categoryBitMask = 0
            increaseScoreBy1()
            nodesToRemove.append(contact.bodyB.node!)
            increaseGoldfishAmount()
            increaseTotalGoldfishAmount()
        }
        
        if contact.bodyA.categoryBitMask == ColliderType.COLLECTIBLES && contact.bodyB.categoryBitMask == ColliderType.MIKEY {
            contact.bodyA.categoryBitMask = 0
            increaseScoreBy1()
            nodesToRemove.append(contact.bodyA.node!)
            increaseGoldfishAmount()
            increaseTotalGoldfishAmount()
        }
    }
    
    func createAnimalExplosion(image: String, explosion: SKEmitterNode, numParticles: Int) {
        let particleTexture = SKTexture(imageNamed: image)
        explosion.particleTexture = particleTexture
        explosion.position = CGPoint(x: -30000, y: 30000)
        explosion.particleBirthRate = 2000
        explosion.numParticlesToEmit = numParticles
        explosion.particleLifetime = 0.25
        explosion.emissionAngleRange = 360
        explosion.particleSpeed = 2000
        explosion.particleScale = 0.08
        explosion.alpha = 0.6
        explosion.zPosition = 3
        explosion.particlePositionRange = CGVector(dx: (self.scene!.size.width) * 0.061576354679803, dy: (self.scene!.size.width) * 0.061576354679803)
        explosion.isHidden = false
        explosion.particleScaleRange = CGFloat(0.15)
        self.addChild(explosion)
    }
    
    override func didFinishUpdate() {
        nodesToRemove.forEach(){$0.removeFromParent()}
        nodesToRemove = [SKNode]()
    }
    
    func createExplosion() {
        explosionTextureAtlas = SKTextureAtlas(named: "Explosion")
        for i in 1...explosionTextureAtlas.textureNames.count {
            let name = "Explosion\(i)"
            explosionTextureArray.append(SKTexture(imageNamed: name))
        }
        explosion = SKSpriteNode(imageNamed: explosionTextureAtlas.textureNames[0])
        explosion.size = CGSize(width: (self.scene!.size.width) * 1.231527093596059, height: (self.scene!.size.width) * 1.231527093596059)
        explosion.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        explosion.position = CGPoint(x: MikeyCamera.position.x, y: MikeyCamera.position.y)
        explosion.zPosition = 29
        explosion.run(SKAction.animate(with: explosionTextureArray, timePerFrame: 0.01))
        self.addChild(explosion)
    }
    
    func createPause() {
        pause = SKSpriteNode(imageNamed: "PauseButton")
        pause.name = "pause"
        pause.size = CGSize(width: (self.scene!.size.width) * 0.06568144499179, height: (self.scene!.size.width) * 0.082101806239737)
        pause.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pause.position = CGPoint(x: (self.scene!.size.width) * 0.947865353037767, y: -(self.scene!.size.width) * 0.106666666666667)
        pause.zPosition = 8
        pause.alpha = 1.0
        self.addChild(pause)
    }
    
    func createPauseButton() {
        pauseButton.size = CGSize(width: (self.scene!.size.width) * 0.04926108374384, height: (self.scene!.size.width) * 0.057471264367816)
        pauseButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pauseButton.position = CGPoint(x: (self.scene!.size.width) * 0.947865353037767, y: -(self.scene!.size.width) * 0.106666666666667)
        pauseButton.zPosition = 8
        self.addChild(pauseButton)
    }
    
    func createUnpause() {
        unpause = SKSpriteNode(imageNamed: "UnpauseButton")
        unpause.name = "unpause"
        unpause.size = CGSize(width: (self.scene!.size.width) * 0.246305418719212, height: (self.scene!.size.width) * 0.246305418719212)
        unpause.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        unpause.position = CGPoint(x: (self.scene!.size.width) / 2, y: Mikey.position.y)
        unpause.zPosition = -2
        unpause.alpha = 0.0
        self.addChild(unpause)
    }
    
    func createUnpauseButton() {
        unpauseButton.size = CGSize(width: (self.scene!.size.width) * 0.164203612479475, height: (self.scene!.size.width) * 0.164203612479475)
        unpauseButton.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        unpauseButton.position = CGPoint(x: (self.scene!.size.width) / 2, y: Mikey.position.y)
        unpauseButton.zPosition = -2
        self.addChild(unpauseButton)
    }
    
    func createPaused () {
        pausedString = SKSpriteNode(imageNamed: "Paused")
        pausedString.name = "pausedString"
        pausedString.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausedString.position = (self.scene?.view?.center)!
        pausedString.zPosition = 7
        self.addChild(pausedString)
    }
    
    func createRatzYouDied () {
        ratzYouDied = SKSpriteNode(imageNamed: "RatzYouDied")
        ratzYouDied.name = "ratzYouDied"
        ratzYouDied.size = CGSize(width: (self.scene!.size.width) * 0.492610837438424, height: (self.scene!.size.width) * 0.443349753694581)
        ratzYouDied.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ratzYouDied.position = CGPoint(x: MikeyCamera.position.x, y: MikeyCamera.position.y)
        ratzYouDied.zPosition = 30
        self.addChild(ratzYouDied)
    }
    
    func createK() {
        K = SKSpriteNode(imageNamed: "KButton")
        K.name = "K"
        K.size = CGSize(width: (self.scene!.size.width) * 0.073891625615764, height: (self.scene!.size.width) * 0.073891625615764)
        K.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        K.position = CGPoint(x: (self.scene!.size.width) * 0.921592775041051, y: MikeyCamera.position.y)
        K.zPosition = -2
        K.alpha = 0.0
        self.addChild(K)
    }
    
    func createKButton() {
        kButton.size = CGSize(width: (self.scene!.size.width) * 0.057471264367816, height: (self.scene!.size.width) * 0.057471264367816)
        kButton.position = CGPoint(x: (self.scene!.size.width) * 0.921592775041051, y: MikeyCamera.position.y)
        kButton.alpha = 0.0
        kButton.zPosition = -2
        self.addChild(kButton)
    }
    
    func spawnGoldfish() {
        goldfish = SKSpriteNode(imageNamed: "BumGoldfish")
        goldfish.name = "Goldfish"
        goldfish.size = CGSize(width: (self.scene!.size.width) * 0.041050903119869, height: (self.scene!.size.width) * 0.032840722495895)
        goldfish.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        goldfish.position.x = -2000
        goldfish.position.y = 2000
        goldfish.zPosition = 3
        goldfish.zRotation = -0.44
        worldNode.addChild(goldfish)
        let goldfishTexture = SKTexture(imageNamed: "BumGoldfish")
        goldfish.physicsBody = SKPhysicsBody(texture: goldfishTexture, size: CGSize(width: goldfish.size.width, height: goldfish.size.height))
        goldfish.physicsBody?.affectedByGravity = false
        goldfish.physicsBody?.allowsRotation = false
        goldfish.physicsBody?.restitution = 0
        goldfish.physicsBody?.categoryBitMask = ColliderType.COLLECTIBLES
        goldfish.physicsBody?.contactTestBitMask = ColliderType.MIKEY
        goldfish.physicsBody?.collisionBitMask = ColliderType.MIKEY
        goldfish.physicsBody?.isDynamic = true
        goldfish.physicsBody?.mass = 0
    }
    
    func spawnSeaCreature(animal: String, wMul: Double, hMul: Double) {
        let creatureTextureAtlas = SKTextureAtlas(named: animal)
        var creatureTextureArray = [SKTexture]()
        for i in 1...creatureTextureAtlas.textureNames.count {
            let name = "Bum" + animal + "\(i)"
            creatureTextureArray.append(SKTexture(imageNamed: name))
        }
        let creature = SKSpriteNode(imageNamed: creatureTextureAtlas.textureNames[0])
        creature.name = animal
        creature.size = CGSize(width: (self.scene!.size.width) * wMul, height: (self.scene!.size.width) * hMul)
        creature.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        creature.position.x = -2000
        creature.position.y = 2000
        creature.zPosition = 3
        worldNode.addChild(creature)
        creature.run(SKAction.repeatForever(SKAction.animate(with: creatureTextureArray, timePerFrame: 0.2)))
        let creatureTexture = SKTexture(imageNamed: "Bum" + animal)
        creature.physicsBody = SKPhysicsBody(texture: creatureTexture, size: CGSize(width: creature.size.width, height: creature.size.height))
        creature.physicsBody?.affectedByGravity = false
        creature.physicsBody?.allowsRotation = false
        creature.physicsBody?.restitution = 0
        creature.physicsBody?.categoryBitMask = ColliderType.BADDIES
        creature.physicsBody?.contactTestBitMask = ColliderType.MIKEY
        creature.physicsBody?.collisionBitMask = ColliderType.MIKEY
        creature.physicsBody?.isDynamic = false
        creature.physicsBody?.mass = 0
    }
    
    func placeBottomOcean() {
        let ocean = SKSpriteNode(imageNamed: "Ocean")
        ocean.name = "Ocean"
        ocean.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.width)! * 2.594706798131811)
        ocean.anchorPoint = CGPoint(x: 0, y: 1)
        ocean.position = CGPoint(x:0, y: 0)
        ocean.zPosition = 1
        worldNode.addChild(ocean)
    }
    
    func placeTopOcean() {
        let ocean = SKSpriteNode(imageNamed: "Ocean")
        ocean.name = "Ocean"
        ocean.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.width)! * 2.594706798131811)
        ocean.anchorPoint = CGPoint(x: 0, y: 1)
        ocean.position = CGPoint(x: 0, y: 0)
        ocean.zPosition = 5
        ocean.alpha = 0.4
        worldNode.addChild(ocean)
    }
    
    func  placeBackBlue() {
        let backBlue = SKSpriteNode(imageNamed: "BackBlue")
        backBlue.name = "BackBlue"
        backBlue.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.width)! * 2.594706798131811)
        backBlue.anchorPoint = CGPoint(x: 0, y: 1)
        backBlue.position = CGPoint(x: 0, y: 0)
        backBlue.zPosition = 3
        backBlue.alpha = 0.2
        worldNode.addChild(backBlue)
    }
    
    private func reverseGravity() {
        physicsWorld.gravity.dy *= -1
    }
    
    func placeTopStopper() {
        let topStopper = SKSpriteNode()
        topStopper.name = "TopStopper"
        topStopper.anchorPoint = CGPoint(x: 0, y: 1)
        topStopper.size = CGSize(width: (self.scene?.size.width)!, height: 10)
        topStopper.position = CGPoint(x: 0, y: -(self.scene?.size.height)! / 2)
        topStopper.alpha = 0
        topStopper.physicsBody = SKPhysicsBody(rectangleOf: topStopper.size)
        topStopper.physicsBody?.affectedByGravity = false
        topStopper.physicsBody?.restitution = 0
        topStopper.physicsBody?.isDynamic = false
        worldNode.addChild(topStopper)
    }
    
    func  placeBottomStopper() {
        let a = (-(self.scene?.size.width)! * 2.594706798131811)
        let b = ((self.scene?.size.height)! / 2)
        let c = CGFloat(Mikey.size.width / 2)
        let bottomStopper = SKSpriteNode()
        bottomStopper.name = "BottomStopper"
        bottomStopper.anchorPoint = CGPoint(x: 0, y: 0)
        bottomStopper.size = CGSize(width: (self.scene?.size.width)!, height: 10)
        bottomStopper.position = CGPoint(x: 0, y: a + b - c)
        bottomStopper.alpha = 0
        bottomStopper.physicsBody = SKPhysicsBody(rectangleOf: bottomStopper.size)
        bottomStopper.physicsBody?.affectedByGravity = false
        bottomStopper.physicsBody?.restitution = 0
        bottomStopper.physicsBody?.isDynamic = false
        worldNode.addChild(bottomStopper)
    }
    
    func createUnderwaterThing() {
        for i in 0...3 {
            let underwaterThing = SKSpriteNode(imageNamed: "UnderwaterThing1")
            underwaterThing.name = "UnderwaterThing"
            underwaterThing.size = CGSize(width: (self.scene?.size.width)! * 3.307732226258433, height: (self.scene?.size.width)! * 2.594706798131811)
            underwaterThing.anchorPoint = CGPoint(x: 0, y: 1)
            underwaterThing.position = CGPoint(x: underwaterThing.size.width * CGFloat(i), y: 0)
            underwaterThing.zPosition = 2
            underwaterThing.alpha = 0.93
            let shiftUnderwaterThing = SKAction.moveBy(x: -underwaterThing.size.width, y: 0, duration: 30)
            let replaceUnderwaterThing = SKAction.moveBy(x: underwaterThing.size.width, y: 0, duration: 0)
            let shiftAndReplaceUnderwaterThing = SKAction.repeatForever(SKAction.sequence([shiftUnderwaterThing, replaceUnderwaterThing]))
            worldNode.addChild(underwaterThing)
            underwaterThing.run(shiftAndReplaceUnderwaterThing)
        }
    }
    
    func createFrontMountains() {
        for i in 0...3 {
            frontMountains = SKSpriteNode(imageNamed: "FrontMountains")
            frontMountains.name = "FrontMountains"
            frontMountains.size = CGSize(width: (self.scene?.size.width)! * 1.427339901477833, height: (self.scene?.size.width)! * 0.655582922824302)
            frontMountains.anchorPoint = CGPoint(x: 0, y: 1)
            frontMountains.position = CGPoint(x: frontMountains.size.width * CGFloat(i), y: (Mikey.position.y * 0.91672695120971 + (self.scene?.size.width)! * 0.161945812807882))
            frontMountains.zPosition = 2
            frontMountains.alpha = 0.6
            let moveFrontMountainsWithMikey = SKAction.moveTo(y: (Mikey.position.y * 0.91672695120971 + (self.scene?.size.width)! * 0.161945812807882), duration: 0)
            let moveFrontMountainsContinually = SKAction.repeatForever(moveFrontMountainsWithMikey)
            let shiftFrontMountains = SKAction.moveBy(x: -frontMountains.size.width, y: 0, duration: 30)
            let replaceFrontMountains = SKAction.moveBy(x: frontMountains.size.width, y: 0, duration: 0)
            let shiftAndReplaceFrontMountains = SKAction.repeatForever(SKAction.sequence([shiftFrontMountains, replaceFrontMountains]))
            let shiftAndReplaceAndMoveFrontMountains = SKAction.group([shiftAndReplaceFrontMountains, moveFrontMountainsContinually])
            worldNode.addChild(frontMountains)
            frontMountains.run(shiftAndReplaceAndMoveFrontMountains)
        }
    }
    
    func placeGround() {
        for i in 0...3 {
            let ground = SKSpriteNode(imageNamed: "Ground")
            ground.name = "Ground"
            ground.anchorPoint = CGPoint(x: 0, y: 0)
            ground.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.width)! * 0.233523611831863)
            ground.position = CGPoint(x: ground.size.width * CGFloat(i), y: -(self.scene?.size.width)! * 2.594706798131811)
            ground.zPosition = 2.25
            let shiftGround = SKAction.moveBy(x: -ground.size.width, y: 0, duration: 6)
            let replaceGround = SKAction.moveBy(x: ground.size.width, y: 0, duration: 0)
            let shiftAndReplaceGround = SKAction.repeatForever(SKAction.sequence([shiftGround, replaceGround]))
            worldNode.addChild(ground)
            ground.run(shiftAndReplaceGround)
        }
    }
    
    func randomBetweenNumbers(firstNumber: CGFloat, secondNumber: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNumber - secondNumber) + min(firstNumber, secondNumber)
    }
    
    let increaseScore = SKAction.perform(#selector(Game.increaseScoreBy1), onTarget: Game.self)
    
    @objc func generateBadCreatures() -> SKSpriteNode {
        func createCreatureCopy(animal: SKSpriteNode, name: String, timeInt1: Int, timeInt2: Float) {
            let creatureCopy = animal.copy() as! SKSpriteNode
            creatureCopy.name = name
            creatureCopy.position.x = MikeyCamera.position.x + (self.scene?.size.width)! * 1.5
            creatureCopy.position.y = randomBetweenNumbers(firstNumber: -(self.scene?.size.width)! * 2.594706798131811 * 0.92, secondNumber: -(self.scene?.size.width)! * 2.594706798131811 * 0.05)
            worldNode.addChild(creatureCopy)
            let followPath = SKAction.moveBy(x: -10000, y: 0, duration: TimeInterval(timeInt1))
            creatureCopy.run(followPath)
            creatureCopy.run(SKAction.sequence([SKAction.wait(forDuration: TimeInterval(timeInt2)), SKAction.removeFromParent()]))
        }
        
        if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 65)) == 64 {
            createCreatureCopy(animal: Whale, name: "whaleCopy", timeInt1: 18, timeInt2: 16.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 10)) == 9 {
            createCreatureCopy(animal: SeaStar, name: "seaStarCopy", timeInt1: 11, timeInt2: 11.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 10)) == 9 {
            createCreatureCopy(animal: Piranha, name: "piranhaCopy", timeInt1: 9, timeInt2: 9.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 10)) == 9 {
            createCreatureCopy(animal: Swordfish, name: "swordfishCopy", timeInt1: 14, timeInt2: 13.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 12)) == 11 {
            createCreatureCopy(animal: GreatWhite, name: "greatWhiteCopy", timeInt1: 16, timeInt2: 15.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 50)) == 49 {
            createCreatureCopy(animal: Chicken, name: "chickenCopy", timeInt1: 12, timeInt2: 12.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 10)) == 9 {
            createCreatureCopy(animal: Turtle, name: "turtleCopy", timeInt1: 13, timeInt2: 11.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 10)) == 9 {
            createCreatureCopy(animal: Crab, name: "crabCopy", timeInt1: 12, timeInt2: 10.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 12)) == 11 {
            createCreatureCopy(animal: Squid, name: "squidCopy", timeInt1: 14, timeInt2: 10.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 10)) == 9 {
            createCreatureCopy(animal: Clam, name: "clamCopy", timeInt1: 11, timeInt2: 10.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 10)) == 9 {
            createCreatureCopy(animal: Jellyfish, name: "jellyfishCopy", timeInt1: 12, timeInt2: 10.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 10)) == 9 {
            createCreatureCopy(animal: Stingray, name: "stingrayCopy", timeInt1: 14, timeInt2: 10.0)
        } else if Int(randomBetweenNumbers(firstNumber: 0, secondNumber: 12)) == 11 {
            createCreatureCopy(animal: Eel, name: "eelCopy", timeInt1: 12, timeInt2: 10.0)
        }
        return SKSpriteNode()
    }
    
    @objc func generateGoldfish() {
        let goldfishCopy = goldfish.copy() as! SKSpriteNode
        goldfishCopy.name = "goldfishCopy"
        goldfishCopy.position.x = MikeyCamera.position.x + (self.scene?.size.width)! * 1.5
        goldfishCopy.position.y = randomBetweenNumbers(firstNumber: -(self.scene?.size.width)! * 2.594706798131811 * 0.92, secondNumber: -(self.scene?.size.width)! * 2.594706798131811 * 0.05)
        worldNode.addChild(goldfishCopy)
        let followGoldfishPath = SKAction.moveBy(x: -10000, y: 0, duration: 25)
        goldfishCopy.run(followGoldfishPath)
        goldfishCopy.run(SKAction.sequence([SKAction.wait(forDuration: 25.0), SKAction.removeFromParent()]))
    }
}
