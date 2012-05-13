//
//  SGScrappyCharacter.m
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright (c) 2012 ThreeOrangeDoors. All rights reserved.
//

#import "SGScrappyCharacter.h"

@implementation SGScrappyCharacter

@synthesize yVelocity = yVelocity;

- (id)init
{
    self = [super initWithCGImage:[[UIImage imageNamed:@"Icon.png"] CGImage] key:@"scrappy"];
    
    if (self) {
        yVelocity = 0;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
