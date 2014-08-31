//
//  StaffDetailsController.h
//  WB
//
//  Created by Owner on 4/26/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StaffDetailsController : UIViewController


@property (nonatomic, strong) NSString *detaillabelcont;


@property (nonatomic ,strong) NSString *numbestring;


@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;



@property (strong, nonatomic) IBOutlet UILabel *numberlabel;

- (IBAction)return:(id)sender;
- (IBAction)call:(id)sender;

@end
