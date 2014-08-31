//
//  GradesController.m
//  WB
//
//  Created by Owner on 5/2/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "GradesController.h"
#import "AppDelegate.h"
#import "FPPopoverView.h"
#import "FPPopoverController.h"
#import "FPTouchView.h"
#import "SwitchSem.h"
#define loginJS @"javascript:document.forms[0].account.value='%@';document.forms[0].pw.value='%@';document.getElementById('btn-enter').click();"


@interface GradesController ()
{
    
    BOOL _showHUD;
    BOOL switchsemester;
    
}
@property (nonatomic, strong) NSArray* fetchedClasses;
@property (nonatomic, strong) NSArray* fetchedAssignments;
@property (nonatomic, strong) UIViewController* hudViewController;
@property (nonatomic, strong) UIActivityIndicatorView* wheel;
@property (nonatomic, strong) UIImageView* arrow;
@property (nonatomic , strong) NSString *webpage;
@property (nonatomic, retain) UIView * view;

@end

@implementation GradesController

@synthesize gradesletter , gradeslink , gradesroom , gradessubject , gradespercent , absences , tableView2 ,  refreshcontroll
;

-(void)attemptLogin
{
    ShowHUDwithTitle(@"Downloading...");

    self.window.rootViewController = self.viewController;
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    
    //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    NSLog(@"getting there");
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://powerschool.dupage88.net/"]];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    
    NSLog(@"getting there2");
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"Web view did start load...");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"Did fail");
    HideHUD;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can't connect. Please check your internet Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    _webpage = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"Web view did finish load");
    
    //NSLog(@"DOM: %@", [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
    
    if ([_webpage isEqualToString: @"Grades and Attendance"]){//Log in successful
        loginFailed = NO;
        [self parse];
        
        
    }else if (loginFailed == NO){
        
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:loginJS, [ud objectForKey:@"student_username"], [ud objectForKey:@"student_password"]]];
        loginFailed = YES;
        
    }else if(loginFailed == YES){
        
        NSLog(@"FAILED");
        [ud removeObjectForKey: @"student_username"];
        [ud removeObjectForKey: @"student_password"];
        [ud synchronize];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             [self.hudViewController.view setAlpha:0.0];
                         }
                         completion:^(BOOL finished) {
                             [self.hudViewController.view removeFromSuperview];
                             self.viewController.tabBarController.tabBar.userInteractionEnabled = YES;
                             self.viewController.navigationController.navigationBar.userInteractionEnabled = YES;
                             [self parse];
                             
                         }];
    }
}

-(void)parse{
    
    NSURL *gradesurl = [[NSURL alloc] initWithString:@"https://powerschool.dupage88.net/guardian/home.html"];
    NSData *gradesdata = [[NSData alloc] initWithContentsOfURL:gradesurl];
    
    TFHpple *broparser = [TFHpple hppleWithHTMLData:gradesdata];
    
    //method for subjectname
    
    NSString *pathfortitle =  [ NSString stringWithFormat:
                               @"//tr/td[12]/text()[1]" ] ;
    
    NSArray *titlenode = [broparser searchWithXPathQuery:pathfortitle];
    
    NSMutableArray *titletable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element1 in titlenode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];
        
        [titletable addObject:object];
        
        object.titlebig = [element1 raw];
        
        
    }
    //method for subject grade
    
    NSString *pathforgrade =  [ NSString stringWithFormat:
                               @"//tr/td[13]/a/text()[1]" ] ;
    
    NSArray *gradenode = [broparser searchWithXPathQuery:pathforgrade];
    NSMutableArray *subjecttable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element2 in gradenode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];
        
        [subjecttable addObject:object];
        
        object.subjectbig = [element2 raw];
        
        
    }
    //method for room number
    
    NSString *pathforroom =  [ NSString stringWithFormat:
                              @"//tr/td[12]/text()[3]" ] ;
    
    NSArray *roomnode = [broparser searchWithXPathQuery:pathforroom];
    NSMutableArray *roomtable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element3 in roomnode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];
        
        [roomtable addObject:object];
        
        object.roombig = [element3 raw];
        
    }
    //method for grades link
    
    NSString *pathforlink =  [ NSString stringWithFormat:
                              @"//tr/td[13]/a" ] ;
    
    NSArray *linknode = [broparser searchWithXPathQuery:pathforlink];
    NSMutableArray *linktable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element3 in linknode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];
        
        [linktable addObject:object];
        
        object.linkbig = [element3 objectForKey:@"href"];
        
    }
    //method for GPA
    NSString *pathforGPA =  [ NSString stringWithFormat:
                             @"//div[@id='quickLookup']/table[2]/tr/td[1]/text()" ] ;
    
    NSArray *gpanode = [broparser searchWithXPathQuery:pathforGPA];
    
    
    for (TFHppleElement *element4 in gpanode) {
        
        //[gpatable addObject:object];
        
        _GPA.text = [element4 raw];
    }
    gradessubject = titletable;
    gradesletter = subjecttable;
    gradesroom = roomtable;
    gradeslink = linktable;
    [self.tableView2 reloadData];
    HideHUD;
    [refreshcontroll endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstsemester) name:@"firstsemester" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(secondsemester) name:@"secondsemester" object:nil];
    
    ud = [NSUserDefaults standardUserDefaults];
    
    UIBarButtonItem *Menubtn = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(refreshbtn)];
    self.navigationItem.leftBarButtonItem = Menubtn;
    
    UIBarButtonItem *Semesterbtn = [[UIBarButtonItem alloc]initWithTitle:@"Semester" style:UIBarButtonItemStyleBordered target:self action:@selector(flipshit:)];
    self.navigationItem.rightBarButtonItem = Semesterbtn;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"student_password"] == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Sign in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self attemptLogin];
    }
    
    refreshcontroll = [[UIRefreshControl alloc] init];
    
    [refreshcontroll addTarget:self action:@selector(refresh2:) forControlEvents:UIControlEventValueChanged];
    [self.tableView2 addSubview:refreshcontroll];
    
    
    NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"stored"];
    
    int value = [savedValue intValue];
    switchsemester = value;
}



