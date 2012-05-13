//
//  SGTileMapLevel.m
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright (c) 2012 ThreeOrangeDoors. All rights reserved.
//

#import "SGTileMapLevel.h"
#import "SimpleAudioEngine.h"

#define tileMapSquareLength 64

@implementation SGTileMapLevel

@synthesize scrappy = _scrappy;
@synthesize tileMap = _tileMap;
@synthesize foreground = _foreground;
@synthesize meta = _meta;
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
        CGPoint tileCoord = [self tileCoordForPosition:oldPosition];
        
        int tileGid = [self.meta tileGIDAt:tileCoord];
        
        if (tileGid) {
            NSDictionary *properties = [self.tileMap propertiesForGID:tileGid];
            
            if (properties) {
                NSString *collision = [properties valueForKey:@"Collidable"];
                
                if (collision && [collision compare:@"True"] == NSOrderedSame) {
                    return;
                }
            }
        } else {
            oldPosition.y-=1;
        }
    }
    
    self.scrappy.position = ccp(oldPosition.x, oldPosition.y);
}

- (void)tickScrappy {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
//    NSLog(@"holdingLeft: %s holdingRight: %s", (_holdingLeft)?"true":"false", (_holdingRight)?"true":"false");
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
    double camX = self.scrappy.position.x - winSize.width/2;
    double camY = self.scrappy.position.y - winSize.height/2;
    [self.camera setCenterX:camX centerY:camY centerZ:0];
    [self.camera setEyeX:camX eyeY:camY eyeZ:415];
}

- (id)init
{
    self = [super initWithColor:ccc4(51,51,51,255)];
	if (self) {
//        [[SimpleAudioEngine sharedEngine] preloadEffect:@"personSavedSound.caf"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Scrappy_Demo.wav"];
//        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5];
        
        _holdingLeft = _holdingRight = false;
		
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        _tileMap = [[CCTMXTiledMap tiledMapWithTMXFile:@"test1.tmx"] retain];
        _foreground = [[self.tileMap layerNamed:@"Foreground"] retain];
//        _meta = [[self.tileMap layerNamed:@"Meta"] retain];
        
        self.meta.visible = NO;
        
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
    [_tileMap release];
    [_foreground release];
    [_meta release];
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
    int tileGid = [self.foreground tileGIDAt:tileCoord];
    
    CGPoint oldPosition = self.scrappy.position;
    // bad jump code
    self.scrappy.position = ccp(oldPosition.x, oldPosition.y+35);
    
    NSLog(@"tileCoord.x:%f, tileCoord.y:%f", tileCoord.x, tileCoord.y);
    NSLog(@"tileGid:%i", tileGid);
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //[touch locationInView:self.view];
}




@end
