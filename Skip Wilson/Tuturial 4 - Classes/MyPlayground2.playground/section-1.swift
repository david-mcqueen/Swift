class SimpleClass {
    var strProperty = "My String";
}

let variableOne:SimpleClass = SimpleClass();
variableOne.strProperty = "Hello World";

let variableTwo = variableOne;

variableOne.strProperty = "Changed";
variableTwo.strProperty;


