//
//  ModelAlbums.h
//  ApiTest
//
//  Created by mbp on 10/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlbumsModel : NSObject

@property(assign,nonatomic) NSInteger albumID;

- (instancetype)initWithDictionary: (NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END
