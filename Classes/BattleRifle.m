//
//  BattleRifle.m
//  MC
//
//  Created by spencer ; on 09-10-04.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BattleRifle.h"



@implementation BattleRifle
@synthesize animationFrame;
@synthesize firing;
+ (void)loadTextures{
	NSString *name =  @"battleRifle.png";
	CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
	NSInteger texWidth = CGImageGetWidth(textureImage);
	NSInteger texHeight = CGImageGetHeight(textureImage);
	GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	memset(textureData, 0, texWidth*texHeight*4);
	CGContextRef textureContext = CGBitmapContextCreate(textureData,texWidth, texHeight,8, texWidth * 4,CGImageGetColorSpace(textureImage),kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	glGenTextures(1, &texture55);
	glBindTexture(GL_TEXTURE_2D, texture55);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

	 name =  @"brFlash1.png";
	 textureImage = [UIImage imageNamed:name].CGImage;
	 texWidth = CGImageGetWidth(textureImage);
	 texHeight = CGImageGetHeight(textureImage);
	 textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	 memset(textureData, 0, texWidth*texHeight*4);
	 textureContext = CGBitmapContextCreate(textureData,texWidth, texHeight,8, texWidth * 4,CGImageGetColorSpace(textureImage),kCGImageAlphaPremultipliedLast);
	 CGContextTranslateCTM(textureContext, 0, texHeight);
	 CGContextScaleCTM(textureContext, 1.0, -1.0);
	 CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	 CGContextRelease(textureContext);
	 glGenTextures(1, &brFlash);
	 glBindTexture(GL_TEXTURE_2D, brFlash);
	 glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	 free(textureData);
	 glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	 glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	 
	
	name =  @"brNum.png";
	textureImage = [UIImage imageNamed:name].CGImage;
	texWidth = CGImageGetWidth(textureImage);
	texHeight = CGImageGetHeight(textureImage);
	textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	memset(textureData, 0, texWidth*texHeight*4);
    textureContext = CGBitmapContextCreate(textureData,texWidth, texHeight,8, texWidth * 4,CGImageGetColorSpace(textureImage),kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	glGenTextures(1, &brNum);
	glBindTexture(GL_TEXTURE_2D, brNum);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

+(void)loadModel{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"battleRifle" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&battleRifleVertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&battleRifleTriangleCount];
	NSLog(@"battlerifle%d",(int)battleRifleTriangleCount);
	NSLog(@"battleRifle%d", battleRifleVertexCount);
	battleRifleData = malloc(sizeof(GLVertexElement) * battleRifleTriangleCount * 3);
    [[handle readDataOfLength:sizeof(GLVertexElement) * battleRifleTriangleCount * 3] getBytes:battleRifleData];
}
const GLfloat tex [8][8] = {
	//0
	//1
	{
		0.0f,0.0f,
		0.23f,0.0f,
		0.23f,0.5f,
		0.0, 0.5f
	},
	//2
	{
		0.5f,0.5f,
		0.75f,0.5f,
		0.75f,1.0f,
		0.5, 1.0f
	},
	//3
	{
		0.0f,0.5f,
		0.25f,0.5f,
		0.25f,1.0f,
		0.0, 1.0f
	},
	//4
	{
		0.75f,0.0f,
		1.0f,0.0f,
		1.0f,0.5f,
		0.75, 0.5f
	},
	//5
	{
		0.25f,0.0f,
		0.5f,0.0f,
		0.5f,0.5f,
		0.25, 0.5f
	},
	//6
	{
		0.25f,0.5f,
		0.5f,0.5f,
		0.5f,1.0f,
		0.25, 1.0f
	},
	//7
	{
		0.75f,0.5f,
		1.0f,0.5f,
		1.0f,1.0f,
		0.75, 1.0f
	},
	//8
	{
		0.5f,0.0f,
		0.75f,0.0f,
		0.75f,0.5f,
		0.5, 0.5f
	}
	//9
};

// Right number vertex coords
const GLfloat rightBrNumCoords [] = {
	0.0485f,0.0f,-1.0f,
	0.1f,   0.0f,-1.0f,
	0.1f,   0.1f,-1.0f,
	0.0485, 0.1f,-1.0f
};
// Left number vertex coords
const GLfloat leftBrNumCoords [] = {
	-0.027f,0.0f,-1.0f,
	0.0485f,0.0f,-1.0f,
	0.0485f,0.1f,-1.0f,
	-0.027, 0.1f,-1.0f
};	
// Muzzle flash
const GLfloat muzzleFlash [] = {
	-0.4f,-0.35f,-1.0f,
	0.4f,-0.35f,-1.0f,
	0.4f,0.35f,-1.0f,
	-0.4, 0.35f,-1.0f
};
const GLfloat muzzleFlashTex[] ={
	0.0f,0.0f,
	0.0f,-1.0f,
	-1.0f,-1.0f,
	-1.0f,0.0f
};

-(void) draw{
	glPushMatrix();
	if(animationFrame <3){
		glTranslatef(0.11f, -0.17f, 0.0f);
		glScalef(0.2222222*(animationFrame+1),0.2222222*(animationFrame+1), 1.0);
		glBindTexture(GL_TEXTURE_2D, brFlash);
		glTexEnvf(GL_TEXTURE_2D,GL_TEXTURE_ENV_MODE,GL_MODULATE);
		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glVertexPointer(3, GL_FLOAT, 0, muzzleFlash);
		glTexCoordPointer(2, GL_FLOAT, 0, muzzleFlashTex);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glDisable(GL_BLEND);
		glScalef(1.0/((animationFrame+1)*0.2222222),1.0/((animationFrame+1)*0.2222222), 1.0);
	}else if(animationFrame == 3){
		glTranslatef(0.11f, -0.17f, 0.0f);
		glScalef(0.2222222,0.2222222, 1.0);
		glBindTexture(GL_TEXTURE_2D, brFlash);
		glTexEnvf(GL_TEXTURE_2D,GL_TEXTURE_ENV_MODE,GL_MODULATE);
		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glVertexPointer(3, GL_FLOAT, 0, muzzleFlash);
		glTexCoordPointer(2, GL_FLOAT, 0, muzzleFlashTex);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glDisable(GL_BLEND);
		glScalef(1.0/(0.2222222),1.0/(0.2222222), 1.0);
	}
	glEnable(GL_CULL_FACE);
	glDisable(GL_DEPTH_TEST);
	glTranslatef(self.x - 0.22f, self.y +0.15, animation[animationFrame] + 0.7);
	glEnableClientState(GL_VERTEX_ARRAY);
	//glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnable(GL_TEXTURE_2D);
	if(animationFrame !=7 ){
		animationFrame++;	
	}
	glRotatef(3, 0.0f, 1.0f, 0.0f);
	glBindTexture(GL_TEXTURE_2D, brNum);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement),battleRifleData);
	//glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data->normal);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), battleRifleData->texCoord);
	glBindTexture(GL_TEXTURE_2D,  texture55);
	glDrawArrays(GL_TRIANGLES, 0,  battleRifleTriangleCount*3);
	pollies+= battleRifleTriangleCount*3;
	glBindTexture(GL_TEXTURE_2D, brNum);
	glTranslatef(-0.017f, 0.1f, 1.17f);
	// Draw the left
	int clip1 =-1+ (clipAmmo%10);
	if(clip1<0){
		clip1 = 0;
	}
	int clip2 =-1+(clipAmmo/12);
	glVertexPointer(3, GL_FLOAT, 0, leftBrNumCoords);
	glTexCoordPointer(2, GL_FLOAT, 0, tex[clip2]);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glVertexPointer(3, GL_FLOAT, 0, rightBrNumCoords);
	glTexCoordPointer(2, GL_FLOAT, 0, tex[clip1]);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glColor4f(1.0f, 1.0f,1.0f, 1.0f);
	glPopMatrix();
	
	glDisable(GL_CULL_FACE);
	glEnable(GL_DEPTH_TEST);
	firing = false;
}


-(void)drawWeaponHUD{
	
	
}

-(void)fire{
	if(1){
		firing = true;
		animationFrame = 0;	
		clipAmmo-=3;
	}
}
-(void)stopFire{
	
}
-(id)init{
	if(self == [super init]){
		self.x = 0.0f;
		self.y = 1.0f;
		self.z = 0.0f;
		animationFrame = 0;
		animation[0] = -2.6f;
		animation[1] = -2.2f;
		animation[2] = -2.0f;
		animation[3] = -1.8f;
		animation[4] = -2.0f;
		animation[5] = -2.2f;
		animation[6] = -2.4f;
		animation[7] = -2.6f;
		
		clipAmmo = 36;
		maxClipAmmo = 36;
		maxReserveAmmo = 72;
		
	}
	return self;
}
+(int)damage{
	return 40;	  
}

@end