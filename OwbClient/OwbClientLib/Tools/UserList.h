//
//  UserList.h
//  OwbClient
//
//  Created by Jack on 16/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#ifndef OwbClient_UserList_h
#define OwbClient_UserList_h

#import "RefreshableList.h"

@interface UserList : RefreshableList

@property(strong, nonatomic) NSMutableArray *users;

- (void)refresh;

@end

#endif
