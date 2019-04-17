//
//  PersonDetailInfoVC.m
//  ApiTest
//
//  Created by mbp on 21/02/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "ImageCache.h"
#import "PersonDetailInfoVC.h"
#import "AlbumsModel.h"
#import "PhotoCustomCell.h"
#import "PhotoModel.h"
#import "DataManager.h"

@interface PersonDetailInfoVC ()<UITableViewDataSource, UITableViewDelegate,PhotoCustomCellDelegate>

@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* albumsArray;
@property (strong, nonatomic) NSMutableArray* photoArray;


@end

@implementation PersonDetailInfoVC

-(void) loadMorePhotos {
    AlbumsModel* album = self.albumsArray.lastObject;
    if (album != nil) {
        [self.albumsArray removeLastObject];
        [[DataManager sharedInstance] getPhoto:album.albumID
                                     OnSuccess:^(NSArray * _Nonnull photos) {
                                         [self.photoArray addObjectsFromArray:photos];
                                         [self.tableView reloadData];
                                     } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                         
                                     }];
    }
}

-(void) downloadImage:(NSURL*) url  onSuccess:(void(^)(UIImage* data)) success  {

    NSString* key = [url absoluteString];
    UIImage* image =  [[ImageCache sharedInstance] getCachedImageForKey:key];

    if (image != nil) {
        success(image);
        return;
    }


    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(q, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        [[ImageCache sharedInstance] cacheImage:img forKey:key];
        dispatch_async(dispatch_get_main_queue(), ^{

            success(img);
        });
    });

}


-(void) loadView {
    [super loadView];
    
    self.albumsArray = [[NSMutableArray alloc] init];
    self.photoArray = [[NSMutableArray alloc] init];
    
    CGRect frame = self.view.bounds;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [tableView registerClass:PhotoCustomCell.self forCellReuseIdentifier:@"Cell"];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;

    [self.view addSubview:tableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataManager sharedInstance] getAlbums:self.userInfo.userID
                                  OnSuccess:^(NSArray * _Nonnull albums) {
                                      [self.albumsArray addObjectsFromArray:albums];
                                    [self loadMorePhotos];

                                  }
                                  onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
                                      
                                  }];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@", self.userInfo.name ];
    self.navigationItem.title = @"Person";

}
#pragma mark - UITableViewDataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.photoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCustomCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PhotoModel* photo = [self.photoArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text =[NSString stringWithFormat: @"%@", photo.photoTitle  ];
    
      cell.userAvatar.image = [UIImage imageNamed:@"plaseHolder"];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [indicator setCenter:cell.userAvatar.center];
    [cell.userAvatar addSubview:indicator];
    
    [self downloadImage:photo.photoURL onSuccess:^(UIImage *data) {
        cell.userAvatar.image = data;
        [indicator stopAnimating];
    }];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    cell.delegate = self;
    
    if (indexPath.row == [self.photoArray count] - 1) {
        [self loadMorePhotos];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
