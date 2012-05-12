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

@end
