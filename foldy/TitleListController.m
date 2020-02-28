#include "TitleListController.h"

@implementation TitleListController

HBPreferences *preferences;

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"title" target:self];
		NSArray *chosenLabels = @[@"titleFontSize",@"hideTitle",@"boldTitle",@"titleTextAlignment",@"customTitleFontSize", @"customTextColor",@"colorBackgroundTitle",@"cornerRadiusBackgroundTitle"];
		self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
	}
	

	[[UISwitch appearanceWhenContainedInInstancesOfClasses:@[[TitleListController class]]] setOnTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[[TitleListController class]]] setTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	[[UISlider appearanceWhenContainedInInstancesOfClasses:@[[TitleListController class]]] setTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];
		preferences = [[HBPreferences alloc]initWithIdentifier:@"com.thomz.foldyprefs"];
		BOOL titleFontSize = [preferences boolForKey:@"titleFontSize"];
		BOOL enableTextColor = [preferences boolForKey:@"enableTextColor"];
		BOOL enableBackgroundTitle = [preferences boolForKey:@"enableBackgroundTitle"];

		if(titleFontSize == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
		} else if(titleFontSize == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customTitleFontSize"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] afterSpecifierID:@"Title Font Size" animated:YES];
		}

		if(enableTextColor == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTextColor"]] animated:YES];
		} else if(enableTextColor == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customTextColor"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTextColor"]] afterSpecifierID:@"Enable Text Color" animated:YES];
		}

		if(enableBackgroundTitle == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"colorBackgroundTitle"], self.mySavedSpecifiers[@"cornerRadiusBackgroundTitle"]] animated:YES];
		} else if(enableBackgroundTitle == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"colorBackgroundTitle"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"cornerRadiusBackgroundTitle"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"colorBackgroundTitle"], self.mySavedSpecifiers[@"cornerRadiusBackgroundTitle"]] afterSpecifierID:@"Add a Background to the Title" animated:YES];
		}

}

-(void)viewDidLoad {
	[super viewDidLoad];
	[self removeSegments];
}

-(void)reloadSpecifiers {
	[self removeSegments];
}

-(void)removeSegments {
	preferences = [[HBPreferences alloc]initWithIdentifier:@"com.thomz.foldyprefs"];
	BOOL titleFontSize = [preferences boolForKey:@"titleFontSize"];
	BOOL enableTextColor = [preferences boolForKey:@"enableTextColor"];
	BOOL enableBackgroundTitle = [preferences boolForKey:@"enableBackgroundTitle"];

	if(titleFontSize == NO){
        [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTitleFontSize"]] animated:YES];
    }

	if(enableTextColor == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customTextColor"]] animated:YES];
	}

	if(enableBackgroundTitle == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"colorBackgroundTitle"], self.mySavedSpecifiers[@"cornerRadiusBackgroundTitle"]] animated:YES];
	}
	
}

@end

