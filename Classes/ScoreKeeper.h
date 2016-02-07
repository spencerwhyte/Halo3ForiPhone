//
//  ScoreKeeper.h
//  Halo 3
//
//  Created by spencer whyte on 09-11-01.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
 #import <time.h>
NSMutableArray * scores;
time_t timeOfLastKill;
int killStreak;
int killSpree;
int sniperKillSpree;
int shotgunKillSpree;
@interface ScoreKeeper : NSObject {

}
+(void)newGame;
+(void)endGame;
+(void)awardKill;
@end
