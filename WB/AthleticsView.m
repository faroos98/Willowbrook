//
//  AthleticsView.m
//  WB
//
//  Created by Owner on 4/30/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "AthleticsView.h"
#import "AppDelegate.h"

@interface AthleticsView ()
@property (nonatomic,strong) NSArray *imageArray;


@end

@implementation AthleticsView{
    UIImageView *Topview , *BottomView;
}
int topIndex = 0, prevTopIndex = 1;

@synthesize timearay , titlearay , locationaray , todaydate ,  imageArray;

-(void)parseathletic{
    
    //method for time
    NSURL  *athleticsurltime = [ NSURL URLWithString:@"http://il.8to18.com/willowbrook/dailycalendar"];
    
    NSData *athleticsdatatime = [[NSData alloc] initWithContentsOfURL:athleticsurltime];
    
    TFHpple *athleticsparser = [TFHpple hppleWithHTMLData:athleticsdatatime];
    
    NSString *pathforathleticstime =  [ NSString stringWithFormat:@"//table[@class='detail']/tbody/tr/td[1]/a/text()"];
    
    NSArray *athleticsnodetime = [athleticsparser searchWithXPathQuery:pathforathleticstime];
    NSMutableArray *athletictabletime = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element in athleticsnodetime) {
        
        AthleticsObject *object = [[AthleticsObject alloc]init];
        
        [athletictabletime addObject:object];
        
        object.timebig = [element raw];
        
        
        //  NSLog(@"%@" , object.timebig);
        
    }
    NSString *pathforathleticstitle =  [ NSString stringWithFormat:@"//table[@class='detail']/tbody/tr/td[2]/a/text()"];
    
    NSArray *athleticsnodetitle = [athleticsparser searchWithXPathQuery:pathforathleticstitle];
    NSMutableArray *athletictabletitle = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element1 in athleticsnodetitle) {
        
        AthleticsObject *object = [[AthleticsObject alloc]init];
        
        [athletictabletitle addObject:object];
        
        object.titlebig = [element1 raw];
    }
    NSString *pathforathleticslocation =  [ NSString stringWithFormat:@"//table[@class='detail']/tbody/tr/td[3]/a/text()"];
    
    NSArray *athleticsnodelocation = [athleticsparser searchWithXPathQuery:pathforathleticslocation];
    NSMutableArray *athletictablelocation = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element2 in athleticsnodelocation) {
        
        AthleticsObject *object = [[AthleticsObject alloc]init];
        
        [athletictablelocation addObject:object];
        
        object.locationbig = [element2 raw];
    }
    
    locationaray = athletictablelocation;
    titlearay = athletictabletitle;
    timearay = athletictabletime;
    
    [self.tableview reloadData];
    HideHUD;
    
}

