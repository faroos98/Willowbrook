//
//  GradesTable.m
//  WB
//
//  Created by Owner on 4/28/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//
#import "AppDelegate.h"

#import "GradesTable.h"
#define loginJS @"javascript:document.forms[0].account.value='%@';document.forms[0].pw.value='%@';document.getElementById('btn-enter').click();"

@interface GradesTable () {
    
    BOOL _showHUD;

}
@property (nonatomic, strong) NSArray* fetchedClasses;
@property (nonatomic, strong) NSArray* fetchedAssignments;
@property (nonatomic, strong) UIViewController* hudViewController;
@property (nonatomic, strong) UIActivityIndicatorView* wheel;
@property (nonatomic, strong) UIImageView* arrow;
@property (nonatomic , strong) NSString *webpage;
@property (nonatomic, retain) UIView * view;


@end

@implementation GradesTable


@synthesize gradesletter , gradeslink , gradesroom , gradessubject , gradespercent , absences;




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
                               @"//tr[not(.//td[2][@class='notInSession']) and not(.//td[1][(contains(.,'WT(A)'))]) and not(.//td[12][(contains(.,'Lunch S2'))])and not(.//td[12][(contains(.,'Lunch S1'))])and not(.//td[2][(contains(.,'.'))])and not(.//td[16]/a/text()[(contains(.,'--'))])]/td[12]/text()[1]" ] ;
    
    NSArray *titlenode = [broparser searchWithXPathQuery:pathfortitle];
    NSMutableArray *titletable = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    for (TFHppleElement *element1 in titlenode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];
        
        [titletable addObject:object];
        
        object.titlebig = [element1 raw];
        

        
    }

    
    //method for subject grade
    
    NSString *pathforgrade =  [ NSString stringWithFormat:
                               @"//tr[not(.//td[2][@class='notInSession']) and not(.//td[1][(contains(.,'WT(A)'))]) and not(.//td[12][(contains(.,'Lunch S2'))])and not(.//td[12][(contains(.,'Lunch S1'))])and not(.//td[2][(contains(.,'.'))])and not(.//td[16]/a/text()[(contains(.,'--'))])]/td[16]/a/text()[1]" ] ;
    
    NSArray *gradenode = [broparser searchWithXPathQuery:pathforgrade];
    NSMutableArray *subjecttable = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    for (TFHppleElement *element2 in gradenode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];
        
        [subjecttable addObject:object];
        
        object.subjectbig = [element2 raw];
        
 
    }

    //method for room number
    
    NSString *pathforroom =  [ NSString stringWithFormat:
                               @"//tr[not(.//td[2][@class='notInSession']) and not(.//td[1][(contains(.,'WT(A)'))]) and not(.//td[12][(contains(.,'Lunch S2'))])and not(.//td[12][(contains(.,'Lunch S1'))])and not(.//td[2][(contains(.,'.'))])and not(.//td[16]/a/text()[(contains(.,'--'))])]/td[12]/text()[3]" ] ;
    
    NSArray *roomnode = [broparser searchWithXPathQuery:pathforroom];
    NSMutableArray *roomtable = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    for (TFHppleElement *element3 in roomnode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];
        
        [roomtable addObject:object];
        
        object.roombig = [element3 raw];
    

    }

    //method for grades link
    
    NSString *pathforlink =  [ NSString stringWithFormat:
                              @"//tr[not(.//td[2][@class='notInSession']) and not(.//td[1][(contains(.,'WT(A)'))]) and not(.//td[12][(contains(.,'Lunch S2'))])and not(.//td[12][(contains(.,'Lunch S1'))])and not(.//td[2][(contains(.,'.'))])and not(.//td[16]/a/text()[(contains(.,'--'))])]/td[18]/a" ] ;
    
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

    //method for percent score
    NSString *pathforpercent =  [ NSString stringWithFormat:
                             @"//tr[not(.//td[2][@class='notInSession']) and not(.//td[1][(contains(.,'WT(A)'))]) and not(.//td[12][(contains(.,'Lunch S2'))])and not(.//td[12][(contains(.,'Lunch S1'))])and not(.//td[2][(contains(.,'.'))])and not(.//td[16]/a/text()[(contains(.,'--'))])]/td[16]/a/text()[2]" ] ;
    
    NSArray *percentnode = [broparser searchWithXPathQuery:pathforpercent];
    
    NSMutableArray *percenttable = [[NSMutableArray alloc] initWithCapacity:0];

    for (TFHppleElement *element5 in percentnode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];

        [percenttable addObject:object];
        
       object.percentbig = [element5 raw];
        
    }

    
    //path for absenses
    
    NSString *pathforabsenses =  [ NSString stringWithFormat:
                                 @"//tr[not(.//td[2][@class='notInSession']) and not(.//td[1][(contains(.,'WT(A)'))]) and not(.//td[12][(contains(.,'Lunch S2'))])and not(.//td[12][(contains(.,'Lunch S1'))])and not(.//td[2][(contains(.,'.'))])and not(.//td[16]/a/text()[(contains(.,'--'))])]/td[19]/a/text()[1]" ] ;
    
    NSArray *absensesnode = [broparser searchWithXPathQuery:pathforabsenses];
    
    NSMutableArray *absensestable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element6 in absensesnode) {
        
        Gradesobject *object = [[Gradesobject alloc]init];
        
        [absensestable addObject:object];
        
        object.percentbig = [element6 raw];
    }
    
    absences = absensestable;
    gradespercent = percenttable;
    gradessubject = titletable;
    gradesletter = subjecttable;
    gradesroom = roomtable;
    gradeslink = linktable;
    [self.tableView reloadData];

    HideHUD;

    }


- (void)viewDidLoad
{
    [super viewDidLoad];

    ud = [NSUserDefaults standardUserDefaults];

    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"student_password"] == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Sign in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];

        
        }
    else {
        
        [self attemptLogin];
        
    }

    
 


    
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GradesCell";
    
    GradesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]
    ;
    
    
    Gradesobject *tt1 = [gradesletter objectAtIndex:indexPath.row];
    Gradesobject *tt2 = [gradessubject objectAtIndex:indexPath.row];
    Gradesobject *tt3 = [gradesroom objectAtIndex:indexPath.row];
   Gradesobject *tt4 = [gradespercent objectAtIndex:indexPath.row];
    
    
    //NSString *gradeandletter = [NSString stringWithFormat:@"%@, %@" , thistt2.url , thss3.nummber ];
    
    
    NSString *addpercentsymbol = [NSString stringWithFormat:@"%@%%" ,tt4.percentbig];
    
    
    cell.roomnumber.text = tt3.roombig;
    cell.subject.text = tt2.titlebig;
    cell.gradeletter.text = tt1.subjectbig;
    cell.percent.text = addpercentsymbol;
    
    
   // NSArray *todelete = [NSArray arrayWithObject:@"--"];
    
    
    //NSLog(@"%@" , tt1.titlebig);
    
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (IBAction)refresh:(id)sender {
    
    [self viewDidLoad];
}

- (IBAction)Menu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GradeTransfer"]) {
        
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Gradesobject *thisTutorial = [gradeslink objectAtIndex:path.row];
        Gradesobject *thisTutorial2 = [gradessubject objectAtIndex:path.row];

        NSString *linkstring = [NSString stringWithFormat:@"%@" , thisTutorial.linkbig ];
        NSString *subjectlink = [NSString stringWithFormat:@"%@" , thisTutorial2.titlebig ];

        GradesDetailsTable *detail = [segue destinationViewController];

        detail.linktransfer = linkstring;
        
        detail.subjecttransfer = subjectlink;
        
        
    }
}










@end
