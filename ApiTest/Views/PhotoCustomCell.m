//
//  PhotoCustomCell.m
//  ApiTest
//
//  Created by mbp on 10/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "PhotoCustomCell.h"

@implementation PhotoCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

-(void) initView{
    
    self.userAvatar = [[UIImageView alloc]init];
    self.userAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.titleLabel =[[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.userAvatar];

    
    self.titleLabel.numberOfLines=0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.userAvatar.layer.masksToBounds = YES;
    self.userAvatar.layer.cornerRadius = 10 ;
    
    [self applyConstraints];
}

-(void)applyConstraints {
    NSDictionary* views = @{
                            @"avatar" : self.userAvatar,
                            @"text" : self.titleLabel,
                            };
    
    NSArray* constraints =[[NSArray alloc] initWithObjects:
                           @"H:|-[avatar]-|",
                           @"H:|-[text]-|",
                           @"V:|-[avatar]-[text]-|"
                           ,nil];
    
    NSMutableArray* layoutConstraint = [[NSMutableArray alloc] init];
    
    for (NSString* constraint in constraints) {
        NSArray* c = [NSLayoutConstraint constraintsWithVisualFormat:constraint options:0 metrics:nil views:views];
        [layoutConstraint addObjectsFromArray:c];
    }
    [NSLayoutConstraint activateConstraints:layoutConstraint];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    self.titleLabel.preferredMaxLayoutWidth = self.titleLabel.frame.size.width;
}

@end
