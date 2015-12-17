//
//  ContentUIvewController.m
//  TelExchangeService-ios
//
//  Created by tldkj on 15/12/9.
//  Copyright © 2015年 lzy. All rights reserved.
//

#import "ContentUIvewController.h"
#import "UIImage+Extension.h"
#import "BLHConst.h"
#import "CulturalCommitteeSystemViewController.h"
#import "StreetTownViewController.h"

@interface ContentUIvewController ()<UIScrollViewDelegate>
{
    NSMutableArray *_viewArray;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSMutableArray *_buttonArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *titleBarImageView;

@property (nonatomic , weak) UIView *buttonBagView;
@property (nonatomic , strong) NSArray * titleArray;

@end

@implementation ContentUIvewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSArray * titleArray = @[@"文化委系统",@"街镇"];
    self.titleArray = titleArray;

    
    UIImageView *  imageView = [[UIImageView  alloc] init];
    UIImage *  image = [UIImage  resizableImageWithName:@"bg_bar" andW:1 andH:1];
    imageView.image  = image;
    [self.view addSubview:  imageView];
    [self  scrollViewChange];
    
    [self  changeButton];
}


//切换的button
-(void) changeButton
{
    _viewArray = [NSMutableArray array];
    _buttonArray = [[NSMutableArray alloc] init];
    UIView * buttonBagView = [[UIView alloc] initWithFrame:CGRectMake(0, 55,self.view.bounds.size.width ,40)];
    self.buttonBagView = buttonBagView;
    buttonBagView.backgroundColor = BLHColor(226, 229, 224);
      CGFloat width = SCREENWIDTH/2;
    CGFloat height = 40;
    
    for( int i = 0 ;i<self.titleArray.count;i++){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button  setTitle:self.titleArray[i] forState:UIControlStateNormal];
        int deviceWidth =      (NSInteger) SCREENWIDTH;
        CGFloat x  =(deviceWidth*i) /self.titleArray.count;
        [button setFrame:CGRectMake(x, 0, width , height)];
        [button setTintColor: [UIColor  blackColor]];
        if (i == 0) {
            button.tintColor =  BLHColor(23,153,157);
        }
        [button setTag:i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonBagView  addSubview: button];
        
        UIView * view = [[UIView alloc] initWithFrame: CGRectMake(x, height-2, width, 2)];
        [view setBackgroundColor:BLHColor(23,153,157)];
        if(i){
            view.hidden = YES;
        }
        [buttonBagView addSubview:view];
        [_viewArray addObject:view];
        [_buttonArray addObject:button];
        
    }
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, height, buttonBagView.bounds.size.width, 1)];
    [bottomLine setBackgroundColor:BLHColor(23,153,157)];
    [buttonBagView  addSubview: bottomLine];
    [self.view addSubview:buttonBagView];
}

- (void)buttonClick:(UIButton *)buttonClick
{
    UIButton * button;
    int  count = self.titleArray.count;
    for (int i = 0; i<count; i++) {
        UIView * view = _viewArray[i];
        button = _buttonArray[i];
        if(buttonClick.tag ==i){
            view.hidden = NO;
            button.tintColor = BLHColor(23, 153, 157);
        }else{
            view.hidden = YES;
            button.tintColor = [UIColor  blackColor];
        }
    }
    
    if (buttonClick.tag == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    if (buttonClick.tag == 1) {
        [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:NO];
    }
}

-(void)scrollViewChange
{
    CGFloat  titleBarViewHeight =  self.titleBarImageView.frame.size.height;
   CGFloat   buttonBagViewHeight= self.buttonBagView.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, (titleBarViewHeight + buttonBagViewHeight),SCREENWIDTH, self.view.frame.size.height)];
    NSLog(@"_scrollView%@",_scrollView);
    [self.view addSubview:_scrollView];
    for (int i = 0; i<self.titleArray.count; i++) {
        if(i==0){
            NSLog(@"%d",i);
            CulturalCommitteeSystemViewController * ccsv = [[CulturalCommitteeSystemViewController alloc] init];
            [ccsv.view setBackgroundColor:[UIColor redColor]];
            [_scrollView addSubview: ccsv.view];
            [self addChildViewController: ccsv];
            
        }
        if(i==1){
            NSLog(@"%d",i);
            StreetTownViewController * stvc = [[StreetTownViewController alloc] init];
            stvc.view.frame =CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, self.view.frame.size.height);
            [stvc.view setBackgroundColor:[UIColor blueColor]];
            [_scrollView addSubview: stvc.view];
            [self addChildViewController: stvc];
        }
    }
    _pageControl  = [[UIPageControl alloc] initWithFrame:CGRectMake(0,(titleBarViewHeight + buttonBagViewHeight),SCREENWIDTH, 2)];
    _pageControl.numberOfPages = self.titleArray.count;
    _pageControl.currentPage = 0;
    _scrollView.pagingEnabled = YES;
   CGFloat width =  SCREENWIDTH *  self.titleArray.count;
    _scrollView.contentSize = CGSizeMake(width, self.view.bounds.size.height);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.directionalLockEnabled = YES;
    _scrollView.bounces = NO;
    //CGFloat top, CGFloat left, CGFloat bottom, CGFloat right
    _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0,SCREENWIDTH , 0);
    _scrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIButton *button;
    for (int i = 0; i<self.titleArray.count; i++) {
        UIView * view = _viewArray[i];
        button = _buttonArray[i];
        if (scrollView.contentOffset.x ==SCREENWIDTH*i) {
            view.hidden = NO;
            button.tintColor = BLHColor(23, 153, 157);
        }else{
            view.hidden = YES;
           button.tintColor = [UIColor  blackColor];
        }
        
    }
}





@end
