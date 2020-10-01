//
//  Loc.swift
//  LBC
//
//  Created by Leo Marcotte on 29/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

enum Loc {
    enum Error {
        static var noDataReceived = NSLocalizedString("error.noDataReceived", comment: "")
        static var jsonDecodeFailed = NSLocalizedString("error.jsonDecodeFailed", comment: "")
        static var errorReceived = NSLocalizedString("error.errorReceived", comment: "")
    }
    
    enum CategoriesFilter {
        static var confirmButtonTitle = NSLocalizedString("categoriesFilter.confirmButtonTitle", comment: "")
        static var visibleCategoriesHeader = NSLocalizedString("categoriesFilter.visibleCategories", comment: "")
        static var hiddenCategoriesHeader = NSLocalizedString("categoriesFilter.hiddenCategories", comment: "")
    }
    
    enum SplashScreen {
        static var avatarCaption = NSLocalizedString("splashScreen.avatarCaption", comment: "")
    }
    
    enum ItemCategory {
        static var vehicles = NSLocalizedString("itemCategory.vehicles", comment: "")
        static var clothes = NSLocalizedString("itemCategory.clothes", comment: "")
        static var handiwork = NSLocalizedString("itemCategory.handiwork", comment: "")
        static var home = NSLocalizedString("itemCategory.home", comment: "")
        static var toys = NSLocalizedString("itemCategory.toys", comment: "")
        static var realEstate = NSLocalizedString("itemCategory.realEstate", comment: "")
        static var entertainement = NSLocalizedString("itemCategory.entertainement", comment: "")
        static var technologies = NSLocalizedString("itemCategory.technologies", comment: "")
        static var serviceDelivery = NSLocalizedString("itemCategory.serviceDelivery", comment: "")
        static var pets = NSLocalizedString("itemCategory.pets", comment: "")
        static var childcareArticles = NSLocalizedString("itemCategory.childcareArticles", comment: "")
    }
}
