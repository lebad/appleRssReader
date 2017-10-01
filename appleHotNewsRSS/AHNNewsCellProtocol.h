//
//  AHNNewsCellProtocol.h
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AHNNewsItemPresentableProtocol.h"

@protocol AHNNewsCellProtocol <NSObject>

- (void)setItem:(id<AHNNewsItemPresentableProtocol>)item;

@end
