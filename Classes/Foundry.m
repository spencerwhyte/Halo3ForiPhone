//
//  BlenderObject.m
//  MC
//
//  Created by spencer whyte on 11/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Foundry.h"


@implementation Foundry
+(NSError*)loadBlenderObject:(NSString*)fileName{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"foundry" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle
							fileHandleForReadingAtPath:filePath];
    if (handle == nil) {
        NSString *msg = @"Something went really, really wrong...";
        return [NSError errorWithDomain:@"BlenderObject"code:0 userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
    }
	[[handle readDataOfLength:sizeof(int)] getBytes:&foundryVertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&foundryTriangleCount];
	NSLog(@"%d",(int)foundryTriangleCount);
	NSLog(@"%d", foundryVertexCount);
	foundryData = malloc(sizeof(GLVertexElement) * foundryTriangleCount * 3);
	
    [[handle readDataOfLength:sizeof(GLVertexElement) * foundryTriangleCount * 3] getBytes:foundryData];
	
	
	[handle closeFile];
	
	
	filePath = [[NSBundle mainBundle] pathForResource:@"foundry2"
                                                         ofType:@"gldata"];
    handle = [NSFileHandle
							fileHandleForReadingAtPath:filePath];
    if (handle == nil) {
        NSString *msg = @"Something went really, really wrong...";
        return [NSError errorWithDomain:@"BlenderObject"code:0 userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
    }
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount2];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount2];
	NSLog(@"%d",(int)triangleCount2);
	NSLog(@"%d", vertexCount2);
	data2 = malloc(sizeof(GLVertexElement) * triangleCount2 * 3);
	
    [[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount2 * 3] getBytes:data2];
	[handle closeFile];
	return [Foundry loadTexture:fileName]; 
	
}

+ (NSError *)loadTexture:(NSString *)fileName {
	
	NSString *name = [NSString stringWithFormat:@"%@R.%@", fileName, @"png"];
	CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
	if (textureImage == nil) {
		return [NSError errorWithDomain:nil
								   code:0
							   userInfo:[NSDictionary dictionaryWithObject:@"Error loading file"
																	forKey:NSLocalizedDescriptionKey]];
	}
	
	NSInteger texWidth = CGImageGetWidth(textureImage);
	NSInteger texHeight = CGImageGetHeight(textureImage);
	
	GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	
	CGContextRef textureContext = CGBitmapContextCreate(textureData,
														texWidth, texHeight,
														8, texWidth * 4,
														CGImageGetColorSpace(textureImage),
														kCGImageAlphaPremultipliedLast);
	
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	glGenTextures(1, &foundryTexture);
	glBindTexture(GL_TEXTURE_2D, foundryTexture);
	//glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
	///glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	////glTexParameterf(GL_TEXTURE_2D,GL_GENERATE_MIPMAP, GL_TRUE);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	
	free(textureData);
	
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	
	
	
	
	
	name = [NSString stringWithFormat:@"%@.%@", @"foundry2R", @"png"];
	textureImage = [UIImage imageNamed:name].CGImage;
	if (textureImage == nil) {
		return [NSError errorWithDomain:nil
								   code:0
							   userInfo:[NSDictionary dictionaryWithObject:@"Error loading file"
																	forKey:NSLocalizedDescriptionKey]];
	}
	
	texWidth = CGImageGetWidth(textureImage);
	texHeight = CGImageGetHeight(textureImage);
	
	textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	
	textureContext = CGBitmapContextCreate(textureData,
														texWidth, texHeight,
														8, texWidth * 4,
														CGImageGetColorSpace(textureImage),
														kCGImageAlphaPremultipliedLast);
	
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	glGenTextures(1, &texture2);
	glBindTexture(GL_TEXTURE_2D, texture2);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	
	free(textureData);
	
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	[Foundry loadTexture:@"floor" forIndex: 0];
	[Foundry loadTexture:@"smoothGreySquare" forIndex:1];
	[Foundry loadTexture:@"yellowSquare" forIndex:2];
	[Foundry loadTexture:@"middleFloor" forIndex:3];
	
	
	return nil;
}
+ (void)loadTexture:(NSString *)fileName forIndex:(int)index{
	
	NSString *name = [NSString stringWithFormat:@"%@.%@", fileName, @"png"];
	CGImageRef textureImage = [UIImage imageNamed:name].CGImage;
	
	NSInteger texWidth = CGImageGetWidth(textureImage);
	NSInteger texHeight = CGImageGetHeight(textureImage);
	
	GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
	memset(textureData, 0, texWidth * texHeight * 4 );
	for(int i = 0 ; i < texWidth * texHeight * 4; i+=1){
		*(textureData + i) +=25;
	}
	CGContextRef textureContext = CGBitmapContextCreate(textureData,
														texWidth, texHeight,
														8, texWidth * 4,
														CGImageGetColorSpace(textureImage),
														kCGImageAlphaPremultipliedLast);
	
	CGContextTranslateCTM(textureContext, 0, texHeight);
	CGContextScaleCTM(textureContext, 1.0, -1.0);
	
	CGContextDrawImage(textureContext, CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight), textureImage);
	CGContextRelease(textureContext);
	glGenTextures(1, &textures[index]);
	glBindTexture(GL_TEXTURE_2D, textures[index]);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	
	free(textureData);
	
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}
const GLfloat ground[] = {
	-8.5f,0.0f,-8.5f,
	-8.5f,0.0f,8.5f,
	8.5f,0.0f,8.5f,
	8.5f,0.0f,-8.5f
};
const GLfloat groundA[] = {
	-115.8f,0.0f,-188.8f,
	-115.8f,0.0f,-154.8f,
	-13.8f,0.0f,-154.8f,
	-13.8f,0.0f,-188.8f
};

