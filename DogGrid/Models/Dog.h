//
//  Dog.h
//  DogGrid
//
//  Created by Hugo Troche on 11/3/17.
//  Copyright © 2017 Hugo Troche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dog : NSObject

@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *pageURL;
@property (strong, nonatomic) NSString *previewURL;

+ (Dog *) unmarshall:(NSDictionary *) json;

@end
