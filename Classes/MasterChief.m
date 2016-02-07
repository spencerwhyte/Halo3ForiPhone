

#import "MasterChief.h"

@implementation MasterChief
@synthesize detailLevel;
@synthesize opacity;
@synthesize localPlayer;
+(NSError*)loadTheChief{

	NSString *filePath = [[NSBundle mainBundle] pathForResource: @"MKVI" ofType:@"gldata"];
	NSString *filePath2 = [[NSBundle mainBundle] pathForResource: @"MKVI3" ofType:@"gldata"];
	NSString *filePath3 = [[NSBundle mainBundle] pathForResource: @"MKVIR2" ofType:@"gldata"];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
	NSFileHandle *handle2 = [NSFileHandle fileHandleForReadingAtPath:filePath2];
	NSFileHandle *handle3 = [NSFileHandle fileHandleForReadingAtPath:filePath3];
    if (handle == nil || handle2 == nil || handle3 == nil) {
        NSString *msg = @"Something went really, really wrong...";
        return [NSError errorWithDomain:@"BlenderObject"code:0 userInfo:[NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey]];
    }
	[[handle readDataOfLength:sizeof(int)] getBytes:&vertexCount];
	[[handle2 readDataOfLength:sizeof(int)] getBytes:&vertexCount2];
	[[handle3 readDataOfLength:sizeof(int)] getBytes:&vertexCount3];
	
	[[handle readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount];
	[[handle2 readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount2];
	[[handle3 readDataOfLength:sizeof(unsigned short)] getBytes:&triangleCount3];
	printf("MASTERCHIEF %d\n",vertexCount);
	data = malloc(sizeof(GLVertexElement) * triangleCount * 3 + sizeof(GLVertexElement) * triangleCount2 * 3+ sizeof(GLVertexElement) * triangleCount3 * 3);
	
	[[handle readDataOfLength:sizeof(GLVertexElement) * triangleCount * 3] getBytes:data];
	[[handle2 readDataOfLength:sizeof(GLVertexElement) * triangleCount2 * 3] getBytes: data+triangleCount * 3];
	[[handle3 readDataOfLength:sizeof(GLVertexElement) * triangleCount3 * 3] getBytes: data +triangleCount * 3 + triangleCount2 * 3];
	
	[handle closeFile];
	[handle2 closeFile];
	[handle3 closeFile];
	
	
	

	
	
	
	
	masterChiefs = [[NSMutableArray alloc]init];
	return [self loadTexture:@"MKVI2"]; 
}

+ (NSError *)loadTexture:(NSString *)fileName {
	
	NSString *name = [NSString stringWithFormat:@"%@.%@", fileName, @"png"];
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
	//glTexParameterf(GL_TEXTURE_2D,GL_GENERATE_MIPMAP, GL_TRUE);
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
	
	free(textureData);
	
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	
	return nil;
}


+ (void)draw {

	glBindTexture(GL_TEXTURE_2D, texture);
	glVertexPointer(3, GL_FLOAT, sizeof(GLVertexElement),data);
	glTexCoordPointer(2, GL_FLOAT, sizeof(GLVertexElement), (data)->texCoord);
	
	//glTexEnvf(GL_TEXTURE_2D,GL_TEXTURE_ENV_MODE,GL_MODULATE);
	//glEnable(GL_BLEND);
	//glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
	
	//glNormalPointer(GL_FLOAT, sizeof(GLVertexElement), data->normal);
	for(int i = 0 ; i < [masterChiefs count]; i++){
		MasterChief * temp = ((MasterChief*)[masterChiefs objectAtIndex:i]);
		if(temp.y > -10.0f){
			glPushMatrix();
			glTranslatef(temp.x, temp.y, temp.z);
			float p = (((localx - temp.x) * (localx - temp.x)) + ((localz - temp.z) * (localz - temp.z)));
			if(p < 200){
			   glDrawArrays(GL_TRIANGLES, 0,triangleCount*3); 
				pollies+=triangleCount*3;
			}else if(p < 1500){
				glDrawArrays(GL_TRIANGLES, triangleCount*3,triangleCount2*3);
					pollies+=triangleCount2*3;
			}else{
				glDrawArrays(GL_TRIANGLES, triangleCount*3+triangleCount2*3,triangleCount3*3); 
					pollies+=triangleCount3*3;
			}

		    glPopMatrix();
		}
	}
	const GLfloat triangle[] = {
		-2.0f,15.0f,0.0f,
		2.0f,15.0f,0.0f,
		0.0f,12.0f,0.0f
	};
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_DEPTH_TEST);
	glColor4f(0.1176f, 0.3333333f, 0.51399f, 1.0f);
	glVertexPointer(3, GL_FLOAT, 0,triangle);
	//glDrawArrays(GL_TRIANGLE_FAN, 0, 3);
	glEnable(GL_TEXTURE_2D);
	glEnable(GL_DEPTH_TEST);
	//glPopMatrix();
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);
	

	//glDisable(GL_BLEND);
	/*const GLfloat line [] = {
	 0.0f, 100.0f, -20.0f	,
	 0.0f, -100.0f, -20.0f	
	 };
	 glLineWidth(2.0f);
	 glDisable(GL_TEXTURE_2D);
	 glColor4f(0.0f, 1.0f, 0.0f, 1.0f);
	 glVertexPointer(3, GL_FLOAT, 0, line);
	 glDrawArrays(GL_LINES, 0, 2);
		 glEnable(GL_TEXTURE_2D);
	 */
	glColor4f(1.0f, 1.0f, 1.0f, 1.0f);

}
+(void)setLocalx:(float)lx{
	localx = lx;
}
+(void)setLocaly:(float)ly{
	localy = ly;
}
+(void)setLocalz:(float)lz{
	localz = lz;
}
-(id)init{
	if(self  == [super init]){
		[masterChiefs addObject:self];
		[self retain];
		x =0.0f;
		y = 6.0f;
		z = 0.0f;
		living = true;
		opacity =0.0f;
	}
	return self;
}

@end
