//
//  StaffDetailsController.m
//  WB
//
//  Created by Owner on 4/26/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "StaffDetailsController.h"

@interface StaffDetailsController ()

@end

@implementation StaffDetailsController

@synthesize detaillabelcont , detailDescriptionLabel;
@synthesize numberlabel , numbestring;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    detailDescriptionLabel.text = detaillabelcont;
    
    numberlabel.text = numbestring;
    
    NSLog(@"%@" , numbestring );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)return:(id)sender {
}
- (IBAction)call:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
														message:[NSString stringWithFormat: @"%@" , numbestring]
													   delegate:self cancelButtonTitle:@"Cancel"
											  otherButtonTitles: @"Call" , nil];
    [alertView setTag:1];
	[alertView show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSString *search = [numbestring stringByReplacingOccurrencesOfString:@"+1" withString:@""];
    
    NSString *search2 =[search stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *final = [search2 stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSString *numbertocall = [NSString stringWithFormat:@"tel:%@" , final];
    
    if (alertView.tag == 01 && buttonIndex != alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numbertocall]];
        
    }
}

@end
