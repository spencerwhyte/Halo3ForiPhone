//
//  Foundry.h
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
#import "Stats.h"

static GLuint foundryTexture;
static GLVertexElement *foundryData;
static int foundryVertexCount;
static unsigned short foundryTriangleCount;// Equivalent to len(mesh.faces)
static GLfloat *foundryVertexArray;
static GLushort *foundryIndexArray;

static GLuint texture2;
static GLVertexElement *data2;
static int vertexCount2;
static unsigned short triangleCount2;// Equivalent to len(mesh.faces)
static bool menu;
static GLuint textures[4];
@interface Foundry : NSObject {

}

+ (NSError *)loadBlenderObject:(NSString *)fileName;
+ (void)draw;
+ (NSError *)loadTexture:(NSString *)fileName;
+ (void)loadTexture:(NSString *)fileName forIndex:(int)index;
@end
