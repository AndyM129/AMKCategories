#
# Be sure to run `pod lib lint AMKCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AMKCategories'
    s.version          = '0.1.1'
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
    s.default_subspec = 'DefaultSubspec'

    # 默认子组件
    s.subspec 'DefaultSubspec' do |defaultSubspec|
        defaultSubspec.dependency 'AMKCategories/UIKit'
        defaultSubspec.dependency 'AMKCategories/Foundation'
    end

    # UIKit 通用扩展
    s.subspec 'UIKit' do |uikit|
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
            end
            # LifeCircleBlock 生命周期相关回调
            viewController.subspec 'LifeCircleBlock' do |lifeCircleBlock|
                lifeCircleBlock.source_files = 'AMKCategories/Classes/UIKit/UIViewController/LifeCircleBlock/*.{h,m}'
                lifeCircleBlock.public_header_files = 'AMKCategories/Classes/UIKit/UIViewController/LifeCircleBlock/*.h'
                lifeCircleBlock.dependency 'AMKCategories/Foundation/NSObject/MethodSwizzling'
            end
        end
    end

    # Foundation 通用扩展
    s.subspec 'Foundation' do |foundation|
        # NSBundle 相关扩展
        foundation.subspec 'NSBundle' do |bundle|
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
        # NSObject 相关扩展
        foundation.subspec 'NSObject' do |object|
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
    end
end