-(void)flipshit:(id)sender{
    
    SwitchSem *controler = [[SwitchSem alloc]initWithStyle:UITableViewStylePlain];
    controler.delegate=self;
    
    UIBarButtonItem *button = sender;
    UIView *btnview = [button valueForKey:@"view"];
    
    popover = [[FPPopoverKeyboardResponsiveController alloc]initWithViewController:controler];
    
    [popover presentPopoverFromView:btnview];
    
    popover.arrowDirection = FPPopoverArrowDirectionDown;
    popover.border = NO;
    popover.tint = FPPopoverWhiteTint;
    popover.alpha = 0.8;
}

-(void)firstsemester{
    
    switchsemester =0;
    
    [self.tableView2 reloadData];
}

-(void)secondsemester{
    
    switchsemester =1;
    
    [self.tableView2 reloadData];
    
}

- (void)refresh2:(UIRefreshControl *)refreshControl {
    [self attemptLogin];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return gradesletter.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row=[indexPath row];
    float ret=0.0;
    
    //this sets the height to zero so it would diifrentiate between first and second semester
    if (switchsemester ==0){
        
        if(row==1) {
            ret=0.0;
        }
        else if (row==3){
            ret=0.0;
            
        }
        else if (row==5){
            ret=0.0;
            
        }
        else if (row==7){
            ret=0.0;
            
        }
        else if (row==9){
            ret=0.0;
            
        }
        else if (row==11){
            ret=0.0;
            
        }
        else if (row==13){
            ret=0.0;
            
        }
        else if (row==15){
            ret=0.0;
            
        }
        else if (row==17){
            ret=0.0;
            
        }
        else if (row==19){
            ret=0.0;
            
        }
        else {
            ret=47.0;
        }
    }
    else if (switchsemester ==1){
        if(row==0) {
            ret=0.0;
        }
        else if (row==2){
            ret=0.0;
            
        }
        else if (row==4){
            ret=0.0;
            
        }
        else if (row==6){
            ret=0.0;
            
        }
        else if (row==8){
            ret=0.0;
            
        }
        else if (row==10){
            ret=0.0;
            
        }
        else if (row==12){
            ret=0.0;
            
        }
        else if (row==14){
            ret=0.0;
            
        }
        else if (row==16){
            ret=0.0;
            
        }
        else if (row==18){
            ret=0.0;
            
        }
        else {
            ret=47.0;
        }
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GradesCell2";
    
    GradesCell *cell = [tableView2 dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]
    ;
    Gradesobject *tt1 = [gradesletter objectAtIndex:indexPath.row];
    Gradesobject *tt2 = [gradessubject objectAtIndex:indexPath.row];
    Gradesobject *tt3 = [gradesroom objectAtIndex:indexPath.row];
    
    NSString *modifiedroom = [NSString stringWithFormat:@"%@" , tt3.roombig];
    
    NSString *roomnumber = [modifiedroom substringFromIndex:7];
    
    NSString *modifiedsubject = [NSString stringWithFormat:@"%@" , tt2.titlebig];
    
    NSString *subjectname = [modifiedsubject stringByReplacingOccurrencesOfString:@"&amp;"
                                                                       withString:@"&"];

    cell.roomnumber.text = roomnumber;
    cell.subject.text = subjectname;
    cell.gradeletter.text = tt1.subjectbig;

    //this would accompany the height adjustment in way that it would hide the cells
    if (switchsemester ==0){
        if (indexPath.row ==1) {
            
            cell.hidden=YES;
        }
        
        else if (indexPath.row ==3){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==5){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==7){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==9){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==11){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==13){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==15){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==17){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==19){
            cell.hidden=YES;
            
        }}
    
    if (switchsemester ==1) {
        
        if (indexPath.row ==0) {
            
            cell.hidden=YES;
        }
        
        else if (indexPath.row ==2){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==4){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==6){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==8){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==10){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==12){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==14){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==16){
            cell.hidden=YES;
            
        }
        else if (indexPath.row ==18){
            cell.hidden=YES;
            
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    [tableView2 deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(void)refreshbtn{
    
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GradeTransfer"]) {


        NSIndexPath *path = [self.tableView2 indexPathForSelectedRow];
        Gradesobject *thisTutorial = [gradeslink objectAtIndex:path.row];
        Gradesobject *thisTutorial2 = [gradessubject objectAtIndex:path.row];
        
        NSString *linkstring = [NSString stringWithFormat:@"%@" , thisTutorial.linkbig ];
        NSString *subjectlink = [NSString stringWithFormat:@"%@" , thisTutorial2.titlebig ];
        
        GradesDetailsTable *detail = [segue destinationViewController];
        
        detail.linktransfer = linkstring;
        
        detail.subjecttransfer = subjectlink;
    }}

-(void)selectedTableRow:(NSUInteger)rowNum
{
    NSLog(@"SELECTED ROW %lu",(unsigned long)rowNum);
    [popover dismissPopoverAnimated:YES];
}
@end
