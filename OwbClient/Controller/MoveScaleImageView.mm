//
//  MoveScaleImageView.m
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "MoveScaleImageView.h"
#define TEST_TIMES 1

#define setOffsetX if ((offsetX+tmpX*scale)<0) { \
                         offsetX=0; \
                     } else if((offsetX+tmpX*scale+CanvasWidth*scale)>CanvasWidth*3) { \
                         return; \
                     } else { \
                         offsetX += tmpX*scale; \
                     }

#define setOffsetY if ((offsetY+tmpY*scale)<0) { \
                         offsetY=0; \
                     } else if((offsetY+tmpY*scale+CanvasHeight*scale)>CanvasHeight*3) { \
                         return; \
                     } else { \
                         offsetY += tmpY*scale; \
                     }

@implementation MoveScaleImageView

- (void)display
{
    [super display];
    [self setNeedsDisplay];
}

-(id)initWithFrame:(CGRect)frame{
	if (self=[super initWithFrame:frame]) {
        offsetX=0;
        offsetY=0;
//        NSLog(@"Board Data: %@", [[BoardModel SharedBoard] getData]);
        [self setClearsContextBeforeDrawing:YES];
        self.isDrawable_ = [[BoardModel SharedBoard] inHostMode_];
        [self setImage:[[BoardModel SharedBoard] getData]];
//        UIImage *background = [UIImage imageWithCGImage: [[BoardModel SharedBoard] getData]];
//        imageView.image = background;
//        [self sendSubviewToBack:imageView];
		[self setUserInteractionEnabled:YES];
		[self setMultipleTouchEnabled:YES];
		scale=1;
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [displayImage_ drawInRect:rect];
    if (isInMiddle_) {
        NSLog(@"==M==");
        isInMiddle_ = NO;
        [[middle_op_ drawer_]draw:middle_op_ InCanvas:UIGraphicsGetCurrentContext()];
        middle_op_ = nil;
    }
    NSLog(@"scale: %f; x: %f; y: %f", scale, offsetX, offsetY);
}

-(void)setImage:(CGImageRef)imageRef{
    CGImageRef tmpBoard = [[BoardModel SharedBoard] getData];
    CGImageRef tmpShot = [self getScreenShot:tmpBoard];
    displayImage_ = [self setToFitScreen:tmpShot];
    CGImageRelease(tmpShot);
    CGImageRelease(tmpBoard);
}

- (CGImageRef)getScreenShot:(CGImageRef)boardShot
{
    return CGImageCreateWithImageInRect(boardShot, CGRectMake(offsetX, offsetY, CanvasWidth*scale, CanvasHeight*scale));
//    CGImageCreateCopy(boardShot);
}

- (UIImage *)setToFitScreen:(CGImageRef)screenShot
{
    UIGraphicsBeginImageContext(CGSizeMake(CanvasWidth, CanvasHeight));
    [[UIImage imageWithCGImage:screenShot] drawInRect:CGRectMake(0, 0, CanvasWidth, CanvasHeight)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if ([touches count]==2&& !self.isDrawable_) {//识别两点触摸,并记录两点间距离
		NSArray* twoTouches=[touches allObjects];
		originSpace=[self spaceToPoint:[[twoTouches objectAtIndex:0] locationInView:self]
						FromPoint:[[twoTouches objectAtIndex:1]locationInView:self]];
        NSLog(@"scale start");
//        NSLog(@"is drawable: %d", self.isDrawable_);
       
	}else if ([touches count]==3){
        
	}else if([touches count]==1 && self.isDrawable_){
//        NSLog(@"draw start");
        UITouch *touch=[touches anyObject];
		drawStartPoint=[touch locationInView:self];
        [[OperationWrapper SharedOperationWrapper] setStart_:CGPointMake(offsetX+drawStartPoint.x/scale, offsetY+drawStartPoint.y/scale)];
        if ([[OperationWrapper SharedOperationWrapper] opType_] == POINT || [[OperationWrapper SharedOperationWrapper] opType_] == ERASER) {
            [[OperationWrapper SharedOperationWrapper] setIsStart_:YES];
        } else {
            [[OperationWrapper SharedOperationWrapper] setIsStart_:NO];
        }
    } else if([touches count]==1 && !self.isDrawable_){
        // 记录移动开始
        UITouch *touch=[touches anyObject];
		gestureStartPoint=[touch locationInView:self];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if ([touches count]==2&& !self.isDrawable_) {
		NSArray* twoTouches=[touches allObjects];
		CGFloat currSpace=[self spaceToPoint:[[twoTouches objectAtIndex:0] locationInView:self]
							 FromPoint:[[twoTouches objectAtIndex:1]locationInView:self]];
		//如果先触摸一根手指，再触摸另一根手指，则触发touchesMoved方法而不是touchesBegan方法
		//此时originSpace应该是0，我们要正确设置它的值为当前检测到的距离，否则可能导致0除错误
		if (originSpace==0) {
			originSpace=currSpace;
		}
		if (fabsf(currSpace-originSpace)>=min_offset) {//两指间移动距离超过min_offset，识别为手势“捏合”
			CGFloat s=originSpace/currSpace;//计算缩放比例
			[self scaleTo:s];		
			originSpace=currSpace;
		} else {    // 两指合拢，识别为移动
            
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
//            NSLog(@"******** point tmp op: %@", tmpOp);
//            NSLog(@"tmp op thickness: %d", tmpOp.thinkness_);
            [[BoardModel SharedBoard] drawOperation:tmpOp];
//            [[QueueHandler SharedQueueHandler] drawOperationToServer:[[OperationWrapper SharedOperationWrapper] wrap]];
        } else {
//            NSLog(@"------- middle shared operation type: %d, thinckness: %d", [[OperationWrapper SharedOperationWrapper] opType_], [[OperationWrapper SharedOperationWrapper] thickness_]);
            /*[[BoardModel SharedBoard] drawMiddleOperation:[[OperationWrapper SharedOperationWrapper] wrapMid]];*/
//            imageView.image = nil;
            middle_op_ = [[OperationWrapper SharedOperationWrapper] wrapMiddle];
            isInMiddle_ = YES;
            [self setNeedsDisplay];
        }
    }
    else if([touches count]==1 && !self.isDrawable_){
        UITouch* touch=[touches anyObject];
        CGPoint curr_point=[touch locationInView:self];
        //分别计算x，和y方向上的移动量
        tmpX=-(curr_point.x-gestureStartPoint.x);
        tmpY=-(curr_point.y-gestureStartPoint.y);
        
        
        setOffsetX;
        setOffsetY;
        //只要在任一方向上移动的距离超过Min_offset,判定手势有效
//        if(fabsf(tmpX)>= min_offset||fabsf(tmpY)>=min_offset){
            gestureStartPoint.x=curr_point.x;
            gestureStartPoint.y=curr_point.y;
//        }
        [[OperationWrapper SharedOperationWrapper] setOffX_:offsetX];
        [[OperationWrapper SharedOperationWrapper] setOffY_:offsetY];
        [self display];
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
//            NSLog(@"end shared operation type: %d, thinckness: %d", [[OperationWrapper SharedOperationWrapper] opType_], [[OperationWrapper SharedOperationWrapper] thickness_]);
            NSLog(@"end: (%f, %f)", drawStartPoint.x, drawStartPoint.y);

            [[BoardModel SharedBoard] drawOperation:[[OperationWrapper SharedOperationWrapper] wrap]];
            //        [[QueueHandler SharedQueueHandler] drawOperationToServer:[[OperationWrapper SharedOperationWrapper] wrap]];
        }else {
            [[OperationWrapper SharedOperationWrapper] setEnd_:CGPointMake(offsetX+currPoint.x/scale, offsetY+currPoint.y/scale)];
            [[OperationWrapper SharedOperationWrapper] setScale_:scale];
//            NSLog(@"end shared operation type: %d, thinckness: %d", [[OperationWrapper SharedOperationWrapper] opType_], [[OperationWrapper SharedOperationWrapper] thickness_]);
            for (int i=0;i<TEST_TIMES;i++) {
                [[BoardModel SharedBoard] drawOperation:[[OperationWrapper SharedOperationWrapper] wrap]];
            }
            //        [[QueueHandler SharedQueueHandler] drawOperationToServer:[[OperationWrapper SharedOperationWrapper] wrap]];
        }
    }
}

-(void)scaleTo:(CGFloat)x{
	scale*=x;
	//缩放限制：>＝0.1，<=10
	scale=(scale<1)?1:scale;
	scale=(scale>3)?3:scale;
    [self display];
}

-(CGFloat)spaceToPoint:(CGPoint)first FromPoint:(CGPoint)two{//计算两点之间的距离
	float x = first.x - two.x;
	float y = first.y - two.y;
	return sqrt(x * x + y * y);
}
@end
