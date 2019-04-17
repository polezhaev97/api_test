//
//  DataManager.h
//  ApiTest
//
//  Created by mbp on 11/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "AlbumsModel.h"
#import "PhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

+ (instancetype)sharedInstance;

-(void) getUsersOnSuccess:(void(^)(NSArray* users)) success
                onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

-(void) getAlbums:(NSInteger) usersID
        OnSuccess:(void(^)(NSArray* albums)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

-(void) getPhoto: (NSInteger) albumId
       OnSuccess:(void(^)(NSArray* photos)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


@end

NS_ASSUME_NONNULL_END
