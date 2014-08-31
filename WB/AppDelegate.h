//
//  AppDelegate.h
//  WB
//
//  Created by Owner on 4/24/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTopViewController.h"

@interface AppDelegate :   UIResponder <UIApplicationDelegate , NSObject> {
    
    MBProgressHUD *HUD;
}


@property (strong, nonatomic) UIWindow *window;




@property (nonatomic, strong) FirstTopViewController * psFetcher;

+ (MBProgressHUD *)showGlobalProgressHUD;
+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
+ (void)dismissGlobalHUD;





@end
