//
//  AboutViewController.h
//  WB
//
//  Created by Owner on 4/24/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"


@interface AboutViewController : UIViewController <MFMailComposeViewControllerDelegate , UITableViewDataSource , UITableViewDelegate>

- (IBAction)btn88:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedcontrol;

- (IBAction)indexchanged:(id)sender;



@end
