//
//  Menu.h
//  Halo 3
//
//  Created by Spencer Whyte on 10-02-22.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Foundry.h"
#import "Ghost.h"
#import "DoubleBox.h"
#import "Bridge.h"
#import <math.h>
static GLuint menuTexture;
static 	float menuRotation;
@interface Menu : NSObject {

}
+(void)draw;
+(void)loadTextures;
@end
