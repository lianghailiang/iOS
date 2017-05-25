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

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
//    NSString *appcode = @"011e0979c77e4758a5d27aecab9c3484";
//    NSString *host = @"http://jisuxhdq.market.alicloudapi.com";
//    NSString *path = @"/xiaohua/text";
//    NSString *method = @"GET";
//    NSString *querys = @"?pagenum=1&pagesize=1&sort=addtime";
//    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
//    NSString *bodys = @"";
//    
//    [[AFHTTPSessionManager manager].requestSerializer setValue:appcode forHTTPHeaderField:@"token"];//设置请求Header
    
//    NSString *url = @"http://www.myapi.com:8888/index.php";
//    [[AFHTTPSessionManager manager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (responseObject) {
//            
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
    [self testPhpApi];
    
}
- (void)testPhpApi{
    NSString *appcode = @"011e0979c77e4758a5d27aecab9c3484";
    NSString *host = @"http://jisuxhdq.market.alicloudapi.com";
    NSString *path = @"/xiaohua/text";
    NSString *method = @"GET";
    NSString *querys = @"?pagesize=5&sort=addtime";
    NSString *pagenum = [NSString stringWithFormat:@"pagenum=%@",@"abc"];
//    NSString *url = [NSString stringWithFormat:@"%@%@%@&%@",  host,  path , querys, pagenum];
    NSString *url = @"http://www.myapi.com:8888/index.php";
    NSString *bodys = @"";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       
                                                       //打印应答中的body
                                                       NSLog(@"Response body: %@" , bodyString);
                                                       NSLog(@"json %@",body.jsonValueDecoded);
                                                   }];
    
    [task resume];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    return 1+20;
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
        switch (indexPath.section) {
            case 0:
                [cell.content_img setImageWithURL:[NSURL URLWithString:@"http://cnews.chinadaily.com.cn/img/attachement/jpg/site1/20170525/d8cb8a14fb901a90b9b21a.jpg"] options:YYWebImageOptionProgressiveBlur];
                break;
            case 1:
                [cell.content_img setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495703813161&di=b81743d6ab7baa56f9838568c6f8a41d&imgtype=0&src=http%3A%2F%2Fc.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F35a85edf8db1cb13d30ef66fdb54564e92584b63.jpg"] options:YYWebImageOptionProgressiveBlur];
                break;
            case 2:
                [cell.content_img setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495703813162&di=aa1c15ee4cf66a1a260617d939a19b30&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2F6f061d950a7b020807c1ac6162d9f2d3572cc822.jpg"] options:YYWebImageOptionProgressiveBlur];
                break;
            case 3:
                [cell.content_img setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495703813162&di=091538f9f830c84af30d3fec93fbc46e&imgtype=0&src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201605%2F11%2F163024s5l5h5l3rzl3qn13.jpg"] options:YYWebImageOptionProgressiveBlur];
                break;
            case 4:
                [cell.content_img setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495703813163&di=9c9882efc3f2bab123629b8e6c0e2217&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201409%2F16%2F20140916193506_mGUPs.jpeg"] options:YYWebImageOptionProgressiveBlur];
                break;
            case 5:
                [cell.content_img setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495703775690&di=66319e5dda7751c684bed26dd73e9a32&imgtype=0&src=http%3A%2F%2Fc.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F0eb30f2442a7d9337afbe24aa94bd11373f001b3.jpg"] options:YYWebImageOptionProgressiveBlur];
                break;
                
            default:
                [cell.content_img setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495703813160&di=0fb14205108c5809b3fcd31936a21894&imgtype=0&src=http%3A%2F%2Fwww.bz55.com%2Fuploads%2Fallimg%2F120712%2F1-120G2104G9.jpg"] options:YYWebImageOptionProgressiveBlur];
                break;
        }
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
