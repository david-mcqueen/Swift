// Playground - noun: a place where people can play

import UIKit

enum Planet:Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

Planet.Earth.toRaw()
Planet.fromRaw(5) == Planet.Jupiter;
