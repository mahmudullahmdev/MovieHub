//
//  Environment.swift
//  MovieHub
//
//  Created by Mahmudullah on 18/2/24.
//

import Foundation
import UIKit
enum EnvironmentVars {
    private static let infoDic: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
                fatalError("plist not found")
        }
        return dict
    }()
    static let host: String = {
        guard let urlString = EnvironmentVars.infoDic["HOST"] as? String else {
            fatalError("HOST invalid")
        }
        return urlString
    }()
    static let imageBaseUrl: String = {
        guard let urlString = EnvironmentVars.infoDic["IMAGE_BASE_URL"] as? String else {
            fatalError("IMAGE_BASE_URL invalid")
        }
        return urlString
    }()  
    static let apiKey: String = {
        guard let urlString = EnvironmentVars.infoDic["API_KEY"] as? String else {
            fatalError("API_KEY invalid")
        }
        return urlString
    }()

}
