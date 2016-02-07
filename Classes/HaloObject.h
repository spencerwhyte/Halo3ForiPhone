//
//  HaloObject.h
//  MC
//
//  Created by spencer whyte on 09-09-26.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"

@interface HaloObject : NSObject {
	float x;
	float y;
	float z;
	float rotationy;
	float rotationx;
	float rotationz;
	bool textureMappingEnabled;
	bool visible;
}
-(id) init;
@property float x;
@property float y;
@property float z;
@property float rotationy;
@property float rotationx;
@property float rotationz;
@property bool textureMappingEnabled;
@property bool visible;
@end
