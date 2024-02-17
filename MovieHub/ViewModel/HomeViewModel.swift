//
//  HomeViewModel.swift
//  MovieHub
//
//  Created by Mahmudullah on 17/2/24.
//

import Foundation
class HomeViewModel: ObservableObject {
    @Published var movieList: [MovieModel] = []
    @Published  var queryString: String = "Marvel"

    
    
    func getMoviesList() async {
        let params: [String: Any] = [
            "api_key": EnvironmentVars.apiKey,
            "query": self.queryString
        ]
        let response = await APIRequest(resource: GetMoviesResource(params: params)).execute()
        if response?.results.count ?? 0 > 0 {
            DispatchQueue.main.async {
                self.movieList = response?.results ?? []
            }
            
        }
    }
}
