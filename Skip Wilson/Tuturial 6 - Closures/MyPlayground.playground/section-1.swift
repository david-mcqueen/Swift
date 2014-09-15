// Playground - noun: a place where people can play

import UIKit

func sayHello() {
    println("Hello from the function");
}

sayHello();

var sayHelloClosure: () -> () = {
    println("Hello from the closure");
}

sayHelloClosure();

sayHelloClosure = sayHello;

sayHelloClosure();

func introToFriends(friendOne:String, friendTwo:String) -> String {
    return "\(friendOne) I'd like you to meet my other friend \(friendTwo)";
    
}

var intro = introToFriends("Jim", "Pam");
intro;

//{
//    () -> return type in
//    statements
//}

var combine: (String, String) -> String;

//combine = {
//    a, b -> String in
//    return a + b
//}

//combine = {
//    a,b -> String in a + b
//}

//combine = {
//    $0 + $1
//}

//combine("Hello,", " World");

let hasPrefixAndSuffix: (String, String, String) -> Bool = {
    var hasPrefix = $0.hasPrefix($1);
    var hasSuffix = $0.hasSuffix($2);
    return hasPrefix && hasSuffix;
}

hasPrefixAndSuffix("Jim - Bob", "Jim", "Bob");

