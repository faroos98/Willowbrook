//
//  AboutViewController.m
//  WB
//
//  Created by Owner on 4/24/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "AboutViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import <MessageUI/MessageUI.h>
#import "AboutCell.h"

@interface AboutViewController ()

@property (nonatomic, strong) NSArray *aray1;
@property (nonatomic, strong) NSArray *aray2;

@end

@implementation AboutViewController {
    BOOL index;
}

@synthesize aray1 , aray2;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    aray1 = [NSArray arrayWithObjects:@"Phone:" , @"Email:" , nil];
    aray2 = [NSArray arrayWithObjects:@"+1 (630) 796-1840" , @"WillowbrookAPP@gmail.com", nil];
    
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    if (index ==0) {
        self.segmentedcontrol.selectedSegmentIndex = 0;
        
    }
    
    else if (index ==1){
        self.segmentedcontrol.selectedSegmentIndex = 1;
    }
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"stored"];
    
    int value = [savedValue intValue];
    
    [self.segmentedcontrol setSelectedSegmentIndex:value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn88:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"AboutCell";
    AboutCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    NSString *string = [aray1 objectAtIndex:indexPath.row];
    NSString *string2 = [aray2 objectAtIndex:indexPath.row];
    
    cell.What.text = string;
    cell.way.text = string2;
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:6307961840"]];
    }
    else if (indexPath.row ==1) {
        NSString * subject = @"Suggestion ?";
        NSArray * recipients = [NSArray arrayWithObjects:@"willowbrookapp@gmail.com", nil];
        
        MFMailComposeViewController * composer = [[MFMailComposeViewController alloc] init];
        composer.mailComposeDelegate = self;
        [composer setSubject:subject];
        [composer setToRecipients:recipients];
        [self presentViewController:composer animated:YES completion:NULL];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled"); break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved"); break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent"); break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]); break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)indexchanged:(id)sender {
    
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    segmentedControl.selectedSegmentIndex = segmentedControl.selectedSegmentIndex;
    
    NSString *value = [NSString stringWithFormat:@"%ld" , (long)segmentedControl.selectedSegmentIndex];
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:@"stored"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@" , value);
    
}    @end
