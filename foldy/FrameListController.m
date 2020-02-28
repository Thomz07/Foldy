#include "FrameListController.h"

@implementation FrameListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Frame" target:self];
		NSArray *chosenLabels = @[@"completelyCustomFrameLeft",@"completelyCustomFrameTop",@"completelyCustomFrameWidth",@"completelyCustomFrameHeight", @"centeredCustomFrameWidth", @"centeredCustomFrameHeight"];
		self.mySavedSpecifiers = (!self.mySavedSpecifiers) ? [[NSMutableDictionary alloc] init] : self.mySavedSpecifiers;
		for(PSSpecifier *specifier in [self specifiers]) {
			if([chosenLabels containsObject:[specifier propertyForKey:@"key"]]) {
			[self.mySavedSpecifiers setObject:specifier forKey:[specifier propertyForKey:@"key"]];
			}
		}
	}
	

	[[UISwitch appearanceWhenContainedInInstancesOfClasses:@[[FrameListController class]]] setOnTintColor:[UIColor colorWithRed:0.32 green:0.91 blue:0.71 alpha:1.0]];
	return _specifiers;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier {
		[super setPreferenceValue:value specifier:specifier];

		HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.foldyprefs"];
		BOOL completelyCustomFrame = [preferences boolForKey:@"completelyCustomFrame"];
		BOOL centeredCustomFrame = [preferences boolForKey:@"centeredCustomFrame"];

		if(completelyCustomFrame == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"completelyCustomFrameLeft"], self.mySavedSpecifiers[@"completelyCustomFrameTop"], self.mySavedSpecifiers[@"completelyCustomFrameWidth"], self.mySavedSpecifiers[@"completelyCustomFrameHeight"]] animated:YES];
		} else if(completelyCustomFrame == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"completelyCustomFrameLeft"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"completelyCustomFrameTop"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"completelyCustomFrameWidth"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"completelyCustomFrameHeight"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"completelyCustomFrameLeft"], self.mySavedSpecifiers[@"completelyCustomFrameTop"], self.mySavedSpecifiers[@"completelyCustomFrameWidth"], self.mySavedSpecifiers[@"completelyCustomFrameHeight"]] afterSpecifierID:@"Completely Custom Frame" animated:YES];
		}

		if(centeredCustomFrame == NO){
         [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"centeredCustomFrameWidth"], self.mySavedSpecifiers[@"centeredCustomFrameHeight"]] animated:YES];
		} else if(centeredCustomFrame == YES && ![self containsSpecifier:self.mySavedSpecifiers[@"centeredCustomFrameWidth"]] && ![self containsSpecifier:self.mySavedSpecifiers[@"centeredCustomFrameHeight"]]) {
			[self insertContiguousSpecifiers:@[self.mySavedSpecifiers[@"centeredCustomFrameWidth"], self.mySavedSpecifiers[@"centeredCustomFrameHeight"]] afterSpecifierID:@"Centered Custom Frame" animated:YES];
		}
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self removeSegments];

}

-(void)reloadSpecifiers{
    [self removeSegments];
}

-(void)removeSegments {

    HBPreferences *preferences = [[HBPreferences alloc] initWithIdentifier:@"com.thomz.foldyprefs"];
    BOOL completelyCustomFrame = [preferences boolForKey:@"completelyCustomFrame"];
	BOOL centeredCustomFrame = [preferences boolForKey:@"centeredCustomFrame"];

    if(completelyCustomFrame == NO){
        [self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"completelyCustomFrameLeft"], self.mySavedSpecifiers[@"completelyCustomFrameTop"], self.mySavedSpecifiers[@"completelyCustomFrameWidth"], self.mySavedSpecifiers[@"completelyCustomFrameHeight"]] animated:YES];
    }

	if(centeredCustomFrame == NO){
		[self removeContiguousSpecifiers:@[self.mySavedSpecifiers[@"centeredCustomFrameWidth"], self.mySavedSpecifiers[@"centeredCustomFrameHeight"]] animated:YES];
	}

}
@end