//
//  AHNNewsService.h
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AHNNewsServiceDelegate;

@interface AHNNewsService : NSObject
@property (nonatomic, weak) id<AHNNewsServiceDelegate> delegate;
- (void)loadNews;
- (void)cancel;

- (AHNNews *)newsForIndex:(NSUInteger)index;
- (NSUInteger)newsCount;
@end

@protocol AHNNewsServiceDelegate <NSObject>
- (void)receiveNews;
- (void)receiveTitle:(NSString *)title;
@end
