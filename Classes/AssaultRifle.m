//
//  SMG.m
//  MC
//
//  Created by spencer whyte on 09-10-05.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AssaultRifle.h"


@implementation AssaultRifle
@synthesize animationFrame;
@synthesize firing;
@synthesize fp;
+ (void)loadTextures{
	NSString *name =  @"FPAssaultRifle.png";
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
	
	name =  @"smgFlash.png";
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
	glGenTextures(1, &assaultRifleFlash);
	glBindTexture(GL_TEXTURE_2D, assaultRifleFlash);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

+(void)loadModel{
	//damage = 10;
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FPAssaultRifle" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	//NSLog(@"smg%d",(int)triangleCount);
	//NSLog(@"smg%d", vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3);
    [[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
}

// Muzzle flash
const GLfloat amuzzleFlash2 [] = {
	-0.4f,-0.35f,-1.0f,
	0.4f,-0.35f,-1.0f,
	0.4f,0.35f,-1.0f,
	-0.4, 0.35f,-1.0f
};
const GLfloat amuzzleFlashTex2[] ={
	0.0f,0.0f,
	0.0f,-1.0f,
	-1.0f,-1.0f,
	-1.0f,0.0f
};

-(void) draw{
	
	glPushMatrix();
	
	if(firing){
		glPushMatrix();
		glTranslatef(sin(animationFrame)*0.01f +0.14f, -0.09f, 0.0f);
		glBindTexture(GL_TEXTURE_2D, smgFlash);
		float factor = 0.45f + (6.6 + animation[animationFrame])/3.0f;
		glScalef(factor ,factor, 1.0f);
	    glRotatef(sin(animationFrame)*70, 0.0f, 0.0f, 1.0f);
		glTexEnvf(GL_TEXTURE_2D,GL_TEXTURE_ENV_MODE,GL_MODULATE);
		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
		glVertexPointer(3, GL_FLOAT, 0, amuzzleFlash2);
		glTexCoordPointer(2, GL_FLOAT, 0, amuzzleFlashTex2);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glDisable(GL_BLEND);
		glPopMatrix();
	}
	glEnable(GL_CULL_FACE);
	//glDisable(GL_DEPTH_TEST);
	glTranslatef(-4.0, -6.0 + ((6.6+animation[animationFrame])/3.0f), animation[animationFrame]+0.2f);
	glEnableClientState(GL_VERTEX_ARRAY);
	//glEnableClientState(GL_NORMAL_ARRAY);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glEnable(GL_TEXTURE_2D);
	if(firing){
		if(animationFrame !=7 ){
			animationFrame++;	
		}else{
			animationFrame = 0;
		}
	}else{
		animationFrame = 7;
	}
	float replacement = -1* (reloadingProgress*reloadingProgress - (100 * reloadingProgress));
	//printf("%f", replacement);
    glTranslatef(-4.1,6.0 -(replacement/55.0), 1.0f);
	glRotatef(-(replacement/25.0), 1.0f, 1.0f, 1.0);
	glRotatef(-5.0f, 0.0f, 1.0f, 0.0f);
	glRotatef(-2.0f, 1.0f, 0.0f, 0.0f);
	//printf("beingDrawn\n");
	glScalef(1.0f, 1.0f, 1.0f);
	//glColor4f(1.0f, 0.0f, 0.0f, 1.0f);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);
	glBindTexture(GL_TEXTURE_2D,  texture55);
	glDrawArrays(GL_TRIANGLES, 0,  triangleCount*3);
	pollies+= triangleCount*3;
	glPopMatrix();
	
	glDisable(GL_CULL_FACE);
	glEnable(GL_DEPTH_TEST);
	//}
	if(firing){
		clipAmmo--;
	}
	if(clipAmmo<=0){
		firing = false;
		[lp stopFireWeapon];
		reloadingProgress++;
	}
	if(reloadingProgress==100){
		clipAmmo=100;
		reloadingProgress=0;
	}
	 
}


-(void)drawWeaponHUD{
	
	
}

-(void)fire{
	if(clipAmmo >0){
		firing = true;
		animationFrame = 0;	
		clipAmmo-=1;
	}
}
-(void)stopFire{
	firing = false;
}

-(id)init{
	if(self == [super init]){
		self.x = 0.0f;
		self.y = 1.0f;
		self.z = 0.0f;
		animationFrame = 0;
		animation[0] = -6.6f;
		animation[1] = -6.0f;
		animation[2] = -6.3f;
		animation[3] = -6.0f;
		animation[4] = -6.5f;
		animation[5] = -6.1f;
		animation[6] = -6.3f;
		animation[7] = -6.6f;
		reloadingProgress = 0;
		clipAmmo = 100;
		maxClipAmmo = 36;
		maxReserveAmmo = 72;
		firing = false;
		fp = false;
	}
	return self;
}
+(int)damage{
	return 10;
}

@end
