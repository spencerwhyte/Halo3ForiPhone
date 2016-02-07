//
//  SniperRifle.h
//  MC
//
//  Created by spencer whyte on 30/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"
#import "HaloObject.h"
#import "Stats.h"
#import "Contrail.h"
static GLVertexElement *data;
static  GLuint texture;
static int vertexCount;
static  unsigned short triangleCount;
static GLuint contrailTexture;
static NSMutableArray *contrails;
static GLuint muzzleFlash;

@interface SniperRifle : HaloObject {
	int animationFrame;
	float animation[11];
	bool firing;
	bool fp;
}
-(id)init;
- (void)draw;
+(void)drawContrails;
+(void)loadTextures;
+(void)loadModel;
+(void)drawSniperRifles;
+(NSMutableArray *)getContrials;
+(NSMutableArray *)getSniperRifles;
-(void)fire;
-(void)stopFire;
@property bool firing;
@property bool fp;
@end
