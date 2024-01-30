// 
// MainMenu.swift
// Mikey's Fishy Adventure
//
// Created by Teddy Lundin on 7/11/18
// 

import Foundation
import SpriteKit
import UIKit

class MainMenu: SKScene {
    
    let MainCamera = SKCameraNode()
    let playButton = SKSpriteNode()
    let gameYellow = UIColor(red: 1.0, green: 240/255, blue: 0.0, alpha: 1.0)
    static var highscore = UserDefaults().integer(forKey: "HIGHSCORE")
    static var totalGoldfishAmount = UserDefaults().integer(forKey: "GOLDFISHAMOUNT")
    let goldfishAmount = SKLabelNode()
    let highscoreLabel = SKLabelNode()
    let vehicleStoreButton = SKSpriteNode()
    let fishStoreButton = SKSpriteNode()
    var mikey = SKSpriteNode()
    var bike = SKSpriteNode()
    var car = SKSpriteNode()
    var train = SKSpriteNode()
    var submarine = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        placeMainOcean()
        placeBubble(widthMul: 0.788177339901478, heightMul: 0.344827586206897, zRot: 0.235, xMul: 0.408456486042693, yMul: 0.476444444444444)
        placeBubble(widthMul: 0.147783251231527, heightMul: 0.147783251231527, zRot: 0, xMul: 0.672413793103448, yMul: 0.8)
        placeBubble(widthMul: 0.246305418719212, heightMul: 0.246305418719212, zRot: 0, xMul: 0.845648604269294, yMul: 0.6)
        placeBubble(widthMul: 0.147783251231527, heightMul: 0.147783251231527, zRot: 0, xMul: 0.096059113300493, yMul: 0.209777777777778)
        placeBubble(widthMul: 0.147783251231527, heightMul: 0.147783251231527, zRot: 0, xMul: 0.905993431855501, yMul: 0.209777777777778)
        placeBubble(widthMul: 0.098522167487685, heightMul: 0.098522167487685, zRot: 0, xMul: 0.782840722495895, yMul: 0.226666666666667)
        placeBubble(widthMul: 0.098522167487685, heightMul: 0.098522167487685, zRot: 0, xMul: 0.213464696223317, yMul: 0.156444444444444)
        placeBubble(widthMul: 0.098522167487685, heightMul: 0.098522167487685, zRot: 0, xMul: 0.930623973727422, yMul: 0.893333333333333)
        placeBubble(widthMul: 0.098522167487685, heightMul: 0.098522167487685, zRot: 0, xMul: 0.549261083743842, yMul: 0.853333333333333)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.967569786535304, yMul: 0.752888888888889)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.856732348111658, yMul: 0.893333333333333)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.950328407224959, yMul: 0.402666666666667)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.822660098522167, yMul: 0.085333333333333)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.763136288998358, yMul: 0.844444444444444)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.721674876847291, yMul: 0.140444444444444)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.475369458128079, yMul: 0.844444444444444)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.43431855500821, yMul: 0.919111111111111)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.066502463054187, yMul: 0.423111111111111)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.032019704433498, yMul: 0.062222222222222)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.155993431855501, yMul: 0.053333333333333)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.28735632183908, yMul: 0.147555555555556)
        placeBubble(widthMul: 0.049261083743842, heightMul: 0.049261083743842, zRot: 0, xMul: 0.106732348111658, yMul: 0.844444444444444)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.141215106732348, yMul: 0.845333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.08128078817734, yMul: 0.784888888888889)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.032019704433498, yMul: 0.348444444444444)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.399835796387521, yMul: 0.861333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.475369458128079, yMul: 0.925333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.676518883415435, yMul: 0.618666666666667)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.588669950738916, yMul: 0.765333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.728653530377668, yMul: 0.925333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.797619047619048, yMul: 0.861333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.970032840722496, yMul: 0.678222222222222)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.072249589490969, yMul: 0.045333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.340311986863711, yMul: 0.141333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.019704433497537, yMul: 0.032)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.019704433497537, yMul: 0.128)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.777914614121511, yMul: 0.085333333333333)
        placeBubble(widthMul: 0.019704433497537, heightMul: 0.019704433497537, zRot: 0, xMul: 0.958949096880131, yMul: 0.072888888888889)
        placeMikeysFishyAdventure()
        placeMikey()
        placePlay()
        spawnGoldfish()
        spawnHighscoreString()
        spawnHighscore()
        spawnGoldfishAmount()
        createVehicleStoreButton()
        placeBike()
        placeCar()
        placeTrain()
        placeSubmarine()
        createFishStoreButton()
        
        MainCamera.position = CGPoint(x: (scene?.size.width)! / 2, y: -(scene?.size.height)! / 2)
        self.addChild(MainCamera)
        self.camera = MainCamera
        
        playButton.size = CGSize(width: (self.scene?.size.width)! * 0.086206896551724, height: (self.scene?.size.width)! * 0.086206896551724)
        playButton.position = CGPoint(x: (self.scene!.size.width) * 0.685550082101806, y: -(self.scene!.size.height) * 0.8)
        playButton.alpha = 0.0
        playButton.zPosition = 6
        self.addChild(playButton)
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateHighscore()
        updateGoldfishAmount()
        if VehicleStore.mikeySelected {
            displayMikey()
        }
        if VehicleStore.bikeSelected {
            displayBike()
        }
        if VehicleStore.carSelected {
            displayCar()
        }
        if VehicleStore.trainSelected {
            displayTrain()
        }
        if VehicleStore.submarineSelected {
            displaySubmarine()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if playButton.contains(location) {
                if let scene = Game(fileNamed: "Game") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene)
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if vehicleStoreButton.contains(location) {
                if let scene = VehicleStore(fileNamed: "VehicleStore") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene)
                }
            }
        }
    }
    
    func updateHighscore() {
        if Game.score > UserDefaults().integer(forKey: "HIGHSCORE") {
            UserDefaults.standard.setValue(Game.score, forKey: "HIGHSCORE")
            highscoreLabel.text = String(UserDefaults().integer(forKey: "HIGHSCORE"))
        }
    }
    
    func updateGoldfishAmount() {
        UserDefaults.standard.setValue(MainMenu.totalGoldfishAmount, forKey: "GOLDFISHAMOUNT")
        goldfishAmount.text = String(UserDefaults().integer(forKey: "GOLDFISHAMOUNT"))
    }
    
    func createVehicleStoreButton() {
        vehicleStoreButton.size = CGSize(width: (self.scene?.size.width)! * 0.145730706075534, height: (self.scene?.size.width)! * 0.145730706075534)
        vehicleStoreButton.position = CGPoint(x: (self.scene!.size.width) * 0.845648604269294, y: -(self.scene!.size.height) * 0.6)
        vehicleStoreButton.alpha = 0.0
        vehicleStoreButton.zPosition = 6
        self.addChild(vehicleStoreButton)
    }
        
    func createFishStoreButton() {
        fishStoreButton.size = CGSize(width: (self.scene?.size.width)! * 0.049261083743842, height: (self.scene?.size.width)! * 0.049261083743842)
        fishStoreButton.position = CGPoint(x: (self.scene!.size.width) * 0.475369458128079, y: -(self.scene!.size.height) * 0.844444444444444)
        fishStoreButton.alpha = 0.0
        fishStoreButton.zPosition = 6
        self.addChild(fishStoreButton)
    }
    
    func displayMikey() {
        mikey.zPosition = 4
        bike.zPosition = -2
        car.zPosition = -2
        train.zPosition = -2
        submarine.zPosition = -2
    }
    
    func displayBike() {
        mikey.zPosition = -2
        bike.zPosition = 4
        car.zPosition = -2
        train.zPosition = -2
        submarine.zPosition = -2
    }
    
    func displayCar() {
        mikey.zPosition = -2
        bike.zPosition = -2
        car.zPosition = 4
        train.zPosition = -2
        submarine.zPosition = -2
    }
    
    func displayTrain() {
        mikey.zPosition = -2
        bike.zPosition = -2
        car.zPosition = -2
        train.zPosition = 4
        submarine.zPosition = -2
    }
    
    func displaySubmarine() {
        mikey.zPosition = -2
        bike.zPosition = -2
        car.zPosition = -2
        train.zPosition = -2
        submarine.zPosition = 4
    }
    
    func spawnHighscoreString() {
        let highscoreString = SKLabelNode()
        highscoreString.fontName = "Futura-MediumItalic"
        highscoreString.fontSize = 48
        highscoreString.fontColor = gameYellow
        highscoreString.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        highscoreString.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        highscoreString.position = CGPoint(x: (self.scene!.size.width) * 0.905993431855501, y: -(self.scene!.size.height) * 0.16)
        highscoreString.zPosition = 4
        highscoreString.text = "Highscore:"
        self.addChild(highscoreString)
    }
    
    func spawnHighscore() {
        highscoreLabel.fontName = "Futura-MediumItalic"
        highscoreLabel.fontSize = 36
        highscoreLabel.fontColor = gameYellow
        highscoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        highscoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
        highscoreLabel.position = CGPoint(x: (self.scene!.size.width) * 0.905993431855501, y: -(self.scene!.size.height) * 0.209777777777778)
        highscoreLabel.zPosition = 4
        highscoreLabel.text = String (UserDefaults().integer(forKey: "HIGHSCORE"))
        self.addChild(highscoreLabel)
    }
    
    func spawnGoldfishAmount() {
        goldfishAmount.fontName = "Futura-MediumItalic"
        goldfishAmount.fontSize = 29
        goldfishAmount.fontColor = gameYellow
        goldfishAmount.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        goldfishAmount.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        goldfishAmount.position = CGPoint(x: (self.scene!.size.width) * 0.549261083743842, y: -(self.scene!.size.height) * 0.853333333333333)
        goldfishAmount.zPosition = 4
        goldfishAmount.text = String(UserDefaults().integer(forKey: "GOLDFISHAMOUNT"))
        self.addChild(goldfishAmount)
    }
    
    func placeMainOcean() {
        let ocean = SKSpriteNode(imageNamed: "Ocean")
        ocean.name = "Ocean"
        ocean.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.width)! * 2.594706798131811)
        ocean.anchorPoint = CGPoint(x: 0, y: 1)
        ocean.position = CGPoint(x: 0, y: (self.scene?.size.height)!)
        ocean.zPosition = 2
        self.addChild(ocean)
    }
    
    func placeTopOcean() {
        let ocean = SKSpriteNode(imageNamed: "Ocean")
        ocean.name = "Ocean"
        ocean.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.width)! * 2.594706798131811)
        ocean.anchorPoint = CGPoint (x: 0, y: 1)
        ocean.position = CGPoint(x: 0, y: (self.scene?.size.height)!)
        ocean.zPosition = 6
        ocean.alpha = 0.4
        self.addChild(ocean)
    }
    
    func spawnGoldfish() {
        var goldfish = SKSpriteNode()
        goldfish = SKSpriteNode(imageNamed: "BumGoldfish")
        goldfish.name = "Goldfish"
        goldfish.size = CGSize(width: (self.scene?.size.width)! * 0.041050903119869, height: (self.scene?.size.width)! * 0.032840722495895)
        goldfish.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        goldfish.position = CGPoint(x: (self.scene!.size.width) * 0.475369458128079, y: -(self.scene!.size.height) * 0.844444444444444)
        goldfish.zPosition = 4
        self.addChild(goldfish)
    }
    
    func placeBubble(widthMul: Double, heightMul: Double, zRot: Double, xMul: Double, yMul: Double) {
        let bubble = SKSpriteNode(imageNamed: "Bubble")
        bubble.name = "Bubble"
        bubble.size = CGSize(width: (self.scene?.size.width)! * widthMul, height: (self.scene?.size.width)! * heightMul)
        bubble.zRotation = zRot
        bubble.position = CGPoint(x: (self.scene?.size.width)! * xMul, y: -(self.scene?.size.height)! * yMul)
        bubble.alpha = 0.5
        bubble.zPosition = 5
        self.addChild(bubble)
    }
    
    func placeMikeysFishyAdventure() {
        let mikeysFishyAdventure = SKSpriteNode(imageNamed: "MikeysFishyAdventure")
        mikeysFishyAdventure.name = "MikeysFishyAdventure"
        mikeysFishyAdventure.size = CGSize(width: (self.scene?.size.width)! * 0.574712643678161, height: (self.scene?.size.width)! * 0.160919540229885)
        mikeysFishyAdventure.zRotation = 0.235
        mikeysFishyAdventure.position = CGPoint(x: (self.scene!.size.width) * 0.408456486042693, y: -(self.scene!.size.height) * 0.476444444444444)
        mikeysFishyAdventure.zPosition = 4
        self.addChild(mikeysFishyAdventure)
    }
    
    func placePlay() {
        let play = SKSpriteNode(imageNamed: "Play")
        play.name = "Play"
        play.size = CGSize(width: (self.scene?.size.width)! * 0.106732348111658, height: (self.scene?.size.width)! * 0.048029556650246)
        play.position = CGPoint(x: (self.scene!.size.width) * 0.672413793103448, y: -(self.scene!.size.height) * 0.672413793103448)
        play.zPosition = 4
        self.addChild(play)
    }
    
    func placeMikey() {
        mikey = SKSpriteNode(imageNamed: "Mikey22")
        mikey.name = "Mikey"
        mikey.size = CGSize (width: (self.scene?.size.width)! * 0.160098522167488, height: (self.scene?.size.width)! * 0.160098522167488)
        mikey.position = CGPoint(x: (self.scene!.size.width) * 0.845648604269294, y: -(self.scene!.size.height) * 0.6)
        mikey.zPosition = 4
        self.addChild(mikey)
    }
    
    func placeBike() {
        bike = SKSpriteNode(imageNamed: "Bike")
        bike.name = "bike"
        bike.size = CGSize(width: (self.scene?.size.width)! * 0.184729064039409, height: (self.scene?.size.width)! * 0.184127004057407)
        bike.position = CGPoint(x: (self.scene!.size.width) * 0.845648604269294, y: -(self.scene!.size.height) * 0.6)
        bike.zPosition = -2
        self.addChild(bike)
    }
    
    func placeCar() {
        car = SKSpriteNode(imageNamed: "Car")
        car.name = "car"
        car.size = CGSize(width: (self.scene?.size.width)! * 0.199507389162562, height: (self.scene?.size.width)! * 0.110837438423645)
        car.position = CGPoint(x: (self.scene!.size.width) * 0.845648604269294, y: -(self.scene!.size.height) * 0.6)
        car.zPosition = -2
        self.addChild(car)
    }
    
    func placeTrain() {
        train = SKSpriteNode(imageNamed: "Train")
        train.name = "train"
        train.size = CGSize(width: (self.scene?.size.width)! * 0.20935960591133, height: (self.scene?.size.width)! * 0.147783251231527)
        train.position = CGPoint(x: (self.scene!.size.width) * 0.845648604269294, y: -(self.scene!.size.height) * 0.6)
        train.zPosition = -2
        self.addChild(train)
    }
    
    func placeSubmarine() {
        submarine = SKSpriteNode(imageNamed: "Submarine")
        submarine.name = "submarine"
        submarine.size = CGSize(width: (self.scene?.size.width)! * 0.20935960591133, height: (self.scene?.size.width)! * 0.123152709359606)
        submarine.position = CGPoint(x: (self.scene!.size.width) * 0.845648604269294, y: -(self.scene!.size.height) * 0.6)
        submarine.zPosition = -2
        self.addChild(submarine)
    }
}
