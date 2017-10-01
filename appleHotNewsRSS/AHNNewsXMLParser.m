//
//  AHNNewsXMLParser.m
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "AHNNewsXMLParser.h"

@interface AHNNewsXMLParser () <NSXMLParserDelegate>

@property (nonatomic, retain) NSXMLParser *XMLParser;
@property (nonatomic, retain) NSMutableArray<AHNNews *> *newsArray;
@property (nonatomic, retain) AHNNews *tempNews;
@property (nonatomic, retain) NSString *currentElement;
@property (nonatomic, retain) NSMutableString *foundValue;

@property (nonatomic, assign) BOOL isChannel;

@property (nonatomic, assign) NSError **error;
@property (nonatomic, assign) dispatch_semaphore_t semaphore;

@end

@implementation AHNNewsXMLParser

- (void)dealloc
{
	self.rssTitleString = nil;
	self.XMLParser = nil;
	self.newsArray = nil;
	self.tempNews = nil;
	self.currentElement = nil;
	self.foundValue = nil;
	[super dealloc];
}

- (NSArray<AHNNews *> *)parseURLString:(NSString *)URLString error:(NSError **)error
{
	NSURL *URL = [NSURL URLWithString:URLString];
	self.XMLParser = [[[NSXMLParser alloc] initWithContentsOfURL:URL] autorelease];
	
	self.XMLParser.delegate = self;

	self.foundValue = [[[NSMutableString alloc] init] autorelease];
	self.isChannel = NO;
	
	[self.XMLParser parse];
	
	return [[self.newsArray copy] autorelease];
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	self.newsArray = [[[NSMutableArray alloc] init] autorelease];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	if (self.newsArray.count == 0) {
		NSError *error = [NSError errorWithDomain:@"com.AHNNewsDomain.nodata"
											 code:0
										 userInfo:nil];
		if (self.error != NULL) {
			*self.error = error;
		}
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	if (self.error != NULL) {
		*self.error = parseError;
	}
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI
 qualifiedName:(nullable NSString *)qName
	attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
	
	if ([elementName isEqualToString:@"channel"]) {
		self.isChannel = YES;
	}
	if ([elementName isEqualToString:@"item"]) {
		self.tempNews = [[[AHNNews alloc] init] autorelease];
	}
	
	self.currentElement = elementName;
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(nullable NSString *)namespaceURI
 qualifiedName:(nullable NSString *)qName {
	
	if ([elementName isEqualToString:@"item"]) {
		[self.newsArray addObject:self.tempNews];
	}
	else if ([elementName isEqualToString:@"title"]) {
		self.tempNews.newsTitle = [[self.foundValue copy] autorelease];
	}
	else if ([elementName isEqualToString:@"link"]) {
		self.tempNews.feedURLString = [[self.foundValue copy] autorelease];
	}
	else if ([elementName isEqualToString:@"description"]) {
		self.tempNews.newsDescription = [[self.foundValue copy] autorelease];
	}
	if ([elementName isEqualToString:@"title"] && self.isChannel) {
		self.rssTitleString = [[self.foundValue copy] autorelease];
		self.isChannel = NO;
	}
	
	[self.foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if ([self.currentElement isEqualToString:@"title"] ||
		[self.currentElement isEqualToString:@"link"] ||
		[self.currentElement isEqualToString:@"description"]) {
		
		if (![string isEqualToString:@"\n"]) {
			[self.foundValue appendString:string];
		}
	}
}

@end
