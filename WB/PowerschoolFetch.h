//
//  PowerschoolFetch.h
//  WB
//
//  Created by Owner on 4/28/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "UnderRightViewController.h"
@import Security;

@interface PowerschoolFetch : NSObject <UIAlertViewDelegate, UIActionSheetDelegate, UIWebViewDelegate>{
    BOOL loginFailed;
    BOOL switchedStudent;
    NSUserDefaults * ud;
}

-(void)attemptLogin;
-(void)fetchPowerSchoolDataAndShowHUD:(BOOL)showHUD;
-(id)initWithViewController:(UIViewController*)viewController;

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIViewController * viewController;
@property (nonatomic,strong) NSString *contentdtuf;
@property (nonatomic,strong) NSData *blah;
@property (nonatomic,strong) NSData *annblah;
@property (nonatomic,strong) NSData *gradesblah;
@property (nonatomic, strong) NSString *name;



@end
