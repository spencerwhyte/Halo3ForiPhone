//
//  ScoreKeeper.m
//  Halo 3
//
//  Created by spencer whyte on 09-11-01.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ScoreKeeper.h"


@implementation ScoreKeeper
+(void)newGame{
	killStreak = 0;
	killSpree = 0;
	sniperKillSpree= 0;
	shotgunKillSpree = 0;
	timeOfLastKill = 0;
}
+(void)endGame{
	
}
+(void)awardKill{
	
}
@end
