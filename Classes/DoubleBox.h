//
//  Double Box
//  MC
//
//  Created by spencer whyte on 01/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "BlenderObject.h"
#import "HaloObject.h"
#import "Stats.h"

@interface DoubleBox : HaloObject {
	bool orientation;
}
-(id)init;
+(void)drawDoubleBoxes;
+(void)loadTextures;
+(NSMutableArray *)getDoubleBoxes;
@property bool orientation;
@end