const GLfloat groundB[] = {
	-132.8f,0.0f,-189.0f,
	-132.8f,0.0f,49.0f,
	-115.8f,0.0f,49.0f,
	-115.8,0.0f,-189.0f
};

const GLfloat groundE[] = {
	112.2f,0.0f,-188.8f,
	112.2f,0.0f,-154.8f,
	10.2f,0.0f,-154.8f,
	10.2,0.0f,-188.8f
};

const GLfloat groundF[] = {
	129.2f,0.0f,-189.0f,
	129.2f,0.0f,49.0f,
	112.2f,0.0f,49.0f,
	112.2f,0.0f,-189.0f
};

const GLfloat groundC[] = {
	112.2f,0.0f,-155.0f,
	112.2f,0.0f,49.0f,
	10.2f,0.0f,49.0f,
	10.2f,0.0f,-155.0f
};

const GLfloat groundD[] = {
	-115.8f,0.0f,-155.0f,
	-115.8f,0.0f,49.0f,
	-13.8f,0.0f,49.0f,
	-13.8f,0.0f,-155.0f
};

const GLfloat middle[] = {
	-13.9f,0.0f,-185.5f,
	-13.9f,0.0f,61.5f,
	10.3f,0.0f,61.5f,
	10.3f,0.0f,-185.5f
};

const GLfloat middleTex[] = {
	0.0, 13.0,
	0.0, 0.0,
	1.0, 0.0,
	1.0, 13.0
};

const GLfloat groundTex[] = {
	0.0, 1.0,
	0.0, 0.0,
	1.0, 0.0,
	1.0, 1.0
};

const GLfloat groundTexA[] = {
	0.0, 2.0,
	0.0, 0.0,
	6.0, 0.0,
	6.0, 2.0
};
const GLfloat groundTexB[] = {
	0.0, 14.0,
	0.0, 0.0,
	1.0, 0.0,
	1.0, 14.0
};
const GLfloat groundTexC[] = {
	0.0, 12.0,
	0.0, 0.0,
	6.0, 0.0,
	6.0, 12.0
};

+ (void)draw { 
	glPushMatrix();
	glBindTexture(GL_TEXTURE_2D, textures[0]);
	glVertexPointer(3, GL_FLOAT, 0, groundC);
	glTexCoordPointer(2, GL_FLOAT, 0, groundTexC);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glVertexPointer(3, GL_FLOAT, 0, groundD);
	glTexCoordPointer(2, GL_FLOAT, 0, groundTexC);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glBindTexture(GL_TEXTURE_2D, textures[1]);
	glVertexPointer(3, GL_FLOAT, 0, groundB);
	glTexCoordPointer(2, GL_FLOAT, 0, groundTexB);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glVertexPointer(3, GL_FLOAT, 0, groundA);
	glTexCoordPointer(2, GL_FLOAT, 0, groundTexA);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glVertexPointer(3, GL_FLOAT, 0, groundE);
	glTexCoordPointer(2, GL_FLOAT, 0, groundTexA);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glVertexPointer(3, GL_FLOAT, 0, groundF);
	glTexCoordPointer(2, GL_FLOAT, 0, groundTexB);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glBindTexture(GL_TEXTURE_2D, textures[3]);
	glVertexPointer(3, GL_FLOAT, 0, middle);
	glTexCoordPointer(2, GL_FLOAT, 0, middleTex);
	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glBindTexture(GL_TEXTURE_2D, textures[2]);
	glTranslatef(0.0f, -2.28f, 21.0f);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), foundryData);
    glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement),foundryData->texCoord);
	glBindTexture(GL_TEXTURE_2D, foundryTexture);
    glDrawArrays(GL_TRIANGLES, 0, foundryTriangleCount*3); 
	pollies+=foundryTriangleCount*3;
	glPopMatrix();
	glPushMatrix();
	glRotatef(-90, 1.0f, 0.0f, 0.0f);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data2);
    glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data2->normal);
    glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data2->texCoord);
	glBindTexture(GL_TEXTURE_2D, texture2);
    glDrawArrays(GL_TRIANGLES, 0, triangleCount2*3); 
	pollies+=triangleCount2*3;
	glPopMatrix();
}
@end