- (void)viewDidLoad
{
    UIBarButtonItem *barListBtn = [[UIBarButtonItem alloc]initWithTitle:@"Date" style:UIBarButtonItemStyleBordered target:self action:@selector(changefae)];
    self.navigationItem.rightBarButtonItem = barListBtn;
    
    
    UIBarButtonItem *Menubtn = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(swipeleft)];
    self.navigationItem.leftBarButtonItem = Menubtn;
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ShowHUDwithTitle(@"Loading...");
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self parseathletic];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSDate *now = [NSDate date];
    
    NSString *thedate = [dateFormat stringFromDate:now];
    
    todaydate.text = thedate;

    
    BottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0,40,320,194)];
    [self.view addSubview:BottomView];
    
    Topview = [[UIImageView alloc] initWithFrame:CGRectMake(0,40,320,194)];
    [self.view addSubview:Topview];
    
    
    imageArray = [NSArray arrayWithObjects:
                  [UIImage imageNamed:@"WB - Athletics 2.jpg"],
                  [UIImage imageNamed:@"WB - Athletics 3.jpg"],
                  [UIImage imageNamed:@"WB - Athletics 4.jpg"],
                  [UIImage imageNamed:@"WB - Athletics 5.jpg"] ,
                  nil]; //etc
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:8.0
                                             target:self
                                           selector:@selector(onTimer)
                                           userInfo:nil
                                            repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    
}
-(void)onTimer{
    if(topIndex %2 == 0){
        [UIView animateWithDuration:5.0 animations:^
         {
             Topview.alpha = 0.0;
         }];
        Topview.image = [imageArray objectAtIndex:prevTopIndex];
        BottomView.image = [imageArray objectAtIndex:topIndex];
    }else{
        [UIView animateWithDuration:5.0 animations:^
         {
             Topview.alpha = 1.0;
         }];
        Topview.image = [imageArray objectAtIndex:topIndex];
        BottomView.image = [imageArray objectAtIndex:prevTopIndex];
    }
    prevTopIndex = topIndex;
    if(topIndex == [imageArray count]-2){
        topIndex = 0;
    }else{
        topIndex++;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return timearay.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AthleticsCell";
    AthleticsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    AthleticsObject *tt1 = [titlearay objectAtIndex:indexPath.row];
    AthleticsObject *tt2 = [locationaray objectAtIndex:indexPath.row];
    AthleticsObject *tt3 = [timearay objectAtIndex:indexPath.row];
    cell.title.text = tt1.titlebig;
    cell.time.text = tt3.timebig;
    cell.place.text = tt2.locationbig;
    
    return cell;
    
}

-(void)swipeleft{
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}
-(void)changefae{
    
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"Choose" otherButtonTitles: nil];
    
    
    // Add the picker
    UIDatePicker *pickerView = [[UIDatePicker alloc] init];
    pickerView.datePickerMode = UIDatePickerModeDate;
    [pickerView addTarget:self action:@selector(bro:) forControlEvents:UIControlEventValueChanged];
    
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0,0,320, 450)];
    
    CGRect pickerRect = pickerView.bounds;
    pickerRect.origin.y = -30;
    pickerView.bounds = pickerRect;
    
}

- (void)bro:(UIDatePicker *)sender {
    //NSLog(@"New Date: %@", sender.date);
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    
    NSString *thedate = [dateFormat stringFromDate:sender.date];
    
    //todaydate.text = thedate;
    
    [todaydate setText:thedate];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [self newdate];
}

-(void)newdate {
    
    ShowHUD;
    
    NSString *urldate = [NSString stringWithFormat:@"http://il.8to18.com/willowbrook/dailycalendar/%@/events", todaydate.text];
    
    //NSLog(@"%@" , urldate);
    
    NSURL  *athleticsurltime = [ NSURL URLWithString:urldate];
    
    
    NSData *athleticsdatatime = [[NSData alloc] initWithContentsOfURL:athleticsurltime];
    
    TFHpple *athleticsparser = [TFHpple hppleWithHTMLData:athleticsdatatime];
    
    NSString *pathforathleticstime =  [ NSString stringWithFormat:@"//table[@class='detail']/tbody/tr/td[1]/a/text()"];
    
    NSArray *athleticsnodetime = [athleticsparser searchWithXPathQuery:pathforathleticstime];
    NSMutableArray *athletictabletime = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element in athleticsnodetime) {
        
        AthleticsObject *object = [[AthleticsObject alloc]init];
        
        [athletictabletime addObject:object];
        
        object.timebig = [element raw];
        
        
        NSLog(@"%@" , object.timebig);
        
    }
    NSString *pathforathleticstitle =  [ NSString stringWithFormat:@"//table[@class='detail']/tbody/tr/td[2]/a/text()"];
    
    NSArray *athleticsnodetitle = [athleticsparser searchWithXPathQuery:pathforathleticstitle];
    NSMutableArray *athletictabletitle = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element1 in athleticsnodetitle) {
        
        AthleticsObject *object = [[AthleticsObject alloc]init];
        
        [athletictabletitle addObject:object];
        
        object.titlebig = [element1 raw];
    }
    NSString *pathforathleticslocation =  [ NSString stringWithFormat:@"//table[@class='detail']/tbody/tr/td[3]/a/text()"];
    
    NSArray *athleticsnodelocation = [athleticsparser searchWithXPathQuery:pathforathleticslocation];
    NSMutableArray *athletictablelocation = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (TFHppleElement *element2 in athleticsnodelocation) {
        
        AthleticsObject *object = [[AthleticsObject alloc]init];
        
        [athletictablelocation addObject:object];
        
        object.locationbig = [element2 raw];
        
    }
    locationaray = athletictablelocation;
    titlearay = athletictabletitle;
    timearay = athletictabletime;
    
    [self.tableview reloadData];
    HideHUD;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
