//
//  BoardIndexList.h
//  Bestiz
//
//  Created by Bumcheol Shin on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{ // 게시판종류
    BoardCategoryGuestHeaven, // 게스트 천국
    BoardCategoryGuestChatter, // 게스트 잡담
    BoardCategoryGuestSpring, // 게잡의 봄
    BoardCategoryGuestSummer // 게잡의 여름
} BoardCategory;

typedef enum
{ // 게시물 형식
    BoardTypeList, // 리스트
    BoardTypeContents // 본문
} BoardType;

typedef enum
{ // 게시판 서버 종류
    GuestTypeHeaven, // 천국서버
    GuestTypeChatter // 잡담서버
} GuestType;

@interface BoardIndex : NSObject
{
    NSString *nameOfBoard;
    NSString *urlOfBoard;
    GuestType guestType;
}

@property (nonatomic, retain) NSString *nameOfBoard;
@property (nonatomic, retain) NSString *urlOfBoard;
@property (nonatomic) GuestType guestType;

- (id)initWithNameOfBoard:(NSString *)name urlOfBoard:(NSString *)url typeOfGuest:(GuestType)type;
- (NSString *)urlOfBoard:(BoardCategory)boardCategory boardType:(BoardType)boardType;

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
// 게천 잡담 ID
#define GUEST_HEAVEN_CHATTER_ID @"id=jd1106"
// 게잡의 봄 ID
#define GUEST_CHATTER_SPRING_ID @"id=jb0901"
// 게잡의 여름 ID
#define GUEST_CHATTER_SUMMER_ID @"id=jy0807"
//=============================================================================//

@end
