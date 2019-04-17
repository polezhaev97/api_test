//
//  PhotoModel.h
//  ApiTest
//
//  Created by mbp on 10/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoModel : NSObject

@property(assign,nonatomic) NSInteger photoID;
@property(strong,nonatomic) NSString* photoTitle;
@property(strong,nonatomic) NSURL* photoURL;


- (instancetype)initWithDictionary: (NSDictionary*) dictionary;

@end

NS_ASSUME_NONNULL_END
