//
//  InitialSlidingViewController.m
//  WB
//
//  Created by Owner on 5/2/14.
//  Copyright (c) 2014 Fares. All rights reserved.
#import "InitialSlidingViewController.h"

@implementation InitialSlidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.shouldAdjustChildViewHeightForStatusBar = YES;
        self.statusBarBackgroundView.backgroundColor = [UIColor blackColor];
    }
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    
    self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"Home"];
    self.shouldAddPanGestureRecognizerToTopViewSnapshot = YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
