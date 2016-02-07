//
//  Oddball.h
//  Halo 3
//
//  Created by Spencer Whyte on 10-02-28.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "HaloObject.h"
static GLuint texture;
static GLVertexElement *data;
static int vertexCount;
static unsigned short triangleCount;// Equivalent to len(mesh.faces)

static int vertexCount2;
static unsigned short triangleCount2;// Equivalent to len(mesh.faces)

static int vertexCount3;
static unsigned short triangleCount3;// Equivalent to len(mesh.faces)

static NSMutableArray *oddballs;

@interface Oddball : NSObject {

}
+(void)load;
-(id)init;
+ (void)draw;
+ (void)loadTextures;
@end
