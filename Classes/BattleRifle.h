//
//  BattleRifle.h
//  MC
//
//  Created by spencer whyte on 09-10-04.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"
#import "HaloObject.h"
#import "Stats.h"
static GLVertexElement *battleRifleData;
static GLuint texture55;
static int battleRifleVertexCount;
static unsigned short battleRifleTriangleCount;
static  GLuint hudTexture;
static GLuint brNum;
static  GLuint brFlash;
@interface BattleRifle : HaloObject {
	int reserveAmmo;
	int clipAmmo;
	bool firing;
	int maxReserveAmmo;
	int maxClipAmmo;
	int animationFrame;
	float animation[8];
}
-(id)init;
- (void)draw;
+(void)loadTextures;
+(void)loadModel;
+(int)damage;
-(void)drawWeaponHUD;
-(void)fire;
-(void)stopFire;
@property int animationFrame;
@property bool firing;
@end

