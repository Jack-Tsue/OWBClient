//
//  MoveScaleImageView.m
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "MoveScaleImageView.h"


@implementation MoveScaleImageView

- (void)display
{
    [super display];
    [self setNeedsDisplay];
}

-(id)initWithFrame:(CGRect)frame{
	if (self=[super initWithFrame:frame]) {
		imageView=[[UIImageView alloc]initWithFrame:frame];
        NSLog(@"Board Data: %@", [[BoardModel SharedBoard] getData]);
        [self setClearsContextBeforeDrawing:YES];
        self.isDrawable_ = [[BoardModel SharedBoard] inHostMode_];
        imageView.backgroundColor = [UIColor clearColor];
        [self setImage:[[BoardModel SharedBoard] getData]];
//        UIImage *background = [UIImage imageWithCGImage: [[BoardModel SharedBoard] getData]];
//        imageView.image = background;
		[self addSubview:imageView];
//        [self sendSubviewToBack:imageView];
		[self setUserInteractionEnabled:YES];
		[self setMultipleTouchEnabled:YES];
		scale=1;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef tmpContextRef= UIGraphicsGetCurrentContext();
    NSLog(@"tmp context: %@; image ref: %@", tmpContextRef, imageRef_);
    CGContextDrawImage(tmpContextRef, rect, imageRef_);
}
-(void)setImage:(CGImageRef)imageRef{
    CGImageRelease(imageRef_);
    NSLog(@"image ref: %@", imageRef);
    imageRef_ = imageRef;
//	originImage=nil;
//	originImage=[[UIImage alloc]initWithCGImage:imageRef];
//	lensRect=imageView.frame;
//	[self moveToX:0 ToY:0];
//    UIGraphicsBeginImageContext
    
//    imageView.image = [[UIImage alloc]initWithCGImage:imageRef];
 //   imageView.image = [UIImage imageWithCGImage:imageRef];
    
}

- (CGImageRef)resetImage:(CGImageRef)imageRef
{
    originImage=nil;
	originImage=[[UIImage alloc]initWithCGImage:imageRef];
	lensRect=imageView.frame;
    [self scaleTo:scale];
    [self moveToX:offsetX ToY:offsetY];
    return imageView.image.CGImage;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if ([touches count]==2) {//识别两点触摸,并记录两点间距离
		NSArray* twoTouches=[touches allObjects];
		originSpace=[self spaceToPoint:[[twoTouches objectAtIndex:0] locationInView:self]
						FromPoint:[[twoTouches objectAtIndex:1]locationInView:self]];
        NSLog(@"scale start");
        NSLog(@"is drawable: %d", self.isDrawable_);
        // 记录移动开始
        UITouch *touch=[[touches allObjects] objectAtIndex:1];
		gestureStartPoint=[touch locationInView:self];
	}else if ([touches count]==3){
		
	}else if([touches count]==1 && self.isDrawable_){
        NSLog(@"draw start");
        UITouch *touch=[touches anyObject];
		drawStartPoint=[touch locationInView:self];
        [[OperationWrapper SharedOperationWrapper] setStart_:CGPointMake(offsetX+drawStartPoint.x/scale, offsetY+drawStartPoint.y/scale)];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if ([touches count]==2) {
		NSArray* twoTouches=[touches allObjects];
		CGFloat currSpace=[self spaceToPoint:[[twoTouches objectAtIndex:0] locationInView:self]
							 FromPoint:[[twoTouches objectAtIndex:1]locationInView:self]];
		//如果先触摸一根手指，再触摸另一根手指，则触发touchesMoved方法而不是touchesBegan方法
		//此时originSpace应该是0，我们要正确设置它的值为当前检测到的距离，否则可能导致0除错误
		if (originSpace==0) {
			originSpace=currSpace;
		}
		if (fabsf(currSpace-originSpace)>=min_offset) {//两指间移动距离超过min_offset，识别为手势“捏合”
			CGFloat s=currSpace/originSpace;//计算缩放比例
			[self scaleTo:s];		
			originSpace=currSpace;
		} else {    // 两指合拢，识别为移动
            UITouch* touch=[[touches allObjects] objectAtIndex:1];
            CGPoint curr_point=[touch locationInView:self];
            //分别计算x，和y方向上的移动量
            offsetX=curr_point.x-gestureStartPoint.x;
            offsetY=curr_point.y-gestureStartPoint.y;
            recordX+=offsetX/scale;
            recordY+=offsetY/scale;
            //只要在任一方向上移动的距离超过Min_offset,判定手势有效
            if(fabsf(offsetX)>= min_offset||fabsf(offsetY)>=min_offset){
                [self moveToX:offsetX ToY:offsetY];
                gestureStartPoint.x=curr_point.x;
                gestureStartPoint.y=curr_point.y;
            }
        }
	}else if([touches count]==3){
		
	}else if([touches count]==1 && self.isDrawable_){
        UITouch* touch=[touches anyObject];
		CGPoint currPoint=[touch locationInView:self];
        [[OperationWrapper SharedOperationWrapper] setEnd_:CGPointMake(offsetX+currPoint.x/scale, offsetY+currPoint.y/scale)];
        [[OperationWrapper SharedOperationWrapper] setScale_:scale];
        if ([[OperationWrapper SharedOperationWrapper] opType_] == POINT || [[OperationWrapper SharedOperationWrapper] opType_] == ERASER) {
            [[OperationWrapper SharedOperationWrapper] setScale_:scale];
            OwbClientOperation *tmpOp = [[OperationWrapper SharedOperationWrapper] wrap];
            NSLog(@"******** point tmp op: %@", tmpOp);
            NSLog(@"tmp op thickness: %d", tmpOp.thinkness_);
            [[BoardModel SharedBoard] drawOperation:tmpOp];
//            [[QueueHandler SharedQueueHandler] drawOperationToServer:[[OperationWrapper SharedOperationWrapper] wrap]];
        } else {
            NSLog(@"------- middle shared operation type: %d, thinckness: %d", [[OperationWrapper SharedOperationWrapper] opType_], [[OperationWrapper SharedOperationWrapper] thickness_]);
            [[BoardModel SharedBoard] drawMiddleOperation:[[OperationWrapper SharedOperationWrapper] wrapMid]];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if([touches count]==1 && self.isDrawable_){
        UITouch* touch=[touches anyObject];
		CGPoint currPoint=[touch locationInView:self];
        if ([[OperationWrapper SharedOperationWrapper] opType_] == POINT || [[OperationWrapper SharedOperationWrapper] opType_] == ERASER) {
        } else if([[OperationWrapper SharedOperationWrapper] opType_] == RECT){
            if(offsetX>0) {
                [[OperationWrapper SharedOperationWrapper] setEnd_:CGPointMake(offsetX+currPoint.x/scale, offsetY+currPoint.y/scale)];
            } else {
                [[OperationWrapper SharedOperationWrapper] setEnd_:[[OperationWrapper SharedOperationWrapper] start_]];
                [[OperationWrapper SharedOperationWrapper] setStart_:CGPointMake(offsetX+currPoint.x/scale, offsetY+currPoint.y/scale)];
            }
            [[OperationWrapper SharedOperationWrapper] setScale_:scale];
            NSLog(@"end shared operation type: %d, thinckness: %d", [[OperationWrapper SharedOperationWrapper] opType_], [[OperationWrapper SharedOperationWrapper] thickness_]);
            [[BoardModel SharedBoard] drawOperation:[[OperationWrapper SharedOperationWrapper] wrap]];
            //        [[QueueHandler SharedQueueHandler] drawOperationToServer:[[OperationWrapper SharedOperationWrapper] wrap]];
        }else {
            [[OperationWrapper SharedOperationWrapper] setEnd_:CGPointMake(offsetX+currPoint.x/scale, offsetY+currPoint.y/scale)];
            [[OperationWrapper SharedOperationWrapper] setScale_:scale];
            NSLog(@"end shared operation type: %d, thinckness: %d", [[OperationWrapper SharedOperationWrapper] opType_], [[OperationWrapper SharedOperationWrapper] thickness_]);
            [[BoardModel SharedBoard] drawOperation:[[OperationWrapper SharedOperationWrapper] wrap]];
            //        [[QueueHandler SharedQueueHandler] drawOperationToServer:[[OperationWrapper SharedOperationWrapper] wrap]];
        }
    }
}

-(void)moveToX:(CGFloat)x ToY:(CGFloat)y{
	CGPoint point=CGPointMake(x, y);
	//重设镜头
	[self resetLens:point];

    imageView.image=[UIImage imageWithCGImage:CGImageCreateWithImageInRect([originImage CGImage], lensRect)]; 
	[self resetMonitor];
//	NSLog(@"lensRect x=%f,y=%f,width=%f,height=%f",lensRect.origin.x,lensRect.origin.y,lensRect.size.width,lensRect.size.height);

}

-(void)resetLens:(CGPoint)point{//设置镜头大小和位置
//	NSLog(@"restlens");
	CGFloat x,y,width,height;
	//===========镜头初始大小=========
	width=self.frame.size.width/scale;
	height=self.frame.size.height/scale;
	
	//===========调整镜大小不得超过图像实际大小==========
	if(width>originImage.size.width){
		width=originImage.size.width;
	}
	if (height>originImage.size.height) {
		height=originImage.size.height;
	}
//	height=(self.frame.size.height>originImage.size.height)?
//		originImage.size.height/scale:self.frame.size.height/scale;
	//===========调整镜头至合适位置===========
	//计算镜头移动的位置（等比缩放）
	x=lensRect.origin.x-point.x/scale;
	y=lensRect.origin.y-point.y/scale;

	//左边界越界处理
	x=(x<0)?0:x;
	//上边界越界处理
	y=(y<0)?0:y;
	
	//右边界越界
	x=(x+width>originImage.size.width)?originImage.size.width-width:x;
	//下边界越界处理
	y=(y+height>originImage.size.height)?originImage.size.height-height:y;
	
	//镜头等比缩放
	lensRect=CGRectMake(x, y, width, height);
}
-(CGFloat)spaceToPoint:(CGPoint)first FromPoint:(CGPoint)two{//计算两点之间的距离
	float x = first.x - two.x;
	float y = first.y - two.y;
	return sqrt(x * x + y * y);
}
-(void)scaleTo:(CGFloat)x{
	scale*=x;
	//缩放限制：>＝0.1，<=10
	scale=(scale<0.1)?0.1:scale;
	scale=(scale>10)?10:scale;
	
	//重设imageView的frame
	[self moveToX:offsetX*scale ToY:offsetX*scale];

}
-(void)resetMonitor{
	CGFloat width,height;
	width=lensRect.size.width*scale;
	height=lensRect.size.height*scale;
	[imageView setFrame:CGRectMake(0, 0, width, height)];
	[self setNeedsDisplay];
}
@end
