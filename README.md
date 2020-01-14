# Zealot iOS SDK

[![CI Status](https://img.shields.io/travis/getzealot/zealot-ios.svg?style=flat)](https://travis-ci.org/getzealot/zealot-ios)
[![Version](https://img.shields.io/cocoapods/v/Zealot.svg?style=flat)](https://cocoapods.org/pods/Zealot)
[![License](https://img.shields.io/cocoapods/l/Zealot.svg?style=flat)](https://cocoapods.org/pods/Zealot)
[![Platform](https://img.shields.io/cocoapods/p/Zealot.svg?style=flat)](https://cocoapods.org/pods/Zealot)

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
let zealot = Zealot(endpoint: "http://zealot.test",
                  channelKey: "...")
zealot.checkVersion()
```

```objective-c
// Objective-C
Zealot *zealot = [[Zealot alloc] initWithEndpoint:@"http://zealot.test" 
                                       channelKey:@"..."];
[zealot checkVersion];
```

## Author

icyleaf, icyleaf.cn@gmail.com

## License

Zealot is available under the MIT license. See the LICENSE file for more info.
