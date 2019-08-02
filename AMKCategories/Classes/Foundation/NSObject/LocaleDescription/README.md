# AMKLocaleDescription

> **控制台本地化输出中文，拒绝Unicode**



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

**以如下代码为例：**

```objective-c
NSString *str = @"中文ABC";
NSArray *array = @[@"中文ABC", @"中文ABC"];
NSDictionary *dict = @{@"str": str, @"array":array};
NSLog(@"%@:%@", self.title, dict);
```

**使用该库之前系统默认的输出：**

```objective-c
AMKLocaleDescription_Example[4032:5495582] 控制台本地化输出中文Demo:{
    array =     (
                 "\U4e2d\U6587ABC",
                 "\U4e2d\U6587ABC"
                 );
    str = "\U4e2d\U6587ABC";
}
```

**使用该库之后的输出：**

```objective-c
AMKLocaleDescription_Example[4045:5499534] 控制台本地化输出中文Demo:<__NSDictionaryI 0x1c027eb80> {
    array = [
             "中文ABC",
             "中文ABC"
             ]
    str = "中文ABC",
}
```

## Requirements


## Installation

AMKLocaleDescription is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AMKCategories/Foundation/NSObject/LocaleDescription'
```

## Author

AndyM129, andy_m129@163.com

## License

AMKCategories is available under the MIT license. See the LICENSE file for more info.