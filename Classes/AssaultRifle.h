//
//  AssaultRifle.h
//  MC
//
//  Created by spencer whyte on 09-10-05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"
#import "HaloObject.h"
#import "Stats.h" 
#import "LocalPlayer.h"
static  GLVertexElement *data;
static  GLuint texture55;
static  int vertexCount;
static  unsigned short triangleCount;
static  GLuint assaultRifleFlash;
static NSMutableArray *assaultRifles;


@interface AssaultRifle : HaloObject {
	int reserveAmmo;
	int clipAmmo;
	
	int maxReserveAmmo;
	int maxClipAmmo;
	int damage;
	int animationFrame;
	float animation[8];
	bool firing;
	int reloadingProgress;
	
	
	bool fp;
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
@property bool fp;
@end
