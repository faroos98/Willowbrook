//
//  SecondTopViewController.m
//  WB
//
//  Created by Owner on 5/2/14.
//  Copyright (c) 2014 Fares. All rights reserved.

#import "SecondTopViewController.h"

@implementation SecondTopViewController

@synthesize webview;


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    self.slidingViewController.underRightViewController = nil;
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    self.slidingViewController.topViewCenterMoved = ^(float x){
    };
    
    NSString *strURL = @"https://twitter.com/WillowbrookHS1";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:urlRequest];
    
    [[self webview] setDelegate:self];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES
     ];
}


- (IBAction)revealMenu1:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)reload:(id)sender {
    [webview reload];
}

- (IBAction)back:(id)sender {
    
    [self.webview goBack];
}

- (IBAction)forward:(id)sender {
    [self.webview goForward];
}

@end
