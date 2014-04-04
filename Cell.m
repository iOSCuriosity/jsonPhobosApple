//
//  Cell.m
//  jsonPhobosApple
//
//  Created by Omnipresent on 01/04/14.
//  Copyright (c) 2014 Omnipresent. All rights reserved.
//

#import "Cell.h"

@implementation Cell
@synthesize lblDeveloper,lblName,btnPrice,imgLogo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnClickPrice:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thanks" message:@"We appreciate your valuable donaion to our organization." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
