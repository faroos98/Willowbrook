//
//  GradesDetailsTable.h
//  WB
//
//  Created by Owner on 4/28/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTopViewController.h"
#import "TFHpple.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface GradesDetailsTable : UITableViewController  {
}

@property (weak, nonatomic) IBOutlet UILabel *Percent;

@property (nonatomic ,strong) NSString *linktransfer;

@property (nonatomic , strong) NSString *percentstring;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) FirstTopViewController * psFetcher3;


@property (nonatomic,strong) NSMutableArray *namearay;
@property (nonatomic,strong) NSMutableArray *leteraray;
@property (nonatomic,strong) NSMutableArray *scorearay;
@property (nonatomic,strong) NSMutableArray *percentaray;
@property (nonatomic,strong) NSMutableArray *percentgradearay;



@property (nonatomic,strong) UIViewController *viewcontroller;

@property (nonatomic,strong) NSData *detaillink;

@property (nonatomic , strong) NSString *subjecttransfer;


@end
