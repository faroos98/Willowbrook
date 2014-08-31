//
//  facebookviewcontroller.m
//  WB
//
//  Created by Owner on 4/24/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "facebookviewcontroller.h"
#import "ECSlidingViewController.h"


@interface facebookviewcontroller ()

@end

@implementation facebookviewcontroller
@synthesize webview;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    NSString *strURL = @"https://m.facebook.com/profile.php?v=timeline&filter=1&id=215426501869790";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:urlRequest];
    
    
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    
    [[self webview] setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES
     ];
}

- (IBAction)btn1:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}
- (IBAction)reload:(id)sender {
    [webview reload];
}

- (IBAction)forward:(id)sender {
    [self.webview goForward];
}
- (IBAction)action:(id)sender {
    [self.webview goBack];
}
@end
