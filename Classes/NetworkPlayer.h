//
//  NetworkPlayer.h
//  Halo 3
//
//  Created by spencer whyte on 09-10-10.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import <time.h>
NSMutableArray *networkPlayers;
@interface NetworkPlayer : Player {
	bool living;
	int camoTimer;
	int teamID;
	NSString *Name;
}
-(id)init;
-(void)damage:(int)damage;
+(NSMutableArray*)getPlayers;
+(void)initialize;
+(void)update;
@property bool living;
@property int camoTimer;
@property int teamID;
@property NSString* Name;
@end
