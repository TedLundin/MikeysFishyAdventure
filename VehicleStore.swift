// 
// VehicleStore.swift
// Mikey's Fishy Adventure
//
// Created by Teddy Lundin on 9/10/18
// 

import Foundation
import SpriteKit
import UIKit

class VehicleStore: SKScene {
    
    var startX: CGFloat = 0.0
    var lastX: CGFloat = 0.0
    var moveableArea = SKNode()
    var back = SKSpriteNode()
    var Mikey = SKSpriteNode()
    var bike = SKSpriteNode()
    var car = SKSpriteNode()
    var train = SKSpriteNode()
    var submarine = SKSpriteNode()
    static var mikeyUnlocked = UserDefaults().bool(forKey: "MIKEYUNLOCKED")
    static var bikeUnlocked = UserDefaults().bool(forKey: "BIKEUNLOCKED")
    static var carUnlocked = UserDefaults().bool(forKey: "CARUNLOCKED")
    static var trainUnlocked = UserDefaults().bool(forKey: "TRAINUNLOCKED")
    static var submarineUnlocked = UserDefaults().bool(forKey: "SUBMARINEUNLOCKED")
    static var mikeySelected = UserDefaults().bool(forKey: "MIKEYSELECTED")
    static var bikeSelected = UserDefaults().bool(forKey: "BIKESELECTED")
    static var carSelected = UserDefaults().bool(forKey: "CARSELECTED")
    static var trainSelected = UserDefaults().bool(forKey: "TRAINSELECTED")
    static var submarineSelected = UserDefaults().bool(forKey: "SUBMARINESELECTED")
    var mikeyCheck = SKSpriteNode()
    var bikeCheck = SKSpriteNode()
    var carCheck = SKSpriteNode()
    var trainCheck = SKSpriteNode()
    var submarineCheck = SKSpriteNode()
    var bikeLock = SKSpriteNode()
    var carLock = SKSpriteNode()
    var trainLock = SKSpriteNode()
    var submarineLock = SKSpriteNode()
    var bikePurchase = SKSpriteNode()
    var bikeYessir = SKSpriteNode()
    var bikeNo = SKSpriteNode()
    var carPurchase = SKSpriteNode()
    var carYessir = SKSpriteNode()
    var carNo = SKSpriteNode()
    var trainPurchase = SKSpriteNode()
    var trainYessir = SKSpriteNode()
    var trainNo = SKSpriteNode()
    var submarinePurchase = SKSpriteNode()
    var submarineYessir = SKSpriteNode()
    var submarineNo = SKSpriteNode()
    let gameYellow = UIColor(red: 1.0, green: 240/255, blue: 0.0, alpha: 1.0)
    var bikePrice = SKLabelNode()
    var carPrice = SKLabelNode()
    var trainPrice = SKLabelNode()
    var submarinePrice = SKLabelNode()
    var notEnoughPescado = SKSpriteNode()
    var o = SKSpriteNode()
    var bikePlusTwo = SKLabelNode()
    var carPlusFive = SKLabelNode()
    var trainPlusTen = SKLabelNode()
    var submarinePlusFifteen = SKLabelNode()
    var mikeyButton = SKSpriteNode()
    var bikeButton = SKSpriteNode()
    var carButton = SKSpriteNode()
    var trainButton = SKSpriteNode()
    var submarineButton = SKSpriteNode()
    var bikeBuy = SKSpriteNode()
    var carBuy = SKSpriteNode()
    var trainBuy = SKSpriteNode()
    var submarineBuy = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0, y: 1)
        
        moveableArea.position = CGPoint(x: 0, y: 1)
        self.addChild(moveableArea)
        
        placeTopOcean()
        placeMainOcean()
        placeBack()
        placeBubble(mul: 0)
        placeBubble(mul: 1)
        placeBubble(mul: 2)
        placeBubble(mul: 3)
        placeBubble(mul: 4)
        placeMikey()
        placeBike()
        placeCar()
        placeTrain()
        placeSubmarine()
        placeMikeyCheck()
        placeBikeCheck()
        placeCarCheck()
        placeTrainCheck()
        placeSubmarineCheck()
        placePurchasingValidations()
        placeAddedLifeValues()
        placeButtons()
        
        if !(VehicleStore.bikeUnlocked) {
            placeBikeLock()
            createBikePrice()
            placeBikeBuy()
        }
        if !(VehicleStore.carUnlocked) {
            placeCarLock()
            createCarPrice()
            placeCarBuy()
        }
        if !(VehicleStore.trainUnlocked) {
            placeTrainLock()
            createTrainPrice()
            placeTrainBuy()
        }
        if !(VehicleStore.submarineUnlocked) {
            placeSubmarineLock()
            createSubmarinePrice()
            placeSubmarineBuy()
        }
        if VehicleStore.mikeySelected {
            selectMikey()
        } else if VehicleStore.bikeSelected {
            selectBike()
        } else if VehicleStore.carSelected {
            selectCar()
        } else if VehicleStore.trainSelected {
            selectTrain()
        } else if VehicleStore.submarineSelected {
            selectSubmarine()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            startX = location.x
            lastX = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let currentX = location.x
            let leftLimit:CGFloat = (self.scene?.size.width)! * 0.344827586206897 * 3
            let rightLimit:CGFloat = (self.scene?.size.width)! * 0.344827586206897 * 0.5
            let scrollSpeed:CGFloat = 1.0
            let newX = moveableArea.position.x + ((currentX - lastX) * scrollSpeed)
            if newX < -leftLimit {
                moveableArea.position = CGPoint(x: -leftLimit, y: moveableArea.position.y)
            } else if newX > rightLimit {
                moveableArea.position = CGPoint(x: rightLimit, y: moveableArea.position.y)
            } else {
                moveableArea.position = CGPoint(x: newX, y: moveableArea.position.y)
            }
            lastX = currentX
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if back.contains(location) {
                if let scene = MainMenu(fileNamed: "MainMenu") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene)
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if mikeyButton.contains(location) {
                if VehicleStore.mikeyUnlocked {
                    selectMikey()
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if bikeButton.contains(location) {
                if VehicleStore.bikeUnlocked {
                    selectBike()
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if carButton.contains(location) {
                if VehicleStore.carUnlocked {
                    selectCar()
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if trainButton.contains(location) {
                if VehicleStore.trainUnlocked {
                    selectTrain()
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if submarineButton.contains(location) {
                if VehicleStore.submarineUnlocked {
                    selectSubmarine()
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if bikeBuy.contains(location) {
                bikePurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: -(self.scene!.size.width) * 0.157224958949097)
                bikeYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: -(self.scene!.size.width) * 0.259031198686371)
                bikeNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: -(self.scene!.size.width) * 0.259852216748768) 
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if carBuy.contains(location) {
                carPurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: -(self.scene!.size.width) * 0.157224958949097)
                carYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: -(self.scene!.size.width) * 0.259031198686371)
                carNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: -(self.scene!.size.width) * 0.259852216748768) 
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if trainBuy.contains(location) {
                trainPurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: -(self.scene!.size.width) * 0.157224958949097)
                trainYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: -(self.scene!.size.width) * 0.259031198686371)
                trainNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: -(self.scene!.size.width) * 0.259852216748768) 
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: moveableArea)
            if submarineBuy.contains(location) {
                submarinePurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: -(self.scene!.size.width) * 0.157224958949097)
                submarineYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: -(self.scene!.size.width) * 0.259031198686371)
                submarineNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: -(self.scene!.size.width) * 0.259852216748768) 
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if bikeYessir.contains(location) {
                if MainMenu.totalGoldfishAmount >= 1000 {
                    MainMenu.totalGoldfishAmount -= 1000
                    bikeLock.removeFromParent()
                    VehicleStore.bikeUnlocked = true
                    bikePurchase.removeFromParent() 
                    bikeYessir.removeFromParent()
                    bikeNo.removeFromParent()
                    bikeBuy.removeFromParent()
                    bikePrice.removeFromParent()
                    VehicleStore.bikeUnlocked = true
                    UserDefaults.standard.setValue(VehicleStore.bikeUnlocked, forKey: "BIKEUNLOCKED")
                } else {
                    bikeYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
                    bikeNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
                    bikePurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
                    notEnoughPescado.position = CGPoint(x: (self.scene!.size.width) * 0.463054187192118, y: -(self.scene!.size.width) * 0.157224958949097)
                    o.position = CGPoint(x: (self.scene!.size.width) * 0.605911330049261, y: -(self.scene!.size.width) * 0.154761904761905)
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if carYessir.contains(location) {
                if MainMenu.totalGoldfishAmount >= 5000 {
                    MainMenu.totalGoldfishAmount -= 5000
                    carLock.removeFromParent()
                    VehicleStore.carUnlocked = true
                    carPurchase.removeFromParent() 
                    carYessir.removeFromParent()
                    carNo.removeFromParent()
                    carBuy.removeFromParent()
                    carPrice.removeFromParent()
                    VehicleStore.carUnlocked = true
                    UserDefaults.standard.setValue(VehicleStore.carUnlocked, forKey: "CARUNLOCKED")
                } else {
                    carYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
                    carNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
                    carPurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
                    notEnoughPescado.position = CGPoint(x: (self.scene!.size.width) * 0.463054187192118, y: -(self.scene!.size.width) * 0.157224958949097)
                    o.position = CGPoint(x: (self.scene!.size.width) * 0.605911330049261, y: -(self.scene!.size.width) * 0.154761904761905)
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if trainYessir.contains(location) {
                if MainMenu.totalGoldfishAmount >= 10000 {
                    MainMenu.totalGoldfishAmount -= 10000
                    trainLock.removeFromParent()
                    VehicleStore.trainUnlocked = true
                    trainPurchase.removeFromParent() 
                    trainYessir.removeFromParent()
                    trainNo.removeFromParent()
                    trainBuy.removeFromParent()
                    trainPrice.removeFromParent()
                    VehicleStore.trainUnlocked = true
                    UserDefaults.standard.setValue(VehicleStore.trainUnlocked, forKey: "TRAINUNLOCKED")
                } else {
                    trainYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
                    trainNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
                    trainPurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
                    notEnoughPescado.position = CGPoint(x: (self.scene!.size.width) * 0.463054187192118, y: -(self.scene!.size.width) * 0.157224958949097)
                    o.position = CGPoint(x: (self.scene!.size.width) * 0.605911330049261, y: -(self.scene!.size.width) * 0.154761904761905)
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if submarineYessir.contains(location) {
                if MainMenu.totalGoldfishAmount >= 25000 {
                    MainMenu.totalGoldfishAmount -= 25000
                    submarineLock.removeFromParent()
                    VehicleStore.submarineUnlocked = true
                    submarinePurchase.removeFromParent() 
                    submarineYessir.removeFromParent()
                    submarineNo.removeFromParent()
                    submarineBuy.removeFromParent()
                    submarinePrice.removeFromParent()
                    VehicleStore.submarineUnlocked = true
                    UserDefaults.standard.setValue(VehicleStore.submarineUnlocked, forKey: "SUBMARINEUNLOCKED")
                } else {
                    submarineYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
                    submarineNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
                    submarinePurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
                    notEnoughPescado.position = CGPoint(x: (self.scene!.size.width) * 0.463054187192118, y: -(self.scene!.size.width) * 0.157224958949097)
                    o.position = CGPoint(x: (self.scene!.size.width) * 0.605911330049261, y: -(self.scene!.size.width) * 0.154761904761905)
                }
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if bikeNo.contains(location) {
                bikeYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
                bikeNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
                bikePurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if carNo.contains(location) {
                carYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
                carNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
                carPurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if trainNo.contains(location) {
                trainYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
                trainNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
                trainPurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if submarineNo.contains(location) {
                submarineYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
                submarineNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
                submarinePurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
            }
        }
        for touch: AnyObject in touches {
            let location: CGPoint = touch.location(in: self)
            if o.contains(location) {
                notEnoughPescado.position = CGPoint(x: (self.scene!.size.width) * 0.463054187192118, y: -(self.scene!.size.width) * 5000)
                o.position = CGPoint(x: (self.scene!.size.width) * 0.605911330049261, y: -(self.scene!.size.width) * 5000)
            }
        }
    }
    
    func createBikePrice() {
        bikePrice.fontName = "Futura-MediumItalic"
        bikePrice.fontSize = 48
        bikePrice.fontColor = gameYellow
        bikePrice.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        bikePrice.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        bikePrice.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 2, У: -(self.scene!.size.width) * 0.139162561576355)
        bikePrice.zPosition = 7
        bikePrice.text = "1000"
        moveableArea.addChild(bikePrice)
    }
    
    func createCarPrice() {
        carPrice.fontName = "Futura-MediumItalic"
        carPrice.fontSize = 48
        carPrice.fontColor = gameYellow
        carPrice.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        carPrice.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        carPrice.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 3, У: -(self.scene!.size.width) * 0.139162561576355)
        carPrice.zPosition = 7
        carPrice.text = "5000"
        moveableArea.addChild(carPrice)
    }
    
    func createTrainPrice() {
        trainPrice.fontName = "Futura-MediumItalic"
        trainPrice.fontSize = 48
        trainPrice.fontColor = gameYellow
        trainPrice.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        trainPrice.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        trainPrice.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 4, У: -(self.scene!.size.width) * 0.139162561576355)
        trainPrice.zPosition = 7
        trainPrice.text = "10000"
        moveableArea.addChild(trainPrice)
    }
    
    func createSubmarinePrice() {
        submarinePrice.fontName = "Futura-MediumItalic"
        submarinePrice.fontSize = 48
        submarinePrice.fontColor = gameYellow
        submarinePrice.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        submarinePrice.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        submarinePrice.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897, y: -(self.scene!.size.width) * 0.139162561576355)
        submarinePrice.zPosition = 7
        submarinePrice.text = "25000"
        moveableArea.addChild(submarinePrice)
    }
    
    func placeAddedLifeValues() {
        bikePlusTwo.fontName = "Futura-MediumItalic"
        bikePlusTwo.fontSize = 48
        bikePlusTwo.fontColor = gameYellow
        bikePlusTwo.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        bikePlusTwo.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        bikePlusTwo.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + ((self.scene?.size.width)! * 0.344827586206897), y: -(self.scene!.size.width) * 0.338259441707718)
        bikePlusTwo.zPosition = 7
        bikePlusTwo.text = "+2"
        moveableArea.addChild(bikePlusTwo)
        
        carPlusFive.fontName = "Futura-MediumItalic"
        carPlusFive.fontSize = 48
        carPlusFive.fontColor = gameYellow
        carPlusFive.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        carPlusFive.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        carPlusFive.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + ((self.scene?.size.width)! * 0.344827586206897) * 2, y: -(self.scene!.size.width) * 0.338259441707718)
        carPlusFive.zPosition = 7
        carPlusFive.text = "+5"
        moveableArea.addChild(carPlusFive)
        
        trainPlusTen.fontName = "Futura-MediumItalic"
        trainPlusTen.fontSize = 48
        trainPlusTen.fontColor = gameYellow
        trainPlusTen.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        trainPlusTen.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        trainPlusTen.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + ((self.scene?.size.width)! * 0.344827586206897) * 3, y: -(self.scene!.size.width) * 0.338259441707718)
        trainPlusTen.zPosition = 7
        trainPlusTen.text = "+10"
        moveableArea.addChild(trainPlusTen)
        
        submarinePlusFifteen.fontName = "Futura-MediumItalic"
        submarinePlusFifteen.fontSize = 48
        submarinePlusFifteen.fontColor = gameYellow
        submarinePlusFifteen.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        submarinePlusFifteen.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        submarinePlusFifteen.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + ((self.scene?.size.width)! * 0.344827586206897) * 4, y: -(self.scene!.size.width) * 0.338259441707718)
        submarinePlusFifteen.zPosition = 7
        submarinePlusFifteen.text = "+15"
        moveableArea.addChild(submarinePlusFifteen)
    }
    
    func selectMikey() {
        VehicleStore.mikeySelected = true
        VehicleStore.bikeSelected = false
        VehicleStore.carSelected = false
        VehicleStore.trainSelected = false
        VehicleStore.submarineSelected = false
        mikeyCheck.zPosition = 7
        bikeCheck.zPosition = 0
        carCheck.zPosition = 0
        trainCheck.zPosition = 0
        submarineCheck.zPosition = 0
        UserDefaults.standard.setValue(VehicleStore.mikeySelected, forKey: "MIKEYSELECTED")
        UserDefaults.standard.setValue(VehicleStore.bikeSelected, forKey: "BIKESELECTED")
        UserDefaults.standard.setValue(VehicleStore.carSelected, forKey: "CARSELECTED")
        UserDefaults.standard.setValue(VehicleStore.trainSelected, forKey: "TRAINSELECTED")
        UserDefaults.standard.setValue(VehicleStore.submarineSelected, forKey: "SUBMARINESELECTED")
    }
    
    func selectBike() {
        VehicleStore.mikeySelected = false
        VehicleStore.bikeSelected = true
        VehicleStore.carSelected = false
        VehicleStore.trainSelected = false
        VehicleStore.submarineSelected = false
        mikeyCheck.zPosition = 0
        bikeCheck.zPosition = 7
        carCheck.zPosition = 0
        trainCheck.zPosition = 0
        submarineCheck.zPosition = 0
        UserDefaults.standard.setValue(VehicleStore.mikeySelected, forKey: "MIKEYSELECTED")
        UserDefaults.standard.setValue(VehicleStore.bikeSelected, forKey: "BIKESELECTED")
        UserDefaults.standard.setValue(VehicleStore.carSelected, forKey: "CARSELECTED")
        UserDefaults.standard.setValue(VehicleStore.trainSelected, forKey: "TRAINSELECTED")
        UserDefaults.standard.setValue(VehicleStore.submarineSelected, forKey: "SUBMARINESELECTED")
    }
    
    func selectCar() {
        VehicleStore.mikeySelected = false
        VehicleStore.bikeSelected = false
        VehicleStore.carSelected = true
        VehicleStore.trainSelected = false
        VehicleStore.submarineSelected = false
        mikeyCheck.zPosition = 0
        bikeCheck.zPosition = 0
        carCheck.zPosition = 7
        trainCheck.zPosition = 0
        submarineCheck.zPosition = 0
        UserDefaults.standard.setValue(VehicleStore.mikeySelected, forKey: "MIKEYSELECTED")
        UserDefaults.standard.setValue(VehicleStore.bikeSelected, forKey: "BIKESELECTED")
        UserDefaults.standard.setValue(VehicleStore.carSelected, forKey: "CARSELECTED")
        UserDefaults.standard.setValue(VehicleStore.trainSelected, forKey: "TRAINSELECTED")
        UserDefaults.standard.setValue(VehicleStore.submarineSelected, forKey: "SUBMARINESELECTED")
    }
    
    func selectTrain() {
        VehicleStore.mikeySelected = false
        VehicleStore.bikeSelected = false
        VehicleStore.carSelected = false
        VehicleStore.trainSelected = true
        VehicleStore.submarineSelected = false
        mikeyCheck.zPosition = 0
        bikeCheck.zPosition = 0
        carCheck.zPosition = 0
        trainCheck.zPosition = 7
        submarineCheck.zPosition = 0
        UserDefaults.standard.setValue(VehicleStore.mikeySelected, forKey: "MIKEYSELECTED")
        UserDefaults.standard.setValue(VehicleStore.bikeSelected, forKey: "BIKESELECTED")
        UserDefaults.standard.setValue(VehicleStore.carSelected, forKey: "CARSELECTED")
        UserDefaults.standard.setValue(VehicleStore.trainSelected, forKey: "TRAINSELECTED")
        UserDefaults.standard.setValue(VehicleStore.submarineSelected, forKey: "SUBMARINESELECTED")
    }
    
    func selectSubmarine() {
        VehicleStore.mikeySelected = false
        VehicleStore.bikeSelected = false
        VehicleStore.carSelected = false
        VehicleStore.trainSelected = false
        VehicleStore.submarineSelected = true
        mikeyCheck.zPosition = 0
        bikeCheck.zPosition = 0
        carCheck.zPosition = 0
        trainCheck.zPosition = 0
        submarineCheck.zPosition = 7
        UserDefaults.standard.setValue(VehicleStore.mikeySelected, forKey: "MIKEYSELECTED")
        UserDefaults.standard.setValue(VehicleStore.bikeSelected, forKey: "BIKESELECTED")
        UserDefaults.standard.setValue(VehicleStore.carSelected, forKey: "CARSELECTED")
        UserDefaults.standard.setValue(VehicleStore.trainSelected, forKey: "TRAINSELECTED")
        UserDefaults.standard.setValue(VehicleStore.submarineSelected, forKey: "SUBMARINESELECTED")
    }
    
    func placePurchasingValidations() {
        bikePurchase = SKSpriteNode(imageNamed: "PurchaseThisItem")
        bikePurchase.size = CGSize(width: (self.scene?.size.width)! * 0.225779967159278, height: (self.scene?.size.width)! * 0.14367816091954)
        bikePurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
        bikePurchase.zPosition = 9
        self.addChild(bikePurchase)
        bikeYessir = SKSpriteNode(imageNamed: "PurchaseThisItem")
        bikeYessir.size = CGSize(width: (self.scene?.size.width)! * 0.110837438423645, height: (self.scene?.size.width)! * 0.080049261083744)
        bikeYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
        bikeYessir.zPosition = 9
        self.addChild(bikeYessir)
        bikeNo = SKSpriteNode(imageNamed: "PurchaseThisItem")
        bikeNo.size = CGSize(width: (self.scene?.size.width)! * 0.110837438423645, height: (self.scene?.size.width)! * 0.080049261083744)
        bikeNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
        bikeNo.zPosition = 9
        self.addChild(bikeNo)
        
        carPurchase = SKSpriteNode(imageNamed: "PurchaseThisItem")
        carPurchase.size = CGSize(width: (self.scene?.size.width)! * 0.225779967159278, height: (self.scene?.size.width)! * 0.14367816091954)
        carPurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
        carPurchase.zPosition = 9
        self.addChild(carPurchase)
        carYessir = SKSpriteNode(imageNamed: "PurchaseThisItem")
        carYessir.size = CGSize(width: (self.scene?.size.width)! * 0.110837438423645, height: (self.scene?.size.width)! * 0.080049261083744)
        carYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
        carYessir.zPosition = 9
        self.addChild(carYessir)
        carNo = SKSpriteNode(imageNamed: "PurchaseThisItem")
        carNo.size = CGSize(width: (self.scene?.size.width)! * 0.110837438423645, height: (self.scene?.size.width)! * 0.080049261083744)
        carNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
        carNo.zPosition = 9
        self.addChild(carNo)
        
        trainPurchase = SKSpriteNode(imageNamed: "PurchaseThisItem")
        trainPurchase.size = CGSize(width: (self.scene?.size.width)! * 0.225779967159278, height: (self.scene?.size.width)! * 0.14367816091954)
        trainPurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
        trainPurchase.zPosition = 9
        self.addChild(trainPurchase)
        trainYessir = SKSpriteNode(imageNamed: "PurchaseThisItem")
        trainYessir.size = CGSize(width: (self.scene?.size.width)! * 0.110837438423645, height: (self.scene?.size.width)! * 0.080049261083744)
        trainYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
        trainYessir.zPosition = 9
        self.addChild(trainYessir)
        trainNo = SKSpriteNode(imageNamed: "PurchaseThisItem")
        trainNo.size = CGSize(width: (self.scene?.size.width)! * 0.110837438423645, height: (self.scene?.size.width)! * 0.080049261083744)
        trainNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
        trainNo.zPosition = 9
        self.addChild(trainNo)
        
        submarinePurchase = SKSpriteNode(imageNamed: "PurchaseThisItem")
        submarinePurchase.size = CGSize(width: (self.scene?.size.width)! * 0.225779967159278, height: (self.scene?.size.width)! * 0.14367816091954)
        submarinePurchase.position = CGPoint(x: (self.scene!.size.width) * 0.5, y: 5000)
        submarinePurchase.zPosition = 9
        self.addChild(submarinePurchase)
        submarineYessir = SKSpriteNode(imageNamed: "PurchaseThisItem")
        submarineYessir.size = CGSize(width: (self.scene?.size.width)! * 0.110837438423645, height: (self.scene?.size.width)! * 0.080049261083744)
        submarineYessir.position = CGPoint(x: (self.scene!.size.width) * 0.447454844006568, y: 5000)
        submarineYessir.zPosition = 9
        self.addChild(submarineYessir)
        submarineNo = SKSpriteNode(imageNamed: "PurchaseThisItem")
        submarineNo.size = CGSize(width: (self.scene?.size.width)! * 0.110837438423645, height: (self.scene?.size.width)! * 0.080049261083744)
        submarineNo.position = CGPoint(x: (self.scene!.size.width) * 0.551724137931034, y: 5000)
        submarineNo.zPosition = 9
        self.addChild(submarineNo)
        
        notEnoughPescado = SKSpriteNode(imageNamed: "NotEnoughPescado")
        notEnoughPescado.size = CGSize(width: (self.scene?.size.width)! * 0.225779967159278, height: (self.scene?.size.width)! * 0.14367816091954)
        notEnoughPescado.position = CGPoint(x: (self.scene!.size.width) * 0.463054187192118, y: 5000)
        notEnoughPescado.zPosition = 9
        self.addChild(notEnoughPescado)
        o = SKSpriteNode(imageNamed: "O")
        o.size = CGSize(width: (self.scene?.size.width)! * 0.07799671592775, height: (self.scene?.size.width)! * 0.133415435139573)
        o.position = CGPoint(x: (self.scene!.size.width) * 0.605911330049261, y: 5000)
        o.zPosition = 9
        self.addChild(o)
    }
    
    func placeBack() {
        back = SKSpriteNode(imageNamed: "Back")
        back.name = "Back"
        back.anchorPoint = CGPoint(x: 0, y: 1)
        back.size = CGSize(width: (self.scene?.size.width)! * 0.147783251231527, height: (self.scene?.size.width)! * 0.061576354679803)
        back.position = CGPoint(x: (self.scene!.size.width) * 0.016420361247947, y: -(self.scene!.size.width) * 0.016420361247947)
        back.zPosition = 4
        self.addChild(back)
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
        ocean.anchorPoint = CGPoint(x: 0, y: 1)
        ocean.position = CGPoint(x: 0, y: (self.scene?.size.height)!)
        ocean.zPosition = 6
        ocean.alpha = 0.2
        self.addChild(ocean)
    }
    
    func placeBubble(mul: Int) {
        let bubble = SKSpriteNode(imageNamed: "Bubble")
        bubble.name = "Bubble"
        bubble.size = CGSize(width: (self.scene?.size.width)! * 0.344827586206897, height: (self.scene?.size.width)! * 0.344827586206897)
        bubble.position = CGPoint(x: (self.scene?.size.width)! * 0.344827586206897 / 2 + (self.scene?.size.width)! * 0.344827586206897 * mul, y: -(self.scene!.size.height) / 2)
        bubble.alpha = 0.5
        bubble.zPosition = 5
        moveableArea.addChild(bubble)
    }
    
    func placeBikeLock() {
        bikeLock = SKSpriteNode(imageNamed: "Lock")
        bikeLock.name = "bikeLock"
        bikeLock.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.123152709359606)
        bikeLock.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897, y: -(self.scene!.size.height) / 2)
        bikeLock.alpha = 1
        bikeLock.zPosition = 7
        moveableArea.addChild(bikeLock)
    }
    
    func placeCarLock() {
        carLock = SKSpriteNode(imageNamed: "Lock")
        carLock.name = "carLock"
        carLock.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.123152709359606)
        carLock.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 2, y: -(self.scene!.size.height) / 2)
        carLock.alpha = 1
        carLock.zPosition = 7
        moveableArea.addChild(carLock)
    }
    
    func placeTrainLock() {
        trainLock = SKSpriteNode(imageNamed: "Lock")
        trainLock.name = "trainLock"
        trainLock.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.123152709359606)
        trainLock.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 3, y: -(self.scene!.size.height) / 2)
        trainLock.alpha = 1
        trainLock.zPosition = 7
        moveableArea.addChild(trainLock)
    }
    
    func placeSubmarineLock() {
        submarineLock = SKSpriteNode(imageNamed: "Lock")
        submarineLock.name = "submarineLock"
        submarineLock.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.123152709359606)
        submarineLock.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 4, y: -(self.scene!.size.height) / 2)
        submarineLock.alpha = 1
        submarineLock.zPosition = 7
        moveableArea.addChild(submarineLock)
    }
    
    func placeMikey() {
        Mikey = SKSpriteNode(imageNamed: "Mikey1")
        Mikey.name = "Mikey"
        Mikey.size = CGSize(width: (self.scene?.size.width)! * 0.205254515599343, height: (self.scene?.size.width)! * 0.205254515599343)
        Mikey.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2, y: -(self.scene!.size.height) / 2)
        Mikey.zPosition = 4
        moveableArea.addChild(Mikey)
    }
    
    func placeBike() {
        bike = SKSpriteNode(imageNamed: "Bike")
        bike.name = "Bike"
        bike.size = CGSize(width: (self.scene?.size.width)! * 0.205254515599343, height: (self.scene?.size.width)! * 0.205254515599343)
        bike.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2 + (self.scene?.size.width)! * 0.344827586206897, y: -(self.scene!.size.height) / 2)
        bike.zPosition = 4
        moveableArea.addChild(bike)
    }
    
    func placeCar() {
        car = SKSpriteNode(imageNamed: "Car")
        car.name = "Car"
        car.size = CGSize(width: (self.scene?.size.width)! * 0.205254515599343, height: (self.scene?.size.width)! * 0.205254515599343)
        car.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2 + (self.scene?.size.width)! * 0.344827586206897 * 2, y: -(self.scene!.size.height) / 2)
        car.zPosition = 4
        moveableArea.addChild(car)
    }
    
    func placeTrain() {
        train = SKSpriteNode(imageNamed: "Train")
        train.name = "Train"
        train.size = CGSize(width: (self.scene?.size.width)! * 0.205254515599343, height: (self.scene?.size.width)! * 0.205254515599343)
        train.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2 + (self.scene?.size.width)! * 0.344827586206897 * 3, y: -(self.scene!.size.height) / 2)
        train.zPosition = 4
        moveableArea.addChild(train)
    }
    
    func placeSubmarine() {
        submarine = SKSpriteNode(imageNamed: "Submarine")
        submarine.name = "Submarine"
        submarine.size = CGSize(width: (self.scene?.size.width)! * 0.205254515599343, height: (self.scene?.size.width)! * 0.205254515599343)
        submarine.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2 + (self.scene?.size.width)! * 0.344827586206897 * 4, y: -(self.scene!.size.height) / 2)
        submarine.zPosition = 4
        moveableArea.addChild(submarine)
    }
    
    func placeMikeyCheck() {
        mikeyCheck = SKSpriteNode(imageNamed: "Checkmark")
        mikeyCheck.name = "mikeyCheck"
        mikeyCheck.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.086206896551724)
        mikeyCheck.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2, y: -(self.scene!.size.height) / 2)
        mikeyCheck.zPosition = 0
        moveableArea.addChild(mikeyCheck)
    }
    
    func placeBikeCheck() {
        bikeCheck = SKSpriteNode(imageNamed: "Checkmark")
        bikeCheck.name = "bikeCheck"
        bikeCheck.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.086206896551724)
        bikeCheck.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2 + (self.scene?.size.width)! * 0.344827586206897, y: -(self.scene!.size.height) / 2)
        bikeCheck.zPosition = 0
        moveableArea.addChild(bikeCheck)
    }
    
    func placeCarCheck() {
        carCheck = SKSpriteNode(imageNamed: "Checkmark")
        carCheck.name = "carCheck"
        carCheck.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.086206896551724)
        carCheck.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2 + (self.scene?.size.width)! * 0.344827586206897 * 2, y: -(self.scene!.size.height) / 2)
        carCheck.zPosition = 0
        moveableArea.addChild(carCheck)
    }
    
    func placeTrainCheck() {
        trainCheck = SKSpriteNode(imageNamed: "Checkmark")
        trainCheck.name = "trainCheck"
        trainCheck.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.086206896551724)
        trainCheck.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2 + (self.scene?.size.width)! * 0.344827586206897 * 3, y: -(self.scene!.size.height) / 2)
        trainCheck.zPosition = 0
        moveableArea.addChild(trainCheck)
    }
    
    func placeSubmarineCheck() {
        submarineCheck = SKSpriteNode(imageNamed: "Checkmark")
        submarineCheck.name = "submarineCheck"
        submarineCheck.size = CGSize(width: (self.scene?.size.width)! * 0.123152709359606, height: (self.scene?.size.width)! * 0.086206896551724)
        submarineCheck.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2 + (self.scene?.size.width)! * 0.344827586206897 * 4, y: -(self.scene!.size.height) / 2)
        submarineCheck.zPosition = 0
        moveableArea.addChild(submarineCheck)
    }
    
    func placeButtons() {
        mikeyButton.size = CGSize(width: (self.scene!.size.width) * 0.184729064039409, height: (self.scene!.size.width) * 0.184729064039409)
        mikeyButton.position = CGPoint(x: ((self.scene?.size.width)! * 0.344827586206897) / 2, y: -(self.scene!.size.height) / 2)
        mikeyButton.alpha = 0.0
        mikeyButton.zPosition = 8
        self.addChild(mikeyButton)
        
        bikeButton.size = CGSize(width: (self.scene!.size.width) * 0.184729064039409, height: (self.scene!.size.width) * 0.184729064039409)
        bikeButton.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897, y: -(self.scene!.size.height) / 2)
        bikeButton.alpha = 0.0
        bikeButton.zPosition = 8
        self.addChild(bikeButton)

        carButton.size = CGSize(width: (self.scene!.size.width) * 0.184729064039409, height: (self.scene!.size.width) * 0.184729064039409)
        carButton.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 2, y: -(self.scene!.size.height) / 2)
        carButton.alpha = 0.0
        carButton.zPosition = 8
        self.addChild(carButton)
        
        trainButton.size = CGSize(width: (self.scene!.size.width) * 0.184729064039409, height: (self.scene!.size.width) * 0.184729064039409)
        trainButton.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 3, y: -(self.scene!.size.height) / 2)
        trainButton.alpha = 0.0
        trainButton.zPosition = 8
        self.addChild(trainButton)
        
        submarineButton.size = CGSize(width: (self.scene!.size.width) * 0.184729064039409, height: (self.scene!.size.width) * 0.184729064039409)
        submarineButton.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + (self.scene?.size.width)! * 0.344827586206897 * 4, y: -(self.scene!.size.height) / 2)
        submarineButton.alpha = 0.0
        submarineButton.zPosition = 8
        self.addChild(submarineButton)
    }
    
    func placeBikeBuy() {
        bikeBuy = SKSpriteNode(imageNamed: "Buy")
        bikeBuy.size = CGSize(width: (self.scene!.size.width) * 0.082101806239737, height: (self.scene!.size.width) * 0.049261083743842)
        bikeBuy.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + ((self.scene?.size.width)! * 0.344827586206897), y: -(self.scene!.size.width) * 0.410509031198686)
        bikeBuy.zPosition = 8
        moveableArea.addChild(bikeBuy)
    }
    
    func placeCarBuy() {
        carBuy = SKSpriteNode(imageNamed: "Buy")
        carBuy.size = CGSize(width: (self.scene!.size.width) * 0.082101806239737, height: (self.scene!.size.width) * 0.049261083743842)
        carBuy.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + ((self.scene?.size.width)! * 0.344827586206897) * 2, y: -(self.scene!.size.width) * 0.410509031198686)
        carBuy.zPosition = 8
        moveableArea.addChild(carBuy)
    }
    
    func placeTrainBuy() {
        trainBuy = SKSpriteNode(imageNamed: "Buy")
        trainBuy.size = CGSize(width: (self.scene!.size.width) * 0.082101806239737, height: (self.scene!.size.width) * 0.049261083743842)
        trainBuy.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + ((self.scene?.size.width)! * 0.344827586206897) * 3, y: -(self.scene!.size.width) * 0.410509031198686)
        trainBuy.zPosition = 8
        moveableArea.addChild(trainBuy)
    }
    
    func placeSubmarineBuy() {
        submarineBuy = SKSpriteNode(imageNamed: "Buy")
        submarineBuy.size = CGSize(width: (self.scene!.size.width) * 0.082101806239737, height: (self.scene!.size.width) * 0.049261083743842)
        submarineBuy.position = CGPoint(x: (((self.scene?.size.width)! * 0.344827586206897) / 2) + ((self.scene?.size.width)! * 0.344827586206897) * 4, y: -(self.scene!.size.width) * 0.410509031198686)
        submarineBuy.zPosition = 8
        moveableArea.addChild(submarineBuy)
    }
}
