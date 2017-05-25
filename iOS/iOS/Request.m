//
//  Request.m
//  iOS
//
//  Created by liang on 2017/5/25.
//  Copyright © 2017年 lianghailiang. All rights reserved.
//

#import "Request.h"

@implementation Request

+ (void)get:(NSString *)url parameters:(id)parameters hud:(BOOL)showHud success:(void (^)(id))success{
    
    [[AFHTTPSessionManager manager] GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            if (success) {
                success(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        success(nil);
    }];

}


@end
