//
//  DataManager.m
//  ApiTest
//
//  Created by mbp on 11/04/2019.
//  Copyright © 2019 mbp. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

-(void) getUsersOnSuccess:(void(^)(NSArray* users)) success
                onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
    NSString *targetUrl = @"https://jsonplaceholder.typicode.com/users";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          NSError *errorJson= nil;
          NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson ];
          NSLog(@"Data received: %@", json);
          
          
          NSMutableArray* users = [[NSMutableArray alloc] init];
          
          for (NSDictionary* dictionary in json){
              
              UserModel* userInfo = [[UserModel alloc] initWithDictionary:dictionary];
              
              [users addObject:userInfo];
              
          }
          dispatch_async(dispatch_get_main_queue(), ^{
              success (users);
          });
          
      }] resume];
}


-(void) getAlbums:(NSInteger) usersID
        OnSuccess:(void(^)(NSArray* albums)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSString *targetUrl = [NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/albums?userId=%ld", usersID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          NSError *errorJson= nil;
          NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson ];
          NSLog(@"Data received: %@", json);
          
          NSMutableArray* albums = [[NSMutableArray alloc] init];
          
          for (NSDictionary* dictionary in json){
              
              AlbumsModel* album = [[AlbumsModel alloc] initWithDictionary:dictionary];
              
              [albums addObject:album];
          }
          dispatch_async(dispatch_get_main_queue(), ^{
              success (albums);
          });
          
      }] resume];
}

-(void) getPhoto: (NSInteger) albumId
       OnSuccess:(void(^)(NSArray* photos)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
    NSString *targetUrl =  [NSString stringWithFormat:@"https://jsonplaceholder.typicode.com/photos?albumId=%ld", albumId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:targetUrl]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          NSError *errorJson= nil;
          NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson ];
          NSLog(@"Data received: %@", json);
          
          NSMutableArray* photos = [[NSMutableArray alloc] init];
          
          for (NSDictionary* dictionary in json){
              
              PhotoModel* photo = [[PhotoModel alloc] initWithDictionary:dictionary];
              
              [photos addObject:photo];
              
          }
          dispatch_async(dispatch_get_main_queue(), ^{
              success (photos);
          });
          
      }] resume];
}

@end
