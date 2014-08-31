//
//  GradesTable.h
//  WB
//
//  Created by Owner on 4/28/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "GradesCell.h"
#import "Gradesobject.h"
#import "GradesDetailsTable.h"
#import "PowerschoolFetch.h"



@interface GradesTable : UITableViewController <MBProgressHUDDelegate , UIAlertViewDelegate, UIActionSheetDelegate, UIWebViewDelegate>  {
    
    
	long long expectedLength;
	long long currentLength;
    BOOL loginFailed;
    BOOL switchedStudent;
    NSUserDefaults * ud;


    
}
@property (weak, nonatomic) IBOutlet UILabel *GPA;

- (IBAction)refresh:(id)sender;

- (IBAction)Menu:(id)sender;

@property (nonatomic,strong) NSMutableArray *gradessubject;
@property (nonatomic,strong) NSMutableArray *gradesroom;
@property (nonatomic,strong) NSMutableArray *gradesletter;
@property (nonatomic,strong) NSMutableArray *gradeslink;
@property (nonatomic,strong) NSMutableArray *gradespercent;
@property (nonatomic,strong) NSMutableArray *absences;

-(void)attemptLogin;
 
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIViewController * viewController;
@property (nonatomic,strong) NSData *gradesblah;
@property (nonatomic, strong) FirstTopViewController * psFetcher;


@end
