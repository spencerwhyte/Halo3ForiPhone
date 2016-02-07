//
//  LocalPlayer.m
//  Halo 3
//
//  Created by spencer whyte on 09-10-10.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "LocalPlayer.h"


@implementation LocalPlayer
@synthesize teamID;
-(id)init
{
    if (self = [super init])
    {
		x = 0.0f;
		y = 0.0f;
		z = 0.0f;
		centerX = 0.0f;
		centerY = 9.0f;
		centerZ =-100.0f;
		speedX  =0.0f;
		speedY = 0.0f;
		speedZ = 0.0f;
		way = 1.0f;
		teamID = 0;
		lp = self;
    }
    return self;
}

//float min(float a, float b){
//   if(a<b){
//		return a;
//}
//	return b;	

//}

double mind(double a, double b){
	if(a<b){
		return a;
	}
	return b;	
}

-(void)physics{
	y += speedY;
	centerY+=speedY;
	float currentHeight = 9.0f;
	NSMutableArray * doubleBoxes  = [DoubleBox getDoubleBoxes]; 
	bool collision = false;
	for(int i = 0 ; i < [doubleBoxes count] ; i++){
		DoubleBox *currentDoubleBox = (DoubleBox*)[doubleBoxes objectAtIndex:i];
		if(currentDoubleBox.orientation){
			if(currentDoubleBox.x-23 < x && currentDoubleBox.x + 23 > x && currentDoubleBox.z + 13 > z && currentDoubleBox.z -13 < z && y <= 29){
				collision = true;
				break;
			}
		}else{
			if(currentDoubleBox.z-23 < z && currentDoubleBox.z + 23 > z && currentDoubleBox.x + 13 > x && currentDoubleBox.x -13 < x && y <= 29 ){
				collision = true;
				break;
			}
		}
	}
	NSMutableArray *bridges  = [Bridge getBridges]; 
	for(int i = 0 ; i < [bridges count] ; i++){
		Bridge *currentbridge = (Bridge*)[bridges objectAtIndex:i];
		if(x < currentbridge.x +40 &&x > currentbridge.x -40 && z < currentbridge.z+10&& z > currentbridge.z-10 && y <= 29.0f &&( y-speedY) >= 29.0f){
			collision = true;
		}
	}
	if(collision){
		currentHeight = 29.0f;
	}
	if(y >currentHeight){
		speedY -= 0.098;
	}
	if(y < currentHeight){
		y = currentHeight;
		float temp = (y -currentHeight);
		centerY =  currentHeight;
		speedY = 0.0f;
	}
}

