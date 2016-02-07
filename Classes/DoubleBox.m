//
//  DoubleBox.m
//  MC
//
//  Created by spencer whyte on 10/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoubleBox.h"

static GLuint textures[6];

@implementation DoubleBox
static NSMutableArray *doubleBoxes;
@synthesize orientation;
+(NSMutableArray *)getDoubleBoxes{
	return doubleBoxes;	
}

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
		orientation = true;
    }
	[self retain];
	[doubleBoxes addObject:self];
	
	NSLog(@"Drawing %i", [doubleBoxes count]);
    return self;
}

+ (void)loadTextures{
	for(int i = 0; i < 6; i++){
		NSString *name = [NSString stringWithFormat: @"DoubleBox%d.png",i+1];
		CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
		NSInteger texWidth = CGImageGetWidth(textureImage);
		NSInteger texHeight = CGImageGetHeight(textureImage);
		GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
		CGContextRef textureContext = CGBitmapContextCreate(textureData,texWidth, texHeight,8, texWidth * 4,CGImageGetColorSpace(textureImage),kCGImageAlphaPremultipliedLast);
		CGContextTranslateCTM(textureContext, 0, texHeight);
		CGContextScaleCTM(textureContext, 1.0, -1.0);
		CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
		CGContextRelease(textureContext);
		glGenTextures(1, &textures[i]);
		glBindTexture(GL_TEXTURE_2D, textures[i]);
		//glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
		//glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		//glTexParameterf(GL_TEXTURE_2D,GL_GENERATE_MIPMAP, GL_TRUE);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
		free(textureData);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);


		NSLog(@"end%d",i+1);
	}
	doubleBoxes = [[NSMutableArray alloc]init ];
}
const GLfloat leftSide[] =  {
	-20.0f, 10.0f,10.0f,
	-20.0f, -10.0f, 10.0f,
	-20.0f, -10.0f, -10.0f,
	-20.0f, 10.0f, -10.0f
};
const GLfloat rightSide[] = {
	20.0f, 10.0f,10.0f,
	20.0f, -10.0f, 10.0f,
	20.0f, -10.0f, -10.0f,
	20.0f, 10.0f, -10.0f
};
const GLfloat top[] = {
	-20.0f,10.0f,10.0f,
	-20.0f,10.0f,-10.0f,
	20.0f,10.0f, -10.0f,
	20.0f,10.0f,10.0f
};
const GLfloat bottom[] = {
	-20.0f,-10.0f,10.0f,
	-20.0f,-10.0f,-10.0f,
	20.0f,-10.0f, -10.0f,
	20.0f,-10.0f,10.0f
};
const GLfloat front[] = {
	-20.0f, 10.0f, 10.0f,
	-20.0f, -10.0f, 10.0f,
	20.0f, -10.0f, 10.0f,
	20.0f, 10.0f, 10.0f
};
const GLfloat back [] =  {
	-20.0f, 10.0f, -10.0f,
	-20.0f, -10.0f, -10.0f,
	20.0f, -10.0f, -10.0f,
	20.0f, 10.0f, -10.0f
};
const GLfloat standardTex[]  = {
	0.0, 1.0,
	0.0, 0.0,
	1.0, 0.0,
	1.0, 1.0,
};

const GLfloat leftSide2[] =  {
	-10.0f, 10.0f,-20.0f,
	-10.0f, -10.0f, -20.0f,
	10.0f, -10.0f, -20.0f,
	10.0f, 10.0f, -20.0f
};
const GLfloat rightSide2[] = {
	-10.0f, 10.0f,20.0f,
	-10.0f, -10.0f, 20.0f,
	10.0f, -10.0f, 20.0f,
	10.0f, 10.0f, 20.0f
};

const GLfloat top2[] = {
	10.0f,10.0f,-20.0f,
	-10.0f,10.0f,-20.0f,
	-10.0f,10.0f, 20.0f,
	10.0f,10.0f,20.0f
};
const GLfloat bottom2[] = {
	10.0f,-10.0f,-20.0f,
	-10.0f,-10.0f,-20.0f,
	-10.0f,-10.0f, 20.0f,
	10.0f,-10.0f,20.0f
};
const GLfloat front2[] = {
	-10.0f, 10.0f, -20.0f,
	-10.0f, -10.0f, -20.0f,
	-10.0f, -10.0f, 20.0f,
	-10.0f, 10.0f, 20.0f
};
const GLfloat back2[] =  {
	10.0f, 10.0f, -20.0f,
	10.0f, -10.0f, -20.0f,
	10.0f, -10.0f, 20.0f,
	10.0f, 10.0f, 20.0f
};  

+(void) drawDoubleBoxes{
	for(int i = 0 ; i < [doubleBoxes count]; i++){
		DoubleBox *current = [doubleBoxes objectAtIndex:i];
		if(current.orientation){
			glPushMatrix();
			glTranslatef(current.x,current.y,current.z);
			glVertexPointer(3, GL_FLOAT, 0, leftSide);
			glBindTexture(GL_TEXTURE_2D, textures[1]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, rightSide);
			glBindTexture(GL_TEXTURE_2D, textures[0]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, front);
			glBindTexture(GL_TEXTURE_2D, textures[2]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, back);
			glBindTexture(GL_TEXTURE_2D, textures[4]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, top);
			glBindTexture(GL_TEXTURE_2D, textures[3]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			pollies+=20;
			//glVertexPointer(3, GL_FLOAT, 0, bottom);
			//glBindTexture(GL_TEXTURE_2D, textures[5]);
			//glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			//glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glPopMatrix();
		}else{
			glPushMatrix();
			glTranslatef(current.x,current.y,current.z);
			glVertexPointer(3, GL_FLOAT, 0, leftSide2);
			glBindTexture(GL_TEXTURE_2D, textures[1]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, rightSide2);
			glBindTexture(GL_TEXTURE_2D, textures[0]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, front2);
			glBindTexture(GL_TEXTURE_2D, textures[2]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, back2);
			glBindTexture(GL_TEXTURE_2D, textures[4]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glVertexPointer(3, GL_FLOAT, 0, top2);
			glBindTexture(GL_TEXTURE_2D, textures[3]);
			glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
			glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
				pollies+=20;
		//	glVertexPointer(3, GL_FLOAT, 0, bottom2);
		//	glBindTexture(GL_TEXTURE_2D, textures[5]);
		//	glTexCoordPointer(2, GL_FLOAT, 0, standardTex);
		//	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
			glPopMatrix();
		}
	}
	
}
@end
