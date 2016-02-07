//
//  PlasmaGrenade.m
//  Halo 3
//
//  Created by Spencer Whyte on 10-03-16.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlasmaGrenade.h"


@implementation PlasmaGrenade
@synthesize headingz;
@synthesize headingx;
@synthesize speedy;
@synthesize animationFrame;
-(id)initWithData:(float)goingx goingy:(float)goingz startx:(float)startx starty:(float)starty startz:(float)startz{
	printf("Created\n");
	if (self = [super init])
    {
		x = startx;
		y = starty;
		z = startz;
		headingx = goingx-x;
		headingz = goingz-z;
		speedy=0.5f;
	}
	[self retain];
	[grenades addObject:self];
	return self;
}
const GLfloat plasmaBurnCoords [ ] ={
	-2.0f,2.0f,0.0f,
	-2.0f,-2.0f,0.0f,
	2.0f,-2.0f,0.0f,
	2.0f,2.0f,0.0f
};


+ (void)draw{
	glBindTexture(GL_TEXTURE_2D, texture55);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), data->texCoord);
	for(int i = 0 ; i < grenades.count; i++){
		PlasmaGrenade *current = [grenades objectAtIndex:i];
		current.x += current.headingx/50.0f;
		current.z += current.headingz/50.0f;
		float calculatedFloor = 0.3f;
		NSMutableArray * doubleBoxes  = [DoubleBox getDoubleBoxes]; 
		for(int i = 0 ; i < [doubleBoxes count] ; i++){
			DoubleBox *currentDoubleBox = (DoubleBox*)[doubleBoxes objectAtIndex:i];
			if(currentDoubleBox.orientation){
				if(currentDoubleBox.x-21 < current.x && currentDoubleBox.x + 21 > current.x && currentDoubleBox.z + 11 > current.z && currentDoubleBox.z -11 <current.z){
					if(current.y-current.speedy > 20){
						calculatedFloor = 20.0f;
					}
					if(current.y < 20){
						current.headingx = 0.0f;
						current.headingz = 0.0f;
					}
					break;
				}
			}else{
				if(currentDoubleBox.z-21 < current.z && currentDoubleBox.z + 21 > current.z && currentDoubleBox.x + 11 > current.x && currentDoubleBox.x -11 < current.x){
					if(current.y-current.speedy > 20){
						calculatedFloor = 20.0f;	
					}
					if(current.y < 20){
						current.headingx = 0.0f;
						current.headingz = 0.0f;
					}
					break;
				}
			}
		}		
		if(current.y > calculatedFloor){
		    current.y += current.speedy;
		}else{
			current.y =calculatedFloor;
			current.headingx = 0.0f;
			current.headingz = 0.0f;
		}
		if(current.x < 125 && current.x > -125 && current.z > -180 && current.z < 150){
			
		}else{
			current.headingx = 0.0f;
			current.headingz = 0.0f;	
		}
		current.speedy-=0.088;
		
		
		glPushMatrix();
		glTranslatef(current.x, current.y, current.z);
		glScalef(10.0f, 10.0f, 10.0f);
		glDrawArrays(GL_TRIANGLE_FAN, 0, triangleCount*3);
		glPopMatrix();
	}
	animationFrame2++;
	int coolc = animationFrame2%4;
	
	const GLfloat plasmaBurnTexCoords1[] = {
		0.0f,0.0,
		0.5f,0.0,
		0.5f,0.5f,
		0.0f,0.5f
	};
	const GLfloat plasmaBurnTexCoords2[] = {
		0.0f,0.5,
		0.5f,0.5,
		0.5f,1.0f,
		0.0f,1.0f
	};
	const GLfloat plasmaBurnTexCoords3[] = {
		0.5f,0.0,
		1.0f,0.0,
		1.0f,0.5f,
		0.5f,0.5f
	};
	const GLfloat plasmaBurnTexCoords4[] = {
		0.5f,0.5,
		1.0f,0.5,
		1.0f,1.0f,
		0.5f,1.0f
	};
	glColor4f(0.1f, 0.1f, 1.0f, 1.0f);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	glBindTexture(GL_TEXTURE_2D, plasmaBurn);
	glVertexPointer(3, GL_FLOAT, 0, plasmaBurnCoords);
	if(coolc ==0){
	glTexCoordPointer(2, GL_FLOAT, 0, plasmaBurnTexCoords1);
	}else if(coolc == 1){
			glTexCoordPointer(2, GL_FLOAT, 0, plasmaBurnTexCoords2);
	}else if(coolc == 2){
		glTexCoordPointer(2, GL_FLOAT, 0, plasmaBurnTexCoords3);
	}else if(coolc == 3){
		glTexCoordPointer(2, GL_FLOAT, 0, plasmaBurnTexCoords4);
	}
	for(int i = 0 ; i < grenades.count; i++){
		PlasmaGrenade *current = [grenades objectAtIndex:i];
		glPushMatrix();
		glTranslatef(current.x, current.y, current.z);
		//glRotatef((animationFrame2%8)*45, 0.0, 0.0f, 1.0);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
		glPopMatrix();
	}
	glDisable(GL_BLEND);
	glColor4f(1.0f,1.0f,1.0f,1.0f);
}

+(void)loadTextures{
	NSString *name =  @"plasmaGrenade.png";
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
	glGenTextures(1, &texture55);
	glBindTexture(GL_TEXTURE_2D, texture55);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	
	name =  @"genericPlasma.png";
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
	glGenTextures(1, &plasmaBurn);
	glBindTexture(GL_TEXTURE_2D, plasmaBurn);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	free(textureData);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
}

+(void)loadModel{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"plasmaGrenade" ofType:@"gldata"];
	NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	NSLog(@"plasma%d",(int)triangleCount);
	NSLog(@"plasma%d", vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3);
	[[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
	grenades = [[NSMutableArray alloc] init];
}
@end
