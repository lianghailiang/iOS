//
//  Request.h
//  iOS
//
//  Created by liang on 2017/5/25.
//  Copyright © 2017年 lianghailiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderFile.h"

@interface Request : NSObject

+ (void)get:(NSString *)url parameters:(id)parameters hud:(BOOL)showHud success:(void (^)(id responseObject))success;


@end
