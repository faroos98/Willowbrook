//
//  MenuViewController.m
//  WB
//
//  Created by Owner on 5/2/14.
//  Copyright (c) 2014 Fares. All rights reserved.

#import "MenuViewController.h"

@interface MenuViewController()
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *section1;
@property (nonatomic, strong) NSArray *section2;
@property (nonatomic, strong) NSArray *section3;
@property (nonatomic, strong) NSArray *section4;

@end

@implementation MenuViewController
@synthesize menuItems;
@synthesize section1 , section2 , section3 , section4;

- (void)awakeFromNib
{
    
    self.section1 = [NSArray arrayWithObjects:@"Grades" , @"Announcements" , @"Final Calculator" , nil];
    self.section2 = [NSArray arrayWithObjects:@"Athletics" , @"Info" , @"Staff Directory" , nil];
    self.section3 = [NSArray arrayWithObjects: @"Facebook" , @"Twitter" ,    nil];
    self.section4 = [NSArray arrayWithObjects: @"Home" ,  @"About" , nil];
    
    
    self.menuItems = [NSArray arrayWithObjects:self.section1, self.section2 , self.section3 , self.section4 , nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.slidingViewController setAnchorRightRevealAmount:240.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.menuItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) {
        return 3;
    }
    
    else if (sectionIndex == 1)  {
        return 3;
    }
    else  if (sectionIndex ==2) {
        
        return self.section3.count;
    }
    else    {
        
        return self.section4.count;
    }}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return @"Student Information";
    }
    else if (section ==1)   {
        
        return @"WillowBrook Information";
    }
    else if (section ==2) {
        
        return @"Social Media";
    }
    else {
        
        return @"Actions";
    }}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor lightTextColor];
    
    // if you have index/header text in your tableview change your index text color
    UITableViewHeaderFooterView *headerIndexText = (UITableViewHeaderFooterView *)view;
    [headerIndexText.textLabel setTextColor:[UIColor brownColor]];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    if (indexPath.section == 0) {
        
        if (indexPath.row ==0) {
            cell.Title.text = @"Grades";
            cell.image.image = [UIImage imageNamed:@"header-icon-home"];
            
        }
        else if (indexPath.row ==1) {
            
            cell.Title.text = @"Announcements";
            cell.image.image = [UIImage imageNamed:@"ann"];
            
        }
        
        else if (indexPath.row ==2){
            
            cell.Title.text = @"Final Calculator";
            cell.image.image = [UIImage imageNamed:@"calc"];
            
        }}
    
    else if (indexPath.section ==1)   {
        
        if (indexPath.row ==0) {
            cell.Title.text = @"Athletics";
            cell.image.image = [UIImage imageNamed:@"ath"];
            
        }
        else if (indexPath.row ==1) {
            
            cell.Title.text = @"Info";
            cell.image.image = [UIImage imageNamed:@"info"];
        }
        
        else if (indexPath.row ==2){
            
            cell.Title.text = @"Staff Directory";
            cell.image.image = [UIImage imageNamed:@"staff"];
            
        }}
    
    else if (indexPath.section ==2)   {
        
        if (indexPath.row ==0) {
            cell.Title.text = @"Facebook";
            cell.image.image = [UIImage imageNamed:@"facebook"];
            
        }
        else if (indexPath.row ==1) {
            
            cell.Title.text = @"Twitter";
            cell.image.image = [UIImage imageNamed:@"twitter"];
            
        }}
    
    else if (indexPath.section ==3)   {
        
        if (indexPath.row ==0) {
            cell.Title.text = @"Home";
            cell.image.image = [UIImage imageNamed:@"home"];
            
        }
        else if (indexPath.row ==1) {
            
            cell.Title.text = @"About";
            cell.image.image = [UIImage imageNamed:@"abt"];
            
        }}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *newTopViewController;
    
    
    if (indexPath.section == 0) {
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.section1 objectAtIndex:indexPath.row]];
        
        newTopViewController  = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else  if (indexPath.section ==1) {
        
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.section2 objectAtIndex:indexPath.row]];
        
        newTopViewController  = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
    }
    else  if (indexPath.section == 2) {
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.section3 objectAtIndex:indexPath.row]];
        newTopViewController  = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    }
    else if (indexPath.section == 3) {
        
        NSString *identifier = [NSString stringWithFormat:@"%@", [self.section4 objectAtIndex:indexPath.row]];
        
        newTopViewController  = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        
    }
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }];
}
@end
