//
//  ModelUser.m
//  ApiTest
//
//  Created by mbp on 09/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (instancetype)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    if (self) {
        
        self.name = [dictionary objectForKey:@"name"];
        self.userID = [[dictionary valueForKeyPath:@"id"] integerValue];
        
    }
    return self;
}


@end
