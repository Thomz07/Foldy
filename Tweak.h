#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface SBFloatyFolderView : UIView
@end

@interface SBIconListPageControl : UIView
@end

@interface SBFolderBackgroundView : UIView
@end

@interface SBFolderTitleTextField : UILabel
@end

@interface _SBIconGridWrapperView : UIView
@end

@interface SBIconListGridLayoutConfiguration : UIView
@property (nonatomic, assign) BOOL viewIsAFolder;
-(BOOL)detectFolders;
@end

@interface SBIconController : UIViewController
@end