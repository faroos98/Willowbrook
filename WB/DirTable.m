//
//  DirTable.m
//  WB School
//
//  Created by Owner on 3/30/14.
//  Copyright (c) 2014 Owner. All rights reserved.
//

#import "DirTable.h"
#import "Contributer.h"
#import "TFHpple.h"
#import "Tutorial.h"
#import "ECSlidingViewController.h"
#import "StaffDetailsController.h"

@interface DirTable () {
    NSArray *aray2;
    
}
@end

@implementation DirTable

@synthesize _objects , _objects2 , _objects3;

-(void)loadContributer {
    
    
    NSData *path=[[NSUserDefaults standardUserDefaults] valueForKey:@"Directorydata"];
    
    TFHpple *broparser = [TFHpple hppleWithHTMLData:path];
    
    //method for first name
    NSString *lastnamepath =  [ NSString stringWithFormat:
                               @"//table[@class='person-directory']/tbody/tr/td/a/span[1]" ] ;
    
    NSArray *bronode = [broparser searchWithXPathQuery:lastnamepath];
    NSMutableArray *brotable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element in bronode) {
        
        Tutorial *tutorial = [[Tutorial alloc] init] ;
        [brotable addObject:tutorial];
        
        tutorial.title = [[element firstTextChild] content];
        
    }
    
    //method for last name
    NSString *firstnamepath =  [ NSString stringWithFormat:
                                @"//table[@class='person-directory']/tbody/tr/td/a/span[2]" ] ;
    NSArray *bronode2 = [broparser searchWithXPathQuery:firstnamepath];
    NSMutableArray *brotable2 = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element2 in bronode2) {
        Tutorial *tutorial = [[Tutorial alloc] init] ;
        [brotable2 addObject:tutorial];
        
        tutorial.url = [[element2 firstTextChild] content];
    
    }
    //method for number
    
    NSString *numberpath = [NSString stringWithFormat:@"//table[@class='person-directory']/tbody/tr/td/text()"];
    NSArray *numbernode = [broparser searchWithXPathQuery:numberpath];
    
    NSMutableArray *numbetable = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element3 in numbernode) {
        
        Tutorial *tutorial = [[Tutorial alloc] init];
        [numbetable addObject:tutorial];
        
        tutorial.nummber = [element3 raw];
        NSLog(@"%@" , tutorial.nummber);
    }
    
    _objects3 = numbetable;
    _objects2 = brotable2;
    _objects = brotable ;
    
    [self.tableView reloadData];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadContributer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Tutorial *thisTutorial = [_objects objectAtIndex:indexPath.row];
    Tutorial *thistt2 = [_objects2 objectAtIndex:indexPath.row];
    
    
    NSString *aray = [NSString stringWithFormat:@"%@, %@", thisTutorial.title, thistt2.url];
    
    if (indexPath.row > 168) {
        
        cell.hidden = YES;
    }
    
    cell.textLabel.text = aray;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:16];
    
    
    NSLog(@"%@" , aray);
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Detail"]) {
        
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Tutorial *thisTutorial = [_objects objectAtIndex:path.row];
        Tutorial *thistt2 = [_objects2 objectAtIndex:path.row];
        Tutorial *numbertt = [_objects3 objectAtIndex:path.row];
        
        NSString *teachername = [NSString stringWithFormat:@"%@, %@" , thisTutorial.title , thistt2.url];
        
        NSString *teachernumber = [NSString stringWithFormat:@"+1 %@" , numbertt.nummber];
        
        StaffDetailsController *detail = [segue destinationViewController];
        
        detail.detaillabelcont = teachername;
        
        detail.numbestring = teachernumber;
        
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


- (IBAction)menubtn2:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}

@end
