//
//  PlasmaGrenade.h
//  Halo 3
//
//  Created by Spencer Whyte on 10-03-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"
#import "HaloObject.h"
#import "DoubleBox.h"
static  GLVertexElement *data;
static  GLuint texture55;
static  int vertexCount;
static  unsigned short triangleCount;
static  GLuint plasmaExplosion;
static GLuint  plasmaBurn;
static  NSMutableArray *grenades;
static int animationFrame2;

@interface PlasmaGrenade : HaloObject {
	float headingx;
	float headingz;
	float speedy;
	int animationFrame;
}
@property float headingx;
@property float headingz;
@property float speedy;
@property int animationFrame;
-(id)initWithData:(float)goingx goingy:(float)goingz startx:(float)startx starty:(float)starty startz:(float)startz;
+ (void)draw;
+(void)loadTextures;
+(void)loadModel;
@end
