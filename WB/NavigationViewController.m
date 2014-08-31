//
//  NavigationViewController.m
//  WB
//
//  Created by Owner on 4/26/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "NavigationViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UnderRightViewController.h"


@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
