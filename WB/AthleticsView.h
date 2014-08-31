//
//  AthleticsView.h
//  WB
//
//  Created by Owner on 4/30/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AthleticsCell.h"
#import "TFHpple.h"
#import "AthleticsObject.h"


@interface AthleticsView : UIViewController <UITableViewDataSource , UITableViewDelegate , UIActionSheetDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UILabel *todaydate;

@property (nonatomic,strong) NSMutableArray *titlearay;
@property (nonatomic,strong) NSMutableArray *locationaray;
@property (nonatomic,strong) NSMutableArray *timearay;



@end
