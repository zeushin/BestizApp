//
//  BaseViewController.h
//  Bestiz
//
//  Created by Bumcheol Shin on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewController : NSObject

//=============================================================================//
#define BOARD_LIST @"/zboard.php?"
#define BOARD_CONTENT @"/view.php?"
//-----------------------------------------------------------------------------//
// 게스트 천국 서버 : 게스트천국+게천영상+게스트북+멤버방+가을의전설(플래쉬)
#define HEAVEN_SERVER @"http://hgc.bestiz.net/zboard"
// 게스트 잡담 서버 : 게천잡담+게잡의봄+게잡의여름+게잡스포츠+게잡멋쟁이+게잡직딩반+게잡발코니
#define CHATTER_SERVER @"http://bestjd.bestiz.net/zboard"
//-----------------------------------------------------------------------------//
// 게스트 천국 ID
#define GUEST_HEAVEN_BOARD_ID @"id=gworld0707"
// 게잡의 봄 ID
#define GUEST_CHATTER_SPRING_ID @"id=jb0901"
// 게천 잡담 ID
#define GUEST_HEAVEN_CHATTER_ID @"id=jd1106"
//=============================================================================//


@end
