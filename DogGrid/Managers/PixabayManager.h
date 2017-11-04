//
//  PixabayManager.h
//  DogGrid
//
//  Created by Hugo Troche on 11/3/17.
//  Copyright © 2017 Hugo Troche. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ DogsFetchSuccess)(NSArray *);
typedef void (^ DogsFetchError)(NSError *);

@interface PixabayManager : NSObject

@property (strong, nonatomic) NSMutableArray *history;

+ (PixabayManager *) instance;
- (void) fetchDogs:(int) page success:(DogsFetchSuccess) success error:(DogsFetchError) error;

@end
