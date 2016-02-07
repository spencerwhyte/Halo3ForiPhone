//
//  HUD.m
//  MC
//
//  Created by spencer whyte on 23/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//


#import "HUD.h"

float mini(float x, float y){
	if(x < y){
		return (float)x;
	}
	return (float)y;
}

float maxi (float x, float y){
	if(x > y){
		return x;	
	}
	return y;
}

@implementation HUD
+(void)loadHUDImages{
	
	timed = mach_absolute_time();
	h = 0;
	textFrame = 0;
	NSString *name = @"hud.png";
	NSLog(name);
	CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
	NSInteger texWidth = CGImageGetWidth(textureImage);
	NSInteger texHeight = CGImageGetHeight(textureImage);
	GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	memset(textureData, 0, texWidth * texHeight * 4);
	CGContextRef textureContext = CGBitmapContextCreate(textureData,texWidth, texHeight,8, texWidth * 4,CGImageGetColorSpace(textureImage),kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	glGenTextures(1, &textureHUD);
    glBindTexture(GL_TEXTURE_2D, textureHUD);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	
	
    textureData8 = (GLubyte *)malloc(128 * 128 * 4);
	memset(textureData8, 0, 128 * 128 * 4);
	currentTextFrame = [[NSMutableArray alloc] init];
	currentTextIndex = [[NSMutableArray alloc] init];
	//[HUD postMessage:@"UvLostTheGame killed Tehpwner"];
	//	[HUD postMessage:@"Tehpwner killed UvLostTheGame"];
	
	NSString *name2 = @"medals.png";
	NSLog(name2);
	CGImageRef textureImage2 = [UIImage imageNamed:name2].CGImage;
	NSInteger texWidth2 = CGImageGetWidth(textureImage2);
	NSInteger texHeight2 = CGImageGetHeight(textureImage2);
	GLubyte *textureData2 = (GLubyte *)malloc(texWidth2 * texHeight2 * 4);
	memset(textureData2, 0, texWidth2 * texHeight2 * 4);
	CGContextRef textureContext2 = CGBitmapContextCreate(textureData2,texWidth2, texHeight2,8, texWidth2 * 4,CGImageGetColorSpace(textureImage2),kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(textureContext2, 0, texHeight2);
	CGContextScaleCTM(textureContext2, 1.0, -1.0);
	CGContextDrawImage(textureContext2, CGRectMake(0.0, 0.0, (float)texWidth2, (float)texHeight2), textureImage2);
	CGContextRelease(textureContext2);
	glGenTextures(1, &medals);
    glBindTexture(GL_TEXTURE_2D, medals);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth2, texHeight2, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData2);
	free(textureData2);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	
	NSString *name3 = @"sweeper.png";
	textureImage2 = [UIImage imageNamed:name3].CGImage;
	texWidth2 = CGImageGetWidth(textureImage2);
	texHeight2 = CGImageGetHeight(textureImage2);
	textureData2 = (GLubyte *)malloc(texWidth2 * texHeight2 * 4);
	memset(textureData2, 0, texWidth2 * texHeight2 * 4);
	textureContext2 = CGBitmapContextCreate(textureData2,texWidth2, texHeight2,8, texWidth2 * 4,CGImageGetColorSpace(textureImage2),kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(textureContext2, 0, texHeight2);
	CGContextScaleCTM(textureContext2, 1.0, -1.0);
	CGContextDrawImage(textureContext2, CGRectMake(0.0, 0.0, (float)texWidth2, (float)texHeight2), textureImage2);
	CGContextRelease(textureContext2);
	glGenTextures(1, &sweeper);
    glBindTexture(GL_TEXTURE_2D, sweeper);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth2, texHeight2, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData2);
	free(textureData2);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	
    name3 = @"radarPlayer.png";
	textureImage2 = [UIImage imageNamed:name3].CGImage;
	texWidth2 = CGImageGetWidth(textureImage2);
	texHeight2 = CGImageGetHeight(textureImage2);
	textureData2 = (GLubyte *)malloc(texWidth2 * texHeight2 * 4);
	memset(textureData2, 0, texWidth2 * texHeight2 * 4);
	textureContext2 = CGBitmapContextCreate(textureData2,texWidth2, texHeight2,8, texWidth2 * 4,CGImageGetColorSpace(textureImage2),kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(textureContext2, 0, texHeight2);
	CGContextScaleCTM(textureContext2, 1.0, -1.0);
	CGContextDrawImage(textureContext2, CGRectMake(0.0, 0.0, (float)texWidth2, (float)texHeight2), textureImage2);
	CGContextRelease(textureContext2);
	glGenTextures(1, &radarPlayer);
    glBindTexture(GL_TEXTURE_2D, radarPlayer);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth2, texHeight2, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData2);
	free(textureData2);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	
	
	
	
	
	health = 0.0f;
	place = 1;
	medalx =0;
	medaly =0;
	currentMedals = [[NSMutableArray alloc] init];
	requestedMedals = [[NSMutableArray alloc] init];
	currentMedalSounds = [[NSMutableArray alloc] init];
	enemyInSight = false;
	delegateO = [[HUD alloc] init];
	
	/*
	 NSString *path = [[NSBundle mainBundle] pathForResource:@"doubleKill" ofType:@"wav"];
	 doubleKillSound =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
	 doubleKillSound.delegate = delegateO; 
	 path = [[NSBundle mainBundle] pathForResource:@"killingSpree" ofType:@"wav"];
	 killingSpreeSound =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
	 killingSpreeSound.delegate =delegateO; 
	 path = [[NSBundle mainBundle] pathForResource:@"killingFrenzy" ofType:@"wav"];
	 killingFrenzySound =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
	 killingFrenzySound.delegate = delegateO; 
	 path = [[NSBundle mainBundle] pathForResource:@"runningRiot" ofType:@"wav"];
	 runningRiotSound =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
	 runningRiotSound.delegate = delegateO; 
	 path = [[NSBundle mainBundle] pathForResource:@"untouchable" ofType:@"wav"];
	 untouchableSound =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
	 untouchableSound.delegate = delegateO; 
	 */
	/*
	 path = [[NSBundle mainBundle] pathForResource:@"sniperSpree" ofType:@"wav"];
	 sniperSpreeSound =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
	 sniperSpreeSound.delegate = self; 
	 path = [[NSBundle mainBundle] pathForResource:@"sharpShooter" ofType:@"wav"];
	 sharpshooterSound =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
	 sharpshooterSound.delegate = self; 
	 */
	
	sweeperProgress = 0.0f;
}

const GLfloat texCoords [] = {
	0.0f,0.0f,
	0.095f,0.0f,
	0.095f,0.75f,
	0.0f,0.75f
};
const GLfloat coords[] = {
	0.0f, 0.0f,-0.5f,
	0.0f, 0.0533333333333333f, -0.5f,
	0.4f, 0.0533333333333333f, -0.5f,
	0.4f, 0.0f, -0.5f
};
const GLfloat brTexCoords [] = {
	0.0f,0.86f,
	0.14f,0.86f,
	0.14f,1.0f,
	0.0f,1.0f
};

const GLfloat sniperTexCoords [] = {
	0.15f,0.94f,
	0.21f,0.94f,
	0.21f,1.0f,
	0.15f,1.0f
};

const GLfloat brCoords[] = {
	-0.04f, 0.04f,-0.5f,
	-0.04f, -0.04f, -0.5f,
	0.04f, -0.04f, -0.5f,
	0.04f, 0.04f, -0.5f
};

const GLfloat sniperCoords[] = {
	-0.012f, 0.012f,-0.5f,
	-0.012f, -0.012f, -0.5f,
	0.012f, -0.012f, -0.5f,
	0.012f, 0.012f, -0.5f
};

const GLfloat visorCoords[] = {
	-0.45f, 0.3f,-0.5f,
	-0.45f, -0.3f, -0.5f,
	0.45f, -0.3f, -0.5f,
	0.45f, 0.3f, -0.5f
};

const GLfloat visorTexCoords[] = {
	0.45f,0.5f,
	0.88f,0.5f,
	0.88f,0.0f,
	0.45f,0.0f
};
const GLfloat radarCoords[] = {
	-0.43f, -0.12f,-0.5f,
	-0.43f, -0.26f, -0.5f,
	-0.26f, -0.26f, -0.5f,
	-0.26f, -0.12f, -0.5f
};
const GLfloat radarTexCoords[] = {
	0.75f,0.78f,
	1.0f,0.78f,
	1.0f,1.0f,
	0.75f,1.0f
};

const GLfloat brTexCoords2 [] = {
	0.55f,0.90f,
	0.55f,0.95f,
	0.75f,0.95f,
	0.75f,0.90f
};
const GLfloat sniperTexCoords2 [] = {
	0.55f,0.85f,
	0.55f,0.90f,
	0.75f,0.90f,
	0.75f,0.85f
};
const GLfloat brCoords2[] = {
	0.43f,0.17f,-0.5f,
	0.43f,0.24f, -0.5f,
	0.21f, 0.24f, -0.5f,
	0.21f, 0.17f, -0.5f
};
const GLfloat smgCoords[] = {
	-0.06f, 0.06f,-0.5f,
	-0.06f, -0.06f, -0.5f,
	0.06f, -0.06f, -0.5f,
	0.06f, 0.06f, -0.5f
};

const GLfloat smgTexCoords[] = {
	0.203125f,-0.34179f,
	0.203125f,-0.47656f,
	0.345703f,-0.47656f,
	0.345703f,-0.34179f
};
const GLfloat smgTexCoords2[] = {
	0.55f,0.59f,
	0.55f,0.65f,
	0.75f,0.65f,
	0.75f,0.59f
};
const GLfloat sweeperCoords[] = {
	-0.07f, 0.085f, -0.5f,
	-0.07f, -0.085f, -0.5f,
	0.07f, -0.085f, -0.5f,
	0.07f, 0.085f, -0.5f
};
const GLfloat sweeperTexCoords[] = {
	0.0f,0.0f,
	1.0f,0.0f,
	1.0f,1.0f,
	0.0f,1.0f
};

const GLfloat radarPlayerCoords[] = {
	-0.008f, 0.008f,-0.5f,
	-0.008f, -0.008f, -0.5f,
	0.008f, -0.008f, -0.5f,
	0.008f, 0.008f, -0.5f
};


/*
 The post message method is a static method of the HUD class that allows you to display messages to the user.
 messsage - A NSString that is the message that is to be displayed. 
 */
+(void)postMessage:(NSString*)message{
	
	
	if([message length] < 34){
		int indexer = 0;
		bool complete = false;
		for(int i = 0 ; i < 9; i++){
			if(complete == true){
				break;
			}
			for(int k = 0 ; k < [currentTextIndex count] ; k++){
				if( [(NSNumber*)[currentTextIndex objectAtIndex:k] intValue] == i ){
					break;
				}
				if(k == [currentTextIndex count] - 1){
					indexer = i;
					complete = true;
					break;
				}
			}
			
		}
		CGContextRef textureContext8 = CGBitmapContextCreate(textureData8,128, 128,8, 128 * 4,CGColorSpaceCreateDeviceRGB(),kCGImageAlphaPremultipliedLast);
		CGContextSetRGBFillColor (textureContext8, 1, 1,1, 1); // 6
		CGContextSetRGBStrokeColor (textureContext8, 1, 1, 1, 1); // 7
		CGContextClearRect(textureContext8, CGRectMake( 0 , 128 - indexer * 13- 9, 128,8));
		CGContextSelectFont (textureContext8, "Verdana",7,kCGEncodingMacRoman);
		CGContextSetCharacterSpacing (textureContext8, 0); // 4
		CGContextSetTextDrawingMode (textureContext8, kCGTextFillStroke); // 5
		CGContextSetRGBFillColor (textureContext8, 1, 1,1, 1); // 6
		CGContextSetRGBStrokeColor (textureContext8, 1, 1, 1, 1); // 7
		CGContextTranslateCTM(textureContext8,0, 128);
		CGContextScaleCTM(textureContext8, 1.0, -1.0);
		CGContextShowTextAtPoint (textureContext8, 0, 3  + indexer * 13, [message UTF8String], [message length]); 
		CGContextRelease(textureContext8);
		glGenTextures(1, &text);
		glBindTexture(GL_TEXTURE_2D, text);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, 128, 128, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData8);
		//free(textureData8);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		[currentTextFrame addObject:[NSNumber numberWithInt:0]];
		[currentTextIndex addObject:[NSNumber numberWithInt:indexer]];
	}else{

	   // [HUD postMessage:[message substringFromIndex:[message length] - [message length]%33    ]];
		NSMutableArray *aba = [[NSMutableArray alloc] init];
		for(int i = 0 ;  i< [message length]; i+=33){
			if(i + 33 < [message length]){
			 [aba addObject:[message substringWithRange:NSMakeRange(i, 33)]];
			}else{
				[aba addObject:[message substringWithRange:NSMakeRange(i, [message length] %33)]];
			}
		}
	    //for(int k = [aba]){
			
		//}
 
	
	}
}




