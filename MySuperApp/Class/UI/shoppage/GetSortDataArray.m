//
//  GetSortDataArray.m
//  MySuperApp
//
//  Created by lee on 14-4-1.
//  Copyright (c) 2014年 aimer. All rights reserved.
//

#import "GetSortDataArray.h"

@implementation GetSortDataArray


+ (NSArray *)womenArray{
    /////////女士/////////////
    NSMutableArray *tmpArrWomen = [[NSMutableArray alloc] init];
    
    NSMutableArray *tmpArr = [NSMutableArray array];
    /**
     文胸
     */
    NSMutableArray *tempArr = [NSMutableArray array];
    [tempArr addObject:@"聚拢"];
    [tempArr addObject:@"无痕"];
    [tempArr addObject:@"侧收"];
    [tempArr addObject:@"大罩杯"];
    [tempArr addObject:@"托高"];
    [tempArr addObject:@"无钢托"];
    [tempArr addObject:@"舒适"];
    [tempArr addObject:@"可摘卸肩带"];
    [tempArr addObject:@"美背"];
    [tempArr addObject:@"前系扣"];
    [tempArr addObject:@"超薄杯"];
    [tempArr addObject:@"薄杯"];
    [tempArr addObject:@"中厚杯"];
    [tempArr addObject:@"厚模杯"];
    [tempArr addObject:@"加厚杯"];
    [tempArr addObject:@"水袋杯"];
    [tempArr addObject:@"上薄下厚杯"];
    [tempArr addObject:@"模杯"];
    [tempArr addObject:@"无纺布杯"];
    [tempArr addObject:@"水袋杯"];
    [tempArr addObject:@"蕾丝超薄杯"];
    [tempArr addObject:@"3/4杯"];
    [tempArr addObject:@"4/4杯"];
    [tempArr addObject:@"1/2杯"];
    [tempArr addObject:@"抹胸"];
    [tempArr addObject:@"深V"];
    [tempArr addObject:@"三角杯"];
    [tempArr addObject:@"全部"];
    
    NSMutableArray *tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,317/p83,353/t,101"];
    [tmpArrID addObject:@"p69,317/p83,356/t,101"];
    [tmpArrID addObject:@"p69,317/p83,355/t,101"];
    [tmpArrID addObject:@"p69,317/p83,362/t,101"];
    [tmpArrID addObject:@"p69,317/p83,354/t,101"];
    [tmpArrID addObject:@"p69,317/p83,359/t,101"];
    [tmpArrID addObject:@"p69,317/p83,387/t,101"];
    [tmpArrID addObject:@"p69,317/p83,360/t,101"];
    [tmpArrID addObject:@"p69,317/p83,357/t,101"];
    [tmpArrID addObject:@"p69,317/p83,358/t,101"];
    [tmpArrID addObject:@"p2,5/p69,317/t,101"];
    [tmpArrID addObject:@"p2,6/p69,317/t,101"];
    [tmpArrID addObject:@"p2,7/p69,317/t,101"];
    [tmpArrID addObject:@"p2,343/p69,317/t,101"];
    [tmpArrID addObject:@"p2,9/p69,317/t,101"];
    [tmpArrID addObject:@"p2,10/p69,317/t,101"];
    [tmpArrID addObject:@"p2,8/p69,317/t,101"];
    [tmpArrID addObject:@"p3,11/p69,317/t,101"];
    [tmpArrID addObject:@"p3,12/p69,317/t,101"];
    [tmpArrID addObject:@"p3,13/p69,317/t,101"];
    [tmpArrID addObject:@"p3,361/p69,317/t,101"];
    [tmpArrID addObject:@"p1,1/p69,317/t,101"];
    [tmpArrID addObject:@"p1,4/p69,317/t,101"];
    [tmpArrID addObject:@"p1,2/p69,317/t,101"];
    [tmpArrID addObject:@"p1,363/p69,317/t,101"];
    [tmpArrID addObject:@"p1,364/p69,317/t,101"];
    [tmpArrID addObject:@"p1,3/p69,317/t,101"];
    [tmpArrID addObject:@"p69,317/t,101/"];
    
    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"文胸" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_pic_01" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加文胸的数据
    /**
     内裤
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"无痕"];
    [tempArr addObject:@"生理裤"];
    [tempArr addObject:@"舒适棉质"];
    [tempArr addObject:@"低腰"];
    [tempArr addObject:@"中腰"];
    [tempArr addObject:@"高腰"];
    [tempArr addObject:@"T裤"];
    [tempArr addObject:@"三角裤"];
    [tempArr addObject:@"平脚裤"];
    [tempArr addObject:@"全部"];

    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,317/p84,345/t,102"];
    [tmpArrID addObject:@"p69,317/p84,346/t,102"];
    [tmpArrID addObject:@"p69,317/p84,383/t,102"];
    [tmpArrID addObject:@"p16,88/p69,317/t,102"];
    [tmpArrID addObject:@"p16,89/p69,317/t,102"];
    [tmpArrID addObject:@"p16,90/p69,317/t,102"];
    [tmpArrID addObject:@"p15,85/p69,317/t,102"];
    [tmpArrID addObject:@"p15,83/p69,317/t,102"];
    [tmpArrID addObject:@"p15,84/p69,317/t,102"];
    [tmpArrID addObject:@"p69,317/t,102/"];

    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"内裤" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_pic_02" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加内裤的数据
    
    /**
     睡衣/家居
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"可外穿"];
    [tempArr addObject:@"性感"];
    [tempArr addObject:@"舒适"];
    [tempArr addObject:@"优雅"];
    //lee999 被要求注释掉
//    [tempArr addObject:@"睡眠"];
    [tempArr addObject:@"外穿"];
    [tempArr addObject:@"家居休闲"];
    [tempArr addObject:@"睡衣下装"];
    [tempArr addObject:@"睡袍"];
    [tempArr addObject:@"睡衣上装"];
    [tempArr addObject:@"分身套装"];
    [tempArr addObject:@"小吊衣/裙"];
    [tempArr addObject:@"睡裙"];
    [tempArr addObject:@"全部"];

    //    [tempArr addObject:@"亲子"];
    
    tmpArrID = [NSMutableArray array];//少了一个亲子
    [tmpArrID addObject:@"p21,129/p69,317/t,103"];
    [tmpArrID addObject:@"p21,128/p69,317/t,103"];
    [tmpArrID addObject:@"p21,126/p69,317/t,103"];
    [tmpArrID addObject:@"p21,127/p69,317/t,103"];
    //lee999 被要求注释掉
//    [tmpArrID addObject:@"p29,177/p69,317/t,103"];
    [tmpArrID addObject:@"p29,178/p69,317/t,103"];
    [tmpArrID addObject:@"p29,176/p69,317/t,103"];
    [tmpArrID addObject:@"p20,122/p69,317/t,103"];
    [tmpArrID addObject:@"p20,124/p69,317/t,103"];
    [tmpArrID addObject:@"p20,348/p69,317/t,103"];
    [tmpArrID addObject:@"p20,123/p69,317/t,103"];
    [tmpArrID addObject:@"p20,118/p69,317/t,103"];
    [tmpArrID addObject:@"p20,347/p69,317/t,103"];
    [tmpArrID addObject:@"p69,317/t,103/"];
    //    [tmpArrID addObject:@""];
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"睡衣/家居" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_pic_03" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加睡衣/家居的数据
    
    /**
     美体内衣
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"塑身短裙"];
    [tempArr addObject:@"连体塑身衣"];
    [tempArr addObject:@"塑身胸衣"];
    [tempArr addObject:@"腰封"];
    [tempArr addObject:@"背背佳"];
    [tempArr addObject:@"塑裤"];
    [tempArr addObject:@"全部"];

    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p30,390/p69,317/t,105"];
    [tmpArrID addObject:@"p30,183/p69,317/t,105"];
    [tmpArrID addObject:@"p30,180/p69,317/t,105"];
    [tmpArrID addObject:@"p30,386/p69,317/t,105"];
    [tmpArrID addObject:@"p30,182/p69,317/t,105"];
    [tmpArrID addObject:@"p30,181/p69,317/t,105"];
    [tmpArrID addObject:@"p69,317/t,105/"];
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"美体内衣" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_pic_04" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加美体内衣的数据
    
    /**
     泳衣
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"分身泳衣"];
    [tempArr addObject:@"连体泳衣"];
    [tempArr addObject:@"比基尼"];
    [tempArr addObject:@"泳帽"];
    [tempArr addObject:@"沙滩裙/裤/纱"];
    //    [tempArr addObject:@"亲子"];
    [tempArr addObject:@"全部"];

    tmpArrID = [NSMutableArray array];//少亲子
    [tmpArrID addObject:@"p44,262/p69,317/t,106"];
    [tmpArrID addObject:@"p44,261/p69,317/t,106"];
    [tmpArrID addObject:@"p44,263/p69,317/t,106"];
    [tmpArrID addObject:@"p44,398/p69,317/t,106"];
    [tmpArrID addObject:@"p44,264/p69,317/t,106"];
    //    [tmpArrID addObject:@""];
    [tmpArrID addObject:@"p69,317/t,106/"];

    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"泳衣" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_pic_05" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加泳衣的数据
    
    /**
     保暖
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"功能保暖"];
    [tempArr addObject:@"时尚外穿"];
    [tempArr addObject:@"基础打底"];
    [tempArr addObject:@"连体衣"];
    [tempArr addObject:@"背心式上衣"];
    [tempArr addObject:@"保暖裤"];
    [tempArr addObject:@"低领上衣"];
    [tempArr addObject:@"高领上衣"];
    //lee999  小纪说保留
    [tempArr addObject:@"保暖套装"];
    [tempArr addObject:@"全部"];

    
    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,317/p85,372/t,104"];
    [tmpArrID addObject:@"p69,317/p85,371/t,104"];
    [tmpArrID addObject:@"p69,317/p85,370/t,104"];
    [tmpArrID addObject:@"p37,220/p69,317/t,104"];
    [tmpArrID addObject:@"p37,219/p69,317/t,104"];
    [tmpArrID addObject:@"p37,221/p69,317/t,104"];
    [tmpArrID addObject:@"p37,217/p69,317/t,104"];
    [tmpArrID addObject:@"p37,218/p69,317/t,104"];
    //lee999  小纪说保留
    [tmpArrID addObject:@"p37,222/p69,317/t,104"];
    [tmpArrID addObject:@"p69,317/t,104/"];

    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"保暖" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_pic_06" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加保暖的数据
    
    /**
     外穿/运动
     */
    tempArr = [NSMutableArray array];
    //lee999
//    [tempArr addObject:@"外穿"];
    [tempArr addObject:@"运动"];
    //lee999 要求增加数据  140528
    [tempArr addObject:@"轻松瑜伽"];
    [tempArr addObject:@"休闲外穿"];
    [tempArr addObject:@"运动上衣"];
    [tempArr addObject:@"运动下装"];
    [tempArr addObject:@"全部"];

    //end
    
    
    tmpArrID = [NSMutableArray array];
    //缺少外穿
    //    [tmpArrID addObject:@""];
    [tmpArrID addObject:@"p69,317/p89,378/t,108"];
    //lee999 要求增加数据  140528
    [tmpArrID addObject:@"p69,317/p90,381/t,108"];
    [tmpArrID addObject:@"p69,317/p90,380/t,108"];
    [tmpArrID addObject:@"p69,317/p89,377/t,108"];
    [tmpArrID addObject:@"p69,317/p89,378/t,108"];
    [tmpArrID addObject:@"p69,317/t,108/"];

    //end
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"外穿/运动" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_pic_07" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加外穿/运动的数据
    
    /**
     配饰
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"耳饰"];
    [tempArr addObject:@"钥匙链"];
    [tempArr addObject:@"手链/手镯"];
    [tempArr addObject:@"套装"];
    [tempArr addObject:@"戒指"];
    [tempArr addObject:@"项链"];
    [tempArr addObject:@"胸针"];
    [tempArr addObject:@"吊袜带"];
    [tempArr addObject:@"肩带"];
    [tempArr addObject:@"佳美垫/乳贴"];
    [tempArr addObject:@"袜子"];
    [tempArr addObject:@"全部"];

    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,317/p88,374/t,107"];
    [tmpArrID addObject:@"p69,317/p88,376/t,107"];
    [tmpArrID addObject:@"p69,317/p88,375/t,107"];
    [tmpArrID addObject:@"p69,317/p88,392/t,107"];
    [tmpArrID addObject:@"p69,317/p88,388/t,107"];
    [tmpArrID addObject:@"p69,317/p88,373/t,107"];
    [tmpArrID addObject:@"p69,317/p88,389/t,107"];
    [tmpArrID addObject:@"p69,317/p91,397/t,107"];
    [tmpArrID addObject:@"p69,317/p91,394/t,107"];
    [tmpArrID addObject:@"p69,317/p91,395/t,107"];
    [tmpArrID addObject:@"p69,317/p91,399/t,107"];
    [tmpArrID addObject:@"p69,317/t,107/"];

    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"配饰" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_pic_08" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpDic setObject:tmpArrID forKey:@""];
    
    [tmpArr addObject:tmpDic];//添加配饰的数据
    
    [tmpArrWomen addObject:tmpArr];
    
    /**
     品牌
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"sort_brand_01"];
    [tempArr addObject:@"sort_brand_02"];
    [tempArr addObject:@"sort_brand_03"];
    [tempArr addObject:@"sort_brand_04"];
    [tempArr addObject:@"sort_brand_05"];
    //lee999 增加新品牌  140528
    [tempArr addObject:@"sort_brand_07"];
    [tempArr addObject:@"sort_brand_08"];
    //end
    [tmpArrWomen addObject:tempArr];
    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"b,11/p69,317/--爱慕"];
    [tmpArrID addObject:@"b,12/p69,317--LA CLOVER"];
    [tmpArrID addObject:@"b,14/p69,317--爱美丽"];
    [tmpArrID addObject:@"b,16/p69,317--心爱"];
    [tmpArrID addObject:@"b,15/p69,317--爱慕儿童"];
    //lee999 增加新品牌  140528
    [tmpArrID addObject:@"b,20/p69,317--宝迪威德"];
    [tmpArrID addObject:@"b,19/p69,317--爱慕运动"];
    //end

    [tmpArrWomen addObject:tmpArrID];
    
    
    return tmpArrWomen;
}



#pragma mark 获取男士的数据
+ (NSArray *)menArray
{
    NSMutableArray *tmpMenArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *tmpArr = [NSMutableArray array];
    /**
     内裤
     */
    NSMutableArray *tempArr = [NSMutableArray array];
    [tempArr addObject:@"无痕"];
    [tempArr addObject:@"舒适棉质"];
    [tempArr addObject:@"低腰"];
    [tempArr addObject:@"中腰"];
    [tempArr addObject:@"高腰"];
    [tempArr addObject:@"三角裤"];
    [tempArr addObject:@"平脚裤"];
    [tempArr addObject:@"全部"];

    
    NSMutableArray *tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,318/p84,345/t,102"];
    [tmpArrID addObject:@"p69,318/p84,383/t,102"];
    [tmpArrID addObject:@"p16,88/p69,318/t,102"];
    [tmpArrID addObject:@"p16,89/p69,318/t,102"];
    [tmpArrID addObject:@"p16,90/p69,318/t,102"];
    [tmpArrID addObject:@"p15,83/p69,318/t,102"];
    [tmpArrID addObject:@"p15,84/p69,318/t,102"];
    [tmpArrID addObject:@"p69,318/t,102/"];
    
    
    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"内裤" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_male_pic_01" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加内裤的数据
    
    /**
     睡衣/家居
     */
    tempArr = [NSMutableArray array];
//    [tempArr addObject:@"睡眠"];
    [tempArr addObject:@"外穿"];
    [tempArr addObject:@"家居休闲"];
    [tempArr addObject:@"可外穿"];
    [tempArr addObject:@"优雅"];
    [tempArr addObject:@"舒适"];
    [tempArr addObject:@"分身套装"];
    [tempArr addObject:@"睡衣上装"];
    [tempArr addObject:@"睡衣下装"];
    [tempArr addObject:@"背心式上衣"];
    [tempArr addObject:@"全部"];


    //    [tempArr addObject:@"亲子"];
    
    tmpArrID = [NSMutableArray array];//缺少亲子
//    [tmpArrID addObject:@"p29,177/p69,318/t,103"];
    [tmpArrID addObject:@"p29,178/p69,318/t,103"];
    [tmpArrID addObject:@"p29,176/p69,318/t,103"];
    [tmpArrID addObject:@"p21,129/p69,318/t,103"];
    [tmpArrID addObject:@"p21,127/p69,318/t,103"];
    [tmpArrID addObject:@"p21,126/p69,318/t,103"];
    [tmpArrID addObject:@"p20,123/p69,318/t,103"];
    [tmpArrID addObject:@"p20,348/p69,318/t,103"];
    [tmpArrID addObject:@"p20,122/p69,318/t,103"];
    //lee999 加上背心式上衣
    [tmpArrID addObject:@"p37,219/p69,318/t,104"];
    [tmpArrID addObject:@"p69,318/t,103/"];

    //    [tmpArrID addObject:@""];
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"睡衣/家居" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_male_pic_02" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加睡衣/家居的数据
    
    /**
     泳衣
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"泳裤"];
    [tempArr addObject:@"沙滩裤"];
    [tempArr addObject:@"全部"];

    //    [tempArr addObject:@"泳帽"];
    //    [tempArr addObject:@"亲子"];
    
    tmpArrID = [NSMutableArray array];//缺少泳帽和亲子
    [tmpArrID addObject:@"p44,369/p69,318/t,106"];
    [tmpArrID addObject:@"p44,264/p69,318/t,106"];
    [tmpArrID addObject:@"p69,318/t,106/"];

    //    [tmpArrID addObject:@""];
    //    [tmpArrID addObject:@""];
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"泳衣" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_male_pic_03" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加泳衣的数据
    
    /**
     保暖
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"基础打底"];
    [tempArr addObject:@"功能保暖"];
    [tempArr addObject:@"时尚外穿"];
    [tempArr addObject:@"低领上衣"];
    [tempArr addObject:@"高领上衣"];
    [tempArr addObject:@"保暖裤"];
    [tempArr addObject:@"保暖套装"];
    [tempArr addObject:@"全部"];

    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,318/p85,370/t,104"];
    [tmpArrID addObject:@"p69,318/p85,372/t,104"];
    [tmpArrID addObject:@"p69,318/p85,371/t,104"];
    [tmpArrID addObject:@"p37,217/p69,318/t,104"];
    [tmpArrID addObject:@"p37,218/p69,318/t,104"];
    [tmpArrID addObject:@"p37,221/p69,318/t,104"];
    [tmpArrID addObject:@"p37,222/p69,318/t,104/"];
    [tmpArrID addObject:@"p69,318/t,104/"];

    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"保暖" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_male_pic_04" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加保暖的数据
    
    /**
     配饰
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"袜子"];
    [tempArr addObject:@"袖扣"];
    [tempArr addObject:@"全部"];

    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,318/p91,399/t,107"];
    [tmpArrID addObject:@"p69,318/p88,417/t,107"];
    [tmpArrID addObject:@"p69,318/t,107/"];
    
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"配饰" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_male_pic_05" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加配饰的数据
    
    [tmpMenArray addObject:tmpArr];
    
    /**
     品牌
     **/
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"sort_brand_06"];
    [tempArr addObject:@"sort_brand_03"];
    [tempArr addObject:@"sort_brand_04"];
    [tempArr addObject:@"sort_brand_07"];
    [tempArr addObject:@"sort_brand_05"];
    [tempArr addObject:@"sort_brand_08"];
    [tmpMenArray addObject:tempArr];
    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"b,13/p69,318--爱慕先生"];
    [tmpArrID addObject:@"b,14/p69,318--爱美丽"];
    [tmpArrID addObject:@"b,16/p69,318--心爱"];
    [tmpArrID addObject:@"b,20/p69,318--宝迪威德"];
    [tmpArrID addObject:@"b,15/p69,318--爱慕儿童"];
    [tmpArrID addObject:@"b,19/p69,318--爱慕运动"];

    [tmpMenArray addObject:tmpArrID];
    
    
    return tmpMenArray;
}


