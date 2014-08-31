//
//  GradesDetailsTable.m
//  WB
//
//  Created by Owner on 4/28/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "GradesDetailsTable.h"
#import "TFHpple.h"
#import "Detailobject.h"
#include "GradesDetailCell.h"

@interface GradesDetailsTable ()

@end

@implementation GradesDetailsTable


@synthesize linktransfer , leteraray, namearay , percentaray , scorearay , detaillink , subjecttransfer , percentgradearay , percentstring , Percent;



-(void)loaddetailgrades{

    NSString *fulllink = [NSString stringWithFormat:@"https://powerschool.dupage88.net/guardian/%@" , linktransfer];
    
    NSURL *yoyoyo2 = [[NSURL alloc] initWithString:fulllink];
    NSData *data2 = [[NSData alloc] initWithContentsOfURL:yoyoyo2];
    
    detaillink = data2;
        TFHpple *broparser = [TFHpple hppleWithHTMLData:detaillink];
    
    
    NSString *pathfortitle =  [ NSString stringWithFormat:
                               @"//*[@id='content-main']/table[2]/tr/td[3]/text()" ] ;
    
    NSArray *titlenode = [broparser searchWithXPathQuery:pathfortitle];
    NSMutableArray *titletable = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    for (TFHppleElement *element1 in titlenode) {
        
        Detailobject *toturial = [[Detailobject alloc]init];
        
        [titletable addObject:toturial];
        
        toturial.name = [element1 raw];
        
    }
    NSString *lettergradepath =  [ NSString stringWithFormat:
                                  @"//*[@id='content-main']/table[2]/tr/td[11]/text()" ] ;
    
    NSArray *lettergradenode = [broparser searchWithXPathQuery:lettergradepath];
    NSMutableArray *lettergradetable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element2 in lettergradenode) {
        
        Detailobject *toturial = [[Detailobject alloc]init];
        
        [lettergradetable addObject:toturial];
        
        toturial.letter = [element2 raw];
        
    }
    NSString *pathforscore =  [ NSString stringWithFormat:
                               @"//*[@id='content-main']/table[2]/tr/td[9]/span/text()" ] ;
    
    NSArray *scorenode = [broparser searchWithXPathQuery:pathforscore];
    NSMutableArray *scoretable = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    for (TFHppleElement *element3 in scorenode) {
        
        Detailobject *toturial = [[Detailobject alloc]init];
        
        [scoretable addObject:toturial];
        
        toturial.score = [element3 raw];
    }
    
    NSString *percentpath =  [ NSString stringWithFormat:
                              @"//*[@id='content-main']/table[2]/tr/td[10]/text()" ] ;
    
    NSArray *percentnode = [broparser searchWithXPathQuery:percentpath];
    NSMutableArray *percenttable = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    for (TFHppleElement *element4 in percentnode) {
        
        Detailobject *toturial = [[Detailobject alloc]init];
        
        [percenttable addObject:toturial];
        
        toturial.percent = [element4 raw];
        
    }
    NSString *percentgradepath =  [ NSString stringWithFormat:
                                   @"//*[@id='content-main']/table[1]/tr/td[4]/script/text()" ] ;
    
    NSArray *percentgradenode = [broparser searchWithXPathQuery:percentgradepath];
    NSMutableArray *percentgradetable = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    for (TFHppleElement *element1 in percentgradenode) {
        
        Detailobject *toturial = [[Detailobject alloc]init];
        
        [percentgradetable addObject:toturial];
        
        toturial.percentgrade = [element1 raw];
        
        NSString *modifiedroom = [NSString stringWithFormat:@"%@" , toturial.percentgrade];
        
        NSString *newStr = [modifiedroom substringFromIndex:92];
        
        NSString *newStr2 = [newStr substringToIndex:[newStr length]-21];
        
        
        NSString *finalpercent = [NSString stringWithFormat: @"Current Grade: %@" , newStr2];
        
        Percent.text = finalpercent;
    }
    percentaray = percenttable;
    scorearay = scoretable;
    leteraray = lettergradetable;
    namearay = titletable;
    
    [self.tableView reloadData];
    
    HideHUD;
    
}

- (void)viewDidLoad
{
    ShowHUDwithTitle(@"Loading");

    [super viewDidLoad];
}


-(void)viewDidAppear:(BOOL)animated {
    
    [self loaddetailgrades];
    
    UIView *content = [[self.view subviews] objectAtIndex:0];
#if SCREENSHOT_MODE
	[content.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
#endif
	((UIScrollView *)self.view).contentSize = content.bounds.size;
    
    self.title = subjecttransfer;
    
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
    return self.namearay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GradedetailCell";
    
    GradesDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath]
    ;

    Detailobject *tt1 = [namearay objectAtIndex:indexPath.row];
    Detailobject *tt2 = [leteraray objectAtIndex:indexPath.row];
    Detailobject *tt3 = [percentaray objectAtIndex:indexPath.row];
    Detailobject *tt4 = [scorearay objectAtIndex:indexPath.row];
    
    cell.titlelabel.text = tt1.name;
    cell.lettergrade.text = tt2.letter;
    cell.percentout.text = tt3.percent;
    cell.scoreout.text = tt4.score;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
