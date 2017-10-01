//
//  AHNNews.m
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "AHNNews.h"

static CGFloat AHNTitleLeft = 15.0;
static CGFloat AHNTitleTop = 8.0;

@implementation AHNNews

- (void)dealloc {
	self.newsTitle = nil;
	self.newsDescription = nil;
	self.feedURLString = nil;
	[super dealloc];
}

- (CGFloat)heightCellForWidth:(CGFloat)width {
	width -= 2 * AHNTitleLeft;
	CGFloat titleHeight = [self.newsTitle mySizeWithFont:[UIFont systemFontOfSize:15.0]
								   constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)].height;
	CGFloat descriptionHeight = [self.newsDescription mySizeWithFont:[UIFont systemFontOfSize:10.0]
												   constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)].height;
	return AHNTitleTop*3 + titleHeight + descriptionHeight;
}

@end
