// 1. Variables and constants
// Make sure you use proper declarations, let for constants and var for variables
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
//maximumNumberOfLoginAttempts = 11 // you can not change this value in future

// use type anotaions, but you can always count on type inference
var welcomeString:String
var red,green,blue:Double
let 🐶🐮 = "dogcow"
welcomeString = "Welcome iOS bootcamp"

// you should use console output for debug purpuse
print(" What do we wan't: \(welcomeString)")

// Out of the box types. A: see other 8/16/32 Int types
var intValue:Int
var uintValue:UInt
var floatValue:Float
var doubleValue:Double
var boolValue:Bool = true
// boolValue = 1 // you can't do this. No conversion provided
typealias NewType = Int

intValue = 1
doubleValue = 1.0
var sum = Double(intValue) + doubleValue // you need to explicitly cast values


let http404error = (404, "Not Found")
let namedError = (code:404, message:"Not Found")
let (code, message) = http404error
let (justCode, _ ) = http404error
print ("Error code is \(code) \(http404error.0) and message is \(message) \(http404error.1)")

///////////////////////////////////////////////////////////////////////////////////////////
// 2. optionals
var convertedValue:Int? = Int("123")
var errorConversion:Int? = Int("abc")
var whatIsDefaultValue:String? // what do you think?
//convertedValue = nil
// we can always check is there any value in our optional
if convertedValue != nil {
    print("Yes there is some value \(convertedValue)") // its OK
    print("Yes there is some value \(convertedValue!)") // its OK
}

var val = convertedValue ?? 1

// use optional binding to extract values from optional ;)
if let extractValue = convertedValue { // you can use var instead of let
    print("This value is extracted  \(extractValue)")
}
if let extractValue1 = convertedValue, let extractedValue2 = errorConversion , extractValue1 == 123 {
    print("will not print")
}

//print("\(extractValue)")

// If you know that your optional exist, you can  unwrap or define optional as explicitly unwraped
let valueFromConverted = convertedValue!
var iknowthiswillbeok:Int! = Int("123")
var temp =  iknowthiswillbeok + 1 // this will work



// 3. error handling
func thisCanThrow() throws {
    // this can throw
}

//thisCanThrow() // you can't call something that will throw

try? thisCanThrow() // ok, discregard error ;)
do {
    try thisCanThrow() // this one can throw, and we will handle error
}catch{
    // handle error
}
// 5. miscelenious
// nobody likes asserts :(
assert(true)
// "=" operator doesn't return any value, ++/-- are removed
var whatValue = (3, "apple") < (3, "bird")



// 5. Strings
// Different then ObjC NSMutableString/NSString. Mutability dictated by var/let
// Strings are value types

for character in "Dog!🐶".characters {
    print(character)
}
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)

// printf on steroids
let multiplier = 3
let newMessage = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

//Swift’s native String type is built from Unicode scalar values. A Unicode scalar is a unique 21-bit number for a character or modifier. Code point in the range U+0000 to U+D7FF inclusive or U+E000 to U+10FFFF inclusive.

let sparklingHeart = "\u{1F496}"

 // é
let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}"
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"

var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
word += "\u{301}"
print("the number of characters in \(word) is \(word.characters.count)")


// “Swift strings cannot be indexed by integer values.”
let pozdrav = "Zdravo svima"
pozdrav[pozdrav.startIndex]
pozdrav[pozdrav.index(before: pozdrav.endIndex)]
pozdrav[pozdrav.index(pozdrav.startIndex, offsetBy: 2)]

for index in pozdrav.characters.indices {
    print("\(pozdrav[index]) ", terminator: "")
}
// insert, remove, removeSubrange works with indexses
// hasPrefix, hasSuffix
let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"

if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent.")
}
//utf8
let dogString = "Dog‼🐶" //\u{0044}\u{006F}\u{0067}\u{203C}\u{1F436}
for codeUnit in dogString.utf8 { // change to utf16, unicodeScalars
    print("\(codeUnit) ", terminator: "")
}


// 7. Collections (arrays, sets and ductionaries). 
// Implemented as generics
// Array<Element> or [Element]
var ints = [Int]()
var newints:[Int] = Array(repeating: 3, count: 10)
ints = []
ints = [ 1 ,2 , 3]
ints += newints
var newStrings = ["Pera" , "Zika" ] // no need to write array type
// .count, .isEmpty, append, +=, insert, remove
newStrings[0] // accessing by index
newStrings[0...1] = ["a", "b"]
for item in newStrings {
    print(item)
}
for (index, item) in newStrings.enumerated() {
    print ("\(item) and \(index)")
    
}
// Sets.. “A type must be hashable in order to be stored in a set”
// Hashable protocol reuqires .hashValue and == equivalence relantion
// Set<Element> 
var sets = Set<Character>()
var strings = Set<String>()
sets.insert("a")
strings = [ "a", "b", "c", "d"]
sets = []
var dontKnowIsItSetOrArray/*:Set*/ = ["a", "a"] // this becomes array
// insert, remove, contains

for s in strings { //.sorted()
    print(s)
}
// set operators intersection, symmetricDifference, union, subtracting, isSubset, isSuperset, isStrictSubset, isStrictSuperset, isDisjoint

// Dictionaries
// Dictionary<Key, Value>. A dictionary Key type must conform to the Hashable protocol, like a set’s value type.
var fullNaming = Dictionary<Int,String>()
var namesOfIntegers = [Int: String]()
namesOfIntegers[5] = "five"
namesOfIntegers = [:]
namesOfIntegers = [1 : "one", 2 : "two"]

var noNeedForTypes = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

noNeedForTypes["XYZ"] = "New value"
print(noNeedForTypes)
noNeedForTypes["XYZ"] = nil // remove
print(noNeedForTypes)

// updateValue, access by [], removeValue returns optional
if let val = noNeedForTypes["abc"] {
    print("we have value")
}
for (key, value) in noNeedForTypes {  // alternativly use .keys or .values
    print( "\(key) \(value)")
}

// 8. Controll flow
// for-in
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
for _ in 1...10 {
    // do something
}
// while and repeat/while
var condition = false
while condition {
    // execute loop
}
// if, else, else-if works as expected. If requeires bool, you can not assign values 
// Switch on steroids. They must be exhaustive. Needs explicit fallthrough. 

// you can list all values in case
let chars: Character = "a"
switch chars {
case "a", "A":  print("The letter A")
default:    print("Not the letter A")
}
// you can use interval in maping case 5..<12:
// switch with tuples, can be user with pattern matching
let somePoint = (1, 1)
switch somePoint {
case (0, 0):            print("(0, 0) is at the origin")
case (_, 0):            print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):            print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):  print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:                print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}
let secondPoint = (2, 0)
switch secondPoint {
case (let x, 0):        print("on the x-axis with an x value of \(x)")
case (0, let y):        print("on the y-axis with a y value of \(y)")
case let (x, y):        print("somewhere else at (\(x), \(y))")
}

let thirdPoint = (1, -1)
switch thirdPoint {
case let (x, y) where x == y:   print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:  print("(\(x), \(y)) is on the line x == -y")
case let (x, y):                print("(\(x), \(y)) is just some arbitrary point")
}

// continue, break, fallthrough, return, throw. 
// label name: while condition {
// guard

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return // break, continue, throw, fatalError()
    }
    // do something with name
    name
}

if #available(iOS 10, macOS 10.12, *) {
    
}





