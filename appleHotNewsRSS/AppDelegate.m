//
//  AppDelegate.m
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import "AppDelegate.h"
#import "AHNNewsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)dealloc {
	self.window = nil;
	[super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	AHNNewsViewController *newsVC = [[[AHNNewsViewController alloc] init] autorelease];
	UINavigationController *navVC = [[[UINavigationController alloc] initWithRootViewController:newsVC] autorelease];
	self.window = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
	self.window.rootViewController = navVC;
	[self.window makeKeyAndVisible];
	return YES;
}


@end
