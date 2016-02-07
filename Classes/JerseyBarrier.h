//
//  JerseyBarrier.h
//  Halo 3
//
//  Created by Spencer Whyte on 10-03-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
static NSMutableArray*barriers;

@interface JerseyBarrier : HaloObject {

}
+(void)draw;
+(void)load;
+(void)load2;
-(id)init;
@end
