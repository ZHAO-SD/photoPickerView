//
//  SDPhotoPicker.h
//  photoPicker
//
//  Created by ZHAO on 2020/5/5.
//  Copyright © 2020 ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDPhotoPicker : UIView

/** 选择的图片数组 */
@property (nonatomic, strong) NSMutableArray<UIImage *> *picArray;

@end

NS_ASSUME_NONNULL_END
