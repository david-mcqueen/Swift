/*
https://www.youtube.com/watch?v=8NSXdqwxRbE&list=TLGXp91iufWVtpeciPRGDVeWO3YUbwP7Ya&index=6
*/
struct GeoPoint {
    var latitude:Double = 0.0
    var longiture:Double = 0.0
}

var newGeoPoint = GeoPoint()
newGeoPoint.latitude = 42.8572
newGeoPoint.longiture = -12.4222

var memberwiseGeoPoint = GeoPoint(latitude: 12.324, longiture: 29.1111)

struct Point {
    var x:Int, y:Int
}

struct Size {
    var width:Int, height:Int
}

struct Rect {
    var origin:Point, size:Size
    
    func center() -> Point {
        var x = origin.x + (size.width / 2)
        var y = origin.y + (size.height / 2)
        return Point(x: x, y: y)
    }
}

var origin = Point(x: 0, y: 0)

var size = Size(width: 100, height: 100);

var rect = Rect(origin: origin, size: size)

rect.size.width = 80

var center = rect.center()


var pointOne = Point(x: 10, y:10)

var pointTwo = pointOne

pointTwo.x = 20

pointOne.x
pointTwo.x


struct Foo {
    var someProperty = 0.0
    mutating func incrementSomeProperty(increment:Double = 1){
        self.someProperty += increment;
    }
}

var myFoo = Foo()
myFoo.incrementSomeProperty()
myFoo.someProperty
myFoo.incrementSomeProperty(increment: 2)
myFoo.someProperty
