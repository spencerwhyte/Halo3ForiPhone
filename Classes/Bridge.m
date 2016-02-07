//
//  DoubleBox.m
//  MC
//
//  Created by spencer whyte on 10/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Bridge.h"


@implementation Bridge
@synthesize orientation;

-(id)init
{
    if (self == [super init])
    {
		[bridges addObject:self];
		self.x = 0.0f;
		self.y = 22.5f;
		self.z = 0.0f;
    }
    return self;
}

+ (void)loadTextures{
		NSString *name =  @"bridgeTexture.png";
		NSLog(@"%s@",name);
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
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bridge" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	NSLog(@"%d",(int)triangleCount);
	NSLog(@"%d", vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3);
    [[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
	bridges = [[NSMutableArray alloc] init];
}

+(void) draw{
	  glBindTexture(GL_TEXTURE_2D,  texture);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
	// glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data->normal);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);	
	for(int i = 0 ; i < [bridges count]; i++){
	  Bridge *currentBridge = [bridges objectAtIndex:i];
      glPushMatrix();
	  glTranslatef(currentBridge.x, currentBridge.y, currentBridge.z);
	  glDrawArrays(GL_TRIANGLES, 0, triangleCount*3); 
	  glPopMatrix();
	}
}
+(NSMutableArray*)getBridges{
	return bridges;
}
@end
