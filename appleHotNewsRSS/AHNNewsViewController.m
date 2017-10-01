//
//  AHNNewsViewController.m
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "AHNNewsViewController.h"
#import "AHNNewsService.h"
#import "AHNNewsCell.h"
#import "AHNFeedWebViewController.h"

@interface AHNNewsViewController () <AHNNewsServiceDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, retain) AHNNewsService *newsService;
@property (nonatomic, retain) UITableView *tableView;
@end

@implementation AHNNewsViewController

- (void)dealloc {
	self.activityIndicatorView = nil;
	self.newsService = nil;
	self.tableView = nil;
	[super dealloc];
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_newsService = [[AHNNewsService alloc] init];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	self.navigationController.navigationBar.translucent = NO;
	
	[self createTableView];
	
	self.newsService.delegate = self;
	[self.newsService loadNews];
	
	[self createActivityIndicator];
	[self.activityIndicatorView startAnimating];
}

- (void)createActivityIndicator {
	self.activityIndicatorView =
	[[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.activityIndicatorView];
	
	NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.activityIndicatorView
															   attribute:NSLayoutAttributeCenterX
															   relatedBy:NSLayoutRelationEqual
																  toItem:self.view
															   attribute:NSLayoutAttributeCenterX
															  multiplier:1.f constant:0.f];
	NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.activityIndicatorView
															   attribute:NSLayoutAttributeCenterY
															   relatedBy:NSLayoutRelationEqual
																  toItem:self.view
															   attribute:NSLayoutAttributeCenterY
															  multiplier:1.f constant:0.f];
	[self.view addConstraints:@[centerX, centerY]];
}

- (void)createTableView {
	self.tableView = [[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] autorelease];
	self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.tableView registerClass:[AHNNewsCell class] forCellReuseIdentifier:NSStringFromClass([AHNNewsCell class])];
	self.tableView.delegate = self;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	[self.view addSubview:self.tableView];
	
	id topLayoutGuide = self.topLayoutGuide;
	UITableView *tableView = self.tableView;
	NSArray *horConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
												  options:0
												  metrics:nil
													views:NSDictionaryOfVariableBindings(tableView)];
	NSArray *vertConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][tableView]|"
												   options:0
												   metrics:nil
													 views:NSDictionaryOfVariableBindings(topLayoutGuide, tableView)];
	[self.view addConstraints:horConstraints];
	[self.view addConstraints:vertConstraints];
}

#pragma mark - AHNNewsServiceDelegate

- (void)receiveNews {
	[self.activityIndicatorView stopAnimating];
	self.tableView.dataSource = self;
	[self.tableView reloadData];
}

- (void)receiveTitle:(NSString *)title {
	self.navigationItem.title = title;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.newsService newsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	AHNNewsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AHNNewsCell class])];
	AHNNews *newsItem = [self.newsService newsForIndex:indexPath.row];
	[cell setItem:newsItem];
	return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat height = [[self.newsService newsForIndex:indexPath.row] heightCellForWidth:CGRectGetWidth(self.tableView.bounds)];
	return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	AHNFeedWebViewController *feedVC = [[[AHNFeedWebViewController alloc] init] autorelease];
	AHNNews *newsItem = [self.newsService newsForIndex:indexPath.row];
	feedVC.newsItem = newsItem;
	[self.navigationController pushViewController:feedVC animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
