//
//  Contrail.h
//  Halo 3
//
//  Created by Spencer Whyte on 10-03-15.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Contrail : NSObject {
@public
	float startx;
	float starty;
	float startz;
	float endx;
	float endy;
	float endz;
	float framesSinceShot;
}
@property(readwrite,assign) float startx;
@property(readwrite,assign) float starty;
@property(readwrite,assign) float startz;
@property(readwrite,assign) float endx;
@property(readwrite,assign) float endy;
@property(readwrite,assign) float endz;
@property(readwrite,assign) float framesSinceShot;
@end
