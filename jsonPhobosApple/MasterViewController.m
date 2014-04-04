//
//  MasterViewController.m
//  jsonPhobosApple
//
//  Created by Omnipresent on 01/04/14.
//  Copyright (c) 2014 Omnipresent. All rights reserved.
//

#import "MasterViewController.h"
#import "DataClass.h"
#import "Cell.h"
#import "DetailViewController.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController
@synthesize tblView;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    arrData = [[NSMutableArray alloc]init];
    
    NSURL *url = [NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=20/json"];
    
    dispatch_async(kBgQueue, ^{
        NSData *data =[NSData dataWithContentsOfURL:url];
        
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
    [tblView reloadData];

}

- (void)fetchedData: (NSData *) data
{
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSDictionary *dictfeed = [json objectForKey:@"feed"];
    
    NSArray *arrentry = [dictfeed objectForKey:@"entry"];
    
    for (int i=0; i<arrentry.count; i++) {
        DataClass *dcObj = [[DataClass alloc]init];
        NSDictionary *dictName = [arrentry objectAtIndex:i];
        NSDictionary *dictLabel = [dictName objectForKey:@"im:name"];
        NSDictionary *dictPrice = [dictName objectForKey:@"im:price"];
        NSDictionary *dictArtist = [dictName objectForKey:@"im:artist"];
        NSDictionary *dictSummary = [dictName objectForKey:@"summary"];
        NSArray *arrImg = [dictName objectForKey:@"im:image"];
        NSDictionary *dictImg = [arrImg objectAtIndex:1];

        NSString *strName = [dictLabel objectForKey:@"label"];
        NSString *strPrice = [dictPrice objectForKey:@"label"];
        NSString *strArtist = [dictArtist objectForKey:@"label"];
        NSString *strSummary = [dictSummary objectForKey:@"label"];
        NSString *strImg = [dictImg objectForKey:@"label"];
        
        dcObj.strDCName = strName;
        dcObj.strDCPrice = strPrice;
        dcObj.strDCDeveloper = strArtist;
        dcObj.strDCImage = strImg;
        dcObj.strDcSummary = strSummary;
        NSLog(@"strDCName: %@",dcObj.strDCName);
        NSLog(@"strDCPrice: %@",dcObj.strDCPrice);
        NSLog(@"strDCDeveloper: %@",dcObj.strDCDeveloper);
        
        [arrData addObject:dcObj];

    }
    [tblView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    DataClass *dcObj = [arrData objectAtIndex:indexPath.row];
    Cell *cell = [tblView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    //NSDate *object = _objects[indexPath.row];
    
    cell.lblName.text =dcObj.strDCName;
    cell.lblDeveloper.text = dcObj.strDCDeveloper;
    //UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dcObj.strDCImage]]]];
    cell.imgLogo.image= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dcObj.strDCImage]]];
    [cell.btnPrice setTitle:dcObj.strDCPrice forState:UIControlStateNormal];
    NSLog(@"lblName: %@",dcObj.strDCName);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_objects removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DataClass *dcObj = [arrData objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] setDetailItem:dcObj];
    }
}

@end
