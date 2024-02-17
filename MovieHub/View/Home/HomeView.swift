//
//  HomeView.swift
//  MovieHub
//
//  Created by Mahmudullah on 17/2/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                VStack {
                    GeometryReader { proxy in
                        ScrollView(.vertical,showsIndicators: false) {
                            
                            if self.viewModel.movieList.count > 0 {
                                LazyVStack {
                                    ForEach(0..<self.viewModel.movieList.count, id: \.self){ index in
                                        let item = self.viewModel.movieList[index]
                                        MovieItemView(item: item, proxy: proxy)
                                        
                                    }
                                }
                            } else {
                                LazyVStack {
                                    ForEach(0..<10){ index in
                                        MovieEmptyItemView()
                                            .frame(width: proxy.size.width, height: proxy.size.width/2)
                                    }
                                }
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
                .navigationTitle("Movie List")
                .onAppear{
                    self.viewModel.queryString = "Marvel"
                    Task {
                        await self.viewModel.getMoviesList()
                        self.viewModel.queryString = ""
                    }
                }
                .searchable(text: self.$viewModel.queryString, prompt: "Search movies..")
                .onChange(of: self.viewModel.queryString){newQuery in
                    self.viewModel.queryString = newQuery
                    Task{
                        await self.viewModel.getMoviesList()
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}


#Preview {
    HomeView()
}
