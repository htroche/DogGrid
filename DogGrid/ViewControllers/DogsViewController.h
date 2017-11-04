//
//  DogsViewController.h
//  DogGrid
//
//  Created by Hugo Troche on 11/3/17.
//  Copyright © 2017 Hugo Troche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DogsViewController : UIViewController <UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *dogsCollection;

- (IBAction) fetchDogs;
- (IBAction) clearHistory;

@end
