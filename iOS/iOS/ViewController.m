//
//  ViewController.m
//  iOS
//
//  Created by liang on 2017/5/25.
//  Copyright © 2017年 lianghailiang. All rights reserved.
//

#import "ViewController.h"
#import "HeaderFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImageURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495689235131&di=d594db9f620e45bdc164c1207e1c5336&imgtype=0&src=http%3A%2F%2Fs2.sinaimg.cn%2Fmw690%2F003NWKKyzy6K1eYJm2Re1%26690"]];
    [imageView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setFrame:self.view.frame];
    [imageView.layer setCornerRadius:8];
    [self.view addSubview:imageView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
