//
//  PixabayManager.m
//  DogGrid
//
//  Created by Hugo Troche on 11/3/17.
//  Copyright © 2017 Hugo Troche. All rights reserved.
//

#import "PixabayManager.h"
#import <AFNetworking/AFNetworking.h>
#import "Dog.h"

#define API_KEY @"6927070-5d0124fc85c612292e7a9c005"
#define RESULTS_NUM 20
#define QUERY @"dog"

static PixabayManager *manager;

@implementation PixabayManager

+ (PixabayManager *) instance {
    if(manager != nil) {
        return manager;
    }
    manager = [[PixabayManager alloc] init];
    manager.history = [NSMutableArray array];
    return manager;
}

- (void) fetchDogs:(int) page success:(DogsFetchSuccess) success error:(DogsFetchError) err {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://pixabay.com/api/?" parameters:@{ @"key": API_KEY, @"page": [NSNumber numberWithInt:page], @"per_page":@RESULTS_NUM, @"q": QUERY, @"image_type":@"photo"} progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSMutableArray* dogs = [NSMutableArray array];
        for (NSDictionary *d in responseObject[@"hits"]) {
            [dogs addObject:[Dog unmarshall:d]];
        }
        [self.history addObjectsFromArray:dogs];
        success(dogs);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        err(error);
    }];
}

@end
