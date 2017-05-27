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
@property (weak, nonatomic) IBOutlet UIImageView *aImageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getData:@"1"];
}


- (void)getData:(NSString *)number{
    
    NSString *appcode = @"011e0979c77e4758a5d27aecab9c3484";
    NSString *host = @"http://jisuxhdq.market.alicloudapi.com";
    NSString *path = @"/xiaohua/text";
    NSString *querys = @"?pagesize=5&sort=addtime";
    NSString *pagenum = [NSString stringWithFormat:@"pagenum=%@",number];
    NSString *url = [NSString stringWithFormat:@"%@%@%@&%@",host,path,querys,pagenum];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"APPCODE %@",appcode] forHTTPHeaderField:@"Authorization"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
