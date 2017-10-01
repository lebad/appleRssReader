//
//  AHNNewsService.m
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "AHNNewsService.h"
#import "AHNNewsOperation.h"

@interface AHNNewsService ()
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) AHNNewsOperation *newsOperation;
@property (nonatomic, retain) NSArray<AHNNews *> *newsArray;
@end

@implementation AHNNewsService

- (void)dealloc {
	self.queue = nil;
	self.newsArray = nil;
	[super dealloc];
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_queue = [[NSOperationQueue alloc] init];
	}
	return self;
}

- (void)loadNews {
	self.newsOperation = [[[AHNNewsOperation alloc] init] autorelease];
	__weak AHNNewsOperation *weakNewsOperation = self.newsOperation;
	__weak typeof(self) weakSelf = self;
	self.newsOperation.completionBlock = ^{
		if (!weakNewsOperation.isCancelled) {
			dispatch_async(dispatch_get_main_queue(), ^{
				if (!weakNewsOperation.error) {
					weakSelf.newsArray = weakNewsOperation.newsArray;
					[weakSelf.delegate receiveTitle:weakNewsOperation.rssTitleString];
					[weakSelf.delegate receiveNews];
				}
			});
		}
	};
	[self.queue addOperation:self.newsOperation];
}

- (void)cancel {
	[self.queue cancelAllOperations];
}

- (AHNNews *)newsForIndex:(NSUInteger)index {
	return self.newsArray[index];
}

- (NSUInteger)newsCount {
	return self.newsArray.count;
}

@end
