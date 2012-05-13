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

@synthesize scrappy = scrappy;
@synthesize tileMap = _tileMap;
@synthesize foreground = _foreground;
@synthesize meta = _meta;
@synthesize scrappyIsJumping = scrappyIsJumping;
@synthesize holdingLeft = _holdingLeft;
@synthesize holdingRight = _holdingRight;
@synthesize lastTouchLocation = lastTouchLocation;

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	SGTileMapLevel *layer = [SGTileMapLevel node];
	[scene addChild: layer];
	return scene;
}

- (bool)scrappyIsStandingOnTheGround {
    if (scrappy.position.y-32 < 0) {
        scrappy.position = ccp(scrappy.position.x, 31.9f);
        return true;   
    }
    else return false;
}

- (void)tickScrappy {
    // Falling & Touching down
    if ([self scrappyIsStandingOnTheGround]) {
        if (scrappy.yVelocity < 0.0f) {scrappy.yVelocity = 0.0f;}
        scrappyIsJumping = false;
    } else {
        scrappy.yVelocity -= GRAVITY;        
    }
    
    // Running
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    double xMove = 0.0f;
    if (_holdingLeft && !_holdingRight) {
        // Run left
        xMove = -2.0f;
    } else if (_holdingRight && !_holdingLeft) {
        // Run right
        xMove = 2.0f;
    } else if (_holdingLeft && _holdingRight) {
        // Activate item
    } else { // Neither is pressed.
        // stop
    }

    scrappy.position = ccp(scrappy.position.x+xMove, scrappy.position.y+scrappy.yVelocity);
    double camX = scrappy.position.x - winSize.width/2;
    double camY = scrappy.position.y - winSize.height/2;
    [self.camera setCenterX:camX centerY:camY centerZ:0];
    [self.camera setEyeX:camX eyeY:camY eyeZ:415];
}

- (id)init
{
    self = [super initWithColor:ccc4(51,51,51,255)];
    if (self) {    
        //[[SimpleAudioEngine sharedEngine] preloadEffect:@"personSavedSound.caf"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Scrappy_Demo.wav"];
        //[[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:0.5];
        
        scrappyIsJumping = _holdingLeft = _holdingRight = false;
        
        _tileMap = [[CCTMXTiledMap tiledMapWithTMXFile:@"test1.tmx"] retain];
        _foreground = [[self.tileMap layerNamed:@"Foreground"] retain];
        _meta = [[self.tileMap layerNamed:@"Meta"] retain];
        
        self.meta.visible = NO;
        
        [self addChild:self.tileMap];
        
		scrappy = [[SGScrappyCharacter alloc] init];
        
        scrappy.position = ccp( self.tileMap.tileSize.width/2, 50*self.tileMap.tileSize.height/2 );
		//scrappy.position = ccp( winSize.width/2, winSize.height/2 );
		[self addChild:scrappy];
        
        self.isTouchEnabled = YES;
        
        //[self schedule:@selector(simulateGravity) interval:1/30]; // Gravity is built into tickScrappy presently.
        [self schedule:@selector(tickScrappy) interval:1/30];
	}
	return self;
}

- (void)dealloc
{
    [scrappy release];
    [_tileMap release];
    [_foreground release];
    [_meta release];
	[super dealloc];
}

- (CGPoint)tileCoordForPosition:(CGPoint)position 
{
    int x = position.x / tileMapSquareLength;
    int y = ((self.tileMap.mapSize.height * tileMapSquareLength) - position.y) / tileMapSquareLength;
    return ccp(x, y);
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Tap began");
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [self convertTouchToNodeSpace: touch];
    lastTouchLocation = touchLocation;
    if (touchLocation.x < winSize.width/2) {
        _holdingLeft = true;
    } else {
        _holdingRight = true;
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _holdingLeft = _holdingRight = false;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [self convertTouchToNodeSpace: touch];
    if ((touchLocation.y - lastTouchLocation.y) > 5.0f) {
        if (!scrappyIsJumping) {
            scrappyIsJumping = true;
            scrappy.yVelocity = 8.0f;
        }
    }
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    if (touchLocation.x < winSize.width/2) {
        _holdingLeft = true;
    } else {
        _holdingRight = true;
    }    
    lastTouchLocation = touchLocation;
}


#pragma mark Stuff that is not presently being used.

- (void)simulateGravity
{
    /*
     // Old code from the start of the game jam.
     // Not being deleted just yet because it points the way cocos2d expects colissions to happen.
     
     CGPoint oldPosition = scrappy.position;
     
     if (oldPosition.y-32 < 0) {
        oldPosition.y = 31.9;
        scrappyIsJumping = false;
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
     
     scrappy.position = ccp(oldPosition.x, oldPosition.y);
     */
}




@end


 CGRect robotRect = [robot getSides];
 CGRect blockRect = [block getSides];
 
 if(CGRectIntersectsRect(robotRect, blockRect)) 
 {
 ...
 }
