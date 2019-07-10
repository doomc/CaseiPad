//
//  GHEmoji.m
//  GameHelper
//
//  Created by Jayla on 17/3/6.
//  Copyright © 2017年 kylincc. All rights reserved.
//

#import "GHEmoji.h"

@implementation GHEmoji

static NSDictionary<NSString *, NSString*> *keyboardEmojiDic = nil;
+ (NSDictionary<NSString *, NSString*> *)keyboardEmojiDic {
    if (!keyboardEmojiDic) {
        keyboardEmojiDic = @{@"[尴尬]":@"emoji1.png",
                             @"[可爱]":@"emoji2.png",
                             @"[生气]":@"emoji3.png",
                             @"[害羞]":@"emoji4.png",
                             @"[忧郁]":@"emoji5.png",
                             @"[坏笑]":@"emoji6.png",
                             @"[哭]":@"emoji7.png",
                             @"[汗]":@"emoji8.png",
                             @"[难过]":@"emoji9.png",
                             @"[惊讶]":@"emoji10.png",
                             @"[高兴]":@"emoji11.png",
                             @"[招呼]":@"emoji12.png",
                             @"[心动]":@"emoji13.png",
                             @"[装酷]":@"emoji14.png",
                             @"[飞吻]":@"emoji15.png",
                             @"[惊恐]":@"emoji16.png",
                             @"[大笑]":@"emoji17.png",
                             @"[无语]":@"emoji18.png",
                             @"[存钱]":@"emoji19.png",
                             @"[恶魔]":@"emoji20.png",
                             @"[书呆子]":@"emoji21.png",
                             @"[喷嚏]":@"emoji22.png",
                             @"[海盗]":@"emoji23.png",
                             @"[嘲笑]":@"emoji24.png",
                             @"[生病]":@"emoji25.png",
                             @"[微笑]":@"emoji26.png",
                             @"[调皮]":@"emoji27.png",
                             @"[踩]":@"emoji28.png",
                             @"[顶]":@"emoji29.png",
                             @"[撇嘴]":@"emoji30.png",
                             @"[愤怒]":@"emoji31.png",
                             @"[眨眼]":@"emoji32.png",
                             @"[开心]":@"emoji33.png"};
    }
    return keyboardEmojiDic;
}


static NSDictionary<NSString *, NSString*> *emojiDic = nil;
+ (NSDictionary<NSString *, NSString*> *)emojiDic {
    if (!emojiDic) {
        emojiDic = [NSMutableDictionary dictionaryWithDictionary:[self keyboardEmojiDic]];
        [emojiDic setValue:@"内容po.png" forKey:@"[动态-楼主]"];
        [emojiDic setValue:@"动态-顶.png" forKey:@"[动态-顶]"];
    }
    return emojiDic;
}
static NSDictionary<NSString *, UIImage*> *emojiPicDic = nil;
+ (NSDictionary<NSString *, UIImage*> *)emojiPicDic {
    if (!emojiPicDic) {
        emojiPicDic = [NSMutableDictionary dictionary];
        [[self emojiDic] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [emojiPicDic setValue:[UIImage imageNamed:obj] forKey:obj];
        }];
    }
    return emojiPicDic;
}



@end
