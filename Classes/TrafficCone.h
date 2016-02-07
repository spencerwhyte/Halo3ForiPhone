//
//  TrafficCone.h
//  MC
//
//  Created by spencer whyte on 09-09-29.
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
static  GLfloat *vertexArray;
static  GLushort *indexArray;


@interface TrafficCone : HaloObject {
	
}
-(id)init;
- (void)draw;
+(void)loadModel;
@end
