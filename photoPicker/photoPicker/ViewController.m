//
//  ViewController.m
//  photoPicker
//
//  Created by ZHAO on 2020/5/5.
//  Copyright © 2020 ZHAO. All rights reserved.
//

#import "ViewController.h"
#import "SDPhotoPicker.h"

@interface ViewController ()

/** <#  #> */
@property (nonatomic, strong) SDPhotoPicker *photoPicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _photoPicker = [[SDPhotoPicker alloc] initWithFrame:CGRectMake(0, 100, 375, 100)];
    _photoPicker.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_photoPicker];
    
    
    
    
}


@end
