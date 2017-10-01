//
//  AHNFeedWebViewController.m
//  appleHotNewsRSS
//
//  Created by andrey on 01/10/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "AHNFeedWebViewController.h"

@interface AHNFeedWebViewController () <UIWebViewDelegate>
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@end

@implementation AHNFeedWebViewController

- (void)dealloc {
	self.webView = nil;
	self.activityIndicatorView = nil;
	[super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.navigationItem.title = self.newsItem.newsTitle;
	
	[self createWebView];
	self.webView.delegate = self;
	
	NSURL *URL = [NSURL URLWithString:self.newsItem.feedURLString];
	if (!URL) {
		return;
	}
	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
	[self.webView loadRequest:request];
	
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

- (void)createWebView {
	self.webView = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
	self.webView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:self.webView];
	
	UIWebView *webView = self.webView;
	id topLayoutGuide = self.topLayoutGuide;
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|"
											  options:0
											  metrics:nil
												views:NSDictionaryOfVariableBindings(webView)]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][webView]|"
											  options:0
											  metrics:nil
												views:NSDictionaryOfVariableBindings(topLayoutGuide, webView)]];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.activityIndicatorView stopAnimating];
}

@end
