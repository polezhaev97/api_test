//
//  PhotoCustomCell.h
//  ApiTest
//
//  Created by mbp on 10/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoCustomCellDelegate <NSObject>

@end

@interface PhotoCustomCell : UITableViewCell

@property(weak,nonatomic) id <PhotoCustomCellDelegate> delegate;
@property(strong, nonatomic) UIImageView* userAvatar;
@property(strong, nonatomic) UILabel* titleLabel;

@end

NS_ASSUME_NONNULL_END
