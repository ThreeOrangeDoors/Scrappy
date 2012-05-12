//
//  HelloWorldLayer.m
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright ThreeOrangeDoors 2012. All rights reserved.
//


#import "HelloWorldLayer.h"
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
    self = [super init];
	if (self){
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Scrappy" fontName:@"Helvetica" fontSize:64];

		CGSize size = [[CCDirector sharedDirector] winSize];
	
		label.position =  ccp( size.width /2 , size.height/2 );
		
		[self addChild: label];
		
		[CCMenuItemFont setFontSize:28];
        [CCMenuItemFont setFontName:@"Helvetica"];
		
		CCMenuItem *itemStartGame = [CCMenuItemFont itemWithString:@"Start Game" block:^(id sender) {
			
			
		}
									   ];
		
		CCMenu *menu = [CCMenu menuWithItems:itemStartGame, nil];
		
		[menu alignItemsHorizontallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		[self addChild:menu];

	}
	return self;
}

- (void) dealloc
{

	[super dealloc];
}

@end
