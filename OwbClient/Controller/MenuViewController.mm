//
//  MenuViewController.m
//  OwbClient
//
//  Created by Jack on 21/4/13.
//  Copyright (c) 2013 tsgsz. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
@property(nonatomic, strong) UIButton *penBtn_;
@property(nonatomic, strong) UIButton *eraserBtn_;
@property(nonatomic, strong) UIButton *lineBtn_;
@property(nonatomic, strong) UIButton *rectBtn_;
@property(nonatomic, strong) UIButton *ellipseBtn_;
@property(nonatomic, strong) UIPickerView *colorThicknessAlphaPicker_;

@property(nonatomic, strong) NSArray *colorData_;
@property(nonatomic, strong) NSArray *thicknessData_;
@property(nonatomic, strong) NSArray *alphaData_;

@property int opType;
@property int colorNo_;
@property int thicknessNo_;
@property float alpha_;

@end

@implementation MenuViewController

- (id)init
{
    if (self) {
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
        self.view.frame = MENU_FRAME;
        UIPanGestureRecognizer *menuGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                         initWithTarget:self  
                                                         action:@selector(handleMenuPan:)];
        [self.view setUserInteractionEnabled:YES];
        [self.view addGestureRecognizer:menuGestureRecognizer];
        
        self.penBtn_ = [[UIButton alloc] initWithFrame:PEN_BTN_FRAME];
        [self.penBtn_ setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:self.penBtn_];
        [self.penBtn_ addTarget:self action:@selector(penBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        self.eraserBtn_ = [[UIButton alloc] initWithFrame:ERASER_BTN_FRAME];
        [self.eraserBtn_ setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:self.eraserBtn_];
        [self.eraserBtn_ addTarget:self action:@selector(eraserBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lineBtn_ = [[UIButton alloc] initWithFrame:LINE_BTN_FRAME];
        [self.lineBtn_ setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:self.lineBtn_];
        [self.lineBtn_ addTarget:self action:@selector(lineBtnPress:) forControlEvents:UIControlEventTouchUpInside];

        self.rectBtn_ = [[UIButton alloc] initWithFrame:RECT_BTN_FRAME];
        [self.rectBtn_ setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:self.rectBtn_];
        [self.rectBtn_ addTarget:self action:@selector(rectBtnPress:) forControlEvents:UIControlEventTouchUpInside];

        self.ellipseBtn_ = [[UIButton alloc] initWithFrame:ELLIPSE_BTN_FRAME];
        [self.ellipseBtn_ setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:self.ellipseBtn_];
        [self.ellipseBtn_ addTarget:self action:@selector(ellipseBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.colorData_ = [[NSArray alloc] initWithObjects:[UIColor blackColor], [UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], nil];
        
        self.colorThicknessAlphaPicker_ = [[UIPickerView alloc] initWithFrame:PICKER_FRAME];
        self.colorThicknessAlphaPicker_.dataSource = self;
        self.colorThicknessAlphaPicker_.delegate = self;
        [self.colorThicknessAlphaPicker_ setBackgroundColor:[UIColor clearColor]];
        [self.colorThicknessAlphaPicker_ setOpaque:NO];
        [self.view addSubview:self.colorThicknessAlphaPicker_];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

# pragma mark - gesture handler
- (void) handleMenuPan:(UIPanGestureRecognizer*) recognizer
{
    if( ([recognizer state] == UIGestureRecognizerStateBegan) ||
       ([recognizer state] == UIGestureRecognizerStateChanged) )
    {
        CGPoint movement = [recognizer translationInView:self.view];
        CGRect oldRect = self.view.frame;
        
        oldRect.origin.y = oldRect.origin.y + movement.y;
        if(oldRect.origin.y < MENU_OPEN_FRAME.origin.y)
        {
            self.view.frame = MENU_OPEN_FRAME;
        }
        else if(oldRect.origin.y > MENU_CLOSE_FRAME.origin.y)
        {
            self.view.frame = MENU_CLOSE_FRAME;
        }
        else
        {
            self.view.frame = oldRect;
        }
        
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled)
    {
        CGFloat halfPoint = (MENU_CLOSE_FRAME.origin.y + MENU_OPEN_FRAME.origin.y)/ 2;
        if(self.view.frame.origin.y > halfPoint)
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.view.frame = MENU_CLOSE_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [UIView animateWithDuration:DURATION delay:0.0f options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut animations:^{
                
                self.view.frame = MENU_OPEN_FRAME;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma mark - Picker Data Soucrce Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return [self.colorData_ count];
    } else if (component==1) {
        return 10;
    } else {
        return 10;
    }
}

#pragma mark - Picker Data Delegate Methods;
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *tmpView = [[UIView alloc]initWithFrame:PICKER_TMP_VIEW_FRAME];
    if (component==0) {
        [tmpView setBackgroundColor:[self.colorData_ objectAtIndex:row]];
    } else if (component==1) {
        [tmpView setFrame:PICKER_TMP_THICKNESS_FRAME];
        [tmpView setBackgroundColor:[self.colorData_ objectAtIndex:self.colorNo_]];
    } else {
        PICKER_TMP_ALPHA_SETTER;
        [tmpView setBackgroundColor:[self.colorData_ objectAtIndex:self.colorNo_]];
    }
    return tmpView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0) {
        self.colorNo_ = row;
        [self.colorThicknessAlphaPicker_ reloadAllComponents];
    } else if (component==1) {
        self.thicknessNo_ = row;
    } else {
        self.alpha_ = 1-0.1*row;
    }
}

#pragma mark - btn handlers
- (void)penBtnPress:(id)sender
{
    self.opType = POINT;
}

- (void)eraserBtnPress:(id)sender
{
    self.opType = ERASER;
}

- (void)lineBtnPress:(id)sender
{
    self.opType = LINE;
}

- (void)rectBtnPress:(id)sender
{
    self.opType = RECT;
}

- (void)ellipseBtnPress:(id)sender
{
    self.opType = ELLIPSE;
}

- (OwbClientOperation *)operationInit
{
    switch (self.opType) {
        case POINT:
        {
            DrawPoint *drawPoint = [[DrawPoint alloc] init];
            drawPoint.color_ = self.colorNo_;
            drawPoint.thinkness_ = self.thicknessNo_;
            drawPoint.alpha_ = self.alpha_;
            return drawPoint;
        }
            break;
        case LINE:
        {
            DrawLine *drawLine = [[DrawLine alloc] init];
            drawLine.color_ = self.colorNo_;
            drawLine.thinkness_ = self.thicknessNo_;
            drawLine.alpha_ = self.alpha_;
            return drawLine;

        }
            break;
        case RECT:
        {
            DrawRectange *drawRect = [[DrawRectange alloc] init];
            drawRect.color_ = self.colorNo_;
            drawRect.thinkness_ = self.thicknessNo_;
            drawRect.alpha_ = self.alpha_;
            return drawRect;
        }
            break;
        case ELLIPSE:
        {
            DrawEllipse *drawEllipse = [[DrawEllipse alloc] init];
            drawEllipse.color_ = self.colorNo_;
            drawEllipse.thinkness_ = self.thicknessNo_;
            drawEllipse.alpha_ = self.alpha_;
            return drawEllipse;
        }
            break;
        case ERASER:
        {
            Erase *erase = [[Erase alloc] init];
        }
            break;
    }
}

- (int)operationType
{
    return self.opType;
}
@end
