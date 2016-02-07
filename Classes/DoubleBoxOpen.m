//
//  DoubleBoxOpen.m
//  MC
//
//  Created by spencer whyte on 09-09-26.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DoubleBoxOpen.h"



@implementation DoubleBoxOpen

+ (void)loadTextures{
	NSString *name =  @"doubleBoxOpen.png";
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
	//glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_NEAREST);
	//glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	//glTexParameterf(GL_TEXTURE_2D,GL_GENERATE_MIPMAP, GL_TRUE);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

+(void)loadModel{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"doubleBoxOpen" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	NSLog(@"%d",(int)triangleCount);
	NSLog(@"%d", vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3);
    [[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
	openDoubleBoxes = [[NSMutableArray alloc ]init ];
}

+(void) drawOpenDoubleBoxes{
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
	//glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data->normal);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);
	glBindTexture(GL_TEXTURE_2D,  texture);
	for(int i = 0 ; i < [openDoubleBoxes count]; i++){
		DoubleBoxOpen *current = [openDoubleBoxes objectAtIndex:i];
		glPushMatrix();
		glTranslatef(current.x, current.y, current.z);
		glRotatef(current.rotationy, 0.0, 1.0, 0.0);
		glDrawArrays(GL_TRIANGLES, 0, triangleCount*3); 
		glPopMatrix();
	}
}

-(id)init
{
    if (self = [super init])
    {
		self.x = 0.0f;
		self.y = 30.5f;
		self.z = 0.0f;
		self.rotationx = 0.0f;
		self.rotationy = 0.0f;
		self.rotationz = 0.0f;
    }
	[openDoubleBoxes addObject:self];
	NSLog(@"Adding %i", [openDoubleBoxes count]);
    return self;
}



@end
