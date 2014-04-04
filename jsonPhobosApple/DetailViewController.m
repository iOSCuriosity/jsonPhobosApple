//
//  DetailViewController.m
//  jsonPhobosApple
//
//  Created by Omnipresent on 01/04/14.
//  Copyright (c) 2014 Omnipresent. All rights reserved.
//

#import "DetailViewController.h"
#import "DataClass.h"

@interface DetailViewController ()
{
    DataClass *dcObj;
}
- (void)configureView;
@end

@implementation DetailViewController
@synthesize lblName,lblDeveloper,btnPrice,txtView,imgLogo;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        dcObj=_detailItem;
        self.lblName.text = dcObj.strDCName;
        self.lblDeveloper.text = dcObj.strDCDeveloper;
        [self.btnPrice setTitle:dcObj.strDCPrice forState:UIControlStateNormal];
        self.imgLogo.image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dcObj.strDCImage]]];
        
        self.txtView.text = dcObj.strDcSummary;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = dcObj.strDCName;
    
    
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (IBAction)btnClickPrice:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Thanks" message:@"We appreciate your valuable donaion to our organization." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
