//
//  EAGLView.m
//  MC
//
//  Created by spencer whyte on 11/07/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//



#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "EAGLView.h"

#define USE_DEPTH_BUFFER 1
#define DEGREES_TO_RADIANS(__ANGLE) ((__ANGLE) / 180.0 * M_PI)
void gluLookAt(GLfloat eyex, GLfloat eyey, GLfloat eyez, GLfloat centerx,
			   GLfloat centery, GLfloat centerz, GLfloat upx, GLfloat upy,
			   GLfloat upz);
// A class extension to declare private methods
@interface EAGLView ()

@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) NSTimer *animationTimer;

- (BOOL) createFramebuffer;
- (void) destroyFramebuffer;

@end


@implementation EAGLView
@synthesize textureMapping;
@synthesize context;
@synthesize animationTimer;
@synthesize animationInterval;
// You must implement this method
+ (Class)layerClass {
    return [CAEAGLLayer class];
}


//The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {
    	printf("Before everything is loaded\n\n\n\n");
    if ((self = [super initWithCoder:coder])) {
		
		[[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
		
        // Get the layer
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        
        eaglLayer.opaque = YES;
        eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
        
        context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
		//EAGLSharegroup *sharegroup = [[EAGLSharegroup alloc] init];
		//context = [[EAGLContext alloc] initWithAPI: kEAGLRenderingAPIOpenGLES1  sharegroup:sharegroup];
        if (!context || ![EAGLContext setCurrentContext:context]) {
            [self release];
            return nil;
        }

		[self setupView];
		animationInterval = 1.0 / 40.0;
		[HUD loadHUDImages];
		UIAccelerometer *uia = [UIAccelerometer sharedAccelerometer];
		uia.delegate = self;
		uia.updateInterval = 1/50;
		loaded = 0;
		self.multipleTouchEnabled = YES;
		gameState = 1;
		
		//mpc = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"preMenu" ofType:@"m4v"]]];
		//mpc.movieControlMode = MPMovieControlModeHidden;
		//mpc.scalingMode = MPMovieScalingModeAspectFill;
	//[[NSNotificationCenter defaultCenter]addObserver: self selector: @selector(preMenuFinished)name: MPMoviePlayerPlaybackDidFinishNotification object: mpc];
		//[mpc play];
		
		
		
	//	ap = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"menuMusic" ofType:@"mp3"]] error:NULL];
    }
	NSLog(@"%f, %f", self.frame.size.width, self.bounds.size.width);
    return self;
}

-(void)preMenuFinished{
	[mpc release];
	[ap play];	
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration {
	if(gameState == 0){
		if (acceleration.z < -0.95f){
			primaryPlayer.forward = true;
			primaryPlayer.backward = false;
		}else if(acceleration.z > -0.85f){
			primaryPlayer.backward = true;
			primaryPlayer.forward = false;
		}else{
			primaryPlayer.forward = false;
			primaryPlayer.backward = false;
		}
		
		if(acceleration.y > 0.2){
			primaryPlayer.moveLeft = true;
			primaryPlayer.moveRight = false;
		}else if(acceleration.y < -0.2){
			primaryPlayer.moveRight = true;
			primaryPlayer.moveLeft = false;
		}else{
			primaryPlayer.moveRight = false;
			primaryPlayer.moveLeft = false;
		}
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	if(gameState == 0){
		NSArray* allTouches = [touches allObjects];
		for(int i = 0 ; i < [allTouches count]; i++){
			float x = [[allTouches objectAtIndex:i] locationInView:self].x;
			float y = [[allTouches objectAtIndex:i] locationInView:self].y;
			if(x > 220 ){ // Up
				if(y < 360){
					if(primaryPlayer.speedY == 0){
						primaryPlayer.speedY = 2.5f;
					}
				}else{
					id temp  =  [HUD getPrimaryWeapon];
					[HUD setPrimaryWeapon:[HUD getSecondaryWeapon]];
					[HUD setSecondaryWeapon:temp];
				
					//[HUD awardMedal:rand() % 55];
				}
			}else if(x < 120){ // Down
				[[HUD getPrimaryWeapon] fire];
				[primaryPlayer fireWeapon];
				//[[PlasmaGrenade alloc] initWithData:primaryPlayer.centerX goingy:primaryPlayer.centerZ startx:primaryPlayer.x starty:primaryPlayer.y startz:primaryPlayer.z];
			}else if(y < 250){ // left
				primaryPlayer.turnLeft = true;
			}else if(y > 250){ // Right
				primaryPlayer.turnRight = true;
			}
		}
	}else if(gameState == 2){
		//[ap stop];
		//[ap release];
		gameState = 0;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	if(gameState == 0){
		NSArray* allTouches = [touches allObjects];
		for(int i = 0 ; i < [allTouches count]; i++){
			float x = [[allTouches objectAtIndex:i] locationInView:self].x;
			float y = [[allTouches objectAtIndex:i] locationInView:self].y;
			if(x > 220){ // Up
				if(y < 360){
					if(primaryPlayer.speedY == 0){
						primaryPlayer.speedY = 2.5f;
					}
				}else{
					
				}
			}else if(x < 120){ // Down
				//	backward = true;
			}else if(y < 250){ // left
				primaryPlayer.moveLeft = true;
			}else if(y > 250){ // Right
				primaryPlayer.turnRight = true;
			}
		}
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	if(gameState == 0){
		[[HUD getPrimaryWeapon] stopFire];
		[primaryPlayer stopFireWeapon];
		primaryPlayer.turnLeft = false;
		primaryPlayer.turnRight = false;
	}
}
-(void)loadEverything{
	
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
	//[ambientFoundry play];
}

-(void)loadMap:(NSString*)mapName{
		
}

//-(void)unloadMap(NSString*)mapName{
	
//}

NSDate *startDate;

int frames;
- (void)drawView {
     
	if(gameState == 0){ // Regular game play
		
		frames++;
		if([[NSDate date] timeIntervalSinceDate:startDate]>1.0){
		//	printf("%d\n", frames);
			frames = 0;
			startDate = [[NSDate date] retain];
		}
	//	printf("%i\n", pollies);
		pollies = 0;
		[primaryPlayer physics];
		[primaryPlayer collision];
		[NetworkPlayer update];
		[EAGLContext setCurrentContext:context];
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		glViewport(0, 0, backingWidth, backingHeight);
		glMatrixMode(GL_MODELVIEW);
		//	glEnableClientState(GL_NORMAL_ARRAY);
		glPushMatrix();
		gluLookAt(primaryPlayer.x, primaryPlayer.y, primaryPlayer.z,primaryPlayer.centerX, primaryPlayer.centerY, primaryPlayer.centerZ, 0.0, 100.0, 0.0f);
		[Foundry draw];
		[DoubleBox drawDoubleBoxes];
		//[PlasmaGrenade draw];
		//[DoubleBoxOpen drawOpenDoubleBoxes];
		[Bridge draw];
		[tc[0] draw];
		//[JerseyBarrier draw];
		//[ghost draw];
		//[SingleBox drawSingleBoxes];
        //[sbo[0] draw];
		//[sp[0] draw ];
		//[br[1] draw];
		//[br[2]draw];
		[MasterChief setLocalx:primaryPlayer.x];
		[MasterChief setLocaly:primaryPlayer.y];
		[MasterChief setLocalz:primaryPlayer.z];
		[MasterChief draw];
		[SniperRifle drawContrails];
		glPopMatrix();
		
        [[HUD getPrimaryWeapon] draw];

		[HUD draw];
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
		[context presentRenderbuffer:GL_RENDERBUFFER_OES];
		if(first ==0){
			first =1;
			//[ap play];
		}
	}else if(gameState == 2){
		[EAGLContext setCurrentContext:context];
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		glViewport(0, 0, backingWidth, backingHeight);
		glMatrixMode(GL_MODELVIEW);
		[Menu draw];
		glClearColor(0,0,0, 1.0);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
		[context presentRenderbuffer:GL_RENDERBUFFER_OES];
	}else if(gameState == 1){ // Loading Foundry
		switch (loaded) {
			case 0:
				startDate = [[NSDate date] retain];
				frames = 0;
				menuRotation = 0.0f;
				//   assaultRifle = [[BlenderObject alloc] init];
				//	[assaultRifle loadBlenderObject:@"f"]; 
				primaryPlayer = [[LocalPlayer alloc] init];
				[HUD saveReferenceToLocalPlayer];
				[MasterChief loadTheChief];
			//	[MasterChief setLocalPlayer: primaryPlayer];
			//	n = [[Networking alloc] init];
			//	[n startServer];
				loaded+=2;
				break;
			case 2 :
				
				
				[JerseyBarrier load];
				jb = [[JerseyBarrier alloc]init];
				
				
				[NetworkPlayer initialize];
				networkPlayers = [[NSMutableArray alloc] init];
				for(int i = 0 ; i<2; i++){
					NetworkPlayer *nu = [[NetworkPlayer alloc] init];
					nu.teamID = 1;
					
					[networkPlayers addObject:nu];
					nu.x = 60-20.0f * i;
					[nu getMasterChief].x = 60-20.0f* i;
					[nu getMasterChief].localPlayer = primaryPlayer;
				}
				[(NetworkPlayer*)[networkPlayers objectAtIndex:0] setName:@"Nate"];
				[(NetworkPlayer*)[networkPlayers objectAtIndex:1] setName:@"Bus Driver"];
				for(int i = 0 ; i<1; i++){
					NetworkPlayer *nu = [[NetworkPlayer alloc] init];
					nu.teamID =0;
					[networkPlayers addObject:nu];
					nu.x = -60 + -20.0f * i;
					[nu getMasterChief].x = -60 + -20.0f* i;
					[nu getMasterChief].localPlayer = primaryPlayer;
				}
				
				[(NetworkPlayer*)[networkPlayers objectAtIndex:2] setName:@"bob100077"];
				[Menu loadTextures];
				loaded+=2;
				break;
			case 4:
			//	[SingleBoxOpen loadModel];
			//	[SingleBoxOpen loadTextures];
				
			//	[DoubleBoxOpen loadModel];
			//	[DoubleBoxOpen loadTextures];
				
				[TrafficCone loadModel];
				for(int i = 0 ; i < 1 ; i++){
					tc[i] = [[TrafficCone alloc] init];
					tc[i].x = 80  +i*-4;
					tc[i].z = -5 + i;
				}
				dbo[0] = [[DoubleBoxOpen alloc] init];
				dbo[0].rotationy = -90.0f;
				dbo[0].z = - 120;
				dbo[1] = [[DoubleBoxOpen alloc] init];
				dbo[1].rotationy = -90.0f;
				dbo[1].z = - 79.7;
				//sbo[0] = [[SingleBoxOpen alloc] init];
				//sbo[1] = [[SingleBoxOpen alloc] init];
				//sbo[0].z = 5.0f;
				[Foundry loadBlenderObject:@"foundry"];
				loaded+=2;
				break;
			case 6:
				[DoubleBox loadTextures];
				loaded+=2;
				//[Ghost loadTextures];
				break;
			case 8:
				loaded+=2;
				[Ghost loadModel];
				
				//[PlasmaGrenade loadModel];
				//[PlasmaGrenade loadTextures];
				break;
			case 10:
				loaded+=2;
				[BattleRifle loadModel];
				[BattleRifle loadTextures];
			
				for(int i = 0 ; i < 3; i++){
					br[i] = [[BattleRifle alloc]init];
					br[i].x = 0.8;
					br[i].z = -2.6f; // Should be -2.6
					br[i].y =-0.7;
				}
				[SMG loadTextures];
				[SMG loadModel];
				for(int i  =  0 ; i < 3; i++){
					smg[i] = [[SMG alloc]init];
					smg[i].x = 0.8;
					smg[i].z = -16.6f; // Should be -2.6
					smg[i].y =-0.7;
				}
				
				[AssaultRifle loadModel];
				[AssaultRifle loadTextures];
				for(int i = 0 ; i < 1; i++){
					ar[i] = [[AssaultRifle alloc]init];
			        ar[i].x = 0.8;
					ar[i].z = -2.6f; // Should be -2.6
					ar[i].y =-0.7;
				}
					printf("Loaded\n");
				
				[SniperRifle loadModel];
						
				[SniperRifle loadTextures];
	
				for(int i = 0 ; i < 2; i++){
					sp[i] = [[SniperRifle alloc] init];
					sp[i].x = 1.0f;
					sp[i].z = -4.5;
					sp[i].y = -1.0f;
				}
				 
				[HUD setPrimaryWeapon:br[0]]; // Set the primary weapon to the SMG
				ar[0].fp = true; // Tell the primary weapon that it is to be drawn in first person
				[HUD setSecondaryWeapon:sp[0]]; // Set the secondary weapon to the Sniper Rifle
                sp[0].fp = true; // Tell the secondary weapon that it is to be drawn is first person
				[Bridge loadTextures]; // Load all of the textures associated with the bridge object
				break;
			case 12:
				timeOfLastKill = time(NULL);
				loaded+=2;
				[Bridge loadModel];
				//loaded+=2;
				
				ghost = [[Ghost alloc]init];
				
				//[Oddball load];
				//Oddball *o = [[Oddball alloc]init];
				
				break;
			case 14:
				loaded+=2;
				bridge = [[Bridge alloc]init];
				bridge.z = -127.0f;
				bridge.x = 40.0f;
				//bridge.y = 20.0f;
				//loaded+=2;
				break;
			case 16:
				loaded+=2;
				[ScoreKeeper newGame];
				
				doubleBoxes[0] = [[DoubleBox  alloc]init];
				doubleBoxes[1] = [[DoubleBox  alloc]init];
				doubleBoxes[2] = [[DoubleBox  alloc]init];
				doubleBoxes[3] = [[DoubleBox  alloc]init];
				doubleBoxes[4] = [[DoubleBox  alloc]init];
				//doubleBoxes[5] = [[DoubleBox  alloc]init];
				//doubleBoxes[6] = [[DoubleBox  alloc]init];
				
				
				doubleBoxes[0].z = -147;
				doubleBoxes[1].z = -126.5;
				doubleBoxes[2].z = -126.5;
				doubleBoxes[3].z = 19;
				doubleBoxes[2].x = 80;
				doubleBoxes[4].z = -60; 
				doubleBoxes[4].orientation = false;
				
				DoubleBox *d = [[DoubleBox alloc] init];
				d.x = 90;
				d.z = -96.0;
				d.orientation = false;
			    
				d= [[DoubleBox alloc] init];
				d.x = -120.5;
				d.z = -137.0;
				d.orientation = false;
			    
				
				
				
				
			//	double
				//[SingleBox loadTextures];
				//sb[0]  = [[SingleBox alloc]init ];
				//sb[1] = [[SingleBox alloc]init ];
				//sb[0].z = 40;
				//sb[1].x = -30;
				textureMapping = true;
				break;
			case 18:
				loaded+=2;
				
				break;
			case 20:
				loaded+=2;
	
				break;
			case 22:
				loaded+=2;
		
				break;
			case 24:
				loaded+=2;
				break;
			case 26:
				loaded+=2;
				rotation = 0.01f;
				autoRotate = true;
				primaryPlayer.x = 0.0;
				primaryPlayer.y = 9.0;
				primaryPlayer.x = 10.0;
				primaryPlayer.centerX = 0.0;
				primaryPlayer.centerY = 9.0;
				primaryPlayer.centerZ = -100.0;
                
                
                GameKeeper * gameKeeper = [[GameKeeper alloc] init];
                [gameKeeper startGame];
				break;
			case 28:
				loaded+=2;
				loaded=100;
                
				HUD.loaded = true;
				/*
				 NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"slayerCallout" ofType:@"mp3"]];
				 ap = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
				 [ap setNumberOfLoops:0];
				 ap.delegate = self;
				 url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"ambientFoundry" ofType:@"mp3"]];
				 ambientFoundry = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
				 [ambientFoundry setNumberOfLoops:-1];
				 [ap play];
				 */
				first = 0;
				gameState = 2;
				break;
				
		}
		[EAGLContext setCurrentContext:context];
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
		glClearColor(0.0, 0.0, 0.0, 1.0);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
		glViewport(0, 0, backingWidth, backingHeight);
		glEnable(GL_TEXTURE_2D);
		glEnableClientState(GL_VERTEX_ARRAY);
		glEnableClientState(GL_TEXTURE_COORD_ARRAY);
		glMatrixMode(GL_MODELVIEW);
		HUD.health = loaded / 68.0f;
		//[HUD draw];
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
		[context presentRenderbuffer:GL_RENDERBUFFER_OES];
	}
}


- (void)layoutSubviews {
    [EAGLContext setCurrentContext:context];
    [self destroyFramebuffer];
    [self createFramebuffer];
    [self drawView];
}


- (BOOL)createFramebuffer {
    
    glGenFramebuffersOES(1, &viewFramebuffer);
    glGenRenderbuffersOES(1, &viewRenderbuffer);
    
    glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(CAEAGLLayer*)self.layer];
    glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
    
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    if (USE_DEPTH_BUFFER) {
        glGenRenderbuffersOES(1, &depthRenderbuffer);
        glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
        glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
        glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);
    }
    
    if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES) {
        NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}

-(void)setupView{
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	glRotatef(-90.0, 0.0, 0.0, 1.0);
	const GLfloat zNear = 0.1, zFar = 430.0, fieldOfView = 60.0;
    GLfloat size;
    glEnable(GL_DEPTH_TEST);
    glMatrixMode(GL_PROJECTION);
    size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);
    CGRect rect = self.bounds;
	glFrustumf( -size / (rect.size.width / rect.size.height),size / (rect.size.width / rect.size.height), -size, size , zNear, zFar);
    glViewport(0, 0, rect.size.width, rect.size.height);
    glClearColor(0.0, 0.0, 0.0, 0.0);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_TEXTURE_2D);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	/*
	glShadeModel(GL_SMOOTH);
	
	glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
	const GLfloat light0Ambient[] = {0.9, 0.9, 0.9, 1.0};
    glLightfv(GL_LIGHT0, GL_AMBIENT, light0Ambient);
	
	const GLfloat light0Diffuse[] = {0.7, 0.7, 0.7, 1.0};
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light0Diffuse);
	
	
	const GLfloat light0Specular[] = {0.9, 0.9, 0.9, 1.0};
	glLightfv(GL_LIGHT0, GL_SPECULAR, light0Specular);
	
	const GLfloat light0Position[] = {10.0, 50.0, 10.0, 0.0}; 
    glLightfv(GL_LIGHT0, GL_POSITION, light0Position);
    */
	
}

- (void)destroyFramebuffer {
    
    glDeleteFramebuffersOES(1, &viewFramebuffer);
    viewFramebuffer = 0;
    glDeleteRenderbuffersOES(1, &viewRenderbuffer);
    viewRenderbuffer = 0;
    
    if(depthRenderbuffer) {
        glDeleteRenderbuffersOES(1, &depthRenderbuffer);
        depthRenderbuffer = 0;
    }
}





- (void)startAnimation {
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:animationInterval target:self selector:@selector(drawView) userInfo:nil repeats:YES];
}


