//
//  Player.h
//  Halo 3
//
//  Created by spencer whyte on 09-10-10.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "DoubleBox.h"
#import "Bridge.h"
#import "HUD.h"
#import "Medal.h"
#import "NetworkPlayer.h"
#import <time.h>
#import "ScoreKeeper.h"
#import "SniperRifle.h"

@interface LocalPlayer : NSObject {
	int deaths;
	int kills;
	int suicides;
	GLfloat x;
	GLfloat y;
	GLfloat z;
	GLfloat centerX;
	GLfloat centerY;
	GLfloat centerZ;
	float speedX;
	float speedY;
	float speedZ;
	bool forward;
	bool backward;
	bool turnLeft;
	bool turnRight;
	bool moveRight;
	bool moveLeft;
	bool turnUp;
	bool turnDown;
	float way ;
	bool weaponFired;
	int teamID;
}
@property GLfloat x;
@property GLfloat y;
@property GLfloat z;
@property GLfloat centerX;
@property GLfloat centerY;
@property GLfloat centerZ;
@property float speedY;
@property bool forward;
@property bool backward;
@property bool turnLeft;
@property bool turnRight;
@property bool moveRight;
@property bool moveLeft;
@property bool turnUp;
@property bool turnDown;
@property int teamID;
-(void)physics;
-(void)collision;
-(void)fireWeapon;
-(void)stopFireWeapon;
-(id)init;
+(id)getLocalPlayer;
@end
LocalPlayer *lp;
