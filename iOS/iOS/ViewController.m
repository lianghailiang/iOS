//
//  ViewController.m
//  iOS
//
//  Created by liang on 2017/5/25.
//  Copyright © 2017年 lianghailiang. All rights reserved.
//

#import "ViewController.h"
#import "HeaderFile.h"
#import "WebViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *aImageView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableView.rowHeight = UITableViewAutomaticDimension;
    _myTableView.estimatedRowHeight = 100;
    _pageNumber = 1;
    [self getData:[NSString stringWithFormat:@"%d",_pageNumber]];
}


- (void)getData:(NSString *)number{
    
    NSString *appcode = @"011e0979c77e4758a5d27aecab9c3484";
    NSString *host = @"http://jisuxhdq.market.alicloudapi.com";
    NSString *path = @"/xiaohua/text";
    NSString *method = @"GET";
    NSString *querys = @"?pagesize=5&sort=addtime";
    NSString *pagenum = [NSString stringWithFormat:@"pagenum=%@",number];
    NSString *url = [NSString stringWithFormat:@"%@%@%@&%@",  host,  path , querys, pagenum];
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
                                                       if (!_dataArray) {
                                                           _dataArray = [NSMutableArray new];
                                                       }
                                                       NSDictionary *dic = body.jsonValueDecoded;
                                                       NSNumber *status = [dic objectForKey:@"status"];
                                                       if (status.integerValue == 0) {
                                                           [_dataArray addObjectsFromArray:dic[@"result"][@"list"]];
                                                           [_myTableView reloadData];
                                                       }
                                                   }];
    
    [task resume];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){//如果行元素为空的话 则新建一行
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.numberOfLines = 0;
//        cell.selectionStyle = 0;
    }
    cell.textLabel.text = _dataArray[indexPath.row][@"content"];
    
    if (indexPath.row >= _dataArray.count-1) {
        _pageNumber ++;
        [self getData:[NSString stringWithFormat:@"%d",_pageNumber]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *ctr = [[WebViewController alloc] init];
    NSString *urlStr = [[_dataArray objectAtIndex:indexPath.row] objectForKey:@"url"];
    [ctr.myWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
