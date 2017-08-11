//
//  ImageLoader.swift
//
//
//  Created by Ali Zahedi on 8/5/1395 AP.
//  Copyright © 1395 Ali Zahedi. All rights reserved.
//

import Foundation
import UIKit

public class AZImageLoader {
    
    var cache = NSCache<AnyObject, AnyObject>()
    
    public static let shared = AZImageLoader()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    public func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        
        let fileManager = FileManager.default
        
        var check_currect_image: Bool = false
        
        if fileManager.fileExists(atPath: self.getFileLocation(urlString: urlString).path) {
            
            let image = UIImage(contentsOfFile: self.getFileLocation(urlString: urlString).path)
            
            if image != nil {
                check_currect_image = true
                completionHandler(image, urlString)
            }
        }
        
        if (!check_currect_image) {
        
            func problemLoad(){
                print("problem load url: \(urlString)")
                completionHandler(UIImage(), urlString)
                
            }
            
            guard let escapedAddress = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed), let url = URL(string: escapedAddress) else {
                problemLoad()
                return
            }
            
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else {
                        problemLoad()
                        return
                }
                DispatchQueue.main.async() { () -> Void in
                    if let data = UIImagePNGRepresentation(image) {
                        try? data.write(to: self.getFileLocation(urlString: urlString), options: [])
                        completionHandler(image, urlString)
                    }
                }
            }.resume()
            
        }
        
    }
    
    func getFileLocation(urlString: String) -> URL{
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dataPath = documentsURL.appendingPathComponent("cache")
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
        
        let nameOfFile: String = urlString.components(separatedBy: "/").last!
        return dataPath.appendingPathComponent(nameOfFile)
    }
    
}
