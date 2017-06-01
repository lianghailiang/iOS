//
//  CollectionViewController.m
//  iOS
//
//  Created by liang on 2017/5/25.
//  Copyright © 2017年 lianghailiang. All rights reserved.
//

#import "CollectionViewController.h"
#import "HeaderFile.h"
#import "CollectionViewCell.h"
#import "ContentCollectionViewCell.h"

@interface CollectionViewController ()
@property (nonatomic, strong) NSMutableArray *imageList;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = @"http://192.168.1.108:8888/insert.php";
//    [Request get:url parameters:nil hud:YES success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//        if (responseObject) {
//            
//        }
//    }];
    
    [self testPhpApi:url];
    
}

- (void)testPhpApi:(NSString *)url{
    
    NSString *method = @"GET";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:1  timeoutInterval:20];
    request.HTTPMethod = method;
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Response object: %@" , response);
        if (!body) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:nil];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            return;
        }
//        NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
        
        //打印应答中的body
//        NSLog(@"Response body: %@" , bodyString);
//        NSLog(@"json %@",body.jsonValueDecoded);
        if (!_imageList) {
            _imageList = [NSMutableArray new];
        }
        NSDictionary *dic = body.jsonValueDecoded;
        NSNumber *code = [dic objectForKey:@"code"];
        if (code.integerValue == 200) {
            _imageList = [dic objectForKey:@"list"];
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
                
            });
        }
    }];
    [task resume];
}

#pragma mark <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.width, 260);
    }else{
        return CGSizeMake(self.view.width/2-15, 100);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsZero;
    }else{
        return UIEdgeInsetsMake(10, 10, 0, 10);//分别为上、左、下、右
    }
}

////两个cell之间的间距（同一行的cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 5;
//}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _imageList.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstid" forIndexPath:indexPath];
        return cell;
    }else{
        ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"contentId" forIndexPath:indexPath];
        
        NSDictionary *dic = [_imageList objectAtIndex:indexPath.section];
        [cell.content_img setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"url"]] options:YYWebImageOptionProgressiveBlur];

        return cell;
    }
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/



@end
