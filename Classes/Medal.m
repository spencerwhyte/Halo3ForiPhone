//
//  Medal.m
//  Halo 3
//
//  Created by Spencer Whyte on 10-02-06.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "Medal.h"

@implementation Medal
@synthesize medal;
@synthesize steps;
-(id)initWithMedal:(int)medalID{
	if(self ==[super init]){
		medal = medalID;	
	    steps = 0;
	}
	return self;
}
@end
