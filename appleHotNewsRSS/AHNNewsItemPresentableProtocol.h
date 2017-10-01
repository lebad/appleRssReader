//
//  AHNNewsItemPresentableProtocol.h
//  appleHotNewsRSS
//
//  Created by andrey on 30/09/2017.
//  Copyright © 2017 AndreyLebedev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AHNNewsItemPresentableProtocol <NSObject>
- (CGFloat)heightCellForWidth:(CGFloat)width;
@end
