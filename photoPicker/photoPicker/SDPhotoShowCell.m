//
//  SDPhotoShowCell.m
//  photoPicker
//
//  Created by ZHAO on 2020/5/5.
//  Copyright © 2020 ZHAO. All rights reserved.
//

#import "SDPhotoShowCell.h"

#define kFit(A) [UIScreen mainScreen].bounds.size.width * (A / 375.f)

@interface SDPhotoShowCell()

/** 图片或加号*/
@property (nonatomic, strong) UIImageView *imgView;
/** 删除 */
@property (nonatomic, strong) UIButton *deleteBtn;


@end

@implementation SDPhotoShowCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.cornerRadius = 5;
        _imgView.layer.masksToBounds = YES;
        _imgView.image = [UIImage imageNamed:@"添加用户"];
        _imgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_imgView];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _imgView.frame = self.bounds;
    
    _deleteBtn.frame = CGRectMake(self.bounds.size.width-kFit(16), 0, kFit(16), kFit(16));
}


-(void)setPhotoImg:(UIImage *)photoImg{
    _photoImg = photoImg;
    
    _imgView.image = photoImg;
}

-(void)setIsShowDelete:(BOOL)isShowDelete{
    _isShowDelete = isShowDelete;
    
    self.deleteBtn.hidden = !isShowDelete;
}

//删除点击
-(void)deleteBtnClick{
    
    if ([self.delegate respondsToSelector:@selector(photoShowCellDeleteAction:)]) {
        [self.delegate photoShowCellDeleteAction:self];
    }
    
}


@end
