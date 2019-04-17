//
//  ModelAlbums.m
//  ApiTest
//
//  Created by mbp on 10/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "AlbumsModel.h"

@implementation AlbumsModel

- (instancetype)initWithDictionary: (NSDictionary*) dictionary
{
    self = [super init];
    if (self) {
        
        self.albumID = [[dictionary valueForKeyPath:@"id"] integerValue];
        
    }
    return self;
}

@end
