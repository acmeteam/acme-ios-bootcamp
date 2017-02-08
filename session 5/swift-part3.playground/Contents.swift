// Enums on steroid
// They support computed properties, methods, protocol implementation, initialisation,....

enum Color {
    case blue
    case red
    case green
}
enum AlternateColor
{
    case black, white, gray
}

var enumVar = Color.blue
var secEnumVar = AlternateColor.black
secEnumVar = .gray // shortened syntax
switch enumVar // switch requires exhaustiveness
{
case .blue: print ("its blue")
case .red:  print ("its red")
case .green: print ("its green")
}

// Enums with rawvalues
enum ASCIIChar: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

enum RawColors : Int {
    case magenta = 0
    case orange
    case brown
}
let c1 = RawColors(rawValue: 1)
let c2 = RawColors(rawValue: 5)
if let existColor = RawColors(rawValue: 2) {
    print("Color exists \(existColor)")
}


enum Compas : String {
    case east, north, south, west
}
print ("\(Compas.east)")


// Associated values. Remember variant type?

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var barCode = Barcode.upc(1, 2, 3, 4)
barCode = .qrCode("1234")
switch barCode
{
case .upc( let a, let b, let c, let d): print( "\(a) \(b) \(c) \(d)")
case .qrCode( let str): print (str)
}
switch barCode
{
case let .upc(  a,  b,  c,  d): print( "\(a) \(b) \(c) \(d)")
case var .qrCode( str): print (str)
}

// Enum recursion
indirect enum Expression {
    case number(Int)
    case addition(Expression, Expression)
    case multiplication(Expression, Expression)
}


// (5+4) * 2

let expression = Expression.multiplication(Expression.addition(Expression.number(5), Expression.number(4)), Expression.number(2))


func evaluate(ex:Expression) -> Int {
    switch ex {
    case let .number(n): return n
    case let .addition(x,y): return evaluate(ex: x) + evaluate(ex: y)
    case let .multiplication(x,y): return  evaluate(ex: x) * evaluate(ex: y)
    }
}

print(evaluate(ex: expression))

/////////////////////////////////////////////////////////
// Classses and structures
// Have properties, methods, subscript, initialisers, extension, confirm to protocol
// Class have: Inheritance, Deinitializers, ref counting, type casting


struct Resolution
{
    var width = 0
    var height = 0
}
class VideoMode
{
    var res = Resolution()
    var name:String?
    var frameRate = 0.0
}


// structures and enumerations are value types in Swift
let res = Resolution()
let newRes = Resolution(width: 100, height: 100) // Structures automatically-generated memberwise initializer

var copied = newRes
copied.height = 50

print( "\(copied.height) \(newRes.height)" )

let vm = VideoMode()
let vm2 = vm
vm.frameRate = 100

print( "\(vm.frameRate) \(vm2.frameRate)" )

// classes have === !== operators.
// Strings, Arrays and Dictionaries are structs. Different then NSArray, NSDictionary....

// Properties
// Stored can be in class, struct, enum. Computed in class, struct

class Example
{
    var varStoredProperty = 0
    let constStoredProperty = 1
    
    init() {
        // can change property values
    }
}
struct PointS
{
    var x:Int
    var y:Int
}

let constPoint = PointS(x: 0, y: 100)
//constPoint.x = 10 // you can't change value of x
// change PointsS to class, and this should work

class NetworkLoader
{
    init() { print("init")}
    func load() {print("load") }
    var fileName:String = ""
}
class Parser
{
    lazy var loader = NetworkLoader() // lazu initializers! not thread safe.
}

var p = Parser()
p.loader.load() // cals both init and load
//p.loader.fileName = "and"

// calculated Properties, always var

struct Rectangle
{
    struct Point {
        var x:Int
        var y:Int
    }
    struct Size {
        var w:Int
        var h:Int
    }
    var p:Point
    var s:Size
    var centar:Point {
        get {
            return Point(x: p.x + s.w/2, y: p.y + s.h/2)
        }
        set { // you can remove setter and then you will have read only computed property
            p = Point(x: newValue.x - (s.w/2), y: newValue.y - (s.h/2))
        }
    }
    /*
     if readonly
     var centar:Point {
        return Point(x: p.x + s.w/2, y: p.y + s.h/2)
     }
     */
}

// Properties observers for storred properties
class Counter {
    var counter:Int = 0 {
        willSet {
            print("value will be updated to \(newValue)")
        }
        didSet {
            print("value was updated from \(oldValue) to \(counter)")
            // can be used to override change!!
        }
    }
}


var cnt = Counter()
cnt.counter += 1
// you can add property observers to global or local storred properties. 

// what about statics

class SomeClass
{
    static var someTypeProperty:Int = 1 // should be always initialised. Lazy and thread safe by default
    static var compTypeProperty:Int {
        return 2
    }
    class var overridableTypeP:Int {
        return 3
    }
}

SomeClass.compTypeProperty
SomeClass.someTypeProperty
SomeClass.overridableTypeP

// Enought about properties, lets talk about methods
// structs, enums and classes can define methods !

class Counter2 {
    var counter:Int = 1
    func increment( by amount:Int) {
        self.counter += amount
    }
}
var cnt2 = Counter2()
cnt2.increment(by: 2)
print(cnt2.counter)

// TODO: change Counter2 from class to struct. You need to mark as mutating
// for struct you can also do self = Counter2(counter:self.counter+1)


enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:  self = .low
        case .low:  self = .high
        case .high: self = .off
        }
    }
}

// you can also have static/class methods in class

// adding subscript access
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index // just a getter, but you can add a setter in same way as used for computed properties
    }
}

var tt = TimesTable(multiplier: 2)
tt[3]

struct Matrix
{
    let rows: Int, columns: Int
    var grid: [Double]
    init() {
        self.rows = 3
        self.columns = 3
        self.grid = Array(repeating: 0.0, count: rows * columns)
    }
    subscript(row: Int, column: Int) -> Double {
        get { return grid[(row * columns) + column] }
        set { grid[(row * columns) + column] = newValue }
    }
    
}

var matrix = Matrix()
matrix[0, 1] = 3
print(matrix.grid)

////////// Inheritance
// subclass can use methods, properties and subscripts from base class. You can override any of them
// There is no universal base class
// No mulitple inheritance

class Superclass
{
    func superMethod() {}
    func overrideMehod() { print("overrideMehod sup")}
}
class Subclass : Superclass
{
    func subMethod() {}
    override func overrideMehod() { super.overrideMehod(); print("overrideMehod sub")}
}

var s = Subclass()
s.superMethod()
s.subMethod()
s.overrideMehod()

// you can also override properties or  Overriding Property Observers
// final modiffier on class/method/property prevents overriding

















