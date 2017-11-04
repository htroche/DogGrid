//
//  Dog.m
//  DogGrid
//
//  Created by Hugo Troche on 11/3/17.
//  Copyright © 2017 Hugo Troche. All rights reserved.
//

#import "Dog.h"

@implementation Dog

+ (Dog *) unmarshall:(NSDictionary *) json {
    Dog* d = [[Dog alloc] init];
    d.imageURL = json[@"webformatURL"];
    d.pageURL = json[@"pageURL"];
    d.previewURL = json[@"previewURL"];
    return d;
}

@end
