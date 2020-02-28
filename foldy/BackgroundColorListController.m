#include "BackgroundColorListController.h"

@implementation BackgroundColorListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"backgroundColor" target:self];
		NSArray *chosenLabels = @[@"backgroundColor", @"customBackgroundColor", @"gradientBackgroundColor", @"customGradientBackgroundColor", @"verticalGradient", @"folderBackgroundColor", @"customFolderBackgroundColor", @"gradientFolderBackgroundColor", @"customGradientFolderBackgroundColor", @"verticalFolderGradient"];
		self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
	}
	

	[[UISwitch appearanceWhenContainedInInstancesOfClasses:@[[BackgroundColorListController class]]] setOnTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.foldyprefs"];
		BOOL backgroundColor = [preferences boolForKey:@"backgroundColor"];
		BOOL gradientBackgroundColor = [preferences boolForKey:@"gradientBackgroundColor"];
		BOOL folderBackgroundColor = [preferences boolForKey:@"folderBackgroundColor"];
		BOOL gradientFolderBackgroundColor = [preferences boolForKey:@"gradientFolderBackgroundColor"];

		if(backgroundColor == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBackgroundColor"]] animated:YES];
		} else if(backgroundColor == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customBackgroundColor"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBackgroundColor"]] afterSpecifierID:@"Use Solid Color" animated:YES];
		}

		if(gradientBackgroundColor == NO){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customGradientBackgroundColor"], self.mySavedSpecifiers[@"verticalGradient"]] animated:YES];
		} else if(gradientBackgroundColor == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customGradientBackgroundColor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"verticalGradient"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customGradientBackgroundColor"], self.mySavedSpecifiers[@"verticalGradient"]] afterSpecifierID:@"Use Gradient" animated:YES];
		}


		if(folderBackgroundColor == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFolderBackgroundColor"]] animated:YES];
		} else if(folderBackgroundColor == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customFolderBackgroundColor"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFolderBackgroundColor"]] afterSpecifierID:@"Use a Solid Color" animated:YES];
		}

		if(gradientFolderBackgroundColor == NO){
			[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customGradientFolderBackgroundColor"], self.mySavedSpecifiers[@"verticalFolderGradient"]] animated:YES];
		} else if(gradientFolderBackgroundColor == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"customGradientFolderBackgroundColor"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"verticalFolderGradient"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"customGradientFolderBackgroundColor"], self.mySavedSpecifiers[@"verticalFolderGradient"]] afterSpecifierID:@"Use a Gradient" animated:YES];
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

	HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.foldyprefs"];
	BOOL backgroundColor = [preferences boolForKey:@"backgroundColor"];
	BOOL gradientBackgroundColor = [preferences boolForKey:@"gradientBackgroundColor"];
	BOOL folderBackgroundColor = [preferences boolForKey:@"folderBackgroundColor"];
	BOOL gradientFolderBackgroundColor = [preferences boolForKey:@"gradientFolderBackgroundColor"];

	if(backgroundColor == NO){
        [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customBackgroundColor"]] animated:YES];
	}

	if(gradientBackgroundColor == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customGradientBackgroundColor"], self.mySavedSpecifiers[@"verticalGradient"]] animated:YES];
	}

	if(folderBackgroundColor == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customFolderBackgroundColor"]] animated:YES];
	}

	if(gradientFolderBackgroundColor == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"customGradientFolderBackgroundColor"], self.mySavedSpecifiers[@"verticalFolderGradient"]] animated:YES];
	}
}

@end