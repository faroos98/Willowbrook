//
//  FirstTopViewController.h
//  WB
//
//  Created by Owner on 5/2/14.
//  Copyright (c) 2014 Fares. All rights reserved.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UnderRightViewController.h"
#import "MBProgressHUD.h"
#import "PowerschoolFetch.h"

@interface FirstTopViewController : UIViewController < MBProgressHUDDelegate ,UIAlertViewDelegate , UIActionSheetDelegate , UIWebViewDelegate> {
    MBProgressHUD *HUD;



}


@property (weak, nonatomic) IBOutlet UIButton *buttonlabel;


@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, strong) PowerschoolFetch * psFetcher;


@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIViewController * viewController;


@property (nonatomic,strong) NSUserDefaults *ud;






@end
