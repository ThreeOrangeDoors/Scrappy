//
//  SGTileMapLevel.m
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright (c) 2012 ThreeOrangeDoors. All rights reserved.
//

#import "SGTileMapLevel.h"
#import "SimpleAudioEngine.h"

#define tileMapSquareLength 32

@implementation SGTileMapLevel

@synthesize scrappy = _scrappy;
@synthesize tileMap = _tileMap;
@synthesize background = _background;
@synthesize holdingLeft = _holdingLeft;
@synthesize holdingRight = _holdingRight;

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	SGTileMapLevel *layer = [SGTileMapLevel node];
	[scene addChild: layer];
	
	return scene;
}

- (void)simulateGravity
{
    CGPoint oldPosition = self.scrappy.position;
    
    if (oldPosition.y-32 < 0) {
        oldPosition.y = 31.9;
    } else {
        oldPosition.y-=1;
    }
    self.scrappy.position = ccp(oldPosition.x, oldPosition.y);
}

- (void)tickScrappy {
    NSLog(@"holdingLeft: %s holdingRight: %s", (_holdingLeft)?"true":"false", (_holdingRight)?"true":"false");
    if (_holdingLeft && !_holdingRight) {
        // Run left
        //self.position = ccp(self.position.x+1.0f, self.position.y);
        self.scrappy.position = ccp(self.scrappy.position.x-1.0f, self.scrappy.position.y);
    } else if (_holdingRight && !_holdingLeft) {
        // Run right
        //self.position = ccp(self.position.x-1.0f, self.position.y);
        self.scrappy.position = ccp(self.scrappy.position.x+1.0f, self.scrappy.position.y);
    } else if (_holdingLeft && _holdingRight) {
        // Activate item
    } else {
        // stop
    }
}

- (id)init
{
    self = [super initWithColor:ccc4(51,51,51,255)];
	if (self) {
        _holdingLeft = _holdingRight = false;
		
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        _tileMap = [[CCTMXTiledMap tiledMapWithTMXFile:@"level.tmx"] retain];
        _background = [[self.tileMap layerNamed:@"Background"] retain];
        
        //[self addChild:self.tileMap z:-1];
        [self addChild:self.tileMap];
        
		_scrappy = [[SGScrappyCharacter alloc] init];
		self.scrappy.position = ccp( winSize.width/2, winSize.height/2 );
		[self addChild:self.scrappy];
        
        self.isTouchEnabled = YES;
        
        [self schedule:@selector(simulateGravity) interval:1/30];
        [self schedule:@selector(tickScrappy) interval:1/30];
	}
	return self;
}

- (void)dealloc
{
    [_scrappy release];
	[super dealloc];
}

- (CGPoint)tileCoordForPosition:(CGPoint)position 
{
    //int x = position.x / self.tileMap.tileSize.width;
    int x = position.x / tileMapSquareLength;
    NSLog(@"self.tileMap.mapSize.height:%f", self.tileMap.mapSize.height);
    NSLog(@"self.tileMap.tileSize.height:%f", self.tileMap.tileSize.height);
    
    //int y = ((self.tileMap.mapSize.height * self.tileMap.tileSize.height) - position.y) / self.tileMap.tileSize.height;
    int y = ((self.tileMap.mapSize.height * tileMapSquareLength) - position.y) / tileMapSquareLength;
    return ccp(x, y);
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Tap began");
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];

    UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [self convertTouchToNodeSpace: touch];
    NSLog(@"touchLocation.x:%f, touchLocation.y:%f", touchLocation.x, touchLocation.y);
    
    if (touchLocation.x < winSize.width/2) {
        _holdingLeft = true;
    } else {
        _holdingRight = true;
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Tap ended");
    
    _holdingLeft = _holdingRight = false;
    
    UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [self convertTouchToNodeSpace: touch];
    NSLog(@"touchLocation.x:%f, touchLocation.y:%f", touchLocation.x, touchLocation.y);
    
    CGPoint tileCoord = [self tileCoordForPosition:touchLocation];
    int tileGid = [self.background tileGIDAt:tileCoord];
    
    //[self.lavaLayer setTileGID:57 at:tileCoord];
    CCSprite *tile = [self.background tileAt:tileCoord];
    tile.opacity = 255/2;
    
    CGPoint oldPosition = self.scrappy.position;
    self.scrappy.position = ccp(oldPosition.x, oldPosition.y+35);
    
    NSLog(@"tileCoord.x:%f, tileCoord.y:%f", tileCoord.x, tileCoord.y);
    NSLog(@"tileGid:%i", tileGid);
}



@end
