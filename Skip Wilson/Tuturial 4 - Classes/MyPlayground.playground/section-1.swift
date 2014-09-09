/* Classes
https://www.youtube.com/watch?v=2HwnLD0Xxro&index=5&list=TLedJ8-mU6EJeiFPIZSsFqELK6OhMg4sTI

*/

class Person {
    let name:String;
    var age:Int;
    var nickname:String?;
    
    init(name:String, age:Int, nickname:String? = nil){
        self.name = name;
        self.age = age;
        self.nickname = nickname;
    }
}

var person1 = Person(name: "David", age: 24);
var person2 = Person(name: "Fred", age: 36, nickname: "T-bone");

person1.age;

class Mutant:Person {
    var level:Int;
    var superPower:String;
    
    init(name: String, age: Int, level:Int, superPower:String, nickname: String?) {
        self.level = level;
        self.superPower = superPower;
        super.init(name: name, age: age, nickname: nickname)
    }
    
    func isMorePowerful(mutant:Mutant) -> Bool {
        return (level > mutant.level);
    }
}

var jim = Mutant(name: "Jim Neutrin", age: 23, level: 7, superPower: "Fight", nickname: "Flying Jim");
var janet = Mutant(name: "Janet Jackson", age: 32, level: 8, superPower: "Telepathy", nickname: "The Brainac")


janet.isMorePowerful(jim)
jim.isMorePowerful(janet)


class SomeClass {
    class func typeMethod(#string:String) -> String {
        return string + "_ModifiedInClassMethod";
    }
}

var strToModify:String = "Happy String";
SomeClass.typeMethod(string: strToModify);