-(void)collision{
	if(turnLeft){ // Turn left
		GLfloat vector[3];
		vector[0] = centerX - x;
		//vector[1] = centerY - y;
		vector[2] = centerZ - z;
		centerX = x + cos(-0.05)*vector[0] - sin(-0.05)*vector[2];
		centerZ = z + sin(-0.05)*vector[0] + cos(-0.05)*vector[2];
	}
	if(turnRight){ // Turn right
		GLfloat vector[3];
		vector[0] = centerX - x;
		//vector[1] = centerY - y;
		vector[2] = centerZ - z;
		centerX = x + cos(0.05)*vector[0] - sin(0.05)*vector[2];
		centerZ = z + sin(0.05)*vector[0] + cos(0.05)*vector[2];
	}
	if(forward){ // Forwards
		GLfloat vector[3];
		vector[0] = centerX - x;
		//vector[1] = centerY - y;
		vector[2] = centerZ - z;
		GLfloat tempX;
		GLfloat tempZ;
		if(speedY == 0.0f){
			tempX = x + vector[0] * 0.01f;
			tempZ = z +  vector[2] * 0.01f;
		}else{
			tempX = x + vector[0] * 0.005f;
			tempZ = z +  vector[2] * 0.005f;
		}
		
		if(tempX < 125 && tempX > -125 && tempZ > -180 && tempZ <150){
			NSMutableArray * doubleBoxes  = [DoubleBox getDoubleBoxes]; 
			bool collision = false;
			for(int i = 0 ; i < [doubleBoxes count] ; i++){
				DoubleBox *currentDoubleBox = (DoubleBox*)[doubleBoxes objectAtIndex:i];
				if(currentDoubleBox.orientation){
					if(currentDoubleBox.x-23 < tempX && currentDoubleBox.x + 23 > tempX && currentDoubleBox.z + 13 > tempZ && currentDoubleBox.z -13 < tempZ && y < 19){
						collision = true;
						break;
					}
				}else{
					if(currentDoubleBox.z-23 < tempZ && currentDoubleBox.z + 23 > tempZ && currentDoubleBox.x + 13 > tempX && currentDoubleBox.x -13 < tempX && y < 19 ){
						collision = true;
						break;
					}
				}
			}
			if(!collision){
				x = tempX;
				z = tempZ;
				if(speedY == 0.0f){
					centerX += vector[0] * 0.01f;
					centerZ += vector[2] * 0.01f;
				}else{
					centerX += vector[0] * 0.005f;
					centerZ += vector[2] * 0.005f;
				}
			}
		}
	}
	if(backward){ // Backwards
		GLfloat vector[3];
		vector[0] = centerX - x;
		//	vector[1] = centerY - y;
		vector[2] = centerZ - z;
		GLfloat tempX;
		GLfloat tempZ;
		if(speedY == 0.0f){
			tempX  = x - vector[0] * 0.01;
			tempZ = z - vector[2] * 0.01;
		}else{
			tempX  = x - vector[0] * 0.005;
			tempZ = z - vector[2] * 0.005;
		}
		
		if(tempX < 125 && tempX > -125 && tempZ > -180 && tempZ < 150){ // If the player is within the map still
			NSMutableArray * doubleBoxes  = [DoubleBox getDoubleBoxes]; 
			bool collision = false;
			for(int i = 0 ; i < [doubleBoxes count] ; i++){
				DoubleBox *currentDoubleBox = (DoubleBox*)[doubleBoxes objectAtIndex:i];
				if(currentDoubleBox.orientation){
					if(currentDoubleBox.x-23 < tempX && currentDoubleBox.x + 23 > tempX && currentDoubleBox.z + 13 > tempZ && currentDoubleBox.z -13 < tempZ && y < 19 ){
						collision = true;
						break;
					}
				}else{
					if(currentDoubleBox.z-23 < tempZ && currentDoubleBox.z + 23 > tempZ && currentDoubleBox.x + 13 > tempX && currentDoubleBox.x -13 < tempX && y < 19){
						collision = true;
						break;
					}
				}
			}
			if(!collision){
				x = tempX;
				z = tempZ;
				if(speedY == 0.0f){
					centerX -= vector[0] * 0.01;
					centerZ -= vector[2] * 0.01;
				}else{
					centerX -= vector[0] * 0.005;
					centerZ -= vector[2] * 0.005;
				}
				
			}
		}
	}
	if(moveLeft){ // Move left
		GLfloat leftVector[3];
		GLfloat vector[3];
		vector[0] = centerX - x;
		vector[2] = centerZ - z;
		leftVector[0] = -vector[2];
		leftVector[2] = vector[0];
		GLfloat tempX;
		GLfloat tempZ;
		if(speedY == 0.0f){
			tempX = x - leftVector[0] * 0.01;
			tempZ  = z - leftVector[2] * 0.01;
		}else{
			tempX = x - leftVector[0] * 0.005;
			tempZ  = z - leftVector[2] * 0.005;
		}
		if(tempX < 125 && tempX > -125 && tempZ > -180 && tempZ < 150){
			NSMutableArray * doubleBoxes  = [DoubleBox getDoubleBoxes]; 
			bool collision = false;
			for(int i = 0 ; i < [doubleBoxes count] ; i++){
				DoubleBox *currentDoubleBox = (DoubleBox*)[doubleBoxes objectAtIndex:i];
				if(currentDoubleBox.orientation){
					if(currentDoubleBox.x-23 < tempX && currentDoubleBox.x + 23 > tempX && currentDoubleBox.z + 13 > tempZ && currentDoubleBox.z -13 < tempZ && y < 19){
						collision = true;
						break;
					}
				}else{
					if(currentDoubleBox.z-23 < tempZ && currentDoubleBox.z + 23 > tempZ && currentDoubleBox.x + 13 > tempX && currentDoubleBox.x -13 < tempX && y < 19){
						collision = true;
						break;
					}
				}
			}
			if(!collision){
				x = tempX;
				z = tempZ;
				
				if(speedY == 0.0f){
					centerX -= leftVector[0] * 0.01;
					centerZ -= leftVector[2] * 0.01;
				}else{
					centerX -= leftVector[0] * 0.005;
					centerZ -= leftVector[2] * 0.005;
				}
			}
		}
	}
	if(moveRight){ // Move right
		GLfloat rightVector[3];
		GLfloat vector[3];
		vector[0] = centerX - x;
		vector[2] = centerZ - z;
		rightVector[0] = vector[2];
		rightVector[2] = -vector[0];
		GLfloat tempX;
		GLfloat tempZ;
		if(speedY == 0.0f){
			tempX = x - rightVector[0] * 0.01;
			tempZ = z - rightVector[2] * 0.01;
		}else{
			tempX = x - rightVector[0] * 0.005;
			tempZ = z - rightVector[2] * 0.005;
		}
		
		if(tempX < 125 && tempX > -125 && tempZ > -180 && tempZ < 150){
			NSMutableArray * doubleBoxes  = [DoubleBox getDoubleBoxes]; 
			bool collision = false;
			for(int i = 0 ; i < [doubleBoxes count] ; i++){
				DoubleBox *currentDoubleBox = (DoubleBox*)[doubleBoxes objectAtIndex:i];
				if(currentDoubleBox.orientation){
					if(currentDoubleBox.x-23 < tempX && currentDoubleBox.x + 23 > tempX && currentDoubleBox.z + 13 > tempZ && currentDoubleBox.z -13 < tempZ && y < 19){
						collision = true;
						break;
					}
				}else{
					if(currentDoubleBox.z-23 < tempZ && currentDoubleBox.z + 23 > tempZ && currentDoubleBox.x + 13 > tempX && currentDoubleBox.x -13 < tempX && y < 19){
						collision = true;
						break;
					}
				}
			}
			if(!collision){
				x= tempX;
				z = tempZ;
				
				if(speedY == 0.0f){
					centerX -= rightVector[0] * 0.01;
					centerZ -= rightVector[2] * 0.01;
				}else{
					centerX -= rightVector[0] * 0.005;
					centerZ -= rightVector[2] * 0.005;
				}
				
			}
		}
	}
	
	[HUD enemyOutOfSight];
	[HUD friendlyOutOfSight];
	bool approved = true;
	NSMutableArray * doubleBoxes = [DoubleBox getDoubleBoxes];
	double cpoi = 10000000;
	for(int i = 0 ; i < [doubleBoxes count]; i++){ // This loop  goes through the double boxes and removes the ones that don't intersect it.
		DoubleBox * current  = [doubleBoxes objectAtIndex:i];
		float Lx = centerX;
		float Lz = centerZ;
		float Px = x;
		float Pz = z;
		if(current.orientation){
			
			if((Px-Lx) != 0){
				double m = (Pz-Lz)/(Px-Lx);
				double b = Pz - m * Px;
				double computed1=((current.z+10)-b)/m;
				double computed2=((current.z-10)-b)/m;
				if((computed1 <= current.x +20 && computed1 >= current.x -20)||(computed2 <= current.x +20 && computed2 >= current.x -20)){
					if(fabs((atan2(current.x-x, current.z-z)*180.0/3.14159265358979)-(atan2(centerX-x, centerZ-z)*180.0/3.14159265358979)) < 90.0){
						cpoi=mind(cpoi,mind( sqrt((computed1-Px)*(computed1-Px)+((current.z+10)-Pz)*((current.z+10)-Pz)),sqrt((computed2-Px)*(computed2-Px)+((current.z-10)-Pz)*((current.z-10)-Pz))));
					}
				}
				double computed3 = m*(current.x-20) + b;
				double computed4 = m*(current.x+20) + b;
				if((computed3 <= (current.z + 10) && computed3 >= (current.z-10))||(computed4 <= (current.z + 10) && computed4 >= (current.z-10))){
					if(fabs((atan2(current.x-x, current.z-z)*180.0/3.14159265358979)-(atan2(centerX-x, centerZ-z)*180.0/3.14159265358979)) < 90.0){
						cpoi = mind(cpoi, mind(sqrt((computed3-Pz)*(computed3-Pz)+(current.x+20 - Px)*(current.x+20 - Px)), sqrt((computed4-Pz)*(computed4-Pz)+(current.x-20 - Px)*(current.x-20 - Px))  ));
					}
				}
			}else{
				if(Px <= current.x+20 && Px >= current.x-20){
					if(Pz > current.z +20){
						if(fabs((atan2(current.x-x, current.z-z)*180.0/3.14159265358979)-(atan2(centerX-x, centerZ-z)*180.0/3.14159265358979)) < 90.0){
							cpoi = mind(cpoi, fabs(Pz-(current.z+20)));
						}
					}else if(Pz < current.z - 20){
						if(fabs((atan2(current.x-x, current.z-z)*180.0/3.14159265358979)-(atan2(centerX-x, centerZ-z)*180.0/3.14159265358979)) < 90.0){
							cpoi = mind(cpoi, fabs(Pz-(current.z-20)));
						}
					}
				}
			}
			
			
			
		}else{
			if((Px-Lx) != 0){
				double m = (Pz-Lz)/(Px-Lx);
				double b = Pz - m * Px;
				double computed1=((current.z+20)-b)/m;
				double computed2=((current.z-20)-b)/m;
				if((computed1 <= current.x +10 && computed1 >= current.x -10)||(computed2 <= current.x +10 && computed2 >= current.x -10)){
					if(fabs((atan2(current.x-x, current.z-z)*180.0/3.14159265358979)-(atan2(centerX-x, centerZ-z)*180.0/3.14159265358979)) < 90.0){
						cpoi=mind(cpoi,mind( sqrt((computed1-Px)*(computed1-Px)+((current.z+20)-Pz)*((current.z+20)-Pz)),sqrt((computed2-Px)*(computed2-Px)+((current.z-20)-Pz)*((current.z-20)-Pz))));
					}
				}
				double computed3 = m*(current.x-10) + b;
				double computed4 = m*(current.x+10) + b;
				if((computed3 <= (current.z + 20) && computed3 >= (current.z-20))||(computed4 <= (current.z + 20) && computed4 >= (current.z-20))){
					if(fabs((atan2(current.x-x, current.z-z)*180.0/3.14159265358979)-(atan2(centerX-x, centerZ-z)*180.0/3.14159265358979)) < 90.0){
						cpoi = mind(cpoi, mind(sqrt((computed3-Pz)*(computed3-Pz)+(current.x+10 - Px)*(current.x+10 - Px)), sqrt((computed4-Pz)*(computed4-Pz)+(current.x-10 - Px)*(current.x-10 - Px))  ));
					}
				}
			}else{
				if(Px <= current.x+10 && Px >= current.x-10){
					if(Pz > current.z +20){
						if(fabs((atan2(current.x-x, current.z-z)*180.0/3.14159265358979)-(atan2(centerX-x, centerZ-z)*180.0/3.14159265358979)) < 90.0){
							cpoi = mind(cpoi, fabs(Pz-(current.z+10)));
						}
					}else if(Pz < current.z - 10){
						if(fabs((atan2(current.x-x, current.z-z)*180.0/3.14159265358979)-(atan2(centerX-x, centerZ-z)*180.0/3.14159265358979)) < 90.0){
							cpoi = mind(cpoi, fabs(Pz-(current.z-10)));
						}
						
					}
				}
			}
			
		}
		//printf("%f\n", cpoi);
	}
	//	printf("%f\n", cpoi);
	
	if([[HUD getPrimaryWeapon] firing]){
		weaponFired = true;
	}else{
		weaponFired = false;	
	}
	float playerStruck = 1000000.0f;
	NSMutableArray *playersTemp = [NetworkPlayer getPlayers];
	double bestAngle = 10000.0;
	int bestAngleIndex = -1;
	double divisorSaved = -100.0;
	for(int i = 0 ; i < [playersTemp count]; i++){
		NetworkPlayer *currentPlayer = [playersTemp objectAtIndex:i];
		float Ex = currentPlayer.x;
		float Ez = currentPlayer.z;
		float Ey = currentPlayer.y;
		float Lx = centerX;
		float Lz = centerZ;
		float Px = x;
		float Pz = z;
		if(centerY-1 < Ey+3 &&centerY+1 > Ey+3){ // Check in the y-azis
			// Approved logic
			if(sqrt((Ex-Px)*(Ex-Px)+(Ez-Pz)*(Ez-Pz)) > cpoi){
				approved = false;
			}
			if(approved){
				double d= (Ex-Px)*(Ex-Px)+(Ez-Pz)*(Ez-Pz);
				double divisor = sqrt(d *((Lx-Px)*(Lx-Px)+(Lz-Pz)*(Lz-Pz)));
				//		printf("%f\n",divisor);
				double computed = acos(((Ex-Px)*(Lx-Px)+(Ez-Pz)*(Lz-Pz))/divisor);
				//printf("%f\n", computed);
				float ca =1.0f;
				if(currentPlayer.teamID == teamID){
					ca = 0.0001f;
				}else{
				    ca = 0.001;
				}
				if(fabs(computed)-0.05 < (ca*sqrt(d)) ){
					double temper = bestAngle;
					bestAngle = mind((fabs(computed)-0.05), bestAngle);
					if(temper!=bestAngle){
						bestAngleIndex = i;
						divisorSaved = divisor;
					}
					playerStruck = mind(playerStruck, sqrt(d));
				}
			}
		}
	}
	if(bestAngleIndex!=-1){
		
	NetworkPlayer *currentPlayer = [networkPlayers objectAtIndex:bestAngleIndex];
		if(currentPlayer.teamID == teamID){
			[HUD friendlyInSight];
		}else{
			[HUD enemyInSight];
		}
	if(weaponFired){
		if([[HUD getPrimaryWeapon]isKindOfClass:[SniperRifle class]]){
			[currentPlayer damage:100]; // Give the person sniper damage
		}else if([[HUD getPrimaryWeapon]isKindOfClass:[BattleRifle class]]){
			[currentPlayer damage:[BattleRifle  damage]];
		}else if([[HUD getPrimaryWeapon] isKindOfClass:[SMG class]]){
			[currentPlayer damage:mind(4, 16000.0/divisorSaved)];
		}
		//	printf("%f",mind(4, 16000.0/divisor));
		if(!currentPlayer.living){ 
			if(currentPlayer.teamID != teamID){ // IF you are not on the persons team
				 [HUD postMessage: [NSString stringWithFormat:@"You killed %@", currentPlayer.Name]];	
				killSpree++;
				//	if(sniperKillSpree ==4){
				//		[HUD awardMedal:killingSpree];	
				//	}else if(sniperKillSpree == 9){
				//		[HUD awardMedal:killingFrenzy];
				if(killSpree == 15){
					[HUD awardMedal:runningRiot];
				}else if(killSpree == 20){
					[HUD awardMedal:rampage];
				}else if(killSpree == 25){
					[HUD awardMedal:untouchable];
				}else if(killSpree == 5){
					[HUD awardMedal:killingSpree];
				}else if(killSpree == 10){
					[HUD awardMedal:killingFrenzy];
				}
				if(difftime( time(NULL) ,  timeOfLastKill)< 4.0){
					if(killStreak == 0){
						[HUD awardMedal:doubleKill];
					}else if(killStreak ==1){
						[HUD awardMedal:tripleKill];
					}else if(killStreak == 2){
						[HUD awardMedal:overKill];
					}else if(killStreak == 3){
						[HUD awardMedal:killtacular];
					}else if(killStreak == 4){
						[HUD awardMedal:killtrocity];
					}else if(killStreak == 5){
						[HUD awardMedal:killamanjaro];
					}else if(killStreak == 6){
						[HUD awardMedal:killtastrophe];
					}else if(killStreak == 7){
						[HUD awardMedal:killpocalypse];
					}else if(killStreak == 8){
						[HUD awardMedal:killionaire];
					}
					killStreak++;
				}else{
					killStreak = 0;	
				}
				timeOfLastKill = time(NULL);
				if([[HUD getPrimaryWeapon]isKindOfClass:[SniperRifle class]]){
					sniperKillSpree++;
					[HUD awardMedal:sniperKill];
				}
			}else{
			  [HUD postMessage: [NSString stringWithFormat:@"You betrayed %@", currentPlayer.Name]];	
			}
		}
		
	}
	
}
	
	
	// printf("%f\n",centerX-x );
	float itty = 500.0f;
	if(y<18.0){
		itty =mind(mind(cpoi, 500.0),playerStruck)/100.0f;
	}else{
		itty = mind(500,playerStruck)/100.0f;
	}
	if(weaponFired && [[HUD getPrimaryWeapon] isKindOfClass:[SniperRifle class]]){
		NSMutableArray *contrails = [SniperRifle getContrials];
		Contrail *c = [[Contrail alloc] init];
		c.startx =x + ((centerX-x))/ 20.0f;
		c.endx =x +((centerX-x)*itty);
		c.starty = y-0.2;
		c.endy = y-0.2;
		c.startz = z+(centerZ-z)/20.0f;
		c.endz = z+((centerZ-z)*itty);
		c.framesSinceShot = 0;
		[contrails addObject:c];
	}
	if(![[HUD getPrimaryWeapon] isKindOfClass:[SMG class]]){
		weaponFired = false;
	}
	
}


- (void)stopFireWeapon{
	weaponFired = false;	
}

-(void)fireWeapon{
	weaponFired = true;
}
+(id)getLocalPlayer{
	return lp;	
}
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize centerX;
@synthesize centerY;
@synthesize centerZ;
@synthesize speedY;
@synthesize moveRight;
@synthesize moveLeft;
@synthesize forward;
@synthesize backward;
@synthesize turnLeft;
@synthesize turnRight;
@synthesize turnDown;
@synthesize turnUp;
@end
