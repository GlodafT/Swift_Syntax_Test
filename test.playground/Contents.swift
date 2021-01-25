import UIKit

enum Voice {
    case low, medium, high
}

protocol RunningCreature {
    var isRuning: Bool { get set}
    var runSpeed: Int { get }
    var pawsCount: Int { get }
    
    func run()
    
    func stop()
}

protocol SpeakingCreature {
    var voice: Voice { get }
    var isMuted: Bool { get set }
    
    func mut ()
    
    func speak()
    
}

class Human {
    
    class Name {
        var name: String = "Felix"
        var surname: String = "Fel"
        var patranomic: String = "Filixvich"
        
        init(name: String, surname: String, patranomic: String) {
            self.name = name
            self.surname = surname
            self.patranomic = patranomic
        }
    }
    
    let name: Name
    
    var age: Int {
        get {
            return _age
        } set {
            if newValue != _age && newValue > 0 {
                _age = newValue
            }
        }
        
    }
    
    private var _age: Int = 0 {
        didSet {
            happyBirthdayAction(age: _age )
        }
    }
    
    var isHumanAdult: Bool {
        guard age >= 18 else { return false }
        return true
    }
    
    func happyBirthdayAction(age: Int) {
        print("Happy BD. Now yours age is \(_age)")
    }
    
    init(name: Name) {
        self.name = name
    }
}




class Animal {
    let isHerbivorous: Bool
    
    let name: String
    
    class var numberOfInstances: Int {
        return 0
    }
    
    init(isHerbivorous: Bool, name: String) {
        self.isHerbivorous = isHerbivorous
        self.name = name
    }
    
    class func getInfoAboutAnimal() {
        print("numberOfInstances: \(numberOfInstances)")
    }
}


class Tiger: Animal, RunningCreature {
    
    var isRuning: Bool = false
    
    var runSpeed: Int = 40
    
    var pawsCount: Int = 4
    
    override class var numberOfInstances: Int {
        return 2000
    }
    
    func run() {
        guard !isRuning else {return}
        isRuning.toggle()
        print("Tiger is running")
    }
    
    func stop() {
        guard isRuning else {return}
        isRuning.toggle()
        print("Tiger is stay")
    }
    override class func getInfoAboutAnimal() {
        super.getInfoAboutAnimal()
        print("something about a tiger")
    }
    
    func eatAnimal(food: Animal) {
        if food is Tiger {
            return
        } else if let food = food as? RunningCreature {
            guard food.runSpeed < self.runSpeed else {return}
            print("Tiger eat \(food.self)")
        } else {
            print("Tiger eat \(food.self)")
        }
    }
}

class Parrot: Animal, SpeakingCreature {
    var voice: Voice = .low
    
    var isMuted: Bool = true
    
    override class var numberOfInstances: Int {
        return 6000
    }
    
    func mut() {
        guard isMuted else {return}
        isMuted.toggle()
        print("Parrot is muted")
    }
    
    func speak() {
        guard !isMuted else {return}
        isMuted.toggle()
        print("Parrot speak")
    }
    
    
}

final class Zoo {
    let maxNumberOfAnimals: Int
    
    let zooName: String
    
    private(set) var totalNumberOfVisitors: Int = 0 {
        willSet {
            print("I full of gladness corse \(Human.Name.self) visited me")
        }
    }
    private(set) var arrayOfAnimals: [Animal] = []
    
    private(set) var arrayOfHuman: [Human] = []
    
    init(maxNumberOfAnimals: Int, zooName: String) {
        self.maxNumberOfAnimals = maxNumberOfAnimals
        self.zooName = zooName
    }
    
    init(zooName: String) {
        self.maxNumberOfAnimals = Int.random(in: 20...100)
        self.zooName = zooName
    }
    
    func addAnimal(animal: Animal) -> String? {
        guard arrayOfAnimals.count > maxNumberOfAnimals else {return "max number of animals"}
        arrayOfAnimals.append(_: animal)
        return nil
    }
    
    func addHuman(human: Human) {
        arrayOfHuman.append(_: human)
    }
    
    func deleteAllAdults() {
        var index: Int = 0
        for human in arrayOfHuman {
            index += 1
            let HumanIndex: Int = index
            if human.isHumanAdult {
                arrayOfHuman.remove(at: HumanIndex - 1)
            }
        }
    }
}

