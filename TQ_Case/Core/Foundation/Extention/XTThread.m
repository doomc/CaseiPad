//
//  XTThread.m
//  XTFramework
//
//  Created by Qing Xiubin on 13-8-15.
//  Copyright (c) 2013年 XT. All rights reserved.
//

#import "XTThread.h"

@interface XTThread(){
	dispatch_queue_t _foreQueue;
	dispatch_queue_t _backQueue;
}

AS_SINGLETON( XTThread )

@end


@implementation XTThread

DEF_SINGLETON(XTThread)

- (id)init{
	self = [super init];
	if ( self ){
		_foreQueue = dispatch_get_main_queue();
		_backQueue = dispatch_queue_create( "com.XT.TaskQueue", nil );
	}
	
	return self;
}

+ (dispatch_queue_t)foreQueue{
	return [[XTThread sharedInstance] foreQueue];
}

- (dispatch_queue_t)foreQueue{
	return _foreQueue;
}

+ (dispatch_queue_t)backQueue{
	return [[XTThread sharedInstance] backQueue];
}

- (dispatch_queue_t)backQueue{
	return _backQueue;
}

+ (void)enqueueForeground:(dispatch_block_t)block{
	return [[XTThread sharedInstance] enqueueForeground:block];
}

- (void)enqueueForeground:(dispatch_block_t)block{
	dispatch_async( _foreQueue, block );
}

+ (void)enqueueBackground:(dispatch_block_t)block{
	return [[XTThread sharedInstance] enqueueBackground:block];
}

- (void)enqueueBackground:(dispatch_block_t)block{
	dispatch_async( _backQueue, block );
}

+ (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block{
	[[XTThread sharedInstance] enqueueForegroundWithDelay:ms block:block];
}

- (void)enqueueForegroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block{
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
	dispatch_after( time, _foreQueue, block );
}

+ (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block{
	[[XTThread sharedInstance] enqueueBackgroundWithDelay:ms block:block];
}

- (void)enqueueBackgroundWithDelay:(dispatch_time_t)ms block:(dispatch_block_t)block{
	dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, ms * USEC_PER_SEC);
	dispatch_after( time, _backQueue, block );
}

@end
