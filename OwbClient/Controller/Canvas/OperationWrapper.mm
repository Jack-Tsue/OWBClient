//
//  OperationWrapper.m
//  OwbClient
//
//  Created by Jack on 28/4/13.
//  Copyright (c) 2013 Jack. All rights reserved.
//

#import "OperationWrapper.h"
#define realPosition(a) CGPointMake((a.x+self.offX_)*self.scale_, (a.y+self.offY_)*self.scale_)

#define screenStart CGPointMake((self.start_.x-self.offX_)*self.scale_, (self.start_.y-self.offY_)*self.scale_)
#define screenEnd CGPointMake((self.end_.x-self.offX_)*self.scale_, (self.end_.y-self.offY_)*self.scale_)

static OperationWrapper *instance = nil;
DrawPoint *midDrawPoint;
DrawLine *midDrawLine;
DrawRectange *midDrawRect;
DrawEllipse *midDrawEllipse;
Erase *midErase;

@implementation OperationWrapper
+ (OperationWrapper *)SharedOperationWrapper {
    if (nil == instance) {
        instance = [[OperationWrapper alloc] init];
        instance.opType_ = POINT;
        instance.alpha_ = 1.0;
        instance.thickness_ = 1;
        instance.color_ = 0;
        midDrawPoint = [[DrawPoint alloc] init];
        midDrawLine = [[DrawLine alloc] init];
        midDrawRect = [[DrawRectange alloc] init];
        midDrawEllipse = [[DrawEllipse alloc] init];
        midErase = [[Erase alloc] init];
    }
    return instance;
}

- (OwbClientOperation *)wrap
{
    switch (self.opType_) {
        case POINT:
        {
            DrawPoint *drawPoint = [[DrawPoint alloc] init];
            drawPoint.color_ = self.color_;
            drawPoint.thinkness_ = self.thickness_/self.scale_;
            drawPoint.alpha_ = self.alpha_;
            drawPoint.position_ = realPosition(self.end_);
            drawPoint.isStart_ = self.isStart_;
//            NSLog(@"****** point is start: %d *******", drawPoint.isStart_);
            self.isStart_ = NO;
            return drawPoint;
        }
            break;
        case LINE:
        {
            DrawLine *drawLine = [[DrawLine alloc] init];
            drawLine.color_ = self.color_;
            drawLine.thinkness_ = self.thickness_/self.scale_;
            drawLine.alpha_ = self.alpha_;
            drawLine.startPoint_ = realPosition(self.start_);
            drawLine.endPoint_ = realPosition(self.end_);
//            NSLog(@"-------Line----");
            return drawLine;
            
        }
            break;
        case RECT:
        {
            DrawRectange *drawRect = [[DrawRectange alloc] init];
            drawRect.color_ = self.color_;
            drawRect.thinkness_ = self.thickness_/self.scale_;
            drawRect.alpha_ = self.alpha_;
            drawRect.topLeftCorner_ = (self.start_);
            drawRect.bottomRightCorner_ = (self.end_);
            NSLog(@"====== rect topLeft: (%f, %f); bottomRight: (%f, %f) =========", drawRect.topLeftCorner_.x, drawRect.topLeftCorner_.y, drawRect.bottomRightCorner_.x, drawRect.bottomRightCorner_.y);
            return drawRect;
        }
            break;
        case ELLIPSE:
        {
            DrawEllipse *drawEllipse = [[DrawEllipse alloc] init];
            drawEllipse.color_ = self.color_;
            drawEllipse.thinkness_ = self.thickness_/self.scale_;
            drawEllipse.alpha_ = self.alpha_;
            drawEllipse.center_ = realPosition(CGPointMake((self.start_.x+self.end_.x)/2, (self.start_.y+self.end_.y)/2));
            drawEllipse.a_ = fabs(realPosition(self.start_).x-realPosition(self.end_).x)/2;
            drawEllipse.b_ = fabs(realPosition(self.start_).y-realPosition(self.end_).y)/2;
//            NSLog(@"{{{{{ center: %f, %f; a: %f, b: %f ; left top: (%f, %f)}}}}}", drawEllipse.center_.x, drawEllipse.center_.y, drawEllipse.a_, drawEllipse.b_, (self.start_.x+self.end_.x), (self.start_.y+self.end_.y));
            return drawEllipse;
        }
            break;
        case ERASER:
        {
            Erase *erase = [[Erase alloc] init];
            erase.thinkness_ = 12*self.thickness_/self.scale_;
            erase.position_ = realPosition(self.end_);
            erase.isStart_ = self.isStart_;
            self.isStart_ = NO;
            return erase;
        }
            break;
    }
}

- (OwbClientOperation *)wrapMiddle
{
    switch (self.opType_) {
        case POINT:
        {
            DrawPoint *drawPoint = [[DrawPoint alloc] init];
            drawPoint.color_ = self.color_;
            drawPoint.thinkness_ = self.thickness_;
            drawPoint.alpha_ = self.alpha_;
            drawPoint.position_ = screenEnd;
            drawPoint.isStart_ = self.isStart_;
            //            NSLog(@"****** point is start: %d *******", drawPoint.isStart_);
            self.isStart_ = NO;
            return drawPoint;
        }
            break;
        case LINE:
        {
            DrawLine *drawLine = [[DrawLine alloc] init];
            drawLine.color_ = self.color_;
            drawLine.thinkness_ = self.thickness_;
            drawLine.alpha_ = self.alpha_;
            drawLine.startPoint_ = screenStart ;
            drawLine.endPoint_ = screenEnd;
            //            NSLog(@"-------Line----");
            return drawLine;
            
        }
            break;
        case RECT:
        {
            DrawRectange *drawRect = [[DrawRectange alloc] init];
            drawRect.color_ = self.color_;
            drawRect.thinkness_ = self.thickness_;
            drawRect.alpha_ = self.alpha_;
            drawRect.topLeftCorner_ = screenStart;
            drawRect.bottomRightCorner_ = screenEnd;
            return drawRect;
        }
            break;
        case ELLIPSE:
        {
            DrawEllipse *drawEllipse = [[DrawEllipse alloc] init];
            drawEllipse.color_ = self.color_;
            drawEllipse.thinkness_ = self.thickness_;
            drawEllipse.alpha_ = self.alpha_;
            drawEllipse.center_ = (CGPointMake((screenStart.x+screenEnd.x)/2, (screenStart.y+screenEnd.y)/2));
            drawEllipse.a_ = fabs((screenStart).x-(screenEnd).x)/2;
            drawEllipse.b_ = fabs((screenStart).y-(screenEnd).y)/2;
            //            NSLog(@"{{{{{ center: %f, %f; a: %f, b: %f ; left top: (%f, %f)}}}}}", drawEllipse.center_.x, drawEllipse.center_.y, drawEllipse.a_, drawEllipse.b_, (self.start_.x+self.end_.x), (self.start_.y+self.end_.y));
            return drawEllipse;
        }
            break;
        case ERASER:
        {
            Erase *erase = [[Erase alloc] init];
            erase.thinkness_ = 12*self.thickness_;
            erase.position_ = realPosition(self.end_);
            erase.isStart_ = self.isStart_;
            self.isStart_ = NO;
            return erase;
        }
            break;
    }
}
@end
