//
//  ViewController.m
//  SuperHeroPedia
//
//  Created by Thomas Orten on 5/27/14.
//  Copyright (c) 2014 Orten, Thomas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *superheros;
@property (weak, nonatomic) IBOutlet UITableView *superHeroTableView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.superheros = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        [self.superHeroTableView reloadData];
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.superheros.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *superhero = [self.superheros objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySuperHeroCellID"];
    NSURL *imageUrl = [NSURL URLWithString:superhero[@"avatar_url"]];
    
    cell.textLabel.text = superhero[@"name"];
    cell.detailTextLabel.text = superhero[@"description"];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0;
}

@end
