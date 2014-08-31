//
//  FirstTopViewController.m
//  WB
//
//  Created by Owner on 5/2/14.
//  Copyright (c) 2014 Fares. All rights reserved.
#import "AppDelegate.h"
#import "FirstTopViewController.h"
#import "TFHpple.h"
#import "Announcmentsobject.h"
#import "AnnouncmentsTable.h"
#define loginJS @"javascript:document.forms[0].account.value='%@';document.forms[0].pw.value='%@';document.getElementById('btn-enter').click();"


@interface FirstTopViewController () {
    NSMutableArray *studentNames;
    NSMutableArray *studentJS;
    NSMutableArray *Classlist;
    
    NSManagedObjectContext *context;
    
    BOOL didlunch5;
    BOOL didlunch6;
    BOOL _showHUD;
    
}
@property (nonatomic, strong) NSArray* fetchedClasses;
@property (nonatomic, strong) NSArray* fetchedAssignments;
@property (nonatomic, strong) UIViewController* hudViewController;
@property (nonatomic, strong) UIActivityIndicatorView* wheel;
@property (nonatomic, strong) UIImageView* arrow;



@property (nonatomic, retain) UIView * view;


@end

@implementation FirstTopViewController{
    
}

@synthesize buttonlabel;

-(void)viewDidLoad{
    [super viewDidLoad];
    UIBarButtonItem *barListBtn = [[UIBarButtonItem alloc]initWithTitle:@"Date" style:UIBarButtonItemStyleBordered target:self action:@selector(logout123)];
    self.navigationItem.rightBarButtonItem = barListBtn;
    
    
    UIBarButtonItem *Menubtn = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(Menu)];
    self.navigationItem.leftBarButtonItem = Menubtn;
    
	[self.navigationController.view addSubview:HUD];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadlabels) name:@"Reloadlabels" object:nil];
    
    
    
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"student_password"] == nil) {
        
        [buttonlabel setTitle:@"Sign in" forState:UIControlStateNormal];
        [self.navigationItem.rightBarButtonItem setTitle:@""];
    }
    else {
        [buttonlabel setTitle:@"Welcome!" forState:UIControlStateNormal];
        [self.navigationItem.rightBarButtonItem setTitle:@"Logout"];
    }}

-(void)reloadlabels{
    
    //studentname
    
    NSString *fullname = [NSString stringWithFormat:@"Welcome !"];
    
    [buttonlabel setTitle:fullname forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitle:@"Logout"];
    
}

-(void)logout123{
    
    NSLog(@"button clicked");
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]];
    
    [self viewDidLoad];
    
    
}


-(void)Menu{
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}
- (IBAction)Alert:(id)sender {
    
    
    self.psFetcher = [[PowerschoolFetch alloc] initWithViewController:self.window.rootViewController];
    [buttonlabel setTitle:@"Welcome!" forState:UIControlStateNormal];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"student_password"] == nil) {
        
        [self.psFetcher fetchPowerSchoolDataAndShowHUD:YES];
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]; [self.view addSubview:spinner];
        
        [buttonlabel setTitle:@"Sign in" forState:UIControlStateNormal];
    }}

@end