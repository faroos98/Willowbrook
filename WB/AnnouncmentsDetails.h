//
//  AnnouncmentsDetails.h
//  WB
//
//  Created by Owner on 4/26/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncmentsDetails : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *anndetaillabel;


@property (weak, nonatomic) IBOutlet UILabel *anndesclabel;

@property (nonatomic, strong) NSString *top;
@property (nonatomic, strong) NSString *bottom;

@end
