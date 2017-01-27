// variable definitions
var language:String = "Swift"
let IntegerValue:Int = 2014
let isAwesome:Bool = true

// type can be infered
let newLanguage = "Swift"
var version = 1

// String can be build in this way
let message = "Hello \(version + 1)"

// strings are supporting full unicode
let dog = "dog⁉︎🐶"
print( dog.characters.count)
for char in dog.characters {
    print(char)
}

// collections are very importannt
// Arrays and dictionaries
let names = ["andrija", "pera", "zika"] // we can just add objects of same type
var years = ["andrija" : 39, "pera" : 15, "zika" : 30]

let newNames:[String] = []
let moreNames:Array<String> = Array<String>()
let newYears:[String:Int] = [:]
let moreYears:Dictionary<String,Int> = Dictionary<String,Int>()

var endOfFile = true
while !endOfFile{
    // do something
}
// no more c like for loops, just for-in
for numbers in 1...5 {
    print("print 5 times \(numbers)")
}

for (key, value) in years {
    print( "key \(key) value \(value)")
}
// typles are nice way to group values
let touple1 = (39, "andrija")
touple1.0
touple1.1

let touple2 = (years:39, name:"andrija")
touple2.name
touple2.years

// let us do some list manipulation ;)
var list = ["socks", "shoes"]
list.append("throusers")
list[2] = "jeans"
list += ["a", "b"]
list[2...4] = ["d", "g", "p"]
print (list)
// and dictionary manupulation
years["andrija"] = 40
years["newuser"] = 50
print(years)

var guesswhattype = years["andrija"]
print(guesswhattype)
var optValue:Int? = years["andrija"]
if optValue != nil {
    print("value is \(optValue)")
    print("value is \(optValue!)")
}
if let unwrapped = optValue {
    print("this is nice \(unwrapped)")
}
if let dictValue = years["user"] {
    print("I have this user")
} else {
    print("there is no user")
}
optValue?.description

// optional initialiser
let strNum = "123"
let num = Int(strNum)
print(num)
if let unwrappedNumber = Int(strNum) {
    print(unwrappedNumber)
}
//////////////////////////
// we will talk about switches in next session
// functions
//1
func sendMessage1() {}
//2
func sendMessage2(recepient:String) {}
sendMessage2(recepient: "Andrija")
//3
func sendMessage3(to recepient:String) {}
sendMessage3(to: "Andrija")
//4
func sendMessage4(_ message:String, to recepient:String) {}
sendMessage4("message", to: "Andrija")
//5
func sendMessage5(_ message:String, to recepient:String, shouting:Bool = false ) {}

// functions and return values
func firstString(havingPrefix prefix:String, in strings:[String])->String? {
    for str in strings {
        if str.hasPrefix(prefix) {
            return str
        }
    }
    return nil
}

var fuctionType = firstString;
// Q: what is a function type?
var func2:(String,[String]) -> String? = firstString
// you can have touples as return values, or maybe other functions as arguments or return values

func filterNumbers(_ numbers:[Int], includeNumbers:(Int)->Bool) -> [Int] {
    var ret:[Int] = []
    for num in numbers {
        if includeNumbers(num) {
            ret.append(num)
        }
    }
    return ret
}
func devisibleByTwo(_ number:Int) -> Bool {return number%2 == 0}

var test = filterNumbers([1,2,3,4], includeNumbers: devisibleByTwo)
var test2 = filterNumbers([1,2,3,4], includeNumbers: { (num:Int) -> Bool in
    return num%2 == 0
})
var test3 = filterNumbers([1,2,3,4]) { $0%2 == 0 }

// filter, map, reduce
func Filter<Element>(_ source:[Element], _ includeElement:(Element)->Bool) ->[Element] {
    return []
}

// structs vs classes
// reference vs value types. Structure can have initialisers, properties, methods

struct Rectangle {
    var width = 12
    var height = 10
}
var r = Rectangle() // allocation and deallocation. 
r.height = 200

struct NewRectangle {
    var width:Int
    var height:Int
    
    var area: Int { // didSet, willSet
        return width*height
    }
    init(width:Int, height:Int) {
        self.width = width
        self.height = height
    }
    func fitsInside(_ rect:NewRectangle) -> Bool {
        return width < rect.width && height < rect.height
    }
}

extension NewRectangle
{
    func printme() ->Void {
        print("\(self.width) \(self.height)")
    }
}

var newRect = NewRectangle(width: 50, height: 30)
newRect.fitsInside(NewRectangle(width: 5, height: 5))
newRect.printme()

// classes can be subclasssed
class Fish {
    var name:String
    init(name:String) {
        self.name = name
    }
}
class ComplainingFish : Fish {
    var complain:String
    init(name:String, complain:String) {
        self.complain = complain
        super.init(name: name)
    }
}

protocol SomethingWild {
    func say()
}

extension ComplainingFish : SomethingWild {
    func say() { print("Aaaaaa")}
}
extension ComplainingFish : CustomStringConvertible {
    var description:String {
        return "opa cupa"
    }
}

enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

func canThrow() throws {
    let opt:Int? = 3
    guard let val = opt else {
        throw VendingMachineError.outOfStock
    }
    print(val)
    
}

do {
    try canThrow()
} catch VendingMachineError.outOfStock {
    // handle error
}
try? canThrow()
try! canThrow()










