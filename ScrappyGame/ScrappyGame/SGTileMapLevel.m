//
//  SGTileMapLevel.m
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright (c) 2012 ThreeOrangeDoors. All rights reserved.
//

#import "SGTileMapLevel.h"
#import "SimpleAudioEngine.h"

@implementation SGTileMapLevel

@synthesize scrappy = _scrappy;

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	SGTileMapLevel *layer = [SGTileMapLevel node];
	[scene addChild: layer];
	
	return scene;
}

- (id)init
{
    self = [super initWithColor:ccc4(51,51,51,255)];
	if (self){
		
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
		_scrappy = [CCSprite spriteWithCGImage:[[UIImage imageNamed:@"Icon.png"] CGImage] key:@"scrappy"];
		self.scrappy.position = ccp( winSize.width/2, winSize.height/2 );
		[self addChild:self.scrappy];
        
	}
	return self;
}

- (void)dealloc
{
    [_scrappy release];
	[super dealloc];
}

@end
