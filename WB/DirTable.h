//
//  DirTable.h
//  WB School
//
//  Created by Owner on 3/30/14.
//  Copyright (c) 2014 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface DirTable : UITableViewController <UITabBarControllerDelegate>




@property (nonatomic,strong) NSMutableArray *_objects;
@property (nonatomic,strong) NSMutableArray *_objects2;
@property (nonatomic, strong) NSMutableArray *_objects3;




- (IBAction)menubtn2:(id)sender;


@end
