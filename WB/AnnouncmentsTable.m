//
//  AnnouncmentsTable.m
//  WB
//
//  Created by Owner on 4/26/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "AnnouncmentsTable.h"
#import "ECSlidingViewController.h"
#import "AnnouncmentsDetails.h"
#import "TFHpple.h"
#import "Announcmentsobject.h"
#import "FirstTopViewController.h"
#import "AppDelegate.h"

//#define loginJS @"javascript:document.forms[0].account.value='%@';document.forms[0].pw.value='%@';document.getElementById('btn-enter').click();"


@interface AnnouncmentsTable () {
}

@end

@implementation AnnouncmentsTable


@synthesize anntitle ,anndesc , refreshcontroll ;
-(void)loadContributer {
    
    
    NSData *path=[[NSUserDefaults standardUserDefaults] valueForKey:@"Announcmentsdata"];
    
    TFHpple *broparser = [TFHpple hppleWithHTMLData:path];
    
    
    //method for first name
    
    
    NSString *lastnamepath =  [ NSString stringWithFormat:
                               @"//*[@id='guardianBulletinDialog']/div/p/font[1]/b/text()" ] ;
    
    NSArray *bronode = [broparser searchWithXPathQuery:lastnamepath];
    NSMutableArray *brotable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element in bronode) {
        
        Announcmentsobject *tutorial = [[Announcmentsobject alloc] init] ;
        [brotable addObject:tutorial];
        
        tutorial.title = [element raw];
        NSLog(@"%@" , tutorial.title);
        
    }
    //second method
    
    NSString *detailpath =  [ NSString stringWithFormat:
                             @"//*[@id='guardianBulletinDialog']/div/p/font[2]/text()" ] ;
    
    
    NSArray *detailnode = [broparser searchWithXPathQuery:detailpath];
    NSMutableArray *detailtable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element2 in detailnode) {
        
        Announcmentsobject *tutorial = [[Announcmentsobject alloc] init] ;
        [detailtable addObject:tutorial];
        
        tutorial.detail = [element2 raw] ;
    }
    
    // title & date method
    
    NSString *titlepath =  [ NSString stringWithFormat:
                            @"//*[@id='guardianBulletinDialog']/div/h2/text()" ] ;
    
    ////*[@id="guardianBulletinDialog"]/div/h2/text()
    NSArray *titlenode = [broparser searchWithXPathQuery:titlepath];
    
    for (TFHppleElement *element2 in titlenode) {
        
        self.toplabel.text = [element2 raw] ;
        
    }
    
    anntitle = brotable;
    
    anndesc = detailtable;
    
    [self.tableView reloadData];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *Menubtn = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(backthru)];
    self.navigationItem.leftBarButtonItem = Menubtn;
    
    [self loadContributer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewData) name:@"ReloadRootViewControllerTable" object:nil];
    
    refreshcontroll = [[UIRefreshControl alloc] init];
    
    [refreshcontroll addTarget:self action:@selector(refresh2:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshcontroll];
}

-(void) reloadTableViewData{
    
    [anntitle removeAllObjects];
    [self loadContributer];
    [refreshcontroll endRefreshing];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    return anntitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnnCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Announcmentsobject *thisTutorial = [anntitle objectAtIndex:indexPath.row];
    //Tutorial *thistt2 = [_objects2 objectAtIndex:indexPath.row];
    
    cell.textLabel.text = thisTutorial.title;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    
    NSLog(@"%@" , thisTutorial.title);
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [anntitle removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Showdetails"]) {
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        Announcmentsobject *thisTutorial = [anntitle objectAtIndex:path.row];
        Announcmentsobject *thistt2 = [anndesc objectAtIndex:path.row];
        //Tutorial *numbertt = [_objects3 objectAtIndex:path.row];
        
        NSString *teachername = [NSString stringWithFormat:@"%@" , thisTutorial.title];
        
        NSString *teachernumber = [NSString stringWithFormat:@"%@" , thistt2.detail];
        
        AnnouncmentsDetails *detail = [segue destinationViewController];
        
        detail.top = teachername;
        
        detail.bottom = teachernumber;
        
    }}

-(void)refresh2:(id)sender{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"student_password"] == nil) {
        
        self.psFetcher3 = [[PowerschoolFetch alloc] initWithViewController:self.window.rootViewController];
        
        [self.psFetcher3 fetchPowerSchoolDataAndShowHUD:YES];
    }
    else {
        
        self.psFetcher3 = [[PowerschoolFetch alloc] initWithViewController:self.window.rootViewController];

        [self.psFetcher3 attemptLogin];
        
}}

-(void)backthru{
    [self.slidingViewController anchorTopViewTo:ECRight];
    
    
}
@end
