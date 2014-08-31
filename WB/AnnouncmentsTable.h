//
//  AnnouncmentsTable.h
//  WB
//
//  Created by Owner on 4/26/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTopViewController.h"

@interface AnnouncmentsTable : UITableViewController < UIWebViewDelegate> {

}


@property (nonatomic,strong) NSMutableArray *anntitle;
@property (nonatomic,strong) NSMutableArray *anndesc;
@property (strong, nonatomic) IBOutlet UITableView *table123;


//powerschool server stuff

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) PowerschoolFetch * psFetcher3;

@property (weak, nonatomic) IBOutlet UILabel *toplabel;


@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIViewController * viewController;
@property (nonatomic , strong) UIRefreshControl *refreshcontroll;


@end
