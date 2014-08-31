//
//  SwitchSem.m
//  WB
//
//  Created by Owner on 5/3/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "SwitchSem.h"
#import "GradesController.h"
#import "FPPopoverController.h"
#import "AppDelegate.h"

@interface SwitchSem ()

@end

@implementation SwitchSem {
    
    NSArray *aray;
}

@synthesize delegate=_delegate;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    aray = [NSArray arrayWithObjects:@"First Semester" , @"Second Semester" , nil];
    
    self.title = nil;    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return aray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSString *string = [NSString stringWithFormat:@"b"];
    
    string = [aray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = string;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row ==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"firstsemester" object:nil];
        
        if([self.delegate respondsToSelector:@selector(selectedTableRow:)])
        {
            [self.delegate selectedTableRow:indexPath.row];
        }}
    
    else if (indexPath.row ==1) {
        //ShowHUDwithTitle(@"Downloading...");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"secondsemester" object:nil];
        
        if([self.delegate respondsToSelector:@selector(selectedTableRow:)])
        {
            [self.delegate selectedTableRow:indexPath.row];
        }}}

@end
