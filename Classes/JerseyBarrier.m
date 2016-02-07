//
//  JerseyBarrier.m
//  Halo 3
//
//  Created by Spencer Whyte on 10-03-31.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "JerseyBarrier.h"


@implementation JerseyBarrier

-(id)init{
	if (self = [super init])
    {
		self.x =0.0f;
		self.y = 5.5f;
		self.z =-10.0f;
		self.rotationx = 0.0f;
		self.rotationy = 0.0f;
		self.rotationz = 0.0f;    }
	[self retain];
	[barriers addObject:self];
    return self;
}

+(void)load{

	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JerseyBarrier" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	NSLog(@"%d",(int)triangleCount);
	NSLog(@"%d", vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3);
    [[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
	[JerseyBarrier load2];
	barriers = [[NSMutableArray alloc] init];
}
+(void)load2{
	NSString *name =  @"jerseybarrier.png";
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
}

+(void)draw{
	glBindTexture(GL_TEXTURE_2D, texture);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);
	for(int i = 0 ; i < [barriers count];i++){
		//printf("Adafa\n");
		JerseyBarrier * current =[barriers objectAtIndex:i];
		glPushMatrix();
		glTranslatef(current.x,current.y, current.z);
		glScalef(5.0f, 5.0f, 5.0f);
		glDrawArrays(GL_TRIANGLES, 0, triangleCount*3);
		glPopMatrix();
	}
	
	
}


@end
