//
//  SGMainMenuScene.m
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright (c) 2012 ThreeOrangeDoors. All rights reserved.
//

#import "SGMainMenuScene.h"
#import "SGTileMapLevel.h"

@implementation SGMainMenuScene

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	SGMainMenuScene *layer = [SGMainMenuScene node];
	[scene addChild: layer];
	
	return scene;
}

- (id)init
{
    self = [super initWithColor:ccc4(51,51,51,255)];
	if (self){
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Scrappy" fontName:@"Helvetica" fontSize:64];
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		label.position =  ccp( size.width /2 , size.height/2 );
		
		[self addChild: label];
		
		[CCMenuItemFont setFontSize:28];
        [CCMenuItemFont setFontName:@"Helvetica"];
		
		CCMenuItem *itemStartGame = [CCMenuItemFont itemWithString:@"Start Game" block:^(id sender) {
			
			[[CCDirector sharedDirector] pushScene:[CCTransitionMoveInR transitionWithDuration:0.5f scene: [SGTileMapLevel scene]]]; 
		}
                                     ];
		
		CCMenu *menu = [CCMenu menuWithItems:itemStartGame, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		[self addChild:menu];
        
	}
	return self;
}

- (void)dealloc
{
    
	[super dealloc];
}

@end
