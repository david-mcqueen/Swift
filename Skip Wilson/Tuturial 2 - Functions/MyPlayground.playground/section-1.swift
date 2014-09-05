/*
    https://www.youtube.com/watch?v=ioR12RPBY0k
*/

import UIKit;

func sayHello(){
    println("Hello");
}

func sayHelloTo(#name:String) -> String{
    println("Hello \(name)");
    return ("Well, hello to you too");
}

sayHello();
println(sayHelloTo(name: "Jack"));


func sumAndCeiling(a: Int, b:Int) -> (Int, Int) {
    var ceiling = a > b ? a : b;
    var sum = (a + b);
    return (sum, ceiling);
}

var total = sumAndCeiling(14, 52);

total.0;
total.1;


func sumAndFloor(a: Int, b:Int) -> (sum:Int, floor:Int) {
    var floor = a < b ? a : b;
    var sum = (a + b);
    return (sum, floor);
}

var totalFloor = sumAndFloor(17, 18);

totalFloor.sum;
totalFloor.floor;


// Passing a function into another function

func double(number:Int) -> Int {
    return number * 2;
}

func triple(number:Int) -> Int {
    return number * 3;
}

func modifyInt(#number:Int, #modifier: Int -> Int) -> Int{
    return modifier(number);
}

//Pass in the function which we want to use
modifyInt(number: 15, modifier: double)
modifyInt(number: 15, modifier: triple)

//return a function from a function
func buildIncrementor() -> () -> Int {
    var count = 0;
    func incrementor() -> Int{
        ++count;
        return count;
    }
    return incrementor;
}

var incrementor = buildIncrementor();
incrementor();
incrementor();


//This allows us to pass in as many INT variables as we like
//variadic arguments
func average(#numbers:Int...) -> Int {
    var total = 0;
    for n in numbers {
        total += n;
    }
    return total / numbers.count
}


average(numbers: 13, 14, 235, 52, 5)
average(numbers: 123, 643, 6)


//workaround to let us pass in arrays, with variadic arguments
func joinString(#strings: [String]) -> String {
    var returnStr = "";
    for str in strings {
        returnStr += str;
    }
    return returnStr;
}

func joinString(#strings: String...) -> String {
    return joinString(strings: strings)
}

var arrayOfStrings = ["I", "am", "an", "array"];
joinString(strings: arrayOfStrings);
joinString(strings: "I", "am", "variadic");


//inout - keeps the original copy, byRef
func incrementNumber(inout #number: Int, increment:Int = 1) {
    number += increment;
}


var ourInt = 1
incrementNumber(number: &ourInt);

ourInt;

incrementNumber(number: &ourInt, increment: 2);
ourInt;



