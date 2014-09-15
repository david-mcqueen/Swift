// Playground - noun: a place where people can play

import UIKit

let aBunchOfInts = [1,2,3,4,5,6,7,8,9,10];
func reverseSorterFunction(numberOne:Int, numberTwo:Int -> Bool){
    if numberOne < numberTwo {
        return false;
    }
    return true
}

sorted(aBunchOfInts, reverseSorterFunction);

let forwardSortClosure