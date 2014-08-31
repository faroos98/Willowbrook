//
//  AnnouncmentsDetails.m
//  WB
//
//  Created by Owner on 4/26/14.
//  Copyright (c) 2014 Fares. All rights reserved.
//

#import "AnnouncmentsDetails.h"

@interface AnnouncmentsDetails ()

@end

@implementation AnnouncmentsDetails
@synthesize top ,bottom;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.anndesclabel.text = bottom;
    
    self.anndetaillabel.text = top;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
