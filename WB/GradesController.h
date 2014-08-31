//
//  GradesController.h
//  WB
//
//  Created by Owner on 5/2/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "GradesCell.h"
#import "Gradesobject.h"
#import "GradesDetailsTable.h"
#import "PowerschoolFetch.h"
#import "FPPopoverKeyboardResponsiveController.h"
#import "MBProgressHUD.h"

@interface GradesController : UIViewController <MBProgressHUDDelegate , UIAlertViewDelegate, UIActionSheetDelegate, UIWebViewDelegate , UITableViewDataSource , UITableViewDelegate>  {
    
    
	long long expectedLength;
	long long currentLength;
    BOOL loginFailed;
    BOOL switchedStudent;
    NSUserDefaults * ud;
    FPPopoverKeyboardResponsiveController *popover;

    
    
}


-(void)selectedTableRow:(NSUInteger)rowNum;

@property (weak, nonatomic) IBOutlet UILabel *GPA;


@property (strong, nonatomic) IBOutlet UITableView *tableView2;

@property (nonatomic,strong) NSMutableArray *gradessubject;
@property (nonatomic,strong) NSMutableArray *gradesroom;
@property (nonatomic,strong) NSMutableArray *gradesletter;
@property (nonatomic,strong) NSMutableArray *gradeslink;
@property (nonatomic,strong) NSMutableArray *gradespercent;
@property (nonatomic,strong) NSMutableArray *absences;

//- (IBAction)btn:(id)sender;

@property (nonatomic , strong) UIRefreshControl *refreshcontroll;
-(void)attemptLogin;

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIViewController * viewController;
@property (nonatomic,strong) NSData *gradesblah;
@property (nonatomic, strong) FirstTopViewController * psFetcher;
 


@end
