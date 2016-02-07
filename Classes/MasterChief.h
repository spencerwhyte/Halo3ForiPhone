//
//  MasterChief.h
//  MC
//
//  Created by spencer whyte on 11/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"
#import  "HaloObject.h"
#import "Stats.h"
static  GLuint texture;
static GLVertexElement *data;
static int vertexCount;
static unsigned short triangleCount;// Equivalent to len(mesh.faces)

static int vertexCount2;
static  unsigned short triangleCount2;// Equivalent to len(mesh.faces)

static int vertexCount3;
static unsigned short triangleCount3;// Equivalent to len(mesh.faces)
static  NSMutableArray *masterChiefs;


float localx;
 float localy;
float localz;

@interface MasterChief : HaloObject {
	float rotation;
	bool direction;
	bool living;
	float opacity;
	int detailLevel;
	id localPlayer;
    
}
+ (NSError *)loadTheChief;
+ (void)draw;
+ (NSError *)loadTexture:(NSString *)fileName;
-(id)init;
+(void)setLocalx:(float)lx;
+(void)setLocaly:(float)ly;
+(void)setLocalz:(float)lz;
@property float opacity;
@property int detailLevel;
@property id localPlayer;
@end
