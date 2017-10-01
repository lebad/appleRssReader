//
//  AHNNewsOperation.h
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AHNNewsXMLParser;
@class AHNNews;

@interface AHNNewsOperation : NSOperation

@property (nonatomic, retain) NSString *rssTitleString;
@property (nonatomic, retain) NSArray<AHNNews *> *newsArray;
@property (nonatomic, retain) NSError *error;

@end
