//
//  EncodingStudy.m
//  DependencyGraph
//
//  Created by 陈东 on 2019/8/5.
//  Copyright © 2019 陈东. All rights reserved.
//

#import "EncodingStudy.h"

@implementation EncodingStudy

- (instancetype)init
{
    self = [super init];
    if (self) {
        // byte? string? int? bool? 傻傻分不清楚
        char *cstr = "😂"; // 当我们写字符串的时候，我们其实在用 utf-8 写内存
        cstr = "\U0001F602";
        
        NSLog(@"print c string");
        printf("%s\n", cstr);
        [self printBytes:cstr length:6];
        
        NSString *str = @"😂";
        NSLog(@"print oc string");
        [self printString:str];
        
        int16_t num = 0xff00;
        char *p = &num;
        printf("%p: %d, %p: %d", p, p[0], p+1, p[1]);
    }
    return self;
}

#pragma mark - Test Methods
- (void)printString:(NSString *)str
{
    NSStringEncoding encodings[4] = {
        NSUTF8StringEncoding,
        NSUTF16LittleEndianStringEncoding,
        NSUTF16BigEndianStringEncoding,
        NSUnicodeStringEncoding
    };
    
    for (int i = 0; i < 4; i++) {
        NSLog(@"print %@ using %@:", str, [self titleForEncoding:encodings[i]]);
        NSData *data = [str dataUsingEncoding:encodings[i]];
        [self printBytesForData:data];
    }
}

#pragma mark - Level 1
/// 打印 NSData 的 bytes
- (void)printBytesForData:(NSData *)data
{
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        [self printBytes:(char *)bytes length:byteRange.length];
    }];
}

/// 按 length 打印 bytes
- (void)printBytes:(char *)bytes length:(NSInteger)length
{
    [self printBytes:bytes when:^BOOL(NSInteger index) {
        return index < length;
    }];
}


#pragma mark - Level 0
/// 用 16 进制打印出 bytes，格式为：指针地址 -> {byte 16 进制}
- (void)printBytes:(unsigned char *)bytes when:(BOOL(^)(NSInteger index))condition
{
    NSInteger index = 0;
    
    while (condition(index)) {
        printf("%p -> 0x%x", &bytes[index], bytes[index]); //
        printf("\n");
        index += 1;
    }
}

/// 按 c string 的方式打印 bytes
- (void)printCStringFrom:(char *)bytes
{
    printf("%s", bytes);
}

#pragma mark - Utils
- (NSString *)titleForEncoding:(NSStringEncoding)encoding
{
    NSString *title;
    
    switch (encoding) {
        case NSUTF8StringEncoding:
            title = @"utf-8";
            break;
        case NSUTF16LittleEndianStringEncoding:
            title = @"utf-16 little endian";
            break;
        case NSUTF16BigEndianStringEncoding:
            title = @"utf-16 big endian";
            break;
        case NSUnicodeStringEncoding:
            title = @"unicode";
            break;
        default:
            break;
    }
    
    return title;
}
@end
