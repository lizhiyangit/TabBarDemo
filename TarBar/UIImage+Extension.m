//
//  UIImage+Extension.m
//  sqsmarttravelservices
//
//  Created by tldkj on 15/12/2.
//  Copyright © 2015年 lzy. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


+(UIImage *)resizableImageWithName:(NSString *)fileName andW:(CGFloat)w andH:(CGFloat)h
{
    UIImage * norImage= [UIImage imageNamed: fileName];
    CGFloat  width =  norImage.size.width;
    CGFloat  height =norImage.size.height;
    CGFloat edgeW = width* w;
    CGFloat edgeH = height*h ;
    UIImage *newImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(edgeH, edgeW, edgeH, edgeW) resizingMode:UIImageResizingModeStretch];
    return newImage;
    
}


@end
