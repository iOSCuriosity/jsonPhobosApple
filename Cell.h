//
//  Cell.h
//  jsonPhobosApple
//
//  Created by Omnipresent on 01/04/14.
//  Copyright (c) 2014 Omnipresent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
{
    UILabel *lblName;
    UILabel *lblDeveloper;
    UIButton *btnPrice;
    UIImageView *imgLogo;
}

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblDeveloper;
@property (strong, nonatomic) IBOutlet UIButton *btnPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
- (IBAction)btnClickPrice:(id)sender;

@end
