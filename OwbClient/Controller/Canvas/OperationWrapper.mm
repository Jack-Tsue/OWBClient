//
//  OperationWrapper.m
//  OwbClient
//
//  Created by Jack on 28/4/13.
//  Copyright (c) 2013 Jack. All rights reserved.
//

#import "OperationWrapper.h"
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
            drawPoint.position_ = self.start_;
            NSLog(@"in point wraper, position: %f", self.alpha_);
            return drawPoint;
        }
            break;
        case LINE:
        {
            DrawLine *drawLine = [[DrawLine alloc] init];
            drawLine.color_ = self.color_;
            drawLine.thinkness_ = self.thickness_/self.scale_;
            drawLine.alpha_ = self.alpha_;
            drawLine.startPoint_ = self.start_;
            drawLine.endPoint_ = self.end_;
            return drawLine;
            
        }
            break;
        case RECT:
        {
            DrawRectange *drawRect = [[DrawRectange alloc] init];
            drawRect.color_ = self.color_;
            drawRect.thinkness_ = self.thickness_/self.scale_;
            drawRect.alpha_ = self.alpha_;
            drawRect.topLeftCorner_ = self.start_;
            drawRect.bottomRightCorner_ = self.end_;
            return drawRect;
        }
            break;
        case ELLIPSE:
        {
            DrawEllipse *drawEllipse = [[DrawEllipse alloc] init];
            drawEllipse.color_ = self.color_;
            drawEllipse.thinkness_ = self.thickness_/self.scale_;
            drawEllipse.alpha_ = self.alpha_;
            drawEllipse.center_ = CGPointMake((self.start_.x+self.end_.x)/2, (self.start_.y+self.end_.y)/2);
            drawEllipse.a_ = fabs(self.start_.x-self.end_.x)/2;
            drawEllipse.b_ = fabs(self.start_.y-self.end_.y)/2;
            NSLog(@"ELLIPSE start: %f, %f; end: %f, %f;Center: %f, %f",self.start_.x, self.start_.y, self.end_.x, self.end_.y, drawEllipse.a_, drawEllipse.b_);
            return drawEllipse;
        }
            break;
        case ERASER:
        {
            Erase *erase = [[Erase alloc] init];
            erase.thinkness_ = self.thickness_/self.scale_;
            erase.position_ = self.start_;
            return erase;
        }
            break;
    }
}

- (OwbClientOperation *)wrapMid
{
    switch (self.opType_) {
        case POINT:
        {
            midDrawPoint.color_ = self.color_;
            midDrawPoint.thinkness_ = self.thickness_/self.scale_;
            midDrawPoint.alpha_ = self.alpha_;
            midDrawPoint.position_ = self.start_;
            NSLog(@"in mid point wraper, alpha: %f", self.alpha_);
            return midDrawPoint;
        }
            break;
        case LINE:
        {
            midDrawLine.color_ = self.color_;
            midDrawLine.thinkness_ = self.thickness_/self.scale_;
            midDrawLine.alpha_ = self.alpha_;
            midDrawLine.startPoint_ = self.start_;
            midDrawLine.endPoint_ = self.end_;
            return midDrawLine;
            
        }
            break;
        case RECT:
        {
            midDrawRect.color_ = self.color_;
            midDrawRect.thinkness_ = self.thickness_/self.scale_;
            midDrawRect.alpha_ = self.alpha_;
            midDrawRect.topLeftCorner_ = self.start_.x>=self.end_.x?self.start_:self.end_;
            midDrawRect.bottomRightCorner_ = self.start_.x<self.end_.x?self.start_:self.end_;
            return midDrawRect;
        }
            break;
        case ELLIPSE:
        {
            midDrawEllipse.color_ = self.color_;
            midDrawEllipse.thinkness_ = self.thickness_/self.scale_;
            midDrawEllipse.alpha_ = self.alpha_;
            midDrawEllipse.center_ = CGPointMake((self.start_.x+self.end_.x)/2, (self.start_.y+self.end_.y)/2);
            midDrawEllipse.a_ = fabs(self.start_.x-self.end_.x)/2;
            midDrawEllipse.b_ = fabs(self.start_.y-self.end_.y)/2;
            return midDrawEllipse;
        }
            break;
        case ERASER:
        {
            midErase.thinkness_ = self.thickness_/self.scale_;
            midErase.position_ = self.start_;
            return midErase;
        }
            break;
    }
}
@end
