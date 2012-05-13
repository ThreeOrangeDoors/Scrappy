//
//  PhysicsSprite.h
//  ScrappyMunk
//
//  Created by Tao Flaherty on 5/13/12.
//  Copyright ThreeOrangeDoors 2012. All rights reserved.
//

#import "cocos2d.h"
#import "chipmunk.h"

@interface PhysicsSprite : CCSprite
{
	cpBody *body_;	// strong ref
}

-(void) setPhysicsBody:(cpBody*)body;
-(CGRect) getSides;    // to find borders for intersection detection

@end