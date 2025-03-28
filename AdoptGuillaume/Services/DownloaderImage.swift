//
//  DownloaderImage.swift
//  AdoptGuillaume
//
//  Created by Guillaume Djaider Fornari on 27/03/2025.
//

import UIKit

struct DownloaderImage {
    static func download(from url: NSURL, completionHandler: @escaping (Bool, UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url as URL) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data,
                  error == nil else {
                NSLog("Error: Can't retrieve data from DataTask.")
                return completionHandler(false, nil)
            }
            let image = UIImage(data: data)
            completionHandler(true, image)
        }
        task.resume()
    }
}