- (void)stopAnimation {
    self.animationTimer = nil;
}


- (void)setAnimationTimer:(NSTimer *)newTimer {
    [animationTimer invalidate];
    animationTimer = newTimer;
}


- (void)setAnimationInterval:(NSTimeInterval)interval {
    
    animationInterval = interval;
    if (animationTimer) {
        [self stopAnimation];
        [self startAnimation];
    }
}


- (void)dealloc {
    
    [self stopAnimation];
    
    if ([EAGLContext currentContext] == context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [context release];  
    [super dealloc];
}
#pragma mark SGI Copyright Functions

/*
 * SGI FREE SOFTWARE LICENSE B (Version 2.0, Sept. 18, 2008)
 * Copyright (C) 1991-2000 Silicon Graphics, Inc. All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice including the dates of first publication and
 * either this permission notice or a reference to
 * http://oss.sgi.com/projects/FreeB/
 * shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * SILICON GRAPHICS, INC. BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Except as contained in this notice, the name of Silicon Graphics, Inc.
 * shall not be used in advertising or otherwise to promote the sale, use or
 * other dealings in this Software without prior written authorization from
 * Silicon Graphics, Inc.
 */

static void normalize(float v[3])
{
    float r;
	
    r = sqrt( v[0]*v[0] + v[1]*v[1] + v[2]*v[2] );
    if (r == 0.0) return;
	
    v[0] /= r;
    v[1] /= r;
    v[2] /= r;
}

static void __gluMakeIdentityf(GLfloat m[16])
{
    m[0+4*0] = 1; m[0+4*1] = 0; m[0+4*2] = 0; m[0+4*3] = 0;
    m[1+4*0] = 0; m[1+4*1] = 1; m[1+4*2] = 0; m[1+4*3] = 0;
    m[2+4*0] = 0; m[2+4*1] = 0; m[2+4*2] = 1; m[2+4*3] = 0;
    m[3+4*0] = 0; m[3+4*1] = 0; m[3+4*2] = 0; m[3+4*3] = 1;
}

static void cross(float v1[3], float v2[3], float result[3])
{
    result[0] = v1[1]*v2[2] - v1[2]*v2[1];
    result[1] = v1[2]*v2[0] - v1[0]*v2[2];
    result[2] = v1[0]*v2[1] - v1[1]*v2[0];
}

void gluLookAt(GLfloat eyex, GLfloat eyey, GLfloat eyez, GLfloat centerx,GLfloat centery, GLfloat centerz, GLfloat upx, GLfloat upy, GLfloat upz)

{
    float forward[3], side[3], up[3];
    GLfloat m[4][4];
	
    forward[0] = centerx - eyex;
    forward[1] = centery - eyey;
    forward[2] = centerz - eyez;
	
    up[0] = upx;
    up[1] = upy;
    up[2] = upz;
	
    normalize(forward);
	
    /* Side = forward x up */
    cross(forward, up, side);
    normalize(side);
	
    /* Recompute up as: up = side x forward */
    cross(side, forward, up);
	
    __gluMakeIdentityf(&m[0][0]);
    m[0][0] = side[0];
    m[1][0] = side[1];
    m[2][0] = side[2];
	
    m[0][1] = up[0];
    m[1][1] = up[1];
    m[2][1] = up[2];
	
    m[0][2] = -forward[0];
    m[1][2] = -forward[1];
    m[2][2] = -forward[2];
	
    glMultMatrixf(&m[0][0]);
    glTranslatef(-eyex, -eyey, -eyez);
}
@end
