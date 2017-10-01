//
//  AHNNewsOperation.m
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "AHNNewsOperation.h"
#import "AHNNewsXMLParser.h"

@interface AHNNewsOperation ()

@property (nonatomic, retain) AHNNewsXMLParser *XMLParser;

@end

@implementation AHNNewsOperation

- (void)dealloc {
	self.rssTitleString = nil;
	self.XMLParser = nil;
	self.newsArray = nil;
	self.error = nil;
	[super dealloc];
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_XMLParser = [[AHNNewsXMLParser alloc] init];
	}
	return self;
}

- (void)main {
	if (self.isCancelled) {
		return;
	}
	
	NSError *error = nil;
	NSString *URLString = @"http://images.apple.com/main/rss/hotnews/hotnews.rss";
	NSArray *newsArray = [self.XMLParser parseURLString:URLString error:&error];
	
	if (self.isCancelled) {
		return;
	}
	
	self.rssTitleString = self.XMLParser.rssTitleString;
	self.newsArray = newsArray;
	self.error = error;
}

@end
