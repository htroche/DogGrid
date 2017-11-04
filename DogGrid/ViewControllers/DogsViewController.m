//
//  DogsViewController.m
//  DogGrid
//
//  Created by Hugo Troche on 11/3/17.
//  Copyright © 2017 Hugo Troche. All rights reserved.
//

#import "DogsViewController.h"
#import "PixabayManager.h"
#import "DogCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import "Dog.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface DogsViewController () {
    NSArray *dogs;
}

@property int page;

- (void) loadDogs:(int) page;

@end

@implementation DogsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Don't reload the screen between going to history screen and back
    if(dogs != nil && [dogs count] > 0) {
        return;
    }
    [self fetchDogs];
}

- (void) loadDogs:(int) page {
    [[PixabayManager instance] fetchDogs:self.page success:^(NSArray *fetchedDogs) {
        dogs = fetchedDogs;
        [self reloadDogs];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self errorDetected]; //This also shows if we have iterated thru all pages of data as a HTTP Code 400 error
        });
    }];
}


- (void)errorDetected
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Ooops!"
                                 message:@"No more doggies to see :("
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    

    
    [alert addAction:okButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) reloadDogs {
    [self.dogsCollection reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Button actions

- (IBAction) fetchDogs {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadDogs:self.page];
    self.page++;
}

- (IBAction) clearHistory {
    self.page = 1;
    [[PixabayManager instance].history removeAllObjects];
    [self loadDogs:self.page];
}


#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(dogs == nil) {
        return 0;
    }
    return [dogs count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DogCollectionViewCell *cell = (DogCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"DocCollectionViewCell" forIndexPath:indexPath];
    Dog *dog = [dogs objectAtIndex:indexPath.row];
    //Images get cached with the category SDWebImage
    [cell.dogImage sd_setShowActivityIndicatorView:YES];
    [cell.dogImage sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.dogImage sd_setImageWithURL:[NSURL URLWithString:dog.imageURL]];
    return cell;
}

@end
