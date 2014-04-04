//
//  DataClass.h
//  jsonPhobosApple
//
//  Created by Omnipresent on 01/04/14.
//  Copyright (c) 2014 Omnipresent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataClass : NSObject
{
        NSString *strDCName;
        NSString *strDCDeveloper;
        NSString *strDCPrice;
        NSString *strDCImage;
        NSString *strDcSummary;
}

@property (strong, nonatomic) NSString *strDCName;
@property (strong, nonatomic) NSString *strDCDeveloper;
@property (strong, nonatomic) NSString *strDCPrice;
@property (strong, nonatomic) NSString *strDCImage;
@property (strong, nonatomic) NSString *strDcSummary;


@end
