//
//  JADSKScrollingNode.h
//  FirstLetters
//
//  Created by Jennifer Dobson on 7/25/14.
//  Copyright (c) 2014 Jennifer Dobson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JADSKScrollingNode : SKNode


@property (nonatomic) CGFloat yMargin;

-(void)scrollToTop;
-(void)scrollToBottom;
-(void)enableScrollingOnView:(UIView*)view;
-(void)disableScrollingOnView:(UIView*)view;

@end
