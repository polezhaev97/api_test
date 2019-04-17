//
//  PhotoModel.m
//  ApiTest
//
//  Created by mbp on 10/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel

- (instancetype)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    if (self) {
        
        self.photoID = [[dictionary valueForKeyPath:@"id"] integerValue];
        self.photoTitle = [dictionary objectForKey:@"title"];
        NSString* stringURL = [dictionary objectForKey:@"url"];
        self.photoURL = [[NSURL alloc] initWithString:stringURL];
    }
    return self;
}

@end
