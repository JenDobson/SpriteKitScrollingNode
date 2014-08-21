//
//  JADViewController.m
//  SpriteKitScrollingNode
//
//  Created by Jennifer Dobson on 7/25/14.
//  Copyright (c) 2014 Jennifer Dobson. All rights reserved.
//

#import "JADViewController.h"
#import "JADMainScene.h"
#import "JADPartScrollingScene.h"

#import <SpriteKit/SpriteKit.h>

@interface JADViewController()

@property (nonatomic, strong) JADMainScene* mainScene;
@property (nonatomic, strong) JADPartScrollingScene* partScrollingScreen;

@end


@implementation JADViewController


-(void)loadView
{
    CGRect viewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    SKView* view = [[SKView alloc] initWithFrame:viewFrame];
    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SKView* skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    CGSize contentSize = CGSizeMake(skView.bounds.size.width,skView.bounds.size.height);
    
    _mainScene = [JADMainScene sceneWithSize:contentSize];
    _mainScene.viewController = self;
    _mainScene.scaleMode = SKSceneScaleModeAspectFill;
    
    _partScrollingScreen = [JADPartScrollingScene sceneWithSize:contentSize];
    _partScrollingScreen.viewController = self;
    _partScrollingScreen.scaleMode = SKSceneScaleModeAspectFill;
    
    [self presentFullScrollingScene];
    //[self presentCropDemoScene];
}


-(void)presentFullScrollingScene
{
    SKView* skView = (SKView*)self.view;
    [skView presentScene:_mainScene];
}
-(void)presentPartScrollingScene
{
    
    SKView* skView = (SKView*)self.view;
    [skView presentScene:_partScrollingScreen];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate
{
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskLandscape;
    }
}


@end
