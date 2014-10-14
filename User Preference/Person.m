//
//  Person.m
//  List Persist
//
//  Created by Dr Vanessa Paugh on 9/29/14.
//  Copyright (c) 2014 Dr Vanessa Paugh. All rights reserved.
//

#import "Person.h"

static NSString *kUserNameKey = @"IADNameString";
static NSString *kPassCodeKey = @"IADCodeFloat";
static NSString *kUserStepperKey = @"IADStepperInteger";
static NSString *kUserSwitchKey = @"IADSwitchBool";
static NSString *kSegmentColorKey = @"IADSegmentColor";

@implementation Person
- (instancetype)initWithDefaults:(NSUserDefaults *)defaults
{
    if (self = [super init]) {
        self.userDefaults = defaults;
        return self;
    } else {
        return nil;
    }
}

- (NSString *)nameString
{
    if (_nameString == nil) {
        _nameString = @"Enter Name";
    }
        return _nameString;
}

- (void)saveDataToUserDefaults
{
    [self.userDefaults setObject:self.nameString forKey:kUserNameKey];
    [self.userDefaults setFloat:self.numberFloat forKey:kPassCodeKey];
    [self.userDefaults setInteger:self.stepperInteger forKey:kUserStepperKey];
    [self.userDefaults setBool:self.switchBool forKey:kUserSwitchKey];
	[self.userDefaults setObject:self.segmentString forKey:kSegmentColorKey];
}

- (void)loadDataFromUserDefaults
{
    self.nameString = [self.userDefaults stringForKey:kUserNameKey];
    self.numberFloat = [self.userDefaults floatForKey:kPassCodeKey];
    self.stepperInteger = [self.userDefaults integerForKey:kUserStepperKey];
    self.switchBool = [self.userDefaults boolForKey:kUserSwitchKey];
	self.segmentString = [self.userDefaults stringForKey:kSegmentColorKey];
	NSLog(@"name: %@", self.nameString);
    NSLog(@"key: %@", self.segmentString);
}

@end
