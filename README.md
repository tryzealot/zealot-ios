# Zealot iOS SDK

[![CI Status](https://img.shields.io/travis/getzealot/zealot-ios.svg?style=flat)](https://travis-ci.org/getzealot/zealot-ios)
[![Version](https://img.shields.io/cocoapods/v/Zealot.svg?style=flat)](https://cocoapods.org/pods/Zealot)
[![License](https://img.shields.io/cocoapods/l/Zealot.svg?style=flat)](https://cocoapods.org/pods/Zealot)
[![Platform](https://img.shields.io/cocoapods/p/Zealot.svg?style=flat)](https://cocoapods.org/pods/Zealot)

iOS 组件提供为 Zealot 检查新版本和安装的服务，支持 Swift 和 Objective-C。

## 安装

### Cocoapods

使用 [Cocoapods](https://cocoapods.org) 安装 Zealot 需要把它加到 `PodFile`:

> 未达到上线标准前暂不上 Cocoapods Specs

```ruby
pod 'Zealot', :git => 'https://github.com/getzealot/zealot-ios.git', :branch => 'master'
```

保存后开始安装：

```sh
pod install
```

## 使用

1. 在 AppDelegate 文件t引入 Zealot 框架头：

```swift
// Swift
import Zealot
```

```objective-c
// Objective-C
#import <Zealot/Zealot-Swift.h>
```

2. 接着在上面文件的 `application:didFinishLaunchingWithOptions:` 方法追加启动代码：

```swift
// Swift
// 单个渠道
let zealot = Zealot(endpoint: "http://zealot.com", channelKey: "...")
zealot.checkVersion()

// 多个渠道，比如测试版本，内测版本
let zealot = Zealot(endpoint: "http://zealot.com",
                 channelKeys: [
                   "beta": "xxxxxxx",
                   "test": "yyyyyyy"],
          default_enviroment: "beta")

// 最后触发监测方法
zealot.checkVersion()
```

```objective-c
// Objective-C
// 单个渠道
Zealot *zealot = [[Zealot alloc] initWithEndpoint:@"http://zealot.com"
                                       channelKey:@"..."];

// 多个渠道，比如测试版本，内测版本
Zealot *zealot = [[Zealot alloc] initWithEndpoint:@"http://zealot.com"
                                          channelKeys:@{
                                              @"beta": @"xxxxxxx",
                                              @"gray": @"yyyyyyy"
                                          }
                                   default_enviroment:@"beta"];

// 最后触发监测方法
[zealot checkVersion];
```

## Author

icyleaf, icyleaf.cn@gmail.com

## License

Zealot is available under the MIT license. See the LICENSE file for more info.
