//
//  AHNNewsXMLParser.h
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AHNNews;

@interface AHNNewsXMLParser : NSObject

@property (nonatomic, retain) NSString *rssTitleString;
- (NSArray<AHNNews *> *)parseURLString:(NSString *)URLString error:(NSError **)error;

@end
