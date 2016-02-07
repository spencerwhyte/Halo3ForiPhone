//
//  EAGLView.h
//  MC
//
//  Created by spencer whyte on 11/07/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "LocalPlayer.h"
#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <Foundation/Foundation.h>
#import "MasterChief.h"
#import "BlenderObject.h"
#import "foundry.h" 
#import "DoubleBox.h"
#import "Bridge.h"
#import "HUD.h"
#import "Ghost.h"
#import "Logo.h"
#import "DoubleBoxOpen.h"
#import "SingleBoxOpen.h"
#import "World.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "SniperRifle.h"
#import "TrafficCone.h"
#import "BattleRifle.h"
#import "SingleBox.h"
#import "Networking.h"
#import "AssaultRifle.h"
#import "NetworkPlayer.h"
#import "Stats.h"
#import "SMG.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Menu.h"
#import "PlasmaGrenade.h"
#import <time.h>
#import "JerseyBarrier.h"
#import "GameKeeper.h"
//#import "Oddball.h"
/*
This class wraps the CAEAGLLayer from CoreAnimation into a convenient UIView subclass.
The view content is basically an EAGL surface you render your OpenGL scene into.
Note that setting the view non-opaque will only work if the EAGL surface has an alpha channel.
*/
static int fer;
@interface EAGLView : UIView <UIAccelerometerDelegate, AVAudioPlayerDelegate> {
bool textureMapping;
	int loaded;
@private
    /* The pixel dimensions of the backbuffer */
    GLint backingWidth;
    GLint backingHeight;
    bool autoRotate;
    EAGLContext *context;
    /* OpenGL names for the renderbuffer and framebuffers used to render to this view */
    GLuint viewRenderbuffer, viewFramebuffer;
    float rotation;
    /* OpenGL name for the depth buffer that is attached to viewFramebuffer, if it exists (0 if it does not exist) */
    GLuint depthRenderbuffer;
    //MasterChief *masterChief[8];
	BlenderObject *assaultRifle;
    NSTimer *animationTimer;
    NSTimeInterval animationInterval;
	DoubleBox *doubleBoxes[10];
	Bridge *bridge;
	Ghost *ghost;
	float modifier;
	Logo *l;
	DoubleBoxOpen *dbo[2];
	SingleBoxOpen *sbo[2];
    JerseyBarrier*jb;
	SniperRifle *sp[3];
	TrafficCone *tc[10];
	BattleRifle *br[3];
	SMG *smg[3];
	LocalPlayer *primaryPlayer;
    GameKeeper * gameKeeper;
	AVAudioPlayer *ap ;
	AVAudioPlayer *ambientFoundry ;
	int first;
	SingleBox *sb[2];
	int gameState; // 0 For normal game play, 2 for menu, 1 for loading
	AssaultRifle *ar[1];
	NSMutableArray *networkPlayers;
	Networking *n;
	MPMoviePlayerController *mpc;
	float menuRotation;
}
@property bool textureMapping;
@property NSTimeInterval animationInterval;
- (void)startAnimation;
- (void)stopAnimation;
- (void)drawView;
-(void)loadEverything;
-(void)setupView;
- (void)loadTexture:(NSString *)fileName forIndex:(int)index;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration;
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
-(void)loadMap;
-(void)unloadMap;
-(void)preMenuFinished;
@end
