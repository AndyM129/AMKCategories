//
//  NSBundle+AMKGitCommitInfo.h
//  AMKCategories
//
//  Created by 孟昕欣 on 2019/7/26.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * _Nonnull const AMKGitCommitSHAInfoKey;
FOUNDATION_EXPORT NSString * _Nonnull const AMKGitCommitBranchInfoKey;
FOUNDATION_EXPORT NSString * _Nonnull const AMKGitCommitUserInfoKey;
FOUNDATION_EXPORT NSString * _Nonnull const AMKGitCommitDateInfoKey;

/// Git提交相关信息
/// 使用前须先进行如下配置（详见源文档：https://www.jianshu.com/p/8156e89b9572）
@interface NSBundle (AMKGitCommitInfo)
@property(nonatomic, strong, readonly, nullable) NSString *amk_gitCommitSHA;        //!< Git 提交的SHA，eg. 3f2447d4deae555eea57c193e33dfd941d1b938a
@property(nonatomic, strong, readonly, nullable) NSString *amk_gitCommitShortSHA;   //!< Git 提交的SHA（前6位），eg. 3f2447
@property(nonatomic, strong, readonly, nullable) NSString *amk_gitCommitBranch;     //!< Git 提交所在分支，eg. develop
@property(nonatomic, strong, readonly, nullable) NSString *amk_gitCommitUser;       //!< Git 提交的用户， eg. andym129
@property(nonatomic, strong, readonly, nullable) NSDate *amk_gitCommitDate;         //!< Git 提交的日期，eg. Fri Jul 26 16:09:35 2019 +0800

- (NSString *_Nullable)amk_gitCommitDateStringWithFormat:(NSString *_Nullable)dateFormat;
//// 辅助方法
//@property(nonatomic, strong, nullable) NSDateFormatter *amk_gitCommitDateFormatter; //!< Git 提交的日期的输出格式，eg.
//@property(nonatomic, strong, readonly, nullable) NSString *amk_gitCommitDateString; //!< Git 提交的日期字符串，eg.
@end


///  使用前须先进行如下配置（详见源文档：https://www.jianshu.com/p/8156e89b9572）
///
///  思路：
///     配置script，获取到需要的Git的信息然后存入info.plist中，需要的时候再从info.plist中取出。
///  步骤（可参考本工程）：
///     1. Xcode-Build Phases-New Run Script Phase,
///        为了和项目中的其他脚本区分开，建议改个名字（双击Run Script改名字），Run Script改为Git Script。
///     2. 给对应的Target下的info.plist文件增加以下属性，用于保存脚本执行中设置的Git信息：
///        AMKGitCommitSHA、AMKGitCommitBranch、AMKGitCommitUser、AMKGitCommitDate
///     3. 复制粘贴如下脚本到Git Script中：
//
//            #最后一次提交的SHA
//            git_sha=$(git rev-parse HEAD)
//
//            #当前的分支
//            git_branch=$(git symbolic-ref --short -q HEAD)
//
//            #最后一次提交的作者
//            git_last_commit_user=$(git log -1 --pretty=format:'%an')
//
//            #最后一次提交的时间
//            git_last_commit_date=$(c)
//
//            info_plist="${BUILT_PRODUCTS_DIR}/${EXECUTABLE_FOLDER_PATH}/Info.plist"
//            /usr/libexec/PlistBuddy -c "Set :'AMKGitCommitSHA'      '${git_sha}'"                   "${info_plist}"
//            /usr/libexec/PlistBuddy -c "Set :'AMKGitCommitBranch'   '${git_branch}'"                "${info_plist}"
//            /usr/libexec/PlistBuddy -c "Set :'AMKGitCommitUser'     ${git_last_commit_user}"        "${info_plist}"
//            /usr/libexec/PlistBuddy -c "Set :'AMKGitCommitDate'     '${git_last_commit_date}'"      "${info_plist}"
///
///     4. 读取方法：
///         NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
///         NSString *gitSHA = [infoDict objectForKey:@"AMKGitCommitSHA"];
///         NSString *gitBranch = [infoDict objectForKey:@"AMKGitCommitBranch"];
///         NSString *gitCommitUser = [infoDict objectForKey:@"AMKGitCommitUser"];
///         NSString *gitCommitDate = [infoDict objectForKey:@"AMKGitCommitDate"];
