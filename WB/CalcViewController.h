//
//  CalcViewController.h
//  WB
//
//  Created by Owner on 5/8/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverKeyboardResponsiveController.h"
#import "FirstTopViewController.h"


@interface CalcViewController : UIViewController  {
    
    FPPopoverKeyboardResponsiveController *popover;

}

@property (weak, nonatomic) IBOutlet UITextField *Current;

@property (weak, nonatomic) IBOutlet UITextField *Goal;

- (IBAction)Calcualte:(id)sender;



@property (nonatomic , strong) UIAlertView *alert;
@property (nonatomic , strong) UIAlertView *alert2;


@end
