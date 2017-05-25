//
//  ViewController.m
//  Watermark
//
//  Created by mac on 17/5/25.
//  Copyright © 2017年 cai. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_Width    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_Height   ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ViewController

#pragma mark -
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, SCREEN_Width - 20, SCREEN_Width - 20)];
        _imgView.backgroundColor = [UIColor orangeColor];
    }
    return _imgView;
}

//为图片添加水印
- (IBAction)watermarkBtnAction:(id)sender {
    
    //1. 加载原图
    UIImage *image = [UIImage imageNamed:@"watermark"];
    
    //2. 创建一个和原图一样大小的图片的图形上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    //3. 把原图绘制到图片的图形上下文中
    [image drawAtPoint:CGPointZero];
    
    //4. 加载水印图片 绘制水印图片/(绘制水印文字)
    //绘制水印文字
    NSString *str = @"cai-waterMark";
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    [str drawAtPoint:CGPointMake(30, 30) withAttributes:attributes];
    
    //绘制图片水印
    //加载一个水印图片
    UIImage *waterImage = [UIImage imageNamed:@"water"];
    //绘制到上下文中
    [waterImage drawAtPoint:CGPointMake(200, 30)];
    
    //5. 从图片的图形上下文中获取绘制好的图片
    UIImage *waterMarkImg = UIGraphicsGetImageFromCurrentImageContext();
    
    //6. 关闭刚才创建的图形上下文
    UIGraphicsEndImageContext();
    
    
    //显示
    self.imgView.image = waterMarkImg;
    
    
    //7. 保存图片
    //获取沙盒路径
    NSString *docu = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [docu stringByAppendingPathComponent:@"waterMark.png"];
    
    //把图片转换为NSData
    NSData *data = UIImagePNGRepresentation(waterMarkImg);
    
    //把NSData保存到文件中
    [data writeToFile:fileName atomically:YES];
    
    NSLog(@"%@", fileName);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.imgView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
