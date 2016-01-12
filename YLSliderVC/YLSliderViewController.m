//
//  SliderViewController.m
//  YLSliderVC
//
//  Created by NaiveVDisk on 15/12/30.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "YLSliderViewController.h"
#import "YLSliderVcInfo.h"
#import "YLTest0ViewController.h"


#define KSliderViewWidth SCREEN_W * 0.8
#define KSliderHideWidth SCREEN_W * 0.5
#define KSliderShowWidth SCREEN_W * 0.3

#define KSliderAnimateDuration 0.3

#define KSliderReuseIdentifier @"SliderCellReuseIdentifier"

@interface YLSliderViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>


@property (nonatomic, strong) YLTableView * sliderView;
@property (nonatomic, strong) YLView * containView;
@property (nonatomic, assign) CGFloat lastOffset;
@property (nonatomic, assign) BOOL sliderIsShow;
@property (nonatomic, strong) NSMutableArray *childVcInfoArray;
@property (nonatomic, weak) YLSliderVcInfo *currentChildVcInfo;

@end


@implementation YLSliderViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setUpView];
    
    [self addChildVCWithTitle:@"Test0" imageName:nil rootViewControllerClass:YLTest0ViewController.class sliderSwitchRootVcType:YLSliderSwitchRootVcTypeReplace];
    
    [self addChildVCWithTitle:@"Test1" imageName:nil rootViewControllerClass:YLTest0ViewController.class sliderSwitchRootVcType:YLSliderSwitchRootVcTypeReplace];
    
    [self addChildVCWithTitle:@"Test2" imageName:nil rootViewControllerClass:YLTest0ViewController.class sliderSwitchRootVcType:YLSliderSwitchRootVcTypeReplace];
    
    [self addChildVCWithTitle:@"Test3" imageName:nil rootViewControllerClass:YLTest0ViewController.class sliderSwitchRootVcType:YLSliderSwitchRootVcTypepush];
    
    [self addChildVCWithTitle:@"Test4" imageName:nil rootViewControllerClass:YLTest0ViewController.class sliderSwitchRootVcType:YLSliderSwitchRootVcTypepush];
    
    [self addChildVCWithTitle:@"Test5 " imageName:nil rootViewControllerClass:YLTest0ViewController.class sliderSwitchRootVcType:YLSliderSwitchRootVcTypepush];
    
    [self tableView:self.sliderView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)setUpView{
    [self.sliderView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.equalTo(self.view);
        make.width.equalTo(KSliderViewWidth);
    }];
    [self.containView makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    _sliderView.delegate = self;
    _sliderView.dataSource = self;
    _sliderView.backgroundColor = [UIColor grayColor];
    _sliderView.scrollEnabled = NO;
    [_sliderView registerClass:UITableViewCell.class forCellReuseIdentifier:KSliderReuseIdentifier];
    _sliderView.tableHeaderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topBg"]];
    _sliderView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sliderBg"]];
    _sliderView.tableFooterView = [[YLView alloc] initWithFrame:CGRectZero];
    _sliderIsShow = NO;
    
    [self addGestureRecognizer];
}

- (void)addChildVCWithTitle:(NSString *)title imageName:(NSString *)imageName rootViewControllerClass:(Class)rootviewcontrollerclass sliderSwitchRootVcType:(YLSliderSwitchRootVcType)switchRootVcType {
    YLSliderVcInfo *sliderChildVcInfo = [[YLSliderVcInfo alloc] init];
    
    sliderChildVcInfo.title = title.length > 0 ? title : @"请设置title";
    sliderChildVcInfo.image = imageName.length > 0 ? [UIImage imageNamed:imageName] : [UIImage createImageWithColor:[UIColor blueColor] size:CGSizeMake(20, 20)];
    
    if(switchRootVcType<0 || switchRootVcType >YLSliderSwitchRootVcTypeReplace)
        sliderChildVcInfo.switchRootVcType = YLSliderSwitchRootVcTypepush;
    else
        sliderChildVcInfo.switchRootVcType = switchRootVcType;
    if(rootviewcontrollerclass)sliderChildVcInfo.viewControllerClass = rootviewcontrollerclass;
    else
        sliderChildVcInfo.viewControllerClass = YLViewController.class;
    
    [self.childVcInfoArray addObject:sliderChildVcInfo];
    
}

#pragma mark -手势识别及处理

- (void)addGestureRecognizer{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.containView addGestureRecognizer:pan];
    
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.containView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.containView addGestureRecognizer:swipeLeft];
    
