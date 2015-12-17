//
//  UIImage+Extension.h
//  sqsmarttravelservices
//
//  Created by tldkj on 15/12/2.
//  Copyright © 2015年 lzy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *传入图片的名称 返回一张拉伸不变形的图片
 *  @param name imageName
 *
 *  @return UIImage
 */

+(UIImage *) resizableImageWithName:(NSString * ) fileName   andW :(CGFloat )  w  andH :(CGFloat ) h ;


@end
