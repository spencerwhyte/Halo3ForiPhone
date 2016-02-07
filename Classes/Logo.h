//
//  logo.h
//  MC
//
//  Created by spencer whyte on 09-09-25.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"

static GLVertexElement *data;
static GLuint texture;
static int vertexCount;
static  unsigned short triangleCount;
static  GLfloat *vertexArray;
static GLushort *indexArray;

static GLuint texture;
@interface Logo : NSObject {
	float rotation;
}
-(void)draw;
+(void)loadTextures;
+(void)loadModel;
-(id)init;
@end
