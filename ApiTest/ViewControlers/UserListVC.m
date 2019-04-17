//
//  ViewController.m
//  ApiTest
//
//  Created by mbp on 21/02/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "UserListVC.h"
#import "PersonDetailInfoVC.h"
#import "UserModel.h"
#import "DataManager.h"

@interface UserListVC ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray* usersArray;

@end

@implementation UserListVC

-(void) loadView {
    [super loadView];
    
    CGRect frame = self.view.bounds;
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.tableFooterView = [UIView new];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    self.navigationItem.title = @"Person";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataManager sharedInstance] getUsersOnSuccess:^(NSArray * _Nonnull users) {
        self.usersArray = users;
        [self.tableView reloadData];
        
    } onFailure:^(NSError * _Nonnull error, NSInteger statusCode) {
        
    }];
    
}

#pragma mark - UITableViewDataSourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.usersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    UserModel* user = [self.usersArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", user.name];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UserModel* contents = [self.usersArray objectAtIndex:indexPath.row];
    
    PersonDetailInfoVC* personVc = [[PersonDetailInfoVC alloc] init];
    personVc.userInfo = contents;
    
    [self.navigationController pushViewController:personVc animated:YES];
}

@end
