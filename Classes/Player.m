//
//  Player.m
//  Halo 3
//
//  Created by Spencer Whyte on 10-02-06.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Player.h"


@implementation Player
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize damage;
-(MasterChief *)getMasterChief{
	return masterChief;	
}
@end
