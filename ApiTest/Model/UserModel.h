//
//  ModelUser.h
//  ApiTest
//
//  Created by mbp on 09/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

@property (strong, nonatomic) NSString* name;
@property(assign,nonatomic) NSInteger userID;

- (instancetype)initWithDictionary: (NSDictionary*) dictionary;


@end

NS_ASSUME_NONNULL_END
