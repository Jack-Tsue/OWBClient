//
//  SnapshotList.h
//  OwbClient
//
//  Created by Jack on 17/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#ifndef OwbClient_SnapshotList_h
#define OwbClient_SnapshotList_h

#import "RefreshableList.h"

@interface SnapshotList : RefreshableList

@property(strong, nonatomic) NSMutableArray *snapshots;

- (void)refresh;
#warning - 'id' should be 'Document'
- (id)getSnapshot:(int)documentID; 

@end


#endif
