//
//  GHMapManager.m
//  JHuSystem
//
//  Created by sky on 2017/7/2.
//  Copyright © 2017年 Chengdu MoonTeam Technology. All rights reserved.
//

#import "GHMapManager.h"

@interface GHMapManager ()

//@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;
//@property (nonatomic, strong) BMKUserLocation *userLocation;
//@property (nonatomic, strong) BMKOfflineMap *offLineSearch;
//@property (nonatomic, strong) BMKReverseGeoCodeOption *reverseGeoCodeSearchOption;
//
//@property (nonatomic, assign) BOOL locationOnce;
//
//
//@property (nonatomic, assign) BOOL isSearching;


@end


@implementation GHMapManager{
//    BMKMapManager* _mapManager;
}

//- (instancetype)init {
//    if (self = [super init]) {
//        [self initMap];
//    }
//    return self;
//}
//
//
//- (void)initMap{
//
//    _mapManager = [[BMKMapManager alloc]init];
//    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [_mapManager start:kBMKMapManagerKey  generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
//
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
//        //由于IOS8中定位的授权机制改变 需要进行手动授权
//        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
//        //获取授权认证
//        [locationManager requestAlwaysAuthorization];
//
//    }
//
//    self.locationOnce = YES;
//    self.offLineSearch = [[BMKOfflineMap alloc] init];
//
//    //初始化定位服务
//    self.locationService = [[BMKLocationService alloc] init];
//    [self.locationService setDelegate:self];
//    [self.locationService setPausesLocationUpdatesAutomatically:NO];
//
//    self.offLineSearch = [[BMKOfflineMap alloc] init];
//
//
//    //初始化检索对象
//    self.geoCodeSearch =[[BMKGeoCodeSearch alloc] init];
//    self.geoCodeSearch.delegate = self;
//
//    self.reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
//
//    [self startLocationOnce];
//
//}
//
//
///**********************************************************************/
//#pragma mark - BMKLocationServiceDelegate
///**********************************************************************/
///**
// *在将要启动定位时，会调用此函数
// */
//- (void)willStartLocatingUser{
//    NSLog(@"=========开始了定位=========");
//}
//
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
//    self.userLocation = userLocation;
//    if (!self.isSearching) {
//        self.isSearching = YES;
//        _reverseGeoCodeSearchOption.reverseGeoPoint = self.userLocation.location.coordinate;
//        BOOL flag = [self.geoCodeSearch reverseGeoCode:_reverseGeoCodeSearchOption];
//        if(!flag) {
////            NSLog(@"反geo检索发送失败");
//            self.isSearching = NO;
//        }
//    }
//}
//
//- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
//    self.userLocation = userLocation;
//    if (!self.isSearching) {
//        self.isSearching = YES;
//        _reverseGeoCodeSearchOption.reverseGeoPoint = self.userLocation.location.coordinate;
//        BOOL flag = [self.geoCodeSearch reverseGeoCode:_reverseGeoCodeSearchOption];
//        if(!flag) {
////            NSLog(@"反geo检索发送失败");
//            self.isSearching = NO;
//        }
//    }
//}
//
///**********************************************************************/
//#pragma mark - BMKGeoCodeSearchDelegate
///**********************************************************************/
//
//- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
//    if (error == BMK_SEARCH_NO_ERROR && [result.cityCode integerValue] != 0) {
//        [self setResult:result];
//        [self postNotification:kLotificationRefreshNotification];
//        if (self.locationOnce) {
//            [self.locationService stopUserLocationService];
//        }
//    } else {
//        NSLog(@"定位地址错误");
//    }
//    self.isSearching = NO;
//}
//
//
//- (void)startLocationAlways{
//    [self setLocationOnce:NO];
//    [self.locationService startUserLocationService];
//}
//
//- (void)startLocationOnce{
//    [self setLocationOnce:YES];
//    [self.locationService startUserLocationService];
//}
//
//- (void)stopLocation{
//    [self setLocationOnce:YES];
//    [self.locationService stopUserLocationService];
//}
@end
