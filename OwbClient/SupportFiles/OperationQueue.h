//
//  OperationQueue.h
//  OwbClient
//
//  Created by Jack on 16/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#ifndef OwbClient_OperationQueue_h
#define OwbClient_OperationQueue_h

@interface OperationQueue {
private
    NSMutableArray *operations_;
}

#warning - 'id' should be 'Operation' object
- (void)enqueue:(id)operation;
- (id)dequeue;
- (BOOL)isEmpty;
- (id)getHead;

@end

#endif
