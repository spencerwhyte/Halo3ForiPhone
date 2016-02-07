//
//  SingleBox.m
//  Halo 3
//
//  Created by spencer whyte on 09-10-15.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SingleBox.h"


@implementation SingleBox

-(id)init
{
    if (self = [super init])
    {
		self.x =0.0f;
		self.y = 10.5f;
		self.z = 0.0f;
		self.rotationx = 0.0f;
		self.rotationy = 0.0f;
		self.rotationz = 0.0f;
    }
	[singleBoxes addObject:self];
	
	NSLog(@"Drawing %i", [singleBoxes count]);
    return self;
}

+ (void)loadTextures{
	for(int i = 0; i < 6; i++){
		NSString *name = [NSString stringWithFormat: @"SB%d.png",i+1];
		CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
		NSInteger texWidth = CGImageGetWidth(textureImage);
		NSInteger texHeight = CGImageGetHeight(textureImage);
		GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
		CGContextRef textureContext = CGBitmapContextCreate(textureData,texWidth, texHeight,8, texWidth * 4,CGImageGetColorSpace(textureImage),kCGImageAlphaPremultipliedLast);
		CGContextTranslateCTM(textureContext, 0, texHeight);
		CGContextScaleCTM(textureContext, 1.0, -1.0);
		CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
		CGContextRelease(textureContext);
		glGenTextures(1, &singleBoxTextures[i]);
		glBindTexture(GL_TEXTURE_2D, singleBoxTextures[i]);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
		free(textureData);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		NSLog(@"end%d",i+1);
	}
	singleBoxes = [[NSMutableArray alloc]init ];
}

+(void) drawSingleBoxes{
	const GLfloat leftSide[] =  {
		-5.0f, 5.0f,5.0f,
		-5.0f, -5.0f, 5.0f,
		-5.0f, -5.0f, -5.0f,
		-5.0f, 5.0f, -5.0f
	};
	const GLfloat rightSide[] = {
		5.0f, 5.0f,5.0f,
		5.0f, -5.0f, 5.0f,
		5.0f, -5.0f, -5.0f,
		5.0f, 5.0f, -5.0f
	};
	const GLfloat top[] = {
		-5.0f,5.0f,5.0f,
		-5.0f,5.0f,-5.0f,
		5.0f,5.0f, -5.0f,
		5.0f,5.0f,5.0f
	};
	const GLfloat bottom[] = {
		-5.0f,-5.0f,5.0f,
		-5.0f,-5.0f,-5.0f,
		5.0f,-5.0f, -5.0f,
		5.0f,-5.0f,5.0f
	};
	const GLfloat front[] = {
		-5.0f, 5.0f, 5.0f,
		-5.0f, -5.0f, 5.0f,
		5.0f, -5.0f, 5.0f,
		5.0f, 5.0f, 5.0f
	};
	const GLfloat back [] =  {
		-5.0f, 5.0f, -5.0f,
		-5.0f, -5.0f, -5.0f,
		5.0f, -5.0f, -5.0f,
		5.0f, 5.0f, -5.0f
	};
	const GLfloat standardTex[]  = {
		0.0, 1.0,
		0.0, 0.0,
		1.0, 0.0,
		1.0, 1.0,
	};
	for(int i = 0 ; i < [singleBoxes count]; i++){
	
		SingleBox *current = [singleBoxes objectAtIndex:i];
		if(current.textureMappingEnabled){
			glPushMatrix();
			glTranslatef(current.x,current.y,current.z);
			glScalef(2.0f,2.0f,2.0f);//u suck at 
			glVertexPointer(3, GL_FLOAT, 0, leftSide);
			glBindTexture(GL_TEXTURE_2D, singleBoxTextures[1]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, rightSide);
			glBindTexture(GL_TEXTURE_2D, singleBoxTextures[3]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, front);
			glBindTexture(GL_TEXTURE_2D, singleBoxTextures[2]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, back);
			glBindTexture(GL_TEXTURE_2D, singleBoxTextures[0]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, top);
			glBindTexture(GL_TEXTURE_2D, singleBoxTextures[5]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, bottom);
			glBindTexture(GL_TEXTURE_2D, singleBoxTextures[4]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glPopMatrix();
		}else{
			glDisable(GL_TEXTURE_2D);
			glPushMatrix();
			glLineWidth(1.5f);
			glColor4f(0.001f, 1.0f, 0.001f, 1.0f);
			glTranslatef(current.x,current.y,current.z);
			glScalef(2.0f,2.0f,2.0f);
			glVertexPointer(3, GL_FLOAT, 0, leftSide);
			glDrawArrays(GL_LINE_LOOP, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, rightSide);
			glDrawArrays(GL_LINE_LOOP, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, front);
			glDrawArrays(GL_LINE_LOOP, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, back);
			glDrawArrays(GL_LINE_LOOP, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, top);
			glDrawArrays(GL_LINE_LOOP, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, bottom);
			glDrawArrays(GL_LINE_LOOP, 0, 4);
			glPopMatrix();
			glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
			glEnable(GL_TEXTURE_2D);	
		}
	}
	
}


@end
