//
//  SGTileMapLevel.h
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright (c) 2012 ThreeOrangeDoors. All rights reserved.
//

#import "cocos2d.h"
#import "SGScrappyCharacter.h"

@interface SGTileMapLevel : CCLayerColor 

+ (CCScene *)scene;

@property (nonatomic, retain) SGScrappyCharacter *scrappy;
@property (nonatomic, retain) CCTMXTiledMap *tileMap;
@property (nonatomic, retain) CCTMXLayer *background;
@property (nonatomic) bool holdingLeft;
@property (nonatomic) bool holdingRight;

@end

