//
//  BeamRifle.m
//  MC
//
//  Created by spencer whyte on 09-09-28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BeamRifle.h"

@implementation BeamRifle
/*
+ (void)loadTextures{
	NSString *name =  @"b.png";
	CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
	NSInteger texWidth = CGImageGetWidth(textureImage);
	NSInteger texHeight = CGImageGetHeight(textureImage);
	GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	CGContextRef textureContext = CGBitmapContextCreate(textureData,texWidth, texHeight,8, texWidth * 4,CGImageGetColorSpace(textureImage),kCGImageAlphaPremultipliedLast);
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	glGenTextures(1, &texture);
	glBindTexture(GL_TEXTURE_2D, texture);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

+(void)loadModel{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"singleBoxOpen" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	NSLog(@"%d",(int)triangleCount);
	NSLog(@"%d", vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3);
    [[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
}

-(void) draw{
	if(textureMappingEnabled){
		glPushMatrix();
		glTranslatef(self.x, self.y, self.z);
		glRotatef(self.rotationy, 0.0, 1.0, 0.0);
		glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
		glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data->normal);
		glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);
		glBindTexture(GL_TEXTURE_2D,  texture);
		glDrawArrays(GL_TRIANGLES, 0, triangleCount*3); 
		glPopMatrix();
	}else{
		glDisable(GL_TEXTURE_2D);
		glLineWidth(0.8f);
		glColor4f(0.001f, 1.0f, 0.001f, 1.0f);
		glPushMatrix();
		glTranslatef(self.x, self.y, self.z);
		glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
		glDrawArrays(GL_LINES, 0, triangleCount*3); 
		glPopMatrix();
		glColor4f(1.0f, 1.0f,1.0f, 1.0f);
		glEnable(GL_TEXTURE_2D);
	}
}

-(id)init{
	if(self == [super init]){
		self.x = 0.0f;
		self.y = 8.0f;
		self.z = 0.0f;
	}
	return self;
}
*/
@end
