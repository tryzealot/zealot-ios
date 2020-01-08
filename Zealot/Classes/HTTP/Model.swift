//
//  Model.swift
//  Zealot
//
//  Created by icyleaf on 2020/1/7.
//

import Foundation

struct Channel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case releases
    }
    
    let releases: [Release]
    
    struct Release: Decodable {
        private enum CodingKeys: String, CodingKey {
            case version
            case releaseVersion = "release_version"
            case buildVersion = "build_version"
            case bundleId = "bundle_id"
            case appName = "app_name"
            case installUrl = "install_url"
            case changelog
        }
        
        let version: Int
        let releaseVersion: String
        let buildVersion: String
        let appName: String
        let bundleId: String
        let installUrl: String
        let changelog: [Changelog]
    }
    
    struct Changelog: Decodable {
        private enum CodingKeys: String, CodingKey {
            case message
        }
        
        let message: String
    }
}
