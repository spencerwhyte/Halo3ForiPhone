//
//  Player.h
//  Halo 3
//
//  Created by Spencer Whyte on 10-02-06.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MasterChief.h"
@interface Player : NSObject {
	float x;
	float y;
	float z;
	MasterChief *masterChief;
	float damage;
}
@property float x;
@property float y;
@property float z;
@property float damage;
-(MasterChief *)getMasterChief;
@end
