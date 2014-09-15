// Playground - noun: a place where people can play

import UIKit

enum Computer {
    //Ram, Processor
    case Desktop(Int, String)
    
    //Screen Size
    case Laptop(Int)
    
    //weight, height and width
    case Phone(Int, Int, Int)
    
    
    case Tablet
}

var computer = Computer.Desktop(8, "i7");

switch computer {
case .Desktop(let ram, let processor):
    println("Was a dekstop with \(ram)gb of RAM and a \(processor) processor");
    
default:println("No idea");
}