#include "PLPRootListController.h"

@implementation PLPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
		NSArray *chosenLabels = @[@"customCornerRadius", @"customBackgroundAlpha",];
		self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
	}
	}

	[[UISwitch appearanceWhenContainedInInstancesOfClasses:@[[PLPRootListController class]]] setOnTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	[[UISlider appearanceWhenContainedInInstancesOfClasses:@[[PLPRootListController class]]] setTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	[[UIImageView appearanceWhenContainedInInstancesOfClasses:@[[PLPRootListController class]]] setTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];

	HBPreferences *preferences = [[HBPreferences alloc]initWithIdentifier:@"com.thomz.foldyprefs"];

	self.navigationItem.titleView = [UIView new];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"Foldy";
		self.titleLabel.alpha = 0.0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navigationItem.titleView addSubview:self.titleLabel];

        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,10,10)];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/Foldy.bundle/icon@2x.png"];
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.iconView.alpha = 1.0;
        [self.navigationItem.titleView addSubview:self.iconView];

		[NSLayoutConstraint activateConstraints:@[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
            [self.iconView.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
        ]];

	
	UISwitch *toggleSwitch =
            [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
        [toggleSwitch setOn:[preferences boolForKey:@"isEnabled"] animated:YES];
        [toggleSwitch addTarget:self
                         action:@selector(switchToggled:)
               forControlEvents:UIControlEventTouchUpInside];

		[toggleSwitch setOnTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];

        self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithCustomView:toggleSwitch];

	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.foldyprefs"];
		BOOL cornerRadius = [preferences boolForKey:@"cornerRadius"];
		BOOL backgroundAlpha = [preferences boolForKey:@"backgroundAlpha"];

		if(cornerRadius == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customCornerRadius"]] animated:YES];
		} else if(cornerRadius == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customCornerRadius"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customCornerRadius"]] afterSpecifierID:@"Corner Radius" animated:YES];
		}

		if(backgroundAlpha == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBackgroundAlpha"]] animated:YES];
		} else if(backgroundAlpha == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customBackgroundAlpha"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBackgroundAlpha"]] afterSpecifierID:@"Background Alpha" animated:YES];
		}

}

-(void)viewDidLoad {
		[super viewDidLoad];
		[self removeSegments];
}

-(void)resetPrefs {

	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.foldyprefs"];
	[preferences removeAllObjects];
	[self reloadSpecifiers];
	[self respring];
}

-(void)reloadSpecifiers {
	[self removeSegments];
}


-(void)removeSegments {

		HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.foldyprefs"];
		BOOL cornerRadius = [preferences boolForKey:@"cornerRadius"];
		BOOL backgroundAlpha = [preferences boolForKey:@"backgroundAlpha"];

		if(cornerRadius == NO){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customCornerRadius"]] animated:YES];
		}

		if(backgroundAlpha == NO){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBackgroundAlpha"]] animated:YES];
		}
}

- (void)switchToggled:(id)sender {
    UISwitch *toggleSwitch = (UISwitch *)sender;

	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.foldyprefs"];

    // if you need a BOOL
    BOOL switchToggled = [toggleSwitch isOn];
	if(switchToggled){
		[preferences setBool:YES forKey:@"isEnabled"];
	} else {
		[preferences setBool:NO forKey:@"isEnabled"];
	}
	
}

-(void)respring {
	NSTask *t = [[NSTask alloc] init];
	[t setLaunchPath:@"/usr/bin/killall"];
	[t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
	[t launch];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 125) {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 0.0;
            self.titleLabel.alpha = 1.0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 0.0;
        }];
    }
}


@end
