//
//  OperationWrapper.m
//  OwbClient
//
//  Created by Jack on 28/4/13.
//  Copyright (c) 2013 Jack. All rights reserved.
//

#import "OperationWrapper.h"

@implementation OperationWrapper
- (OwbClientOperation *)wrap
{
    switch (self.opType_) {
        case POINT:
        {
            DrawPoint *drawPoint = [[DrawPoint alloc] init];
            drawPoint.color_ = self.color_;
            drawPoint.thinkness_ = self.thickness_;
            drawPoint.alpha_ = self.alpha_;
            drawPoint.position_ = self.start_;
            return drawPoint;
        }
            break;
        case LINE:
        {
            DrawLine *drawLine = [[DrawLine alloc] init];
            drawLine.color_ = self.color_;
            drawLine.thinkness_ = self.thickness_;
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
            drawRect.thinkness_ = self.thickness_;
            drawRect.alpha_ = self.alpha_;
            drawRect.topLeftCorner_ = self.start_.x>=self.end_.x?self.start_:self.end_;
            drawRect.bottomRightCorner_ = self.start_.x<self.end_.x?self.start_:self.end_;
            return drawRect;
        }
            break;
        case ELLIPSE:
        {
            DrawEllipse *drawEllipse = [[DrawEllipse alloc] init];
            drawEllipse.color_ = self.color_;
            drawEllipse.thinkness_ = self.thickness_;
            drawEllipse.alpha_ = self.alpha_;
            drawEllipse.center_ = CGPointMake((self.start_.x+self.end_.x)/2, (self.start_.y+self.end_.y)/2);
            drawEllipse.a_ = fabs(self.start_.x-self.end_.x)/2;
            drawEllipse.b_ = fabs(self.start_.y-self.end_.y)/2;
            return drawEllipse;
        }
            break;
        case ERASER:
        {
            Erase *erase = [[Erase alloc] init];
            erase.thinkness_ = self.thickness_;
            erase.position_ = self.start_;
            return erase;
        }
            break;
    }
}
@end
