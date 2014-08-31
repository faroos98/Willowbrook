//
//  SecondTopViewController.h
//  WB
//
//  Created by Owner on 5/2/14.
//  Copyright (c) 2014 Fares. All rights reserved.

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface SecondTopViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webview;

- (IBAction)revealMenu1:(id)sender;

- (IBAction)reload:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)forward:(id)sender;


@end
