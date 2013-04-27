//
//  MoveScaleImageView.h
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define min_offset 10 //定义手势最小移动距离为5，小于此距离的移动不处理

@interface MoveScaleImageView : UIView{
	UIImage* originImage;//原图
	
	UIImageView* imageView;
	CGPoint gestureStartPoint;//手势开始时起点
	CGFloat offsetX,offsetY;//移动时x,y方向上的偏移量

	CGFloat originSpace;//两个手指的初始距离
	CGFloat scale;//缩放比例
	CGRect lensRect;//设置镜头的大小
}
- (void)setImage:(CGImageRef)imageRef;
- (void)setImage:(CGImageRef)imageRef withScaleTo:(CGFloat)s moveToX:(CGFloat)x ToY:(CGFloat)y;
- (void)moveToX:(CGFloat)x ToY:(CGFloat)y;
- (CGFloat)spaceToPoint:(CGPoint)first FromPoint:(CGPoint)two;
- (void)scaleTo:(CGFloat)x;
- (void)resetLens:(CGPoint)point;
- (void)resetMonitor;
@end
