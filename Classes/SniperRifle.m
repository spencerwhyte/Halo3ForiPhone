//
//  SniperRifle.m
//  MC
//
//  Created by spencer whyte on 30/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SniperRifle.h"


@implementation SniperRifle
static NSMutableArray *sniperRifles;
@synthesize firing;
@synthesize fp;

+ (void)loadTextures{
	NSString *name =  @"sniper_rifle.png";
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
	for(int i = 0 ; i< texWidth*texHeight*4; i++){
		*(GLubyte *)(textureData+i)+=10;
	}
	glGenTextures(1, &texture);
	glBindTexture(GL_TEXTURE_2D, texture);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	name =  @"sniperContrail.png";
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
	glGenTextures(1, &contrailTexture);
	glBindTexture(GL_TEXTURE_2D, contrailTexture);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	name =  @"sniperMuzzleFlash.png";
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
	glGenTextures(1, &muzzleFlash);
	glBindTexture(GL_TEXTURE_2D, muzzleFlash);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	sniperRifles = [[NSMutableArray alloc] init];
}

+(void)loadModel{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"FPSniperL1" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	NSLog(@"%d",(int)triangleCount);
	NSLog(@"%d", vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3);
    [[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
	contrails = [[NSMutableArray alloc]init];
}

+(void)drawContrails{
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	for(int i = 0 ; i  <  contrails.count; i++){
		Contrail *current = [contrails objectAtIndex:i];
		current.framesSinceShot++;
		
		const GLfloat contrail[] = {
			current.startx,0.8f+current.starty,current.startz,
			current.startx,-0.8f+current.starty,current.startz,
			current.endx,-0.8f+current.starty,current.endz,
			current.endx,0.8f+current.starty,current.endz
		};
		
		const GLfloat contrail2[] = {
			0.8f+current.startx,current.starty,current.startz,
			-0.8f+current.startx,current.starty,current.startz,
			-0.8f+current.endx,current.starty,current.endz,
			0.8f+current.endx,current.starty,current.endz
		};
		float distance =sqrt((current.startx-current.endx)*(current.startx-current.endx) + (current.startz-current.endz)*(current.startz-current.endz));
		const GLfloat contrailTex [] = {
			0.0f,0.0f,
			0.0f,1.0f,
			0.1f * distance,1.0f,
			0.1f * distance,0.0f
		};
		
		if(current.framesSinceShot <= 7){
			glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
		}else{
			glColor4f(1.0f, 1.0f, 1.0f, 1.0-(1.0/63.0)*(current.framesSinceShot-7.0f))	;
		}
		current.startx-=0.04f;
		current.endx-=0.04f;
		glPushMatrix();
		//glTranslatef(20.0f,8.6f, 0.0f);
		glBindTexture(GL_TEXTURE_2D, contrailTexture);
		glVertexPointer(3, GL_FLOAT, 0, contrail);
		glTexCoordPointer(2, GL_FLOAT, 0, contrailTex);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glVertexPointer(3, GL_FLOAT, 0, contrail2);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glPopMatrix();
		
		
		if(current.framesSinceShot>70){
			[contrails removeObjectAtIndex:i];
			[current release];
		    if(i!=0){
				i--;
			}
		}
		
	}
	glDisable(GL_BLEND);
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
}
const GLfloat sniperMuzzleFlash [] = {
	-0.4f,-0.35f,-1.0f,
	0.4f,-0.35f,-1.0f,
	0.4f,0.35f,-1.0f,
	-0.4, 0.35f,-1.0f
};
const GLfloat sniperMuzzleFlashTex[] ={
	0.0f,0.0f,
	0.0f,-1.0f,
	-1.0f,-1.0f,
	-1.0f,0.0f
};

-(void) draw{
	
	if(fp){
		if(animationFrame!=10){
			animationFrame++;
		}
		//glEnable(GL_CULL_FACE);
		//glDisable(GL_DEPTH_TEST);
		//printf("%d\n", triangleCount*3);
		glPushMatrix();
		//glScalef(500.0f, 500.0f, 500.0f);
		glTranslatef(self.x + 0.5, self.y+ ((10-animationFrame)/30.0) -0.7, -3+self.z + animation[animationFrame]+2.6);
		glRotatef((10-animationFrame)/1.50, 1.0f, 0.0f, 0.0f);
		glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
		glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
		glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);
		//glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data->normal);
		glBindTexture(GL_TEXTURE_2D,  texture);
		glDrawArrays(GL_TRIANGLES, 0, triangleCount*3); 
		pollies+= triangleCount*3;
		glPopMatrix();
		glDisable(GL_BLEND);
		//glDisable(GL_CULL_FACE);
		//glEnable(GL_DEPTH_TEST);
		firing = false;
	}else{
		glPushMatrix();
		glTranslatef(self.x, self.y, self.z);
		glRotatef((10-animationFrame)/1.50, 1.0f, 0.0f, 0.0f);
		glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
		glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
		glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);
		//glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data->normal);
		glBindTexture(GL_TEXTURE_2D,  texture);
		glDrawArrays(GL_TRIANGLES, 0, triangleCount*3); 
		pollies+= triangleCount*3;
		glPopMatrix();
		glDisable(GL_BLEND);
	}
	
}
+(NSMutableArray *)getContrials{
	return contrails;
}


-(void)fire{
	animationFrame = 0;
	firing = true;
}

+(void)drawSniperRifles{
	
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);
	//glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data->normal);
	glBindTexture(GL_TEXTURE_2D,  texture);
	
	for(int i  =0 ; i < [sniperRifles count] ; i ++){
			glPushMatrix();
		
			glPopMatrix();
			glDisable(GL_BLEND);
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
		animation[1] = -2.0f;
		animation[2] = -1.6f;
		animation[3] = -1.0f;
		animation[4] = -1.3f;
		animation[5] = -1.5f;
		animation[6] = -1.5f;
		animation[7] = -2.0f;
		animation[8] = -2.2f;
		animation[9] = -2.4f;
		animation[10] = -2.6f;
		fp= false;
		[self retain];
		[sniperRifles addObject:self];
	}
	return self;
}

@end
