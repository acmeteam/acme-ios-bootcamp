//
//  animals.swift
//  SplitMeGently
//
//  Created by Petar Cvijic on 1/19/17.
//  Copyright © 2017 iosBootcamp2017. All rights reserved.
//

import Foundation
import UIKit

protocol AtlasItem {
    var name: String { get }
    var image: UIImage? { get }
    var details: String { get }
    
    func fetchItem(for name: String) -> AtlasItem?
}

enum Animals: String, AtlasItem {
    
    private static let FerretDetails = "The ferret (Mustela putorius furo) is the domesticated form of the European polecat, a mammal belonging to the same genus as the weasel, Mustela of the family Mustelidae.They typically have brown, black, white, or mixed fur. They have an average length of 51 cm (20 in) including a 13 cm (5.1 in) tail, weigh about 1.5–4 pounds (0.7–2 kg), and have a natural lifespan of 7 to 10 years. Ferrets are sexually dimorphic predators with males being substantially larger than females."
    
    private static let PandaDetails = "The giant panda (Ailuropoda melanoleuca, literally \"black and white cat-foot\"; Chinese: 大熊猫; pinyin: dà xióng māo, literally \"big bear cat\"), also known as panda bear or simply panda, is a bear native to south central China.[1] It is easily recognized by the large, distinctive black patches around its eyes, over the ears, and across its round body. The name \"giant panda\" is sometimes used to distinguish it from the unrelated red panda. Though it belongs to the order Carnivora, the giant panda's diet is over 99% bamboo. Giant pandas in the wild will occasionally eat other grasses, wild tubers, or even meat in the form of birds, rodents or carrion. In captivity, they may receive honey, eggs, fish, yams, shrub leaves, oranges, or bananas along with specially prepared food. The giant panda (Ailuropoda melanoleuca, literally \"black and white cat-foot\"; Chinese: 大熊猫; pinyin: dà xióng māo, literally \"big bear cat\"), also known as panda bear or simply panda, is a bear native to south central China.[1] It is easily recognized by the large, distinctive black patches around its eyes, over the ears, and across its round body. The name \"giant panda\" is sometimes used to distinguish it from the unrelated red panda. Though it belongs to the order Carnivora, the giant panda's diet is over 99% bamboo. Giant pandas in the wild will occasionally eat other grasses, wild tubers, or even meat in the form of birds, rodents or carrion. In captivity, they may receive honey, eggs, fish, yams, shrub leaves, oranges, or bananas along with specially prepared food."
    
    private static let TigerDetails = "The tiger (Panthera tigris) is the largest cat species, most recognisable for their pattern of dark vertical stripes on reddish-orange fur with a lighter underside. The species is classified in the genus Panthera with the lion, leopard, jaguar and snow leopard. Tigers are apex predators, primarily preying on ungulates such as deer and bovids. They are territorial and generally solitary but social animals, often requiring large contiguous areas of habitat that support their prey requirements. This, coupled with the fact that they are indigenous to some of the more densely populated places on Earth, has caused significant conflicts with humans."
    
    case Tiger
    case Ferret
    case Panda

    var name: String {
        return self.rawValue
    }
    
    var image: UIImage? {
        return UIImage(named: self.rawValue.lowercased())
    }
    
    var details: String {
        switch self {
        case .Ferret: return Animals.FerretDetails
        case .Tiger: return Animals.TigerDetails
        case .Panda: return Animals.PandaDetails
        }
    }
    
    func fetchItem(for name: String) -> AtlasItem? {
        return Animals(rawValue: name)
    }
}

extension Animals {
    static var allAnimals:[Animals] {
        return [.Ferret, .Panda, .Tiger]
    }
}
