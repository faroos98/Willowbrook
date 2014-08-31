//
//  facebookviewcontroller.h
//  WB
//
//  Created by Owner on 4/24/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"


@interface facebookviewcontroller : UIViewController <UIWebViewDelegate>
- (IBAction)btn1:(id)sender;

@property (strong, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)reload:(id)sender;

- (IBAction)forward:(id)sender;

- (IBAction)action:(id)sender;

@end
