//
//  CachedImage.swift
//  EvaluacionApp
//
//  Created by Sofia Yobal Castro on 10/2/19.
//  Copyright © 2019 Sofia Yobal Castro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CachedImage: NSObject {
    let cache = NSCache<NSString, AnyObject>()
    static let sharedInstance = CachedImage()
    
    private override init() {
        super.init()
    }
    
    func downloadImage(endPoint: String, completion: @escaping(UIImage) -> Void) {
        let image = UIImage(named: "noImage")!
        
        if let cachedImage = CachedImage.sharedInstance.cache.object(forKey: endPoint as NSString) as? UIImage {
            completion(cachedImage)
        } else {
            if let url = URL(string: endPoint), NetworkReachabilityManager()!.isReachable {
                let session = URLSession.shared
                let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
                    guard let data = data, error == nil else { return }
                    let imageToCache = UIImage(data: data) ?? image
                    CachedImage.sharedInstance.cache.setObject(imageToCache, forKey: endPoint as NSString)
                    completion(imageToCache)
                })
                task.resume()
            } else {
                completion(image)
            }
        }
    }
}
