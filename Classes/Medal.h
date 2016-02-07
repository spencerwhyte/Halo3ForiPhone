//
//  Medal.h
//  Halo 3
//
//  Created by Spencer Whyte on 10-02-06.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define assasination 0
#define beatDown 1
#define bombScore 2
#define bullTrue 3
#define killFromTheGrave 4
#define doubleKill 5
#define extermination 6
#define flagKill 7
#define flagScore 8
#define stick 9 
#define hailToTheKing 10
#define hellsJanitor 11
#define highJacker 12
#define incineration 13
#define infectionSpree 14
#define invincible 15
#define juggernautSpree 16
#define killpocalypse 17
#define killedBombCarrier 18
#define killedFlagCarrier 19
#define killedJuggernaut 20
#define killedVIP 21
#define killamanjaro 22
#define killingFrenzy 23
#define killingSpree 24
#define killionaire 25
#define killJoy 26
#define killtacular 27
#define killtastrophe 28 
#define killtrocity 29
#define laserKill 30
#define lastManStanding 31
#define linktacular 32
#define mmmmBrains 33
#define oddballKill 34
#define openSeason 35
#define overKill 36
#define perfection 37
#define rampage 38 
#define runningRiot 39 
#define sharpShooter 40
#define shotgunSpree 41
#define skyjacker 42
#define sliceNDice 43
#define sniperKill 44
#define sniperSpree 45
#define splatter 46
#define splatterSpree 47
#define steakTacular 48
#define swordSpree 49
#define tripleKill 50
#define unstoppable 51
#define untouchable 52
#define vehicularManslaughter 53
#define wheelMan 54
#define zombieKillingSpree 55


@interface Medal : NSObject {
	int medal;
	int steps;
}
-(id)initWithMedal:(int)medalID;
@property int medal;
@property int steps;
@end