#pragma mark 获取儿童的数据
+(NSArray *)kidsArray
{
    NSMutableArray *tmpMenArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *tmpArr = [NSMutableArray array];
    /**
     女童
     少女内衣
     */
    NSMutableArray *tempArr = [NSMutableArray array];
    [tempArr addObject:@"文胸"];
    [tempArr addObject:@"基础内衣"];
    //lee999 要求增加数据  140528
    [tempArr addObject:@"内裤"];
    [tempArr addObject:@"睡衣"];
    [tempArr addObject:@"全部"];

    //end
    
    NSMutableArray *tmpArrID = [NSMutableArray array];
    //@李阳 @嘉义    app竖屏首页  导航那     女童->少女内衣-> 文胸   换一个参数   换成 p69,427/t,101/  这个
    [tmpArrID addObject:@"p69,427/t,101/"];//
    //    [tmpArrID addObject:@"p69,427/t,109"];
//    [tmpArrID addObject:@"p69,425-427/t,101"];
    [tmpArrID addObject:@"p69,425-427/t,109"];
    //lee999 要求增加数据  140528
    [tmpArrID addObject:@"p69,427/t,102"];
    [tmpArrID addObject:@"p69,427/t,103"];
    [tmpArrID addObject:@"p69,425/t,109/"];

    //end
    
    NSMutableDictionary *tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"少女内衣" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_girl_pic_01" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加少女内衣的数据
    
    /**
     内裤
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"无痕"];
    [tempArr addObject:@"生理裤"];
    [tempArr addObject:@"舒适棉质"];
    [tempArr addObject:@"低腰"];
    [tempArr addObject:@"中腰"];
    [tempArr addObject:@"高腰"];
    [tempArr addObject:@"平脚裤"];
    [tempArr addObject:@"全部"];

    
    tmpArrID = [NSMutableArray array];//缺少高腰
    //    [tmpArrID addObject:@"p69,427/p84,346/t,102"];
    //    [tmpArrID addObject:@"p69,427/p84,383/t,102"];
    //    [tmpArrID addObject:@"p16,88/p69,427/t,102"];
    //    [tmpArrID addObject:@"p16,89/p69,427/t,102"];
    //    //高腰
    //    [tmpArrID addObject:@""];
    //    [tmpArrID addObject:@"p15,83/p69,427/t,102"];
    //    [tmpArrID addObject:@"p15,84/p69,427/t,102"];
    //    [tmpArrID addObject:@"p69, 425-427/t,102"];
    
    [tmpArrID addObject:@"p69,425-427/t,102"]; //无痕
    [tmpArrID addObject:@"p69, 425-427/p84,346/t,102"];//生理裤
    [tmpArrID addObject:@"p69,425-427/p84,383/t,102"];//舒适棉质
    [tmpArrID addObject:@"p16,88/p69,425-427/t,102"];//低腰
    [tmpArrID addObject:@"p16,89/p69,425-427/t,102"];//中腰
    [tmpArrID addObject:@"p15,83/p69,425-427/t,102"]; //高腰
    [tmpArrID addObject:@"p15,84/p69, 425-427/t,102"];//平角
    [tmpArrID addObject:@"p69,425/t,102/"];

    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"内裤" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_girl_pic_02" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加内裤的数据
    
    /**
     睡衣/家居
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"可外穿"];
    //    [tempArr addObject:@"亲子装"];
    [tempArr addObject:@"舒适"];
    [tempArr addObject:@"优雅"];
//    [tempArr addObject:@"睡眠"];
    [tempArr addObject:@"家居休闲"];
    [tempArr addObject:@"分身套装"];
    [tempArr addObject:@"睡衣下装"];
    [tempArr addObject:@"小吊衣/裙"];
    [tempArr addObject:@"睡裙"];
    [tempArr addObject:@"睡衣上装"];
    [tempArr addObject:@"全部"];

    
    tmpArrID = [NSMutableArray array];
    //    [tmpArrID addObject:@""];//可外穿
    //    [tmpArrID addObject:@""];//亲子装
    //    [tmpArrID addObject:@"p21,126/p69,427/t,103"];
    //    [tmpArrID addObject:@"p29,176/p69,427/t,103"];
    //    [tmpArrID addObject:@""];
    //    [tmpArrID addObject:@""];
    //    [tmpArrID addObject:@"p20,122/p69,427/t,103"];
    //    [tmpArrID addObject:@""];
    //    [tmpArrID addObject:@"p20,347/p69,427/t,103"];
    //    [tmpArrID addObject:@""];
    //    [tmpArrID addObject:@"p20,348/p69,427/t,103"];
    [tmpArrID addObject:@"p21,129/p69,425/t,103"];//可外穿
    //    [tmpArrID addObject:@""];//亲子装
    [tmpArrID addObject:@"p21,126/p69,425-427/t,103"];//舒适
    [tmpArrID addObject:@"p21,127/p69,425/t,103"];//优雅
//    [tmpArrID addObject:@"p29,177/p69,425/t,103"];//睡眠
    [tmpArrID addObject:@"p29,176/p69,425-427/t,103"];//家居休闲
    [tmpArrID addObject:@"p20,123/p69,425/t,103"];//分身套装
    [tmpArrID addObject:@"p20,122/p69,425-427/t,103"];//睡衣下装
    [tmpArrID addObject:@"p20,118/p69,425/t,103"];//小吊衣/裙
    [tmpArrID addObject:@"p20,347/p69,425-427/t,103"];//睡裙
    [tmpArrID addObject:@"p20,348/p69,425-427/t,103"];//睡衣上装
    [tmpArrID addObject:@"p69,425/t,103/"];//全部

    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"睡衣/家居" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_girl_pic_03" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加睡衣/家居的数据
    
    /**
     泳衣
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"分身泳衣"];
    [tempArr addObject:@"连体泳衣"];
    //    [tempArr addObject:@"泳帽"];
//    [tempArr addObject:@"沙滩裙/裤/纱"];
    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p44,262/p69,425/t,106"];
    [tmpArrID addObject:@"p44,261/p69,425/t,106"];
    [tmpArrID addObject:@""];
    [tmpArrID addObject:@""];
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"泳衣" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_girl_pic_04" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加泳衣的数据
    
    /**
     保暖
     */
    tempArr = [NSMutableArray array];
    //    [tempArr addObject:@"基础打底"];
    [tempArr addObject:@"功能保暖"];
    //    [tempArr addObject:@"可外穿"];
    [tempArr addObject:@"低领上衣"];
    [tempArr addObject:@"高领上衣"];
    [tempArr addObject:@"保暖裤"];
    [tempArr addObject:@"保暖套装"];
    //lee999 增加新品牌  140528
    [tempArr addObject:@"背心式上衣"];
    [tempArr addObject:@"全部"];

    //end
    
    tmpArrID = [NSMutableArray array];
    //    [tmpArrID addObject:@"p69,425/p85,370/t,104"];
    [tmpArrID addObject:@"p69,425/p85,372/t,104"];
    //    [tmpArrID addObject:@""];
    [tmpArrID addObject:@"p37,217/p69,425/t,104"];
    [tmpArrID addObject:@"p37,218/p69,425/t,104"];
    [tmpArrID addObject:@"p37,221/p69,425/t,104"];
    [tmpArrID addObject:@"p37,222/p69,425/t,104"];
    //lee999 增加新分类@"背心式上衣"  140528
    [tmpArrID addObject:@"p37,219/p69,425/t,104"];
    [tmpArrID addObject:@"p69,425/t,104/"];
    //end
    
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"保暖" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_girl_pic_05" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加保暖的数据
    
    [tmpMenArray addObject:tmpArr];
    
    /**
     男童
     内裤
     */
    tmpArr = [NSMutableArray array];
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"无痕"];
    [tempArr addObject:@"舒适棉质"];
    [tempArr addObject:@"中腰"];
    [tempArr addObject:@"三角裤"];
    [tempArr addObject:@"平脚裤"];
    [tempArr addObject:@"全部"];

    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,426/p84,345/t,102"];//无痕
    [tmpArrID addObject:@"p69,426/p84,383/t,102"];
    [tmpArrID addObject:@"p16,89/p69,426/t,102"];
    [tmpArrID addObject:@"p15,83/p69,426/t,102"];
    [tmpArrID addObject:@"p15,84/p69,426/t,102"];
    [tmpArrID addObject:@"p69,426/t,102/"];

    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"内裤" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_boy_pic_01" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加内裤的数据
    
    /**
     睡衣/家居
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"舒适"];
    [tempArr addObject:@"家居休闲"];
//    [tempArr addObject:@"睡眠"];
    [tempArr addObject:@"睡衣下装"];
    [tempArr addObject:@"睡衣上装"];
    [tempArr addObject:@"分身套装"];
    [tempArr addObject:@"全部"];

    //    [tempArr addObject:@"亲子"];
    
    tmpArrID = [NSMutableArray array];//缺少亲子
    [tmpArrID addObject:@"p21,126/p69,426/t,103"];
    [tmpArrID addObject:@"p29,176/p69,426/t,103"];
//    [tmpArrID addObject:@"p29,177/p69,426/t,103"];
    [tmpArrID addObject:@"p20,122/p69,426/t,103"];
    [tmpArrID addObject:@"p20,348/p69,426/t,103"];
    [tmpArrID addObject:@"p20,123/p69,426/t,103"];
    [tmpArrID addObject:@"p69,426/t,103/"];

    //    [tmpArrID addObject:@""];
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"睡衣/家居" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_boy_pic_02" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加睡衣/家居的数据
    
    /**
     泳衣
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"泳裤"];
    [tempArr addObject:@"沙滩裤"];
    [tempArr addObject:@"泳帽"];
    [tempArr addObject:@"全部"];

    //    [tempArr addObject:@"亲子"];
    
    tmpArrID = [NSMutableArray array];//缺少亲子
    [tmpArrID addObject:@"p44,369/p69,426/t,106"];
    [tmpArrID addObject:@"p44,264/p69,426/t,106"];
    [tmpArrID addObject:@"p44,398/p69,426/t,106"];//泳帽
    [tmpArrID addObject:@"p69,426/t,106/"];

    //    [tmpArrID addObject:@""];
    //    [tmpArrID addObject:@""];
    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"泳衣" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_boy_pic_03" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加泳衣的数据
    
    /**
     保暖
     */
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"基础打底"];
    [tempArr addObject:@"功能保暖"];
    //    [tempArr addObject:@"可外穿"];
    [tempArr addObject:@"低领上衣"];
    [tempArr addObject:@"高领上衣"];
    [tempArr addObject:@"保暖裤"];
    [tempArr addObject:@"保暖套装"];
    [tempArr addObject:@"全部"];

    
    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"p69,426/p85,370/t,104"];//基础打底
    [tmpArrID addObject:@"p69,426/p85,372/t,104"];
    //    [tmpArrID addObject:@""];//可外穿
    [tmpArrID addObject:@"p37,217/p69,426/t,104"];//低领上衣
    [tmpArrID addObject:@"p37,218/p69,426/t,104"];
    [tmpArrID addObject:@"p37,221/p69,426/t,104"];
    [tmpArrID addObject:@"p37,222/p69,426/t,104/"];
    [tmpArrID addObject:@"p69,426/t,104/"];

    
    tmpDic = [NSMutableDictionary dictionary];
    [tmpDic setObject:@"保暖" forKey:@"title"];
    [tmpDic setObject:@"0" forKey:@"isOpen"];
    [tmpDic setObject:@"sort_boy_pic_04" forKey:@"imgName"];
    [tmpDic setObject:tempArr forKey:@"subTitleArr"];
    [tmpDic setObject:tmpArrID forKey:@"subIDArr"];
    [tmpArr addObject:tmpDic];//添加保暖的数据
    
    [tmpMenArray addObject:tmpArr];
    
    /**
     品牌
     **/
    tempArr = [NSMutableArray array];
    [tempArr addObject:@"sort_brand_05"];
    [tempArr addObject:@"sort_brand_04"];
    [tmpMenArray addObject:tempArr];
    
    tmpArrID = [NSMutableArray array];
    [tmpArrID addObject:@"b,15--爱慕儿童"];
    [tmpArrID addObject:@"b,16/p69,425--心爱"];
    [tmpMenArray addObject:tmpArrID];
    
    return tmpMenArray;
}


@end
