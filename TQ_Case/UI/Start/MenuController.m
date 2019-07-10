//
//  MenuController.m
//  LeonYangBao
//
//  Created by Sunyi on 15/7/20.
//  Copyright (c) 2015年 SiChuan Ayedu Technalagy. All rights reserved.
//

#import "MenuController.h"
#import "WindowController.h"



@interface MenuController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *categoryArray;

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setBackgroundColor:[UIColor clearColor]];

    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)initData{
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:return 1;break;
        case 1:return self.categoryArray.count;break;
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:return 165;break;
        case 1:return 50; break;
        default:
            break;
    }
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] init];
    [headView setBackgroundColor:[UIColor clearColor]];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:return 0;break;
        case 1:return 10;break;
        default:break;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

