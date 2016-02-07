//
//  HaloObject.m
//  MC
//
//  Created by spencer whyte on 09-09-26.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HaloObject.h"


@implementation HaloObject
-(id)init
{
    if (self = [super init])
    {
		self.x = 0.0f;
		self.y = 0.0f;
		self.z = 0.0f;
		self.rotationx = 0.0f;
		self.rotationy = 0.0f;
		self.rotationz = 0.0f;
		textureMappingEnabled = true;
    }
    return self;
}
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize rotationx;
@synthesize rotationy;
@synthesize rotationz;
@synthesize textureMappingEnabled;
@synthesize visible;
@end
