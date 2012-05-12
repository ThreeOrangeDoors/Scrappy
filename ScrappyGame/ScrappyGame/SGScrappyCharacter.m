//
//  SGScrappyCharacter.m
//  ScrappyGame
//
//  Created by Omid Mikhchi on 5/11/12.
//  Copyright (c) 2012 ThreeOrangeDoors. All rights reserved.
//

#import "SGScrappyCharacter.h"

@implementation SGScrappyCharacter

- (id)init
{
    self = [super initWithCGImage:[[UIImage imageNamed:@"Icon.png"] CGImage] key:@"scrappy"];
    
    if (self) {
        
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
