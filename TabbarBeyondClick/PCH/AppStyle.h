//
//  AppStyle.h
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/18.
//  Copyright © 2017年 lujh. All rights reserved.
//

#ifndef AppStyle_h
#define AppStyle_h

#define Nav_Back_Font_M [UIFont systemFontOfSize:14]
#define RGB(r,g,b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define Theme_Color_Red  RGB(231,56,55)
#define Theme_Color_Pink RGB(255,83,123)
#define Theme_Color_White [UIColor whiteColor]

#define Theme_Color_Orange RGB(255,178,148)
#define Theme_Color_Peach RGB(253,184,202)


#define Theme_NavColor   RGB(255,255,255)

#define Theme_TextColor RGB(55,65,75)  //

//导航栏颜色
#define kNavigationBarBg  RGB(206,8,2) //#ce0802

#define KUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define KUIScreenHeight [UIScreen mainScreen].bounds.size.height
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define ViewController_BackGround [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0]//视图控制器背景颜色

#endif /* AppStyle_h */
