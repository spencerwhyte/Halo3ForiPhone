//
//  World.h
//  MC
//
//  Created by spencer whyte on 09-09-18.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface World : NSObject {
	NSMutableArray *otherObjects;
	NSMutableArray *textureMappedObjects;
	NSMutableArray *normalMappedObjects;
}
-(void)draw;
@end
