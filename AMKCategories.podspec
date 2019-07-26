#
# Be sure to run `pod lib lint AMKCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AMKCategories'
    s.version          = '0.1.0'
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
        defaultSubspec.dependency 'AMKCategories/Foundation/NSBundle/VersionInfo'
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
        end
    end
end