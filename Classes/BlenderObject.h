//
//  BlenderObject.h
//  MC
//
//  Created by spencer whyte on 11/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

typedef struct __GLVertexElement {
    GLfloat coordiante[3];
    GLfloat normal[3];
    GLfloat texCoord[2];
} GLVertexElement;

@interface BlenderObject : NSObject {
	    GLuint texture;
	GLVertexElement *data;
	int vertexCount;
	unsigned short triangleCount;// Equivalent to len(mesh.faces)
	GLfloat *vertexArray;
	GLushort *indexArray;
}
- (NSError *)loadBlenderObject:(NSString *)fileName;
- (void)draw;
- (NSError *)loadTexture:(NSString *)fileName;
@end