//    [pan requireGestureRecognizerToFail:swipeLeft];
//    [pan requireGestureRecognizerToFail:swipeRight];
    
}

// 是否使用手势
- (BOOL)usePan{
    return self.currentChildVcInfo.navigationController.viewControllers.count <= 1;
}

- (void)HandleWithTouchEnd{
    if (!self.sliderIsShow) {
        if ((_lastOffset>=KSliderShowWidth)&&(!self.sliderIsShow)) {
            [self showSliderView:YES];
        }else{
            [self showSliderView:NO];
        }
    }else{
        if((_lastOffset<=KSliderHideWidth)&&(self.sliderIsShow)){
            [self showSliderView:NO];
        }else{
            [self showSliderView:YES];
        }
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    if (![self usePan])return;
    
    CGFloat offset = [recognizer translationInView:self.containView].x;
    [recognizer setTranslation:CGPointZero inView:self.containView];
    CGFloat realOffset = _lastOffset + offset;
    if (realOffset >= 0 && realOffset <= KSliderViewWidth) {
        _lastOffset = realOffset;
        [_containView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(realOffset);
        }];
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self HandleWithTouchEnd];
    }
    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer{
    if (![self usePan])return;
    switch (recognizer.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            [self showSliderView:NO];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self showSliderView:YES];
            break;
            
        default:
            break;
    }
}

- (void)showSliderView:(BOOL)show{
    [self.view setNeedsUpdateConstraints];
    self.lastOffset = show ? KSliderViewWidth : 0;
    self.sliderIsShow = show;
    [self.containView updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lastOffset);
    }];
    [UIView animateWithDuration:KSliderAnimateDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 懒加载
- (YLTableView *)sliderView{
    if (_sliderView == nil) {
        _sliderView = [[YLTableView alloc] init];
        [self.view addSubview:self.sliderView];
    }
    return _sliderView;
}

- (YLView *)containView{
    if (_containView == nil) {
        _containView = [[YLView alloc] init];
        _containView.backgroundColor = [UIColor redColor];
        [self.view addSubview:self.containView];
    }
    return _containView;
}

-(NSMutableArray *)childVcInfoArray{
    if (_childVcInfoArray == nil) {
        _childVcInfoArray = [[NSMutableArray alloc] init];
    }
    return _childVcInfoArray;
}

#pragma mark - tableView delegate datasource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.childVcInfoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLSliderVcInfo *sliderVcinfo = self.childVcInfoArray[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KSliderReuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = sliderVcinfo.title;
    cell.imageView.image = sliderVcinfo.image;
    cell.backgroundColor = [UIColor clearColor];
    [self showSliderView:NO];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YLSliderVcInfo *sliderVcInfo = self.childVcInfoArray[indexPath.row];
    if ([self.currentChildVcInfo.title isEqualToString:sliderVcInfo.title]) {
        [self showSliderView:NO];
        return;
    }
    
    [self handleSwitchRootVc:sliderVcInfo];
}

- (void)handleSwitchRootVc:(YLSliderVcInfo*)sliderVcInfo{
    switch (sliderVcInfo.switchRootVcType) {
        case YLSliderSwitchRootVcTypeReplace:
            [self handleSwitchRootVcTypeReplace:sliderVcInfo];
            break;
        case YLSliderSwitchRootVcTypepush:
            [self handleSwitchRootVcTypePush:sliderVcInfo];
            break;
        default:
            break;
    }
}

#pragma mark - 视图切换处理

- (void)handleSwitchRootVcTypeReplace:(YLSliderVcInfo*)sliderVcInfo{
    static NSInteger num = 0;
    if (!sliderVcInfo.navigationVcIsActivated) {
        [self.containView addSubview:sliderVcInfo.navigationController.view];
        [self addChildViewController:sliderVcInfo.navigationController];
        [sliderVcInfo.navigationController.view makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.containView);
        }];
        num++;
        NSLog(@"num:%lu",num);
    }
    [self.containView bringSubviewToFront:self.navigationController.view];
    self.currentChildVcInfo = sliderVcInfo;
    [self showSliderView:NO];
}

- (void)handleSwitchRootVcTypePush:(YLSliderVcInfo*)sliderVcInfo{
    YLViewController *vc = [[sliderVcInfo.viewControllerClass alloc] init];
    vc.title = sliderVcInfo.title;
    [self.currentChildVcInfo.navigationController pushViewController:vc animated:YES];
    [self showSliderView:NO];
}





@end
