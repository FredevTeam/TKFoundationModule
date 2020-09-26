//
//  NSOperationQueue+Ext.swift
//  TKFoundationModule
//
//  Created by 聂子 on 2019/1/26.
//

import Foundation

extension TypeWrapperProtocol where WrappedType: OperationQueue {
    
}

//+(NSArray *)imageWithImageUrl:(NSArray *)imageUrls
//{
//    NSMutableArray *imageArray  = [[NSMutableArray alloc]init];
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
//    [queue setMaxConcurrentOperationCount:5];
//    for (NSInteger i =  0;  i <  imageUrls.count; i++) {
//        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//            [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:imageUrls[i]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            //                            WLLog(@"--------线程执行完毕了");
//            if (image != nil) {
//            [imageArray addObject:image];
//            }
//            }];
//            }];
//        [queue addOperation:operation];
//        [operation waitUntilFinished];
//        //        WLLog(@"-----------线程执行完毕");
//    }
//
//    [queue waitUntilAllOperationsAreFinished];      //阻塞
//
//    if(imageArray.count == imageUrls.count)
//    {
//        return imageArray;
//    }
//    return nil;
//}
