//
//  EasyJsonModel.h
//  字典转模型
//
//  Created by 樱桃李子 on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+jsonModel.h"

NS_ASSUME_NONNULL_BEGIN
/*
"type": "endScreen",
"successHeading": "Congratulations!",
"successText": "You just learned how to rearrange and trim your clips. Next, you’ll learn how to export your project to a video file.",
"additionalInfo": "For an in-depth overview on this topic and more, watch the full <a href=\"https://helpx.adobe.com/premiere-pro/tutorials.html\">Get Started with Premiere Pro</a> series from adobe.com."
*/

@interface EasyJsonModel : NSObject
@property(nonatomic,strong)NSString  *tp;

//@property(nonatomic,strong)NSString  *type;
@property(nonatomic,strong)NSString  *successHeading;
@property(nonatomic,strong)NSString  *successText;
@property(nonatomic,strong)NSString  *additionalInf;
//@property(nonatomic,assign)BOOL  ok;

@end

NS_ASSUME_NONNULL_END
