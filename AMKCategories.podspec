#
# Be sure to run `pod lib lint AMKCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AMKCategories'
    s.version          = '0.1.7'
    s.summary          = 'Summary of AMKCategories.'
    s.description      = <<-DESC
                          A description of AMKCategories.
                         DESC
    s.homepage         = 'https://github.com/AndyM129/AMKCategories'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Andy Meng' => 'andy_m129@163.com' }
    s.source           = { :git => 'https://github.com/AndyM129/AMKCategories.git', :tag => s.version.to_s }
    s.social_media_url = 'http://www.jianshu.com/u/28d89b68984b'
    s.ios.deployment_target = '8.0'
    s.requires_arc = true
    s.default_subspec = 'DefaultSubspec'

    # 默认子组件
    s.subspec 'DefaultSubspec' do |defaultSubspec|
        defaultSubspec.dependency 'AMKCategories/UIKit'
        defaultSubspec.dependency 'AMKCategories/QuartzCore'
        defaultSubspec.dependency 'AMKCategories/Foundation'
    end

    # UIKit 通用扩展
    s.subspec 'UIKit' do |uikit|
        # UIWindow 相关扩展
        uikit.subspec 'UIWindow' do |window|
            # ReleaseMode 相关扩展
            window.subspec 'ReleaseMode' do |releaseMode|
                releaseMode.source_files = 'AMKCategories/Classes/UIKit/UIWindow/ReleaseMode/*.{h,m}'
                releaseMode.public_header_files = 'AMKCategories/Classes/UIKit/UIWindow/ReleaseMode/*.h'
                releaseMode.dependency 'AMKCategories/UIKit/UIApplication/MobileProvision'
                releaseMode.dependency 'AMKCategories/UIKit/UILabel/Drawing'
                releaseMode.dependency 'AMKCategories/UIKit/UIView/ViewLevel'
            end
        end
        # UICollectionView 视图相关
        uikit.subspec 'UICollectionView' do |collectionView|
            # Delegate 相关
            collectionView.subspec 'Delegate' do |delegate|
                delegate.source_files = 'AMKCategories/Classes/UIKit/UICollectionView/Delegate/*.{h,m}'
                delegate.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
        end
        # UITableView 视图相关
        uikit.subspec 'UITableView' do |tableView|
            # Delegate 相关
            tableView.subspec 'Delegate' do |delegate|
                delegate.source_files = 'AMKCategories/Classes/UIKit/UITableView/Delegate/*.{h,m}'
                delegate.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
        end
        # UILabel 相关
        uikit.subspec 'UILabel' do |label|
            # Drawing 内容绘制相关
            label.subspec 'Drawing' do |drawing|
                drawing.source_files = 'AMKCategories/Classes/UIKit/UILabel/Drawing/*.{h,m}'
                drawing.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
        end
        # UIView 视图相关
        uikit.subspec 'UIView' do |view|
            # Interactions 交互相关
            view.subspec 'Interactions' do |interactions|
                interactions.source_files = 'AMKCategories/Classes/UIKit/UIView/Interactions/*.{h,m}'
                interactions.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
            # The position of the view in the z-axis.
            view.subspec 'ViewLevel' do |viewLevel|
                viewLevel.source_files = 'AMKCategories/Classes/UIKit/UIView/ViewLevel/*.{h,m}'
                viewLevel.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
        end
        # UIImage 相关
        uikit.subspec 'UIImage' do |image|
            # Resizing 尺寸调整相关
            image.subspec 'Resizing' do |resizing|
                resizing.source_files = 'AMKCategories/Classes/UIKit/UIImage/Resizing/*.{h,m}'
            end
            # Rendering 渲染相关
            image.subspec 'Rendering' do |rendering|
                rendering.source_files = 'AMKCategories/Classes/UIKit/UIImage/Rendering/*.{h,m}'
            end
        end
        # UIViewController 相关扩展
        uikit.subspec 'UIViewController' do |viewController|
            # NavigationControllerWithCallback 导航控制
            viewController.subspec 'NavigationControllerWithCallback' do |navigationControllerWithCallback|
                navigationControllerWithCallback.source_files = 'AMKCategories/Classes/UIKit/UIViewController/NavigationControllerWithCallback/*.{h,m}'
                navigationControllerWithCallback.public_header_files = 'AMKCategories/Classes/UIKit/UIViewController/NavigationControllerWithCallback/*.h'
                navigationControllerWithCallback.dependency 'AMKCategories/UIKit/UIViewController/NavigationController'
                navigationControllerWithCallback.dependency 'AMKCategories/UIKit/UIViewController/LifeCircleBlock'
            end
            # NavigationController 导航控制
            viewController.subspec 'NavigationController' do |navigationController|
                navigationController.source_files = 'AMKCategories/Classes/UIKit/UIViewController/NavigationController/*.{h,m}'
                navigationController.public_header_files = 'AMKCategories/Classes/UIKit/UIViewController/NavigationController/*.h'
                navigationController.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
            # LifeCircleBlock 生命周期相关回调
            viewController.subspec 'LifeCircleBlock' do |lifeCircleBlock|
                lifeCircleBlock.source_files = 'AMKCategories/Classes/UIKit/UIViewController/LifeCircleBlock/*.{h,m}'
                lifeCircleBlock.public_header_files = 'AMKCategories/Classes/UIKit/UIViewController/LifeCircleBlock/*.h'
                lifeCircleBlock.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
        end
        # UIApplication 相关扩展
        uikit.subspec 'UIApplication' do |application|
            # MobileProvision 相关扩展
            application.subspec 'MobileProvision' do |mobileProvision|
                mobileProvision.source_files = 'AMKCategories/Classes/UIKit/UIApplication/MobileProvision/*.{h,m}'
                mobileProvision.public_header_files = 'AMKCategories/Classes/UIKit/UIApplication/MobileProvision/*.h'
                mobileProvision.dependency 'AMKCategories/Foundation/NSBundle/MobileProvision'
            end
        end
    end
    
    # QuartzCore 通用扩展
    s.subspec 'QuartzCore' do |quartzCore|
        # CAAnimation 动画相关
        quartzCore.subspec 'CAAnimation' do |animation|
            # AnimationDelegate 代理
            animation.subspec 'AnimationDelegate' do |animationDelegate|
                animationDelegate.source_files = 'AMKCategories/Classes/QuartzCore/CAAnimation/AnimationDelegate/*.{h,m,mm}'
            end
        end
    end

    # Foundation 通用扩展
    s.subspec 'Foundation' do |foundation|
        # NSBundle 相关扩展
        foundation.subspec 'NSBundle' do |bundle|
            # MobileProvision 证书信息
            bundle.subspec 'MobileProvision' do |mobileProvision|
                mobileProvision.source_files = 'AMKCategories/Classes/Foundation/NSBundle/MobileProvision/*.{h,m}'
                mobileProvision.public_header_files = 'AMKCategories/Classes/Foundation/NSBundle/MobileProvision/*.h'
            end
            # GitCommitInfo Git提交信息（因该扩展 需额外的工程配置，故默认不引入）
            bundle.subspec 'GitCommitInfo' do |gitCommitInfo|
                gitCommitInfo.source_files = 'AMKCategories/Classes/Foundation/NSBundle/GitCommitInfo/*.{h,m}'
                gitCommitInfo.public_header_files = 'AMKCategories/Classes/Foundation/NSBundle/GitCommitInfo/*.h'
            end
            # AppVersionInfo 版本信息
            bundle.subspec 'VersionInfo' do |versionInfo|
                versionInfo.source_files = 'AMKCategories/Classes/Foundation/NSBundle/AppVersionInfo/*.{h,m}'
                versionInfo.public_header_files = 'AMKCategories/Classes/Foundation/NSBundle/AppVersionInfo/*.h'
            end
            # BundleInfo 包信息
            bundle.subspec 'BundleInfo' do |bundleInfo|
                bundleInfo.source_files = 'AMKCategories/Classes/Foundation/NSBundle/BundleInfo/*.{h,m}'
                bundleInfo.public_header_files = 'AMKCategories/Classes/Foundation/NSBundle/BundleInfo/*.h'
            end
        end
        # NSDictionary 相关扩展
        foundation.subspec 'NSDictionary' do |dictionary|
            # ObjectForKey 自定义类型取值
            dictionary.subspec 'ObjectForKey' do |objectForKey|
                objectForKey.source_files = 'AMKCategories/Classes/Foundation/NSDictionary/ObjectForKey/*.{h,m}'
                objectForKey.public_header_files = 'AMKCategories/Classes/Foundation/NSDictionary/ObjectForKey/*.h'
            end
        end
        # NSString 相关扩展
        foundation.subspec 'NSString' do |string|
            # Emoji 相关
            string.subspec 'Emoji' do |emoji|
                emoji.source_files = 'AMKCategories/Classes/Foundation/NSString/Emoji/*.{h,m}'
                emoji.public_header_files = 'AMKCategories/Classes/Foundation/NSString/Emoji/*.h'
                emoji.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
        end
        # NSObject 相关扩展
        foundation.subspec 'NSObject' do |object|
            # KeyValueObserving
            object.subspec 'KeyValueObserving' do |keyValueObserving|
                keyValueObserving.source_files = 'AMKCategories/Classes/Foundation/NSObject/KeyValueObserving/*.{h,m}'
                keyValueObserving.public_header_files = 'AMKCategories/Classes/Foundation/NSObject/KeyValueObserving/*.h'
            end
            # KeyPathCoding
            object.subspec 'KeyPathCoding' do |keyPathCoding|
                keyPathCoding.source_files = 'AMKCategories/Classes/Foundation/NSObject/KeyPathCoding/*.{h,m}'
                keyPathCoding.public_header_files = 'AMKCategories/Classes/Foundation/NSObject/KeyPathCoding/*.h'
                keyPathCoding.dependency 'AMKCategories/Foundation/Macros/Metamacros'
            end
            # LocaleDescription 本地化输出
            object.subspec 'LocaleDescription' do |localeDescription|
                localeDescription.source_files = 'AMKCategories/Classes/Foundation/NSObject/LocaleDescription/*.{h,m}'
                localeDescription.public_header_files = 'AMKCategories/Classes/Foundation/NSObject/LocaleDescription/*.h'
            end
            # MethodSwizzling 方法替换
            object.subspec 'MethodSwizzling' do |methodSwizzling|
                methodSwizzling.source_files = 'AMKCategories/Classes/Foundation/NSObject/MethodSwizzling/*.{h,m}'
                methodSwizzling.public_header_files = 'AMKCategories/Classes/Foundation/NSObject/MethodSwizzling/*.h'
            end
        end
        # Macros 宏指令
        foundation.subspec 'Macros' do |macros|
            # metamacros
            macros.subspec 'Metamacros' do |metamacros|
                metamacros.source_files = 'AMKCategories/Classes/Foundation/Macros/Metamacros/*.{h,m}'
                metamacros.public_header_files = 'AMKCategories/Classes/Foundation/Macros/Metamacros/*.h'
            end
        end
    end
end
