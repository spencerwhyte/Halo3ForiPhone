//
//  NetworkPlayer.m
//  Halo 3
//
//  Created by spencer whyte on 09-10-10.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NetworkPlayer.h"


@implementation NetworkPlayer
@synthesize living;
@synthesize camoTimer;
@synthesize teamID;
@synthesize Name;
float min(float a, float b){
    if(a<b){
		return a;
	}else{
		return b;	
	}
}

-(id)init{
	if(self == [super init]){
		x=0.0f;
		y=6.0f;
		z=0.0f;
		damage = 100.0f;
		camoTimer =0;
		masterChief = [[MasterChief alloc] init];
		[networkPlayers addObject:self];
		living = true;
		Name = @"Filler";
	}
	return self;
}

+(void)update{
    for(int i = 0 ; i < [networkPlayers count]; i++){
		NetworkPlayer *currentPlayer = [networkPlayers objectAtIndex:i];
		if(currentPlayer.camoTimer < 300){
			if([currentPlayer getMasterChief].opacity > 0.005){
				[currentPlayer getMasterChief].opacity-=0.005f;
			}
		  currentPlayer.camoTimer++;
		}else{
			if([currentPlayer getMasterChief].opacity < 1.0){
				[currentPlayer getMasterChief].opacity+=0.05f;
			}
		}
		if(currentPlayer.damage < 100.0f){
			currentPlayer.damage++;
		}
		if(!currentPlayer.living){
			currentPlayer.y--;
			[currentPlayer getMasterChief].y--;
			if(currentPlayer.y < -400){
				currentPlayer.living= true;
				currentPlayer.damage = 100.0f;
				currentPlayer.y = 6.0f;
				[currentPlayer getMasterChief].y = 6.0f;
			}
		}
	}
}

-(void)damage:(int)ddamage{
	damage -= ddamage;
	if(damage <= 0.0f){
	   living = false;
	}
	[ self getMasterChief].opacity+=(ddamage/100.0f);
	[self getMasterChief].opacity = min(1.0f,  [self getMasterChief].opacity);
}

+(void)initialize{
	networkPlayers = [[NSMutableArray alloc] init];
}

+(NSMutableArray *)getPlayers{
	return networkPlayers;	
}

@end
