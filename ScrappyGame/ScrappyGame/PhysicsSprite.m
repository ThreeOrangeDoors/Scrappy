//
//  PhysicsSprite.m
//  ScrappyMunk
//
//  Created by Tao Flaherty on 5/13/12.
//  Copyright ThreeOrangeDoors 2012. All rights reserved.
//


#import "PhysicsSprite.h"

// callback to remove Shapes from the Space
void removeShape( cpBody *body, cpShape *shape, void *data )
{
	cpShapeFree( shape );
}

#pragma mark - PhysicsSprite
@implementation PhysicsSprite

-(void) setPhysicsBody:(cpBody *)body
{
	body_ = body;
}

// this method will only get called if the sprite is batched.
// return YES if the physic's values (angles, position ) changed.
// If you return NO, then nodeToParentTransform won't be called.
-(BOOL) dirty
{
	return YES;
}

// returns the transform matrix according the Chipmunk Body values
-(CGAffineTransform) nodeToParentTransform
{	
	CGFloat x = body_->p.x;
	CGFloat y = body_->p.y;
	
	if ( ignoreAnchorPointForPosition_ ) {
		x += anchorPointInPoints_.x;
		y += anchorPointInPoints_.y;
	}
	
	// Make matrix
	CGFloat c = body_->rot.x;
	CGFloat s = body_->rot.y;
	
	if( ! CGPointEqualToPoint(anchorPointInPoints_, CGPointZero) ){
		x += c*-anchorPointInPoints_.x + -s*-anchorPointInPoints_.y;
		y += s*-anchorPointInPoints_.x + c*-anchorPointInPoints_.y;
	}
	
	// Translate, Rot, anchor Matrix
	transform_ = CGAffineTransformMake( c,  s,
									   -s,	c,
									   x,	y );
	
	return transform_;
}

// making a rect for intersection methods
-(CGRect) getSides
{
    CGSize s = [self contentSize];
    s.width *= scaleX_;
    s.height *= scaleY_;
        return CGRectMake(
                          position_.x - s.width * anchorPoint_.x,
                          position_.y - s.height * anchorPoint_.y,
                          s.width,
                          s.height);
}

-(void) dealloc
{
	cpBodyEachShape(body_, removeShape, NULL);
	cpBodyFree( body_ );
	
	[super dealloc];
}

@end
