//
//  InfoTableController.m
//  WB
//
//  Created by Owner on 4/24/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "InfoTableController.h"
#import "InfoCellController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface InfoTableController ()

@end

@implementation InfoTableController


@synthesize Title1 , Number1 , About1;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    Title1 = @[@"All Day Abscences",
               @"WillowBrook",
               @"WillowBrook",
               @"Anti-bullying Hotline",
               @"Directions",];
    
    About1 = @[@"24 Hour Attendance Line",
               @"Office Phone",
               @"Deans Office",
               @"Call ASAP",
               @"Willowbrook High School"];
    
    Number1 = @[@"(630) 530-3428" ,
                @"(630) 530-3400" ,
                @"(630) 530-3418",
                @"(630) 782-2801",
                @"1250 South Ardmore Avenue Villa Park, Illinois 60181"];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.Number1.count;
}

-(void)callnumber {
    
    NSString *mysring;
    
    mysring = [NSString stringWithFormat:@"tel:%@" , Number1];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mysring]];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InfoCell";
    
    
    InfoCellController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSInteger row = [indexPath row];
    
    cell.Title.text = Title1[row];
    cell.About.text = About1[row];
    cell.Number.text = Number1 [row];
    
    if (indexPath.row ==4){
        
        cell.Title.font = [UIFont systemFontOfSize:25.0];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0){
        
        
        //Display a quick alert view to show that this cell was pressed
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[NSString stringWithFormat: @"(630) 530-3428"]
                                                           delegate:self cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles: @"Call" , nil];
        
        [alertView setTag:1];
        [alertView show];
        
    }
    else if (indexPath.row ==1){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[NSString stringWithFormat: @"(630) 530-3400"]
                                                           delegate:self cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles: @"Call" , nil];
        
        [alertView setTag:2];
        [alertView show];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    
    else if (indexPath.row ==2){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[NSString stringWithFormat: @"(630) 530-3418"]
                                                           delegate:self cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles: @"Call" , nil];
        
        [alertView setTag:3];
        [alertView show];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    
    else if (indexPath.row ==3) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                            message:[NSString stringWithFormat: @"(630) 782-2801"]
                                                           delegate:self cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles: @"Call" , nil];
        
        [alertView setTag:4];
        [alertView show];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    else if (indexPath.row ==4) {
        
        NSURL *url = [NSURL URLWithString:@"https://www.google.com/maps/place/1250+S+Ardmore+Ave/@41.8644586,-87.9827277,17z/data=!3m1!4b1!4m2!3m1!1s0x880e4d073abfb2a7:0xa46aa8c577438bd3"];
        [[UIApplication sharedApplication] openURL:url];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 01 && buttonIndex != alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(630)530-3428"]];
    }
    else if (
             alertView.tag == 02 && buttonIndex != alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(630)530-3400"]];
        
    }
    else if (
             alertView.tag == 03 && buttonIndex != alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(630)530-3418"]];
        
    }
    else if (
             alertView.tag == 04 && buttonIndex != alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://(630)782-2801"]];
        
    }
    
}

- (IBAction)btn4444:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}
@end
