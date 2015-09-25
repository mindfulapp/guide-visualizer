//
//  GameScene.swift
//  FlamePrototype
//
//  Created by Andrew Campoli on 8/27/15.
//  Copyright (c) 2015 Harmony. All rights reserved.
//

import SpriteKit

protocol GuideSceneDelegate: class {
    func addSavedExerciseViewController()
}

class GuideScene: SKScene, UIGestureRecognizerDelegate {
    
    var guideEmitterController: GuideEmitterController!
    var guideNode: SKEmitterNode!
    
    var guideSceneDelegate: GuideSceneDelegate!
    
    let birthrateI: CGFloat = 300.0
    let lifetimeI: CGFloat = 2.5, lifetimeRangeI: CGFloat = 0.0
    let positionRangeXI: CGFloat = 30.0, positionRangeYI: CGFloat = 30.0
    let angleStartI: CGFloat = 0.0, angleRangeI: CGFloat = 360.0
    let speedI: CGFloat = 100.0, speedRangeI: CGFloat = 10.0
    let accelerationXI: CGFloat = 0.0, accelerationYI: CGFloat = 0.0
    let alphaStartI: CGFloat = 0.8, alphaRangeI: CGFloat = 0.2, alphaSpeedI: CGFloat = 0.75
    let scaleStartI: CGFloat = 2.0, scaleRangeI: CGFloat = 2.0, scaleSpeedI: CGFloat = -1.0
    let rotationStartI: CGFloat = 0.0, rotationRangeI: CGFloat = 0.0, rotationSpeedI: CGFloat = 0.0
    let colorBlendFactorI: CGFloat = 1.0, colorBlendRangeI: CGFloat = 0.0, colorBlendSpeedI: CGFloat = 0.0
    var colorRampColorsI = [UIColor]()
    
    let appearDuration: CFTimeInterval = 2
    
    let elongateFactorI: CGFloat = 5.0
    var elongateFactor: CGFloat = 0.0
    
    let buttonNames = ["flare", "randomPoop", "particleShower", "pulse", "disappear", "shrinkDisapper", "growDisappear", "snapBack", "appear", "snapBackEaseOutPosition"]
    
    let buttonSize = CGSize(width: 75, height: 40.0)
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = UIColor.blackColor()
        
        let center = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        let path = NSBundle.mainBundle().pathForResource("Guide", ofType: "sks")
        
        guideNode = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as! SKEmitterNode
        guideNode.position = center
        guideNode.zPosition = 1
        guideNode.targetNode = self
        
        setupGuide()
        
        guideEmitterController = GuideEmitterController()
        guideEmitterController.guideEmitter = guideNode
        
        addChild(guideNode)
        