+(void)draw{
	if(health < 1.0){
		health += 0.04f;
	}
	// .4 diff
	const GLfloat fCoords[] = {
		0.002f, 0.0f,-0.5f,
		0.002f, 0.062333333333333f, -0.5f,
		0.4 * health + 0.002, 0.062333333333333f, -0.5f,
		0.4 * health + 0.002, 0.0f, -0.5f
	};
	//.11 diff
	const GLfloat fTexCoords [] = {
		0.085f,0.0f,
		0.195 ,0.0f,
		0.195 ,0.75 * health,
		0.085f,0.75 * health
	};
	
	// Start of Radar sweeper code
    glPushMatrix();
	glDisable(GL_DEPTH_TEST);
	glTexEnvf(GL_TEXTURE_2D,GL_TEXTURE_ENV_MODE,GL_MODULATE);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	if(sweeperProgress < 1.0){
		glPushMatrix();
		glTranslatef(-0.352, -0.19f, 0.0f);
		glRotatef(-90, 0.0f, 0.0f, 1.0f);
		glColor4f(0.8f, 0.8f, 1.0, 0.5f);
		glScalef(sweeperProgress, sweeperProgress, 1.0f);
		glVertexPointer(3, GL_FLOAT, 0, sweeperCoords);
		glTexCoordPointer(2, GL_FLOAT, 0, sweeperTexCoords);
		glBindTexture(GL_TEXTURE_2D, sweeper);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glPopMatrix();
	}
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	sweeperProgress += 0.03;
	if(sweeperProgress > 2.5){
		sweeperProgress = 0.0f;
	}
	//  end of Radar sweeper code
	
	glBindTexture(GL_TEXTURE_2D, textureHUD);
	if(loaded){
		if(enemyInSight){
			glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
		}else if(friendlyInSight){
			glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
		}
		if([primaryWeapon isKindOfClass:[BattleRifle class]]){
			glTexCoordPointer(2, GL_FLOAT, 0, brTexCoords);
			glVertexPointer(3, GL_FLOAT, 0, brCoords);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
			
			glTexCoordPointer(2, GL_FLOAT, 0, brTexCoords2);
			glVertexPointer(3,GL_FLOAT, 0, brCoords2);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			
			//glEnable(GL_TEXTURE_2D);
		}else if([primaryWeapon isKindOfClass:[SniperRifle class]]){
			glTexCoordPointer(2, GL_FLOAT, 0, sniperTexCoords);
			glVertexPointer(3, GL_FLOAT, 0, sniperCoords);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
			glTexCoordPointer(2, GL_FLOAT, 0, sniperTexCoords2);
			glVertexPointer(3,GL_FLOAT, 0, brCoords2);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			
		}else if([primaryWeapon isKindOfClass:[SMG class]]){
			//glDisable(GL_TEXTURE_2D);
			glTexCoordPointer(2, GL_FLOAT, 0, smgTexCoords);
			glVertexPointer(3, GL_FLOAT, 0, smgCoords);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
			
			glTexCoordPointer(2, GL_FLOAT, 0, smgTexCoords2);
			glVertexPointer(3,GL_FLOAT, 0, brCoords2);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glEnable(GL_TEXTURE_2D);
		}
		glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	}
	glColor4f(1.0, 1.0f, 1.0f, 1.0f);
	glTranslatef(-0.2f, 0.2f, 0.0f);
	//Healthbar Outline
	glTexCoordPointer(2, GL_FLOAT, 0, texCoords);
	glVertexPointer(3, GL_FLOAT, 0, coords);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	// Healthbar
	glColor4f(1.0f, 1.0f, 1.0f, 0.7f);
	glTexCoordPointer(2, GL_FLOAT, 0, fTexCoords);
	glVertexPointer(3, GL_FLOAT, 0, fCoords);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	//Visor
	//glTexCoordPointer(2, GL_FLOAT, 0, visorTexCoords);
	//glVertexPointer(3, GL_FLOAT, 0, visorCoords);
	//glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	//radar
	glTranslatef(0.2f, -0.2f, 0.0f);
	glColor4f(0.1f, 0.4f, 1.0f, 1.0f);
	glTexCoordPointer(2, GL_FLOAT, 0, radarTexCoords);
	glVertexPointer(3, GL_FLOAT, 0, radarCoords);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	
	
	
	// Draw the current player on radar
	LocalPlayer*lp = (LocalPlayer*)lpp;
	if(hasMovedx!=lp.x || hasMovedy!=lp.y || hasMovedz !=lp.z){
		hasMovedTime = 0;
		glColor4f(1.0, 0.85, 0.085, 1.0);
		glPushMatrix();
		glTranslatef(-0.352, -0.19f, 0.0f);
		glBindTexture(GL_TEXTURE_2D, radarPlayer);
		glVertexPointer(3, GL_FLOAT, 0, radarPlayerCoords);
		glTexCoordPointer(2, GL_FLOAT, 0, sweeperTexCoords);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glPopMatrix();
	}else if(hasMovedTime < 6){
		glColor4f(1.0, 0.85, 0.085, 1.0);
		glPushMatrix();
		glTranslatef(-0.352, -0.19f, 0.0f);
		glBindTexture(GL_TEXTURE_2D, radarPlayer);
		glVertexPointer(3, GL_FLOAT, 0, radarPlayerCoords);
		glTexCoordPointer(2, GL_FLOAT, 0, sweeperTexCoords);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glPopMatrix();
	}
	hasMovedx = lp.x;
	hasMovedy = lp.y;
	hasMovedz = lp.z;
	hasMovedTime++;
	// Draw all of the other people on radar
	for(int i = 0 ; i < [networkPlayers count]; i++){
		NetworkPlayer * current  = [networkPlayers objectAtIndex:i];	
		if(current.living){
			if((current.x-lp.x)*(current.x-lp.x)+(current.z-lp.z)*(current.z-lp.z) < 5000)
			{
				float diffx =  current.x-lp.x;
				float diffz = current.z - lp.z;
				if(current.teamID!=lp.teamID){ // Enemy
					glColor4f(1.0, 0.085, 0.085, 1.0);
				}else{ // Friendly
					glColor4f(1.0, 0.85, 0.085, 1.0);
				}
				glPushMatrix();
				glTranslatef(-0.352 ,  -0.19f, 0.0f);
				float angle = -atan2(lp.centerX - lp.x,lp.centerZ-lp.z) * (180.0/3.14159265358979);
				glRotatef(angle, 0.0f, 0.0f, 1.0f);		
				glTranslatef( -diffx*0.001,diffz * 0.001, 0.0f);
				glBindTexture(GL_TEXTURE_2D, radarPlayer);
				glVertexPointer(3, GL_FLOAT, 0, radarPlayerCoords);
				glTexCoordPointer(2, GL_FLOAT, 0, sweeperTexCoords);
				glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
				glPopMatrix();
			}
		}
	}
	
	
	
	while([requestedMedals count] > 0){
		int temp =[requestedMedals count]-1;
		[currentMedals addObject:[requestedMedals objectAtIndex:temp]];
		[requestedMedals removeObjectAtIndex:temp];
		while([currentMedals count] > 3){
			[[currentMedals objectAtIndex:0] release];
			[currentMedals removeObjectAtIndex:0];
		}
	}
	for(int i = [currentMedals count]-1;  i >= 0 ; i--){
		glPushMatrix();
		if(i < ([currentMedals count]-4)){
			Medal*currentMedal = [currentMedals objectAtIndex:i];
			const GLfloat medalCoords[] = {
				-0.05f, -0.05f,-0.5f,	
				-0.05f, 0.05f, -0.5f,
				0.05f, 0.05f,-0.5f,
				0.05f, -0.05f,-0.5f
			};
			int	medalx = (currentMedal.medal%8);
			int medaly = floor(currentMedal.medal/8.0f);
			const GLfloat medalTexCoords[]= {
				0.0f + medalx*0.11718, 0.8828125f+ medaly* -0.11718 ,
				0.0f + medalx*0.11718, 1.0f + medaly* -0.11718 ,
				0.11718f+ medalx*0.11718,1.0f + medaly* -0.11718,
				0.11718f+ medalx*0.11718,0.8828125f + medaly* -0.11718
			};
			if(currentMedal.steps < 49){
				currentMedal.steps+=7;
				glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
				glTranslatef(-0.35  + 0.08*([currentMedals count]-1-i) , 0.0f, 0.0f);
				float computed = (1.0/-800)*(currentMedal.steps)*(currentMedal.steps-64);
				glScalef(computed,computed ,1.0f);
				glRotatef(-98+currentMedal.steps*2, 0.0f, 0.0f, 1.0f);
				glBindTexture(GL_TEXTURE_2D, medals);
				glVertexPointer(3, GL_FLOAT, 0, medalCoords);
				glTexCoordPointer(2,GL_FLOAT, 0, medalTexCoords);
				glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			}else{
				if(([currentMedals count]-1-i) == 0){
					currentMedal.steps+=1;
				}else if(([currentMedals count]-1-i) == 1){
					currentMedal.steps+=2;
				}else{
					currentMedal.steps+=3;
				}
				if(currentMedal.steps > 220){
					[[currentMedals objectAtIndex:i] release];
					[currentMedals removeObjectAtIndex:i];	
				}else if(currentMedal.steps >140){
					glColor4f(1.0f, 1.0f, 1.0f,((6400-(currentMedal.steps-140)*(currentMedal.steps-140)))/6400.0f);
					glTranslatef(-0.35 + 0.08*([currentMedals count]-1-i), 0.0f, 0.0f);
					float computed = (1.0/-800)*(49)*(49-64);
					glScalef(computed,computed ,1.0f);
					glRotatef(-98+49*2, 0.0f, 0.0f, 1.0f);
					glBindTexture(GL_TEXTURE_2D, medals);
					glVertexPointer(3, GL_FLOAT, 0, medalCoords);
					glTexCoordPointer(2,GL_FLOAT, 0, medalTexCoords);
					glDrawArrays(GL_TRIANGLE_FAN, 0, 4);	
				}else{
					glColor4f(1.0f, 1.0f, 1.0f, 1.0);
					glTranslatef(-0.35 + 0.08*([currentMedals count]-1-i), 0.0f, 0.0f);
					float computed = (1.0/-800)*(49)*(49-64);
					glScalef(computed,computed ,1.0f);
					glRotatef(-98+49*2, 0.0f, 0.0f, 1.0f);
					glBindTexture(GL_TEXTURE_2D, medals);
					glVertexPointer(3, GL_FLOAT, 0, medalCoords);
					glTexCoordPointer(2,GL_FLOAT, 0, medalTexCoords);
					glDrawArrays(GL_TRIANGLE_FAN, 0, 4);	
				}
			}
		}else{
			[[currentMedals objectAtIndex:i] release];
			[currentMedals removeObjectAtIndex:i];
		}
		glPopMatrix();
	}
	
	
	
	
	
	if(timed- mach_absolute_time() < -100000000){
		timed = mach_absolute_time();
		h++;
		NSLog(@"sugsfs");
		
		//	NSLog(@"elapsed");
	}
	
	
	if(rand()%500 == 50){
		// [HUD postMessage:@"Checkpoint......Done."];
	}
	
	
	
	
	
	
	for(int i = [currentTextIndex count]-1 ; i >=0 ; i--){
		
		textFrame = [(NSNumber *)[currentTextFrame objectAtIndex:i] intValue];
		
		glPushMatrix();
		
		int cy =  [(NSNumber *)[currentTextIndex objectAtIndex:i]intValue];
		const GLfloat currentTextTexCoords [] = {
			0.00f,0.0f + cy * 0.1f,
			0.00f,0.1f + cy * 0.1f,
			1.0f,0.1f + cy*0.1f,
			1.00f,0.0f + cy*0.1f
		};
		const GLfloat currentTextCoords [] = {
			-0.2f,-0.02f,-0.5f,
			-0.2f,0.02f,-0.5f,
			0.2f,0.02f,-0.5f,
			0.2f,-0.02f,-0.5f
		};
		printf("%f\n",500.0f-textFrame/300.0f );
		glTranslatef(0.0f, ( [currentTextIndex count] - i -1 )* -0.025f, 0.0f);
		glTranslatef(-0.38f + mini(pow(textFrame , 1.1),157)/1000.0f, -0.06f + 0.005*( 1- (mini(textFrame,100)/100.0) ), 0.0f);
		glColor4f(0.6f - 0.6*( 1- (mini(textFrame,70)/70.0) ), 0.7925f + 0.2075 * ( 1- (mini(textFrame,70)/70.0) ) , 0.949f - ( 1- (mini(textFrame,70)/70.0) ) * 0.949,        mini(   ((2000.0f-textFrame)/700.0f)  ,1.0f )  );
		glScalef((mini(textFrame,110)/100.0f) - mini(maxi(maxi((float)textFrame - 110, 0)/450.0f, 0.0),0.1 )    , mini(textFrame*10,120)/100.0f    -  mini(maxi(maxi((float)textFrame - 120, 0)/900.0f, 0.0),0.2 )  , 1.0f);
		//glScalef(2.0f, 2.0f, 1.0f);
		glBindTexture(GL_TEXTURE_2D, text);
		glVertexPointer(3, GL_FLOAT, 0, currentTextCoords);
		glTexCoordPointer(2,GL_FLOAT, 0, currentTextTexCoords);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		//glDisable(GL_TEXTURE_2D);
		
		//glDrawArrays(GL_LINE_LOOP, 0, 4);
		//	glEnable(GL_TEXTURE_2D);
		
		
		glPopMatrix();
		
		
		[currentTextFrame replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:textFrame+7]];
		
	}
	/*
	 const GLfloat currentTextTexCoords [] = {
	 0.00f,0.0f,
	 0.00f,1.0f,
	 1.0f,1.0f,
	 1.00f,0.0f
	 };
	 const GLfloat currentTextCoords [] = {
	 -0.2f,-0.2f,-0.5f,
	 -0.2f,0.2f,-0.5f,
	 0.2f,0.2f,-0.5f,
	 0.2f,-0.2f,-0.5f
	 };
	 glPushMatrix();
	 
	 glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	 glBindTexture(GL_TEXTURE_2D, text);
	 glVertexPointer(3, GL_FLOAT, 0, currentTextCoords);
	 glTexCoordPointer(2,GL_FLOAT, 0, currentTextTexCoords);
	 glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	 glDisable(GL_TEXTURE_2D);
	 
	 glDrawArrays(GL_LINE_LOOP, 0, 4);
	 glEnable(GL_TEXTURE_2D);
	 
	 glPopMatrix();
	 */
	for(int i = [currentTextIndex count]-1 ; i >=0 ; i--){
		if([(NSNumber*)[currentTextFrame objectAtIndex:i] intValue] > 2000){
			[currentTextFrame removeObjectAtIndex:i];
			[currentTextIndex removeObjectAtIndex:i];
		}
	}
	
	glColor4f(1.0, 1.0f, 1.0f, 1.0f);
	glEnable(GL_DEPTH_TEST);
	glDisable(GL_BLEND);
	glPopMatrix();
}
+(void)setHealth: (float)h{
	health = h;
	if(h > 1.0f){
		health = 1.0f;
	}
}
+(void)setLoaded: (bool)l{
	loaded  = l;
}
+(void)setPrimaryWeapon:(id)weapon{
	primaryWeapon = weapon;
}
+(void)setSecondaryWeapon: (id) weapon{
	secondaryWeapon = weapon;
}
+(id)getPrimaryWeapon{
	return primaryWeapon;
}

