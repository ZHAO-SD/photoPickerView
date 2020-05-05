//
//  SDPhotoShowCell.h
//  photoPicker
//
//  Created by ZHAO on 2020/5/5.
//  Copyright © 2020 ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SDPhotoShowCell;

@protocol SDPhotoShowCellDelegate<NSObject>

-(void)photoShowCellDeleteAction:(SDPhotoShowCell *)cell;

@end




@interface SDPhotoShowCell : UICollectionViewCell

/** 显示图片 */
@property (nonatomic, strong) UIImage *photoImg;

/** 是否显示删除 */
@property (nonatomic, assign) BOOL isShowDelete;

/** 代理属性 */
@property (nonatomic, weak) id<SDPhotoShowCellDelegate> delegate;

@end


