//
//  Zealot.swift
//  Zealot
//
//  Created by icyleaf on 2020/1/7.
//

import UIKit

@objcMembers
public final class Zealot: NSObject {
    public let defaultEnvironment: String = "default"
    public var enviroment: String
    public var endpoint: String
    public var channelKeys: [String: String] = [:]
    
    public init(endpoint: String, channelKey: String) {
        self.endpoint = endpoint
        self.enviroment = defaultEnvironment
        self.channelKeys[enviroment] = channelKey
        super.init()
    }
    
    public init(endpoint: String, channelKey: String, enviroment: String) {
        self.endpoint = endpoint
        self.enviroment = enviroment
        self.channelKeys[enviroment] = channelKey
        super.init()
    }
}

// MARK: - Public methods
public extension Zealot {
    
    func setChannelKey(channelKey: String, environment: String) {
        self.channelKeys[environment] = channelKey
    }
    
    func checkVersion() {
        let client = try! Client(endpoint: endpoint, channelKey: useChannelKey())
        client.checkVersion { (result) in
            switch result {
            case .success(let channel):
                DispatchQueue.main.async {
                    self.showAlert(channel)
                }
            case .failure(_): break  // ignore
            }
        }
    }
}

// MARK: - Alert
private extension Zealot {
    func showAlert(_ channel: Channel) {
        guard channel.releases.count > 0 else { return }
        let alert = createAlertVC(releases: channel.releases)
        alert.show()
    }
    
    func updateAlertAction(url: String) -> UIAlertAction {
        return UIAlertAction(title: "立即更新", style: .default) { (UIAlertAction) in
            guard let installUrl = URL(string: url) else { return }
            UIApplication.shared.canOpenURL(installUrl)
        }
    }
    
    func cancelAlertAction() -> UIAlertAction {
        return UIAlertAction(title: "下次再说", style: .cancel) { (UIAlertAction) in
        }
    }
    
    func createAlertVC(releases: [Channel.Release]) -> UIAlertController {
        let release = releases[0]
    
        let title = "⭐️发现新版本⭐️"
        let message = "\(release.releaseVersion) (\(release.buildVersion))"
        let changelog = generateChangelog(releases: releases)
    
        
        
        let alert = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        alert.setMaxHeight(UIScreen.main.bounds.height / 2)
        alert.addTextView(text: changelog)
        alert.addAction(updateAlertAction(url: release.installUrl))
        alert.addAction(cancelAlertAction())
        
        return alert
    }
}

// MARK: - Helper methods
private extension Zealot {
    func generateChangelog(releases: [Channel.Release]) -> String {
        var changelogMessage = [String]()
        for release in releases {
            for (index, changelog) in release.changelog.enumerated() {
                if changelog.message.isEmpty { continue }
                
                changelogMessage.append("\(index + 1). \(changelog.message)")
            }
        }
        
        return changelogMessage.joined(separator: "\n")
    }

    func useChannelKey() throws -> String {
        guard let channelKey = channelKeys[enviroment] else {
            let defaultChannelkey = channelKeys[defaultEnvironment]
            if defaultChannelkey != nil {
                return defaultChannelkey!
            }
            
            throw ZealotError.notFoundChannelKey
        }
        
        return channelKey
    }
}

enum ZealotError: Error {
    case notFoundChannelKey
    case notFoundChannel
    case invaildJson(String)
}
