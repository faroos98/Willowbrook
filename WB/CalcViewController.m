//
//  CalcViewController.m
//  WB
//
//  Created by Owner on 5/8/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "CalcViewController.h"
#import "FPPopoverView.h"
#import "FPPopoverController.h"
#import "FPTouchView.h"


@interface CalcViewController ()

@end

@implementation CalcViewController

@synthesize Goal , Current;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *taprec = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    
    [self.view addGestureRecognizer:taprec];
    
    UIBarButtonItem *Menubtn = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(backthru)];
    self.navigationItem.leftBarButtonItem = Menubtn;

}

-(void)backthru{
    [self.slidingViewController anchorTopViewTo:ECRight];
    
    
}

-(void)tap:(UIGestureRecognizer *)gr {
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (IBAction)Calcualte:(id)sender {
    
    float q = ([Current.text floatValue]);
    
    float w = 0.8;
    
    float e = .20;
    
    float score = [Goal.text floatValue];
    
    
    float step1 = (w *q);
    
    
    float step2 = (score - step1);
    
    float step3 = (step2 / e);
    
    
    [self.Goal resignFirstResponder];
    [self.Current resignFirstResponder];
    
    
    NSString *finalgrade = [NSString stringWithFormat:@"%0.02f" , step3];
    
    
    NSString *alertfinal = [NSString stringWithFormat:@"You need to score atleast %@%% on the final exam" , finalgrade];
    
    _alert = [[UIAlertView alloc]initWithTitle:@"Alert"
                                       message:alertfinal  delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    
    
    _alert2 = [[UIAlertView alloc]initWithTitle:@"Alert"
                                        message:@"Please input values"  delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    
    
    if ([self.Current.text  isEqual: @""]) {
        
        [_alert2 show];
        
    }
    
    else {
        
        [_alert show];
        
    }
    
    
    if ([_alert buttonTitleAtIndex:0]) {
        
        self.Current.text = @"";
        self.Goal.text = @"";
        
        
    }}
@end
