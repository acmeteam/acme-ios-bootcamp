// functions
// Function in Swift has a type, consisting of the function’s parameter types and return type.
// functions inside other functions, as return arguments, parameters....
// arguments vs parameters 

func helloWorld(person: String) -> String { // helloWorld(person:)
    let greeting = "Hello, " + person + "!"
    return greeting
}
func helloWorld2(_ person: String) -> String { return helloWorld(person: person) }
helloWorld(person: "Andrija")
//helloWorld("Andrija")
helloWorld2("Andrija")

//print(_:separator:terminator:) 

func thisIsFunction(argument1 param1:Int,argument2 param2:(Int,String),argument3 param3:String, _ param4:Int) -> (p1:Int, p2:String) {
    return (1, "a")
}
func defaultParams( param1: Int, def: Int = 3) {}
defaultParams(param1: 1)

// in and out
func swap( _ a: inout Int, _ b: inout Int) { let temp = a ; a = b; b = temp } //swap(_:_:)
var first = 1, second = 2
swap(&first, &second)
print("\(first) \(second)")

// -> Void when function doesn't return any value 

_ = thisIsFunction(argument1: 1, argument2: (1,"b"), argument3: "c", 3) // we are not interested in return value

func minMax(array: [Int]) -> (min: Int, max: Int)? { //minMax(array:)
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin       { currentMin = value}
        else if value > currentMax  { currentMax = value }
    }
    return (currentMin, currentMax)
}

func mean(_ numbers: Double...) -> Double { // Max one variadic param
    var total: Double = 0
    for number in numbers { total += number }
    return total/Double(numbers.count);
}


var param:(([Int])->(Int,Int)?) = minMax
param ([1,2,30,4])

func sum(_ a: Int, _ b: Int) -> Int { return a + b }
func mul(_ a: Int, _ b: Int) -> Int { return a * b }
func printf( _ f: (Int, Int) -> Int ) { print("exec result \(f(1,3))") }
func printf2( _ f: (Int, Int) -> Int, _ a : Int, _ b : Int ) { print("exec result \(f(a,b))") }
func getfunc(_ issum:Bool) -> ((Int,Int)->Int) { return issum ? sum : mul }
var mathFunc = sum  //mathfunc is of type (Int, Int ) -> Int
mathFunc = mul
printf(sum)
printf(mul)
printf(mathFunc)
printf2(sum, 2 , 5)
printf2( getfunc(true), 1, 4)

// you can next functions to hide details
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 } // can capture values from upper function
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

// closures
// Closures are self-contained blocks of functionality that can be passed around and used in your code.
// aka blocks and lambdas
// Closures can capture and store references to any constants and variables from the context in which they are defined

// closure syntaxt is lightway and promote inferring parameter types
/* 
    Inferring parameter and return value types from context
    Implicit returns from single-expression closures
    Shorthand argument names
    Trailing closure syntax
 */

func sortingf(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let a = names.sorted(by: sortingf)
/*
 
 { (parameters) -> return_type in
        statements
 }
 
 */
let b = names.sorted(by: { (s1: String, s2:String) -> Bool in
    return s1 > s2
} )
// we can infer types from context:
let c = names.sorted(by: { (s1 , s2)  in // no need even for "(" and ")". Omitting types is question of style
    return s1 > s2
})

let d = names.sorted(by: { s1, s2 in s1 > s2 })
// horthand argument names
let e = names.sorted(by: { $0 > $1 } )
let f = names.sorted(by: > )

func funcWithClosure(closure: () -> Void) {
    
}
funcWithClosure( closure:  {} )
funcWithClosure() {}
funcWithClosure {}

let g = names.sorted { $0 > $1 }

// Arrays map funciton
let numbers = [ 1, 2, 3]

let h = numbers.map { String($0) }
print( "\(h)")


// closure can capture a value

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

var incr10 = makeIncrementer(forIncrement: 10)
var incr2  = makeIncrementer(forIncrement: 2)
incr2()
incr2()
incr10()
incr10()

// escaping closure. When passing closure to a function, and indicating that closure can be called after function exits
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
// autoclosure ?!
func someFunctionWithautoclosure(completionHandler: @autoclosure () -> Int) {
    completionHandler()
}

someFunctionWithautoclosure(completionHandler: 1 + 2)





