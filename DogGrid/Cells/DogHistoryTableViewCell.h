//
//  DogHistoryTableViewCell.h
//  DogGrid
//
//  Created by Hugo Troche on 11/3/17.
//  Copyright © 2017 Hugo Troche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DogHistoryTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dogPageURL;
@property (strong, nonatomic) IBOutlet UIImageView *dogPreviewImage;

@end
