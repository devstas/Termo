//
//  NetworkManeger.swift
//  Tempo
//
//  Created by Serov Stas on 25.10.18.
//  Copyright © 2018 Devolper. All rights reserved.
//

import Foundation
import UIKit


class Network {
    
    private init() {}
    static let shared  = Network()
    
    // MARK: - Send request
    func getData(urlRequest: URLRequest, decodeFunc: @escaping (_ data: Data) -> Any?, completion: @escaping (Any) -> ()) {
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
    
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("[HTTPRequest]: status code = \(httpStatus.statusCode)")
                return
            }
            
            guard let decodeData = decodeFunc(data) else { return }
            
            DispatchQueue.main.async {
                completion(decodeData)
            }
        }.resume()
    }
    
    
    // MAKR: helper methods
    func getUrlRequest(url: String, parameters: [String: String]) -> URLRequest {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        return URLRequest(url: components.url!)
    }
    
    // MARK: - Download image
    private var imageCache = NSCache<NSString, UIImage>()

    func downloadImage(url: URL, useCache: Bool = true, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString), useCache {
            //print("Load image from cache [for url]: \(url.absoluteString)")
            completion(cachedImage)
        } else {

            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad , timeoutInterval: 20)

            URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                guard error == nil, data != nil else {return}
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}
                guard let image = UIImage(data: data!) else {return}
                if useCache {
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                }

                DispatchQueue.main.async {
                    //print("Load image from vk.com [for url]: \(url.absoluteString)")
                    completion(image)
                }
            }).resume()
        }
    }
    
}
