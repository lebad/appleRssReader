//
//  AHNNews.h
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHNNewsItemPresentableProtocol.h"

@interface AHNNews : NSObject <AHNNewsItemPresentableProtocol>

@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *newsDescription;
@property (nonatomic, copy) NSString *feedURLString;

@end
