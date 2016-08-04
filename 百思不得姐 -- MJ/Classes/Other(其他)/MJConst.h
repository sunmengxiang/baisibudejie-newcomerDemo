
#import <UIKit/UIKit.h>

typedef enum
{
    MJTopicsTypeAll = 1,
    MJTopicsTypePicture = 10,
    MJTopicsTypeWord = 29,
    MJTopicsTypeVoice = 31,
    MJTopicsTypeVideo = 41
}MJTopicsType;



/** 精华--顶部标题--高度 **/
UIKIT_EXTERN CGFloat const MJTopicsTitleViewHeight;
/** 精华--顶部标题--Y 值 **/
UIKIT_EXTERN CGFloat const MJTopicsTitleViewY;
/** 精华-- cell--底部工具条高度 **/
UIKIT_EXTERN CGFloat const MJTopicsCellBottomToolsH;
/** 精华-- cell--中间文字内容的 Y 值 **/
UIKIT_EXTERN CGFloat const MJTopicsCellTextY;
/** 精华-- cell--与 superView 的间距 **/
UIKIT_EXTERN CGFloat const MJTopicsCellMargin;



/** 精华-- 图片 Topics--允许的最大高度 **/
UIKIT_EXTERN CGFloat const MJTopicsPictureMaxHeight;

/** 精华-- 图片 Topics--图片超过最大高度后转为这个高度 **/
UIKIT_EXTERN CGFloat const MJTopicsPicturePreferHeight;

/** 精华-- 帖子评论header 文字大小 **/
UIKIT_EXTERN CGFloat const MJTopicsHeaderTitleFontSize;