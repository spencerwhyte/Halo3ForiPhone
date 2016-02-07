//
//  DoubleBoxOpen.h
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
#import "HaloObject.h"

static GLuint singleBoxTextures[6];
static NSMutableArray *singleBoxes;
@interface SingleBox : HaloObject {
	
}
-(id)init;
+(void)drawSingleBoxes;
+(void)loadTextures;

@end
