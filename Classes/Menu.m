//
//  Menu.m
//  Halo 3
//
//  Created by Spencer Whyte on 10-02-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Menu.h"


@implementation Menu

float bound(float x){
	if(x < -10){
		return -10;
	}else if(x > 10){
		return 10;
	}else{
		return x;	
	}
}




const GLfloat screen[] = {
	-1.0f,1.0f,-1.0f,
	-1.0f,-1.0f,-1.0f,
	1.0f,-1.0f,-1.0f,
	1.0f,1.0f,-1.0f
};

+(void)loadTextures{
	NSString *name = @"menuTexture.png";
	CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
	
	NSInteger texWidth = CGImageGetWidth(textureImage);
	NSInteger texHeight = CGImageGetHeight(textureImage);
	
	GLubyte *textureData = (GLubyte *)calloc(texWidth * texHeight * 4,sizeof(GLubyte));
	//memset(textureData, 0, texWidth * texHeight * 4);
	CGContextRef textureContext = CGBitmapContextCreate(textureData,
														texWidth, texHeight,
														8, texWidth * 4,
														CGImageGetColorSpace(textureImage),
														kCGImageAlphaPremultipliedLast);
	
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	glGenTextures(1, &menuTexture);
	glBindTexture(GL_TEXTURE_2D, menuTexture);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

const GLfloat haloLogo [] = {
	0.1f,-0.25f,-0.9f,
	0.1f,-0.45f,-0.9f,
	0.75f,-0.45f,-0.9f,
	0.75f,-0.25f,-0.9f
	
};
const GLfloat logoTexCoords[] = {
   0.0f,-0.4f,
   0.0f,-1.0f,
   1.0f,-1.0f,
   1.0f,-0.4f
};

const GLfloat matchmaking[] = {
	-0.6f,0.31f,-0.9f,
	-0.6f,0.25f,-0.9f,
	-0.2f,0.25f,-0.9f,
	-0.2f,0.31f,-0.9f
};

const GLfloat matchmakingTexCoords[] = {
	0.0f,0.0f,
	0.0f,-0.1f,
	1.0f,-0.1f,
	1.0f,0.0f	
};

+(void)draw{
	glPushMatrix();
	glTranslatef(sin(menuRotation*5)*50.0f-20, -30.0f, 0.0f);
	glRotatef(10*menuRotation, 0.0f, 1.0f, 0.0f);
	glTranslatef(0.0f, bound(sin(90+menuRotation*5)*10)-5, 90.0f);
	printf("%f\n",bound(sin(90+menuRotation*5)*10)-5);
	[Foundry draw];
	[DoubleBox drawDoubleBoxes];
	[Bridge draw];
	menuRotation+=fabs(cos(menuRotation))/100.0+0.0001;
	glPopMatrix();
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glDisable(GL_TEXTURE_2D);
	glColor4f(13.0/256.0, 24.0/256.0, 80.0/256.0, 0.5f);
	glVertexPointer(3, GL_FLOAT, 0, screen);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glEnable(GL_TEXTURE_2D);
	
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	glBindTexture(GL_TEXTURE_2D, menuTexture);
	glTexCoordPointer(2,GL_FLOAT,0,logoTexCoords);
	glVertexPointer(3, GL_FLOAT, 0, haloLogo);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	glTexCoordPointer(2, GL_FLOAT, 0, matchmakingTexCoords);
	glVertexPointer(3, GL_FLOAT, 0, matchmaking);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	
	glDisable(GL_BLEND);
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	
}
@end
