//
//  Person.h
//  List Persist
//
//  Created by Dr Vanessa Paugh on 9/29/14.
//  Copyright (c) 2014 Dr Vanessa Paugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (weak, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSString *nameString;
@property (nonatomic) float numberFloat;
@property (nonatomic) NSInteger stepperInteger;
@property (nonatomic) BOOL switchBool;
@property (nonatomic) NSString* segmentString;

- (instancetype)initWithDefaults:(NSUserDefaults *)defaults;
- (void)saveDataToUserDefaults;
- (void)loadDataFromUserDefaults;
@end
