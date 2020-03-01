#include "LayoutListController.h"
//#import "PSSpecifier.h"

@implementation LayoutListController

HBPreferences *preferences;

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Layout" target:self];
		NSArray *chosenLabels = @[@"numberOfRowsColumns", @"customLayoutRows", @"customLayoutColumns", @"setFolderIconSize"];
		self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
	}
	

	[[UISwitch appearanceWhenContainedInInstancesOfClasses:@[[LayoutListController class]]] setOnTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	[[UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[[LayoutListController class]]] setTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];
		preferences = [[HBPreferences alloc]initWithIdentifier:@"com.thomz.foldyprefs"];
		BOOL enableCustomPremadeLayout = [preferences boolForKey:@"enableCustomPremadeLayout"];
		BOOL enableCustomCustomLayout = [preferences boolForKey:@"enableCustomCustomLayout"];
		BOOL resizeFolderIcon = [preferences boolForKey:@"resizeFolderIcon"];

		if(enableCustomPremadeLayout == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"numberOfRowsColumns"]] animated:YES];
		} else if(enableCustomPremadeLayout == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"numberOfRowsColumns"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"numberOfRowsColumns"]] afterSpecifierID:@"Use Premade Layout" animated:YES];
		}

		if(enableCustomCustomLayout == NO){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] animated:YES];
		} else if(enableCustomCustomLayout == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customLayoutRows"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"customLayoutColumns"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] afterSpecifierID:@"Use Custom Layout" animated:YES];
		}

		if(resizeFolderIcon == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"setFolderIconSize"]] animated:YES];
		} else if(resizeFolderIcon == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"setFolderIconSize"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"setFolderIconSize"]] afterSpecifierID:@"Resize Folder Icon" animated:YES];
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
	BOOL enableCustomPremadeLayout = [preferences boolForKey:@"enableCustomPremadeLayout"];
	BOOL enableCustomCustomLayout = [preferences boolForKey:@"enableCustomCustomLayout"];
	BOOL resizeFolderIcon = [preferences boolForKey:@"resizeFolderIcon"];

	if(enableCustomPremadeLayout == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"numberOfRowsColumns"]] animated:YES];
	}

	if(enableCustomCustomLayout == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customLayoutRows"], self.mySavedSpecifiers[@"customLayoutColumns"]] animated:YES];
	}

	if(resizeFolderIcon == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"setFolderIconSize"]] animated:YES];
	}

}

@end


