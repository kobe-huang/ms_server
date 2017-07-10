sl_log_file       = "/private/var/touchelf/scripts/sl/sl_log.txt" --配置文件
sl_error_time     = 3 ;  --容错处理
try_time  =   1     --等待时间/s

strategy = {"1"}    ;     --策略 =1 -- 2  

--全局配置参数
pre_fix_phone_numb   = {1865571}--1388888, 1355555, 1344444,1366666}--号段前缀，可以添加多个号码段

pre_fix_name = {"艾","毕","蔡","代","厄","方","甘","黄","马","赵","钱","孙","李","周","吴","郑","王"};

phone_num = {13006644179,13006646687,13006647343,13006648168,13006650256,13006652675,13006655095,13006644179,13006660411,13006660522,13006660832,13006660835,13006661662,13006661680,13006661702,13006661998,13006662207,13006662294,13006662799,13006662893,13006662921,13006663001,13006663133,13006663179,13006663236,13006663317,13006663353,13006663360,13006663376,13006663570,13006663754,13006663772,13006664116,13006664206,13006664219,13006664527}

path_guanzhu="/var/touchelf/res/path_guanzhu.bmp";     --关注公众号图片存放位置 
---page_jiagongzhonghao.lua

path_fuzhi="/var/touchelf/res/path_fuzhi.bmp"           ---朋友圈复制文字图片存放位置
---page_fuzhiwenzi.lua

path_zhaopian="/var/touchelf/res/path_zhaopian.bmp"     --照片图片存放位置
---page_main.lua       

path_ifile="/var/touchelf/res/path_ifile.bmp"           --ifile文件管理器图标存放位置
---page_main.lua

gongzhonghao={"顺联天下","淘宝","京东","唯品会","蘑菇街","开心购","天猫","咔购","欢乐购","英雄联盟","王者荣耀","北京","湖北","天安门"};         --微信关注的公众号名字/page_jiagongzhonghao.lua

text_gzhmingpian={"顺联天下"};                      --发送的公众号名单
--page_xuanzegzh.lua

text_huifu={"你好","关注一下这个名片你会用到的","(｡･∀･)ﾉﾞ嗨"};                         --回复朋友消息内容
--page_liaotian.lua

text_gerenmingpian={"《》微⃝信⃝"};              --推送个人名片 
--page_xuanzepengyou.lua

---/page_text/phone_weixin.txt
text_phone_weixin="/var/touchelf/res/phone_weixin.txt"  --手机号微信号文本存放位置到手机的位置
---page_sousuojiahaoyou.lua

text_gongzhonghao = {"欢乐购","英雄联盟","王者荣耀"}    --转发文章的公众号
---page_gongzhonghao.lua

text_yanzheng={"你好呀","你好","嗨","哈喽"};           ---搜手机号验证信息/page_yanzheng.lua

text_zhaohu={"你好呀","你好","嗨","哈喽"} ;                 --打招呼内容 /page_zhaohu.lua  附近的人和我的瓶子打招呼

text_huiying={"你好呀，很高兴认识你","你好,加个朋友吧","认识一下啦","嗨"};     --回应瓶子内容/page_huiying.lua

text_renpingzi= {"我有一个梦，就是想和你见一面","唯品会一家专门做特卖的网站","港荣蒸蛋糕，好吃不上火","跟我走跟我走",""};        --扔瓶子内容/page_rengpingzi.lua

text_mingzi={"花花","微微","素素","芊芊","浅浅","琪琪","浅语歌","石莲","柳萍","欢欢","提莫","慕慕","露露","璐璐"};    --修改名字/page_mingzi.lua

text_qianming={"我爱的人他不爱我","我有一个梦，就是想和你见一面","你瞅啥","取其沉沦而死！不如踏浪与歌"}
---个性签名 / page_qianming.lua

text_pengyou={"《》微⃝信⃝"}--,"泗县小微","泗县便民信息平台","泗县城市网","泗县微服务","泗县百事通"};                   ---转发朋友圈的朋友名字/page_sousuo.lua

text_qunfa={"你好","嗨","哈喽"};                        --群发消息内容/page_qunfa.lua

text_pengyouquan={"今天天气真好","今天放假真爽","今天好开心，哈哈哈"};    --发朋友圈文字
---page_shuoshuo.lua

gps_x = {40.0460810000,29.2814450000,30.6321630000,23.1427560000,32.0711820000,39.9328920000};

gps_y = {116.6256760000,106.3714830000,104.1491470000,113.2644320000,118.7839080000,116.4441080000};
 ---gps伪装/page_faxian.lua

action = {         --功能
     --微信通讯录：2
     "搜索手机加好友" , --2.11  --添加朋友 
     "加公众号"   ,     --2.12
     "通讯录加好友" ,   --2.2
     "微信群加好友",    --2.3
     "转发说说 文章"  ,    --2.4
     "转发公众号文章" ,  --2.5
     --微信发现  3
     "附近人打招呼"  ,  --3.1
     "漂流瓶"     ,     --3.2  
     "发朋友圈"    ,    --3.3
     "保存图片到相册发朋友圈" , --3.31
     "站街扫街"    ,    --3.4
     --我  4
     "修改名字签名头像",  --4.1
     "清理缓存"      ,  --4.2
     "群发消息"      ,  --4.3
     --手机 5
     "删除照片"     ,  --5.1
     "增加联系人"    , --5.2
     "删除联系人"     --5.3
}


gongneng = 4.3 ;       --1=action[1]...
--全局配置参数
