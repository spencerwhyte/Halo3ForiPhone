//
// Bridge
//  MC
//
//  Created by spencer whyte on 01/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"
#import "HaloObject.h"

static  GLVertexElement *data;
static  GLuint texture;
static  int vertexCount;
static  unsigned short triangleCount;
static  NSMutableArray *bridges;
@interface Bridge : HaloObject {
	bool orientation;
}
-(id)init;
+(void)draw;
+(void)loadTextures;
+(void)loadModel;
+(NSMutableArray*)getBridges;
@property bool orientation;
@end
