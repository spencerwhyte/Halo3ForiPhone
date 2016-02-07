//
//  TrafficCone.m
//  MC
//
//  Created by spencer whyte on 09-09-29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TrafficCone.h"


@implementation TrafficCone

+(void)loadModel{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"trafficCone" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	NSLog(@"%d",(int)triangleCount);
	NSLog(@"%d", vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3);
    [[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
}

-(void) draw{

		glDisable(GL_TEXTURE_2D);
		glColor4f(0.58f, 0.27f,0.047f, 1.0f);
		glPushMatrix();
	
		glTranslatef(self.x, self.y, self.z);
    //	glScalef(10.0f, 10.0f, 10.0f);
		glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement), data);
		glDrawArrays(GL_TRIANGLES, 0, triangleCount*3); 
		glPopMatrix();
		glColor4f(1.0f, 1.0f,1.0f, 1.0f);
		glEnable(GL_TEXTURE_2D);
}

-(id)init{
	if(self == [super init]){
		self.x = 0.0f;
		self.y = 1.0f;
		self.z = 0.0f;
	}
	return self;
}

@end
