//
//  NSString+AHNNews.m
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "NSString+AHNNews.h"

@implementation NSString (AHNNews)

- (CGSize)mySizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
	return [self mySizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
}

- (CGSize)mySizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
	NSMutableParagraphStyle *paragraph = [[[NSMutableParagraphStyle alloc] init] autorelease];
	paragraph.lineBreakMode = lineBreakMode;
	
	NSDictionary *attrs = @{
							NSFontAttributeName: font,
							NSParagraphStyleAttributeName: paragraph,
							};
	return [self boundingRectWithSize:size
							  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
						   attributes:attrs
							  context:nil].size;
}

@end
