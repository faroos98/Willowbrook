//
//  PowerschoolFetch.m
//  WB
//
//  Created by Owner on 4/28/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//
#import "AppDelegate.h"

#import "PowerschoolFetch.h"
#import "FirstTopViewController.h"
#import "TFHpple.h"
#import "Announcmentsobject.h"
#import "AnnouncmentsTable.h"
@import Security;

#define loginJS @"javascript:document.forms[0].account.value='%@';document.forms[0].pw.value='%@';document.getElementById('btn-enter').click();"
@interface PowerschoolFetch (){
    NSMutableArray * studentNames;
    NSMutableArray * studentJS;
    NSMutableArray * classListForAssignments;
    
    BOOL didLunch4;
    BOOL didLunch5;
    BOOL didLunch6;
    BOOL _showHUD;
}

@property (nonatomic, strong) NSArray* fetchedClasses;
@property (nonatomic, strong) NSArray* fetchedAssignments;
@property (nonatomic, strong) UIViewController* hudViewController;
@property (nonatomic, strong) UIActivityIndicatorView* wheel;
@property (nonatomic, strong) UIImageView* arrow;


@property (nonatomic, retain) UIView * view;

@end

@implementation PowerschoolFetch

@synthesize gradesblah , annblah, blah, name;

-(id)initWithViewController:(UIViewController*)viewController
{
    if (self) {
        ud = [NSUserDefaults standardUserDefaults];
        // KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
        
        loginFailed = NO;
        NSLog(@"initiated");
        self.webView = [[UIWebView alloc] init];
        self.webView.delegate = self;
        self.view = viewController.view;
    }
    return self;
}
-(void)fetchPowerSchoolDataAndShowHUD:(BOOL)showHUD {
    
    //pop up display intiateed in app delegate
    
    _showHUD = showHUD;
    
    NSString * message = [[NSString alloc] init];
    if (loginFailed == NO){
        message = @"Please Login";
    }else{
        message = @"Login Failed";
    }
    
    if (![ud objectForKey:@"student_password"] || ![ud objectForKey:@"student_username"]){
        UIAlertView * loginAlert = [[UIAlertView alloc]initWithTitle:@"PowerSchool" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Login", nil];
        loginAlert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [loginAlert setTag:1];
        
        [loginAlert show];
        
        //Student enters info and then we jump back to the else...
    }else{
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        if (_showHUD) {
            
            self.hudViewController = [[UIViewController alloc]init];
            UIView * hudView = [[UIView alloc]initWithFrame:CGRectMake(110, (screenRect.size.height/2)-50, 100, 100)];
            hudView.backgroundColor = [UIColor colorWithRed:0.032 green:0.36 blue:0.667 alpha:1.0];
            hudView.layer.cornerRadius = hudView.frame.size.width/2;
            
            self.wheel = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(40, 40, 20, 20)];
            [self.wheel setColor:[UIColor colorWithRed:0.98 green:0.78 blue:0.21 alpha:1]];
            
            self.arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downArrow"]];
            
            [hudView addSubview:self.wheel];
            [hudView addSubview:self.arrow];
            
            hudView.alpha = 0;
            self.arrow.alpha = 0;
            
            [self.wheel startAnimating];
            self.hudViewController.view = hudView;
            [self.viewController.view addSubview:hudView];
            UITabBarController * tbc = (UITabBarController*)self.viewController;
            tbc.tabBar.userInteractionEnabled = NO;
            UINavigationController * nvc = (UINavigationController*)tbc.selectedViewController;
            nvc.navigationBar.userInteractionEnabled = NO;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.4];
            hudView.alpha = 1;
            [UIView commitAnimations];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self attemptLogin];
        
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 01 && buttonIndex != alertView.cancelButtonIndex) {
        
        loginFailed = NO;
        [ud setValue:[[alertView textFieldAtIndex:0] text] forKey:@"student_username"];
        [ud setValue:[[alertView textFieldAtIndex:1] text] forKey:@"student_password"];
        [ud synchronize];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self fetchPowerSchoolDataAndShowHUD:_showHUD];}
}


-(void)attemptLogin
{
        ShowHUDwithTitle(@"Loading...");
    
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
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString* domTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"Web view did finish load");
    
    //NSLog(@"DOM: %@", [webView stringByEvaluatingJavaScriptFromString:@"document.body.innerHTML"]);
    
    if ([domTitle isEqualToString: @"Grades and Attendance"]){//Log in successful
        loginFailed = NO;
        [self parse];
        
        
    }else if (loginFailed == NO){
        
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:loginJS, [ud objectForKey:@"student_username"], [ud objectForKey:@"student_password"]]];
        loginFailed = YES;
        
    }else if(loginFailed == YES){
        HideHUD;
        
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
                             [self fetchPowerSchoolDataAndShowHUD:YES];
                             
                         }];
    }
}

-(void)parse {
    
    
    
    //save announcemnts to userdefaults
    
    NSLog(@"reached parsing stage succefully");
    NSURL *yoyoyo = [[NSURL alloc] initWithString:@"https://powerschool.dupage88.net/guardian/bulletin_popup.html"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:yoyoyo];
    
    blah = data;
    
    NSLog(@"Saved Announcments" );
    
    
    NSUserDefaults *strinToSave= [NSUserDefaults standardUserDefaults];
    [strinToSave setObject:self.blah forKey:@"Announcmentsdata"];
    
    
    //save directory to userdefaults
    
    NSURL *yoyoyo2 = [[NSURL alloc] initWithString:@"https://www.dupage88.net/site/page/41"];
    NSData *data2 = [[NSData alloc] initWithContentsOfURL:yoyoyo2];
    //NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    annblah = data2;
    
    NSLog(@"Saved staff directory" );
    
    
    NSUserDefaults *strinToSave2= [NSUserDefaults standardUserDefaults];
    [strinToSave2 setObject:self.annblah forKey:@"Directorydata"];
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    UIActivityIndicatorView *activityIndicator;
    [activityIndicator stopAnimating];
    [activityIndicator hidesWhenStopped];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadRootViewControllerTable" object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Reloadlabels" object:nil];
    
    HideHUD;
    
}

@end
