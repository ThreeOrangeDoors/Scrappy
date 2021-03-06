//
//  SGTileMapLevel.h
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright (c) 2012 ThreeOrangeDoors. All rights reserved.
//

#import "cocos2d.h"
#import "SGScrappyCharacter.h"

#define GRAVITY 0.35f

@interface SGTileMapLevel : CCLayerColor 

+ (CCScene *)scene;
- (CGPoint)tileCoordForPosition:(CGPoint)position;
- (bool)scrappyIsStandingOnTheGround;

@property (nonatomic, retain) SGScrappyCharacter *scrappy;
@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *foreground;
@property (nonatomic, retain) CCTMXLayer *meta;
@property (nonatomic) bool scrappyIsJumping;
@property (nonatomic) bool holdingLeft;
@property (nonatomic) bool holdingRight;
@property (nonatomic) CGPoint lastTouchLocation;

@end

