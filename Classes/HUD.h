//
//  HUD.h
//  MC
//
//  Created by spencer whyte on 23/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BattleRifle.h"
#import "SniperRifle.h"
#import "SMG.h"
#import "Medal.h"
#import "AVFoundation/AVAudioPlayer.h"
#import <AVFoundation/AVAudioSession.h>
#import "LocalPlayer.h"
#import "NetworkPlayer.h"
#include <mach/mach.h>
#include <mach/mach_time.h>
static GLuint textureHUD;
static GLuint medals;
static GLuint text;

static float health;
static bool loaded;
static id primaryWeapon;
static id secondaryWeapon;
static int place;
static int medalx;
static int medaly;
static int hasWaited;
static NSMutableArray * currentMedals;
static NSMutableArray * requestedMedals;
static bool enemyInSight;
static bool friendlyInSight;
static GLuint sweeper;
static float sweeperProgress;
static GLuint radarPlayer;
static GLfloat hasMovedx;
static GLfloat hasMovedy;
static GLfloat hasMovedz;
static int hasMovedTime;
static id lpp;
static int h;
static int textFrame;
static uint64_t timed;
static 	GLubyte *textureData8;
AVAudioPlayer *doubleKillSound;
AVAudioPlayer *killingSpreeSound;
AVAudioPlayer *killingFrenzySound;
AVAudioPlayer *sniperSpreeSound;
AVAudioPlayer *sharpshooterSound;
AVAudioPlayer *runningRiotSound;
AVAudioPlayer *untouchableSound;
NSMutableArray *currentMedalSounds;
static NSMutableArray * currentTextFrame;
static NSMutableArray * currentTextIndex;
@interface HUD : NSObject<AVAudioPlayerDelegate> {

}
+ (void)loadHUDImages;
+(void)draw;
+(void)setHealth: (float)h;
+(void)setLoaded: (bool)l;
+(void)setPrimaryWeapon:(id)weapon;
+(void)setSecondaryWeapon:(id)weapon;
+(id)getPrimaryWeapon;
+(id)getSecondaryWeapon;
+(void)awardMedal:(int)medalID;
+(void)enemyInSight;
+(void)enemyOutOfSight;
+(void)friendlyInSight;
+(void)friendlyOutOfSight;
+(void)saveReferenceToLocalPlayer;
+(void)postMessage:(NSString*)message;
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
@end
HUD *delegateO;