//
//  HomeResources.swift
//  MovieHub
//
//  Created by Mahmudullah on 17/2/24.
//
import Foundation
struct GetMoviesResource: APIResource {
    var method: RequestMethod {
        return .Get
    }
    var params: [String:Any]?
    typealias ModelType = GetMoviesWrapper
    var methodPath: String {
        return Api.getListOfMovies
    }
}

