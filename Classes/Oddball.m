//
//  Oddball.m
//  Halo 3
//
//  Created by Spencer Whyte on 10-02-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Oddball.h"


@implementation Oddball
/*
+(void)load{
	NSString *filePath = [[NSBundle mainBundle] pathForResource: @"ball" ofType:@"gldata"];
	NSString *filePath2 = [[NSBundle mainBundle] pathForResource: @"ball2" ofType:@"gldata"];
	NSString *filePath3 = [[NSBundle mainBundle] pathForResource: @"ball3" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	NSFileHandle *handle2 = [NSFileHandle fileHandleForReadingAtPath:filePath2];
	NSFileHandle *handle3 = [NSFileHandle fileHandleForReadingAtPath:filePath3];

	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle2 readDataOfLength:sizeof(int)] getBytes:&vertexCount2];
	[[handle3 readDataOfLength:sizeof(int)] getBytes:&vertexCount3];
	
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	[[handle2 readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount2];
	[[handle3 readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount3];
	
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3 + sizeof(GLVertexElement) * triangleCount2 * 3+ sizeof(GLVertexElement) * triangleCount3 * 3);
	
	[[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount*3] getBytes:data];
	[[handle2 readDataOfLength:sizeof(GLVertexElement) * triangleCount2*3] getBytes: data+triangleCount * 3];
	[[handle3 readDataOfLength:sizeof(GLVertexElement) * triangleCount3*3] getBytes: data +triangleCount * 3 + triangleCount2 * 3];
	
	[handle closeFile];
	[handle2 closeFile];
	[handle3 closeFile];

	oddballs = [[NSMutableArray alloc] init];
	 
	[self loadTextures]; 
}

+ (void)loadTextures{
	
	NSString *name = @"oddBall.png";
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
	glGenTextures(1, &texture);
	glBindTexture(GL_TEXTURE_2D, texture);
	//glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
	//glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	// glTexParameterf(GL_TEXTURE_2D,GL_GENERATE_MIPMAP, GL_TRUE);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	
	free(textureData);
	
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	return nil;
}

-(id)init{
	if(self  == [super init]){
		self.x = 0.0f;
		self.y = 1.0f;
		self.z = 0.0f;
		[self retain];
		[oddballs addObject:self];
	}
	return self;
}

+ (void)draw{
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement),data->texCoord);
	glBindTexture(GL_TEXTURE_2D, texture);
	for (int i = 0 ;  i < [oddballs count]; i++) {
		Oddball * current  = [oddballs objectAtIndex:i];
		glPushMatrix();
		glTranslatef(current.x, current.y, current.z);
		glDrawArrays(GL_TRIANGLES, 0, triangleCount*3);
		
		glPopMatrix();
	}
}
 */
@end