        elongateFactor = elongateFactorI
    }
    
    func pulse() {
        
        guideNode.particleSpeed = 100
        
        if CGFloat(Float(arc4random()) / Float(UINT32_MAX)) > 0.5
        {
            elongateHorizontal()
            performSelector("elongateVertical", withObject: self, afterDelay: 0.15)
        }else
        {
            elongateVertical()
            performSelector("elongateHorizontal", withObject: self, afterDelay: 0.15)
        }
        
        performSelector("snapBack", withObject: self, afterDelay: 0.3)
    }
    
    func growDisappear() {
        
        guideEmitterController.animateScale(scaleStartI / 2, bounciness: 1.0, speed: 20.0)
        
        performSelector("grow", withObject: self, afterDelay: 0.5)
        performSelector("disappear", withObject: self, afterDelay: 0.8)
    }
    
    func shrinkDisapper() {
        
        guideEmitterController.animateScale(scaleStartI / 2, bounciness: 1.0, speed: 20.0)
        particleShower()
        
        performSelector("disappear", withObject: self, afterDelay: 0.7)
    }
    
    func randomPoop() {
        
        let randomAngle = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * 360.0
        
        guideEmitterController.animateAngleRange(0.0, bounciness: 5.0, speed: 10.0)
        guideEmitterController.animateStartAngle(randomAngle, bounciness: 5.0, speed: 10.0)
        
        performSelector("snapBack", withObject: self, afterDelay: 0.75)
    }
    
    func flare() {
        
        guideEmitterController.animateBirthrate(birthrateI * 1.75, bounciness: 4.0, speed: 4.0)
        guideEmitterController.animateLifetime(lifetimeI * 3.0, bounciness: 0.0, speed: 20.0)
        guideEmitterController.animateWidth(positionRangeXI * 6.0, bounciness: 15.0, speed: 5.0)
        guideEmitterController.animateHeight(positionRangeXI * 6.0, bounciness: 15.0, speed: 5.0)
        
        performSelector("snapBack", withObject: self, afterDelay: 0.75)
    }
    
    func grow() {
        
        guideEmitterController.animateScaleEaseOut(7.5, time: 0.25)
        guideEmitterController.animateWidth((positionRangeXI * 5) * 0.56, bounciness: 10, speed: 20)
        guideEmitterController.animateHeight(positionRangeYI * 5, bounciness: 10, speed: 20)
        guideEmitterController.animateBirthrate(birthrateI / 20, bounciness: 10, speed: 10)
        guideEmitterController.animateLifetime(lifetimeI / 200, bounciness: 10, speed: 10)
        guideEmitterController.animateSpeed(25, bounciness: 10, speed: 10)
        
        let growColors = [colorRampColorsI[0], colorRampColorsI[2], colorRampColorsI[2], colorRampColorsI[2], colorRampColorsI[0]]
        
        animateColorRamp(growColors)
    }
    
    func disappear() {
        
        guideEmitterController.animateScale(scaleStartI, bounciness: 1, speed: 20)
        guideEmitterController.animateBirthrate(birthrateI, bounciness: 10, speed: 10)
        guideEmitterController.animateLifetime(lifetimeI, bounciness: 10, speed: 10)
        guideEmitterController.animateWidth(1000.0, bounciness: 10, speed: 20)
        guideEmitterController.animateHeight(1000.0, bounciness: 10, speed: 20)
    }
    
    func appear() {
        
        guideEmitterController.animateWidthEaseOut(positionRangeXI, duration: appearDuration)
        guideEmitterController.animateHeightEaseOut(positionRangeYI, duration: appearDuration)
    }
    
    func snapBackEaseOutPosition() {
        
        let positionDuration: CFTimeInterval = 1.5
        
        guideEmitterController.animateSpeed(speedI, bounciness: 20, speed: 4)
        guideEmitterController.animateBirthrate(birthrateI, bounciness: 20, speed: 4)
        guideEmitterController.animateWidthEaseOut(positionRangeXI, duration: positionDuration)
        guideEmitterController.animateHeightEaseOut(positionRangeYI, duration: positionDuration)
        guideEmitterController.animateLifetime(lifetimeI, bounciness: 20, speed: 4)
        guideEmitterController.animateAngleRange(angleRangeI, bounciness: 20, speed: 4)
        guideEmitterController.animateSpeedRange(speedRangeI, bounciness: 20, speed: 4)
        guideEmitterController.animateScale(scaleStartI, bounciness: 20, speed: 4)
        
        animateColorRamp(colorRampColorsI)
    }
    
    func snapBack() {
        
        guideEmitterController.animateSpeed(speedI, bounciness: 20, speed: 4)
        guideEmitterController.animateBirthrate(birthrateI, bounciness: 20, speed: 4)
        guideEmitterController.animateWidth(positionRangeXI, bounciness: 20, speed: 4)
        guideEmitterController.animateHeight(positionRangeYI, bounciness: 20, speed: 4)
        guideEmitterController.animateLifetime(lifetimeI, bounciness: 20, speed: 4)
        guideEmitterController.animateAngleRange(angleRangeI, bounciness: 20, speed: 4)
        guideEmitterController.animateSpeedRange(speedRangeI, bounciness: 20, speed: 4)
        guideEmitterController.animateScale(scaleStartI, bounciness: 20, speed: 4)
        
        animateColorRamp(colorRampColorsI)
    }
    
    func animateLastColorInColorRamp(color: UIColor) {
        
        var newColorRamp = colorRampColorsI
        newColorRamp.removeLast()
        newColorRamp.append(color)
        animateColorRamp(newColorRamp)
    }
    
    func animateColorRamp(colors: [UIColor!]) {
        
        if colors.count != 5
        {
            print("animateColorRamp requires exactly 5 colors.")
            return
        }
        
        var i = 0
        for color in colors
        {
            guideEmitterController.animateColorSequence(color, atIndex: i, bounciness: 10, speed: 0.1)
            i++
        }
    }
    
    func particleShower() {
        
        guideEmitterController.animateSpeedRange(500, bounciness: 5, speed: 1)
        guideEmitterController.animateLifetime(lifetimeI * 5, bounciness: 5, speed: 1)
        guideEmitterController.animateBirthrate(birthrateI * 3, bounciness: 5, speed: 1)
    }
    
    func incrementElongateFactor() {
        
        elongateFactor += 5.0
    }
    
    func elongateHorizontal() {
        
        let random = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * -elongateFactor
    
        guideEmitterController.animateWidth((positionRangeXI * random) + 50.0, bounciness: 20.0, speed: 5.0)
    }
    
    func elongateVertical() {
        
        let random = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * elongateFactor
        
        guideEmitterController.animateHeight((positionRangeYI * random) + 50.0, bounciness: 20.0, speed: 5.0)
    }

    func setupGuide() {
        
        //set guide options and modify particle position in range to prepare for appear call
        guideNode.particleBirthRate = birthrateI; guideNode.particleLifetime = lifetimeI; guideNode.particleLifetimeRange = lifetimeRangeI; guideNode.particlePositionRange = CGVector(dx: 1000.0, dy: 1000.0); guideNode.emissionAngle = angleStartI; guideNode.emissionAngleRange = angleRangeI; guideNode.particleSpeed = speedI; guideNode.particleSpeedRange = speedRangeI; guideNode.xAcceleration = accelerationXI; guideNode.yAcceleration = accelerationYI; guideNode.particleAlpha = alphaStartI; guideNode.particleAlphaRange = alphaRangeI; guideNode.particleAlphaSpeed = alphaSpeedI; guideNode.particleScale = scaleStartI; guideNode.particleScaleRange = scaleRangeI; guideNode.particleScaleSpeed = scaleSpeedI; guideNode.particleRotation = rotationStartI; guideNode.particleRotationRange = rotationRangeI; guideNode.particleRotationSpeed = rotationSpeedI; guideNode.particleColorBlendFactor = colorBlendFactorI; guideNode.particleColorBlendFactorRange = colorBlendRangeI; guideNode.particleColorBlendFactorSpeed = colorBlendSpeedI;
        
        getColorRampColors()
    }
    
    func getColorRampColors() {
        
        for i in 0 ... 4
        {
            if i == 0
            {
                colorRampColorsI.append(guideNode.particleColorSequence!.getKeyframeValueForIndex(i) as! UIColor)
            }
            if i == 1
            {
                colorRampColorsI.append(guideNode.particleColorSequence!.getKeyframeValueForIndex(i) as! UIColor)
            }
            if i == 2
            {
                colorRampColorsI.append(guideNode.particleColorSequence!.getKeyframeValueForIndex(i) as! UIColor)
            }
            if i == 3
            {
                colorRampColorsI.append(guideNode.particleColorSequence!.getKeyframeValueForIndex(i) as! UIColor)
            }
            if i == 4
            {
                colorRampColorsI.append(guideNode.particleColorSequence!.getKeyframeValueForIndex(i) as! UIColor)
            }
        }
    }
    
    func setupAnimationButtons(size: CGSize) {
        
        let spacer: CGFloat = 5
        
        var row: CGFloat = 1
        var colomn: CGFloat = 1
        for buttonName in buttonNames {
            
            let currentmakeAnimationButton = makeAnimationButton(buttonName)
            currentmakeAnimationButton.frame.size = size
            
            currentmakeAnimationButton.center.x = (size.width + spacer) * colomn
            currentmakeAnimationButton.center.y = (size.height + spacer) * row
            
            colomn++
            
            if (size.width + spacer) * colomn > view!.bounds.width {
                row++
                colomn = 1
            }
        }
    }
    
    func makeAnimationButton(selector: String) -> UIButton {
        
        let animationButton = UIButton()
        animationButton.setTitle(selector, forState: .Normal)
        animationButton.titleLabel!.font = UIFont.systemFontOfSize(8.0)
        animationButton.backgroundColor = SKColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        animationButton.addTarget(self, action: Selector(selector), forControlEvents: .TouchUpInside)
        
        view!.addSubview(animationButton)
        
        return animationButton
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
