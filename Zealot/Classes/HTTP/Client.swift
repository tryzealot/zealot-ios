//
//  Client.swift
//  Zealot
//
//  Created by icyleaf on 2020/1/8.
//

import Foundation

@objcMembers
public final class Client {
    private var endpoint: String
    private var channelKey: String
    
    typealias CompletionHandler = (Result<Channel, ZealotError>) -> Void

    public init(endpoint: String, channelKey: String) {
        self.endpoint = endpoint
        self.channelKey = channelKey
    }
    
    func checkVersion(completion: CompletionHandler?) {
        var component = URLComponents(string: "\(endpoint)/api/apps/latest")!
        component.queryItems = buildQuery()
        
        let request = URLRequest(url: component.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                response.statusCode == 200, error == nil else {
                    completion?(.failure(.notFoundChannel))
                    return
            }

            do {
                let decoder = JSONDecoder()
                let channel = try decoder.decode(Channel.self, from: data)
                completion?(.success(channel))
            } catch let parsingError {
                completion?(.failure(.invaildJson(parsingError.localizedDescription)))
            }
        }
        task.resume()
    }
    
    func buildQuery() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "channel_key", value: channelKey),
            URLQueryItem(name: "bundle_id", value: bundleId),
            URLQueryItem(name: "release_version", value: version),
            URLQueryItem(name: "build_version", value: buildVersion),
            URLQueryItem(name: "zealot_version", value: zealotVersion)
        ]
    }
}

extension Client {
    var bundleId: String {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String
    }
    
    var version: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var buildVersion: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
    }
    
    var zealotVersion: String {
        return Bundle(for: type(of: self)).object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
}
