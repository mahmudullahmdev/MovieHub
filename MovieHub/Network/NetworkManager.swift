//
//  NetworkManager.swift
//  MovieHub
//
//  Created by Mahmudullah on 17/2/24.
//

import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute() async -> Self.ModelType?
}

extension NetworkRequest {
    // We can add here few univarsal tasks also. Like adding an internet connection check or any special status code that behaves same for all rest api calls. We can filter those checks here and can Fire special messages to show alerts or custom ui to user.
    
    fileprivate func load(_ url: URLRequest) async -> Self.ModelType? {
        return await withCheckedContinuation { continuation in
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _ , _) -> Void in
                guard let decodedData = self?.decode(data!) else {
                    return continuation.resume(returning: nil)
                }
                return continuation.resume(returning: decodedData)
            }
            task.resume()
        }
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        do {
            let wrapper = try decoder.decode(Resource.ModelType.self, from: data)
            return wrapper
        }
        catch _ {
           // print("Failed to decode JSON \(err)")
            return nil
        }
    }
    func execute() async -> Resource.ModelType? {
        return  await load(resource.request)
    }
}
protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String {get}
    var method: RequestMethod {get}
    var params: [String:Any]? {get}
}
extension APIResource {
    var request: URLRequest {
        var components = URLComponents(string: EnvironmentVars.host)!
        components.path = methodPath
        var queryItems = [URLQueryItem]()
        // If api key is required with query params in every api call. then we can add the api key here once. so that we don't need to add the api key in each api call from outer layer.
       
        for (key, value) in params ?? [:] {
            queryItems.append(URLQueryItem(name: "\(key)", value: "\(value)"))
        }
        components.queryItems = queryItems
        var request = URLRequest(url: (components.url!))
        request.httpMethod = method.rawValue
        return request
    }
}
