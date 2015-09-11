//
//  GuideEmitterController.swift
//  GuidePrototype
//
//  Created by Andrew Campoli on 8/29/15.
//  Copyright © 2015 Harmony. All rights reserved.
//

import Foundation
import SpriteKit

class GuideEmitterController: NSObject {
    
    var guideEmitter: SKEmitterNode!
    
    func animateScaleLinear(toScale: CGFloat, time: CFTimeInterval) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideScaleLinear") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particleScale
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particleScale = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let scaleAnimation = POPBasicAnimation()
        scaleAnimation.property = property as! POPAnimatableProperty
        scaleAnimation.duration = time
        scaleAnimation.fromValue = guideEmitter.particleScale
        scaleAnimation.toValue = toScale
        guideEmitter.pop_addAnimation(scaleAnimation, forKey: "GuideScaleLinear")
    }

    func animateScaleEaseOut(toScale: CGFloat, time: CFTimeInterval) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideScaleLinear") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particleScale
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particleScale = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let scaleAnimation = POPBasicAnimation.easeOutAnimation()
        scaleAnimation.property = property as! POPAnimatableProperty
        scaleAnimation.duration = time
        scaleAnimation.fromValue = guideEmitter.particleScale
        scaleAnimation.toValue = toScale
        guideEmitter.pop_addAnimation(scaleAnimation, forKey: "GuideScaleLinear")
    }
    
    func animateSpeed(toSpeed: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideSpeed") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particleSpeed
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particleSpeed = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let scaleAnimation = POPSpringAnimation()
        scaleAnimation.property = property as! POPAnimatableProperty
        scaleAnimation.springBounciness = bounciness
        scaleAnimation.springSpeed = speed
        scaleAnimation.fromValue = guideEmitter.particleSpeed
        scaleAnimation.toValue = toSpeed
        guideEmitter.pop_addAnimation(scaleAnimation, forKey: "GuideSpeed")
    }
    
    func animateScale(toScale: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideScale") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particleScale
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particleScale = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let scaleAnimation = POPSpringAnimation()
        scaleAnimation.property = property as! POPAnimatableProperty
        scaleAnimation.springBounciness = bounciness
        scaleAnimation.springSpeed = speed
        scaleAnimation.fromValue = guideEmitter.particleScale
        scaleAnimation.toValue = toScale
        guideEmitter.pop_addAnimation(scaleAnimation, forKey: "GuideScale")
    }
    
    func animateColorSequenceEaseOut(toColor: UIColor, atIndex: Int, duration: CFTimeInterval) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideColorSequence\(atIndex)") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                
                let colorComponents = CGColorGetComponents((obj as! SKEmitterNode).particleColorSequence!.getKeyframeValueForIndex(atIndex).CGColor)
                
                values[0] = colorComponents[0]
                values[1] = colorComponents[1]
                values[2] = colorComponents[2]
                values[3] = colorComponents[3]
            }
            
            property.writeBlock = { (obj, values) -> Void in
                
                let newColorSequence = (obj as! SKEmitterNode).particleColorSequence!
                newColorSequence.setKeyframeValue(UIColor(red: values[0], green: values[1], blue: values[2], alpha: values[3]), forIndex: atIndex)
                
                (obj as! SKEmitterNode).particleColorSequence = newColorSequence
            }
            
            property.threshold = 0.5
        }
        
        let colorSequenceAnimation = POPBasicAnimation.easeOutAnimation()
        colorSequenceAnimation.property = property as! POPAnimatableProperty
        colorSequenceAnimation.fromValue = guideEmitter.particleColorSequence?.getKeyframeValueForIndex(atIndex)
        colorSequenceAnimation.toValue = toColor
        colorSequenceAnimation.duration = duration
        guideEmitter.pop_addAnimation(colorSequenceAnimation, forKey: "GuideColorSequence\(atIndex)")
    }
    
    func animateColorSequence(toColor: UIColor, atIndex: Int, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideColorSequence\(atIndex)") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                
            let colorComponents = CGColorGetComponents((obj as! SKEmitterNode).particleColorSequence!.getKeyframeValueForIndex(atIndex).CGColor)
            
            values[0] = colorComponents[0]
            values[1] = colorComponents[1]
            values[2] = colorComponents[2]
            values[3] = colorComponents[3]
        }
        
        property.writeBlock = { (obj, values) -> Void in
            
            let newColorSequence = (obj as! SKEmitterNode).particleColorSequence!
            newColorSequence.setKeyframeValue(UIColor(red: values[0], green: values[1], blue: values[2], alpha: values[3]), forIndex: atIndex)
            
            (obj as! SKEmitterNode).particleColorSequence = newColorSequence
        }
        
        property.threshold = 0.5
        }
        
        let colorSequenceAnimation = POPSpringAnimation()
        colorSequenceAnimation.property = property as! POPAnimatableProperty
        colorSequenceAnimation.springBounciness = bounciness
        colorSequenceAnimation.springSpeed = speed
        colorSequenceAnimation.fromValue = guideEmitter.particleColorSequence?.getKeyframeValueForIndex(atIndex)
        colorSequenceAnimation.toValue = toColor
        guideEmitter.pop_addAnimation(colorSequenceAnimation, forKey: "GuideColorSequence\(atIndex)")
    }
    
    func animateColor(toColor: SKColor, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideColor") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                
                let colorComponents = CGColorGetComponents((obj as! SKEmitterNode).particleColor.CGColor)
                
                values[0] = colorComponents[0]
                values[1] = colorComponents[1]
                values[2] = colorComponents[2]
                values[3] = colorComponents[3]
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particleColor = SKColor(red: values[0], green: values[1], blue: values[2], alpha: values[3])
            }
            
            property.threshold = 0.5
        }
        
        let colorAnimation = POPSpringAnimation()
        colorAnimation.property = property as! POPAnimatableProperty
        colorAnimation.springBounciness = bounciness
        colorAnimation.springSpeed = speed
        colorAnimation.fromValue = guideEmitter.particleColor
        colorAnimation.toValue = toColor
        guideEmitter.pop_addAnimation(colorAnimation, forKey: "GuideColor")
    }

    func animateBirthrate(toBirthrate: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideBirthrate") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particleBirthRate
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particleBirthRate = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let birthrateAnimation = POPSpringAnimation()
        birthrateAnimation.property = property as! POPAnimatableProperty
        birthrateAnimation.springBounciness = bounciness
        birthrateAnimation.springSpeed = speed
        birthrateAnimation.fromValue = guideEmitter.particleBirthRate
        birthrateAnimation.toValue = toBirthrate
        guideEmitter.pop_addAnimation(birthrateAnimation, forKey: "GuideWidth")
    }
    
    func animateWidthEaseOut(toWidth: CGFloat, duration: CFTimeInterval) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideParticleWidthEaseOut") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particlePositionRange.dx
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particlePositionRange.dx = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let widthAnimation = POPBasicAnimation.easeOutAnimation()
        widthAnimation.property = property as! POPAnimatableProperty
        widthAnimation.fromValue = guideEmitter.particlePositionRange.dx
        widthAnimation.toValue = toWidth
        widthAnimation.duration = duration
        guideEmitter.pop_addAnimation(widthAnimation, forKey: "GuideParticleWidthEaseOut")
    }
    
    func animateHeightEaseOut(toHeight: CGFloat, duration: CFTimeInterval) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideParticleHeightEaseOut") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particlePositionRange.dy
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particlePositionRange.dy = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let heightAnimation = POPBasicAnimation.easeOutAnimation()
        heightAnimation.property = property as! POPAnimatableProperty
        heightAnimation.fromValue = guideEmitter.particlePositionRange.dy
        heightAnimation.toValue = toHeight
        heightAnimation.duration = duration
        guideEmitter.pop_addAnimation(heightAnimation, forKey: "GuideParticleHeightEaseOut")
    }

    func animateWidth(toWidth: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideParticleWidth") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particlePositionRange.dx
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particlePositionRange.dx = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let widthAnimation = POPSpringAnimation()
        widthAnimation.property = property as! POPAnimatableProperty
        widthAnimation.springBounciness = bounciness
        widthAnimation.springSpeed = speed
        widthAnimation.fromValue = guideEmitter.particlePositionRange.dx
        widthAnimation.toValue = toWidth
        guideEmitter.pop_addAnimation(widthAnimation, forKey: "GuideParticleWidth")
    }
    
    func animateHeight(toHeight: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideParticleHeight") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particlePositionRange.dy
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particlePositionRange.dy = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let heightAnimation = POPSpringAnimation()
        heightAnimation.property = property as! POPAnimatableProperty
        heightAnimation.springBounciness = bounciness
        heightAnimation.springSpeed = speed
        heightAnimation.fromValue = guideEmitter.particlePositionRange.dy
        heightAnimation.toValue = toHeight
        guideEmitter.pop_addAnimation(heightAnimation, forKey: "GuideParticleHeight")
    }
    
    func animateLifetime(toLifetime: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideLifetime") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particleLifetime
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particleLifetime = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let lifetimeAnimation = POPSpringAnimation()
        lifetimeAnimation.property = property as! POPAnimatableProperty
        lifetimeAnimation.springBounciness = bounciness
        lifetimeAnimation.springSpeed = speed
        lifetimeAnimation.fromValue = guideEmitter.particleLifetime
        lifetimeAnimation.toValue = toLifetime
        guideEmitter.pop_addAnimation(lifetimeAnimation, forKey: "GuideLifetime")
    }
    
    func animateSpeedRange(toSpeedRange: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideSpeedRange") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).particleSpeedRange
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).particleSpeedRange = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let speedRangeAnimation = POPSpringAnimation()
        speedRangeAnimation.property = property as! POPAnimatableProperty
        speedRangeAnimation.springBounciness = bounciness
        speedRangeAnimation.springSpeed = speed
        speedRangeAnimation.fromValue = guideEmitter.particleSpeedRange
        speedRangeAnimation.toValue = toSpeedRange
        guideEmitter.pop_addAnimation(speedRangeAnimation, forKey: "GuideSpeedRange")
    }
    
    func animateStartAngle(toStartAngle: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideStartAngle") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).emissionAngle
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).emissionAngle = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let startAngleAnimation = POPSpringAnimation()
        startAngleAnimation.property = property as! POPAnimatableProperty
        startAngleAnimation.springBounciness = bounciness
        startAngleAnimation.springSpeed = speed
        startAngleAnimation.fromValue = guideEmitter.emissionAngle
        startAngleAnimation.toValue = toStartAngle
        guideEmitter.pop_addAnimation(startAngleAnimation, forKey: "GuideStartAngle")
    }
        
    func animateAngleRange(toAngleRange: CGFloat, bounciness: CGFloat, speed: CGFloat) {
        
        let property = POPAnimatableProperty.propertyWithName("co.Harmonoy.GuideAngleRange") { (property) -> Void in
            property.readBlock = { (obj, values) -> Void in
                values[0] = (obj as! SKEmitterNode).emissionAngleRange
            }
            
            property.writeBlock = { (obj, values) -> Void in
                (obj as! SKEmitterNode).emissionAngleRange = values[0]
            }
            
            property.threshold = 0.5
        }
        
        let angleRangeAnimation = POPSpringAnimation()
        angleRangeAnimation.property = property as! POPAnimatableProperty
        angleRangeAnimation.springBounciness = bounciness
        angleRangeAnimation.springSpeed = speed
        angleRangeAnimation.fromValue = guideEmitter.emissionAngleRange
        angleRangeAnimation.toValue = toAngleRange
        guideEmitter.pop_addAnimation(angleRangeAnimation, forKey: "GuideAngleRange")
    }
}