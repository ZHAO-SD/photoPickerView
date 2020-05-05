//
//  SDPhotoPicker.m
//  photoPicker
//
//  Created by ZHAO on 2020/5/5.
//  Copyright © 2020 ZHAO. All rights reserved.
//

#import "SDPhotoPicker.h"
#import "SDPhotoShowCell.h"

@interface SDPhotoPicker()<UICollectionViewDelegate,
                            UICollectionViewDataSource,
                            UIImagePickerControllerDelegate,
                            UINavigationControllerDelegate,
                            SDPhotoShowCellDelegate>


/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** flowLayout */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SDPhotoPicker

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.collectionView];
       
        
    }
    return self;
}





#pragma mark - DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.picArray.count + 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SDPhotoShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SDPhotoShowCell class]) forIndexPath:indexPath];
    
    if (indexPath.item == self.picArray.count) {
        //加号
        cell.photoImg = [UIImage imageNamed:@"添加用户"];
        cell.isShowDelete = NO;
    }else{
        cell.photoImg = self.picArray[indexPath.item];
        cell.isShowDelete = YES;
    }
    
    cell.delegate = self;
    
    return cell;
    
    
}

#pragma mark - delegate
//cell 大小
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = self.bounds.size.height;   //(self.bounds.size.width - 5*10) / 4;
    CGFloat height = self.bounds.size.height;
    return CGSizeMake(width,height);
    
    
}


//cell点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //如果是加号,选择图片
    if (indexPath.item == self.picArray.count) {
        
        [self chooseImage];
        
    }else{
        
        //图片浏览
        NSLog(@"%zd",indexPath.item);
    }
    
    
    
}

/*  SDPhotoShowCellDelegate  */
-(void)photoShowCellDeleteAction:(SDPhotoShowCell *)cell{
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    [self.picArray removeObjectAtIndex:indexPath.item];
    
    [self.collectionView reloadData];
    
}
//图片选择完成
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if(!image){
            [picker dismissViewControllerAnimated:YES completion:^{
                NSLog(@"照片获取失败！");
            }];
            ;
            return;
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];


    [self.picArray addObject:image];
    
    [self.collectionView reloadData];
    
    //滚到最后一个
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.picArray.count inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    
    
}



#pragma mark - private
//选择图片
-(void)chooseImage{
    
     UIAlertController *alertController;
        __block NSUInteger blockSourceType = 0;
    //    if (![self callCameraPermissions]) {
    //        return;
    //    }
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            //支持访问相机与相册情况
            alertController = [UIAlertController alertControllerWithTitle:@"选择图片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击从相册中选取");
                //相册
                blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                
                imagePickerController.delegate = self;
                
                imagePickerController.allowsEditing = NO;
                
                imagePickerController.sourceType = blockSourceType;
                
                [self presentController:imagePickerController];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击拍照");
                //相机
                blockSourceType = UIImagePickerControllerSourceTypeCamera;
                
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                
                imagePickerController.delegate = self;
                
                imagePickerController.allowsEditing =NO;//这两句保证了图片可以裁剪为正方形
                //            imagePickerController.allowsImageEditing=YES;//这两句保证了图片可以裁剪为正方形
                
                imagePickerController.sourceType = blockSourceType;
                
                 [self presentController:imagePickerController];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击取消");
                // 取消
                return;
            }]];
            
            [self presentController:alertController];
        }
        else
        {
            //只支持访问相册情况
            alertController = [UIAlertController alertControllerWithTitle:@"选择图片" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击从相册中选取");
                //相册
                blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                
                imagePickerController.delegate = self;
                
                imagePickerController.allowsEditing =NO;//这两句保证了图片可以裁剪为正方形
                //            imagePickerController.allowsImageEditing=YES;//这两句保证了图片可以裁剪为正方形
                imagePickerController.sourceType = blockSourceType;
    
                
                [self presentController:imagePickerController];
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                NSLog(@"点击取消");
                // 取消
                return;
            }]];
            
            [self presentController:alertController];

        }
    
}

/** 获取当前View的控制器对象 */
- (UIViewController *)viewControler{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

-(void)presentController:(UIViewController *)controller{
    
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [[self viewControler] presentViewController:controller animated:YES completion:nil];
    
}


#pragma mark - getter
-(NSMutableArray<UIImage *> *)picArray{
    if (_picArray == nil) {
        _picArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _picArray;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout)
    {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 5;
        
    }
    return _flowLayout;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[SDPhotoShowCell class] forCellWithReuseIdentifier:NSStringFromClass([SDPhotoShowCell class])];
        
        
        _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    }
    return _collectionView;
}


@end
