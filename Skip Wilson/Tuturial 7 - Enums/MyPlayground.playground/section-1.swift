// Playground - noun: a place where people can play

import UIKit

enum SomeEnum {
    
}

enum CompassPoint {
    case North
    case South
    case East
    case West
}

CompassPoint.East

enum Matter {
    case Solid, Liquid, Gas
}

var directionToHead = CompassPoint.West;

var directionToHead2: CompassPoint;
directionToHead = .West;

var currentMatter = Matter.Liquid;

switch currentMatter {
case .Solid:
    println("It was solid");
case .Liquid:
    println("It was liquid");
case .Gas:
    println("It was gas");
}