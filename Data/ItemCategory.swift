//
//  ItemCategory.swift
//  LBC
//
//  Created by Leo Marcotte on 25/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

enum ItemCategory: Int, Codable, CaseIterable {
    case vehicles = 1
    case clothes = 2
    case handiwork = 3
    case home = 4
    case toys = 5
    case realEstate = 6
    case entertainement = 7
    case technologies = 8
    case serviceDelivery = 9
    case pets = 10
    case childcareArticles = 11

    var name: String {
        switch self {
        case .vehicles: return Loc.ItemCategory.vehicles
        case .clothes: return Loc.ItemCategory.clothes
        case .handiwork: return Loc.ItemCategory.handiwork
        case .home: return Loc.ItemCategory.home
        case .toys: return Loc.ItemCategory.toys
        case .realEstate: return Loc.ItemCategory.realEstate
        case .entertainement: return Loc.ItemCategory.entertainement
        case .technologies: return Loc.ItemCategory.technologies
        case .serviceDelivery: return Loc.ItemCategory.serviceDelivery
        case .pets: return Loc.ItemCategory.pets
        case .childcareArticles: return Loc.ItemCategory.childcareArticles
        }
    }

    var gradientColors: (UIColor, UIColor) {
        switch self {
        case .vehicles: return  (UIColor(hex: "#43C6AC"), UIColor(hex: "#191654"))
        case .clothes: return (UIColor(hex: "#ef32d9"), UIColor(hex: "#89fffd"))
        case .handiwork: return (UIColor(hex: "#c31432"), UIColor(hex: "#240b36"))
        case .home:  return (UIColor(hex: "#FDC830"), UIColor(hex: "#F37335"))
        case .toys: return (UIColor(hex: "#34e89e"), UIColor(hex: "#0f3443"))
        case .realEstate: return (UIColor(hex: "#c0c0aa"), UIColor(hex: "#1cefff"))
        case .entertainement: return (UIColor(hex: "#FC466B"), UIColor(hex: "#3F5EFB"))
        case .technologies: return (UIColor(hex: "#000046"), UIColor(hex: "#1CB5E0"))
        case .serviceDelivery: return (UIColor(hex: "#36D1DC"), UIColor(hex: "#5B86E5"))
        case .pets: return (UIColor(hex: "#ee9ca7"), UIColor(hex: "#ffdde1"))
        case .childcareArticles: return (UIColor(hex: "#EB5757"), UIColor(hex: "#EB5757"))
        }
    }
}
