//
//  AHNNewsCell.m
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "AHNNewsCell.h"


@interface AHNNewsCell ()

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;

@property (nonatomic, assign) BOOL isUpdatedConstraints;

@end

@implementation AHNNewsCell

- (void)dealloc {
	self.titleLabel = nil;
	self.descriptionLabel = nil;
	[super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		_isUpdatedConstraints = NO;
		[self setupCell];
	}
	return self;
}

- (void)setupCell {
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
	_titleLabel.font = [UIFont systemFontOfSize:15.0];
	_titleLabel.textColor = [UIColor blackColor];
	_titleLabel.numberOfLines = 0;
	[self.contentView addSubview:_titleLabel];
	
	_descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
	_descriptionLabel.font = [UIFont systemFontOfSize:10.0];
	_descriptionLabel.textColor = [UIColor blackColor];
	_descriptionLabel.numberOfLines = 0;
	[self.contentView addSubview:_descriptionLabel];
}

- (void)updateConstraints {
	if (!self.isUpdatedConstraints) {
	
		UILabel *title = self.titleLabel;
		UILabel *description = self.descriptionLabel;
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[title]-|"
										 options:0
										 metrics:nil
										   views:NSDictionaryOfVariableBindings(title)]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[title]-[description]"
										 options:0
										 metrics:nil
										   views:NSDictionaryOfVariableBindings(title, description)]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[description]-|"
										 options:0
										 metrics:nil
										   views:NSDictionaryOfVariableBindings(description)]];
		
		self.isUpdatedConstraints = YES;
	}
	[super updateConstraints];
}


#pragma mark - AHNNewsCellProtocol

- (void)setItem:(id<AHNNewsItemPresentableProtocol>)item {
	NSAssert([item isKindOfClass:[AHNNews class]], @"item is not AHNNews class");
	AHNNews *newsItem = (AHNNews *)item;
	
	self.titleLabel.text = newsItem.newsTitle;
	self.descriptionLabel.text = newsItem.newsDescription;

	[self.contentView setNeedsUpdateConstraints];
}

@end