+(id)getSecondaryWeapon{
	return secondaryWeapon;	
}

+(void)awardMedal:(int)medalID{
	[requestedMedals addObject:[[Medal alloc]initWithMedal:medalID]];
	
	printf("%d\n", currentMedalSounds.count);
	
	if(medalID == doubleKill){
		[HUD postMessage:@"Double Kill!"];
	}else if(medalID == killingSpree){
		[HUD postMessage:@"Killing Spree!"];
	}else if(medalID == killingFrenzy){
		[HUD postMessage:@"Killing Frenzy!"];
	}else if(medalID == sniperSpree){
		[HUD postMessage:@"Sniper Spree!"];
	}else if(medalID == sharpShooter){
		[HUD postMessage:@"Sharpshooter!"];
	}else if(medalID == runningRiot){
		[HUD postMessage:@"Running Riot!"];
	}else if(medalID == untouchable){
		[HUD postMessage:@"Untouchable!"];
	}
	
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
	[[currentMedalSounds objectAtIndex:0] release];
	[currentMedalSounds removeObjectAtIndex:0];
	if(currentMedalSounds.count > 0){
		int medalID = [[currentMedalSounds objectAtIndex:0]intValue];
		if(medalID == doubleKill){
			[doubleKillSound play];
			printf("Source DK\n");
		}else if(medalID == killingSpree){
			[killingSpreeSound play];
		}else if(medalID == killingFrenzy){
			[killingFrenzySound play];
		}else if(medalID == sniperSpree){
			[killingSpreeSound play];
		}else if(medalID == sharpShooter){
			[killingFrenzySound play];
		}else if(medalID == runningRiot){
			[runningRiotSound play];
		}
	}
}


+(void)enemyInSight{
	enemyInSight = true;
}
+(void)enemyOutOfSight{
	enemyInSight = false;
}

+(void)friendlyInSight{
	friendlyInSight = true;
}
+(void)friendlyOutOfSight{
	friendlyInSight  = false;	
}
+(void)saveReferenceToLocalPlayer{
	lpp = [LocalPlayer getLocalPlayer];	
	hasMovedx = [lpp x];
	hasMovedy = [lpp y];
	hasMovedz = [lpp z];
}
@end
