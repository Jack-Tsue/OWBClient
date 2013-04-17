//
//  Displayer.h
//  OwbClient
//
//  Created by  tsgsz on 4/17/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DisplayerDataSource <NSObject>
- (CGImageRef) getData;
@end

@protocol DisplayerDelegate <NSObject>

- (CGImageRef) displayerWillRefresh : (id<DisplayerDataSource>) dataSouce_;

@end

@interface Displayer : UIView {
@private
    id<DisplayerDataSource> dataSouce_;
}

- (void) display;
@end
