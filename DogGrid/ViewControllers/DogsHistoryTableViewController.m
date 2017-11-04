//
//  DogsHistoryTableViewController.m
//  DogGrid
//
//  Created by Hugo Troche on 11/3/17.
//  Copyright © 2017 Hugo Troche. All rights reserved.
//

#import "DogsHistoryTableViewController.h"
#import "PixabayManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIView+WebCache.h>
#import "Dog.h"
#import "DogHistoryTableViewCell.h"

@interface DogsHistoryTableViewController ()

@end

@implementation DogsHistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([PixabayManager instance].history == nil) {
        return 0;
    }
    return [[PixabayManager instance].history count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DogHistoryTableViewCell *cell = (DogHistoryTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"DogHistoryTableCell" forIndexPath:indexPath];
    Dog *dog = [[PixabayManager instance].history objectAtIndex:indexPath.row];
    cell.dogPageURL.text = dog.pageURL;
    //Images get cached with the category SDWebImage
    [cell.dogPreviewImage sd_setShowActivityIndicatorView:YES];
    [cell.dogPreviewImage sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.dogPreviewImage sd_setImageWithURL:[NSURL URLWithString:dog.previewURL]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Dog *dog = [[PixabayManager instance].history objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:dog.pageURL];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
