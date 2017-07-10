sl_log_file       = "/private/var/touchelf/scripts/sl/sl_log.txt" --配置文件
sl_error_time     = 3 ;  --容错处理
try_time  =   1     --等待时间/s
strategy = {"1"}    ;     --策略 =1 -- 2 -- 3  

--号码段
pre_fix_phone_numb   = {1865571}--1388888, 1355555, 1344444,1366666}--号段前缀，可以添加多个号码段

--姓名
pre_fix_name = {"艾","毕","蔡","代","厄","方","甘","黄","马","赵","钱","孙","李","周","吴","郑","王"};

--精准电话号码
phone_num = {13006644179,13006646687,13006647343,13006648168,13006650256,13006652675,13006655095,13006644179,13006660411,13006660522,13006660832,13006660835,13006661662,13006661680,13006661702,13006661998,13006662207,13006662294,13006662799,13006662893,13006662921,13006663001,13006663133,13006663179,13006663236,13006663317,13006663353,13006663360,13006663376,13006663570,13006663754,13006663772,13006664116,13006664206,13006664219,13006664527}

--关注公众号图片存放位置/page_jiagongzhonghao.lua
path_guanzhu="/var/touchelf/res/path_guanzhu.bmp";     

---朋友圈复制文字图片存放位置/page_fuzhiwenzi.lua
path_fuzhi="/var/touchelf/res/path_fuzhi.bmp"           

--照片图片存放位置/page_main.lua 
path_zhaopian="/var/touchelf/res/path_zhaopian.bmp"          

--ifile文件管理器图标存放位置/page_main.lua
path_ifile="/var/touchelf/res/path_ifile.bmp"           

--微信关注的公众号名字/page_jiagongzhonghao.lua
gongzhonghao={"顺联天下","淘宝","京东","唯品会","蘑菇街","开心购","天猫","咔购","欢乐购","英雄联盟","王者荣耀","北京","湖北","天安门"};         

--回复朋友消息内容1/page_liaotian.lua
text_huifu1 = {}-- "[微信红包] 恭喜发财 大吉大利", "你好", "(｡･∀･)ﾉﾞ嗨"}
    
--回复朋友消息内容2/page_liaotian.lua
text_huifu2={"今天给你发这条信息呢主要有5个目的  1.提醒你我的存在   2.稳固我们的关系   3.说明我真的很在乎你  4.记得关注我家的名片 还有我家的公众号  么么哒   5.想了解我的话,请看我的朋友圈 么么哒"};    

--发送的公众号名单/page_xuanzegzh.lua
text_gzhmingpian={"泗州快讯"};                      

--推送个人名片/page_xuanzepengyou.lua
text_gerenmingpian={}--"《》微⃝信⃝"};              

--群拉人/page_xuanzelianxiren.lua
text_quntianjia = {}--"张罗冰"};  

--搜索添加指定好友的微信号/page_sousuoshoujihao.lua
text_weixinhao ={"sixian-168"}                   

--手机号微信号文本存放位置到手机的位置/page_text/phone_weixin.txt ; page_sousuojiahaoyou.lua
text_phone_weixin="/var/touchelf/res/phone_weixin.txt"  

--转发文章的公众号/page_gongzhonghao.lua
text_gongzhonghao = {"欢乐购","英雄联盟","王者荣耀"}    

--群聊天内容/page_quliaotian.lua 
text_qunliaotian= {"不劳而获要不得。轻易得来的不会珍惜，还会养成贪婪的毛病。",
            "不要把别人的善良当成自己要饭的资本，谁也不亏欠你的。",
            "不要活得太卑贱，没有任何人必须对你好。",
            "每个人走的路不一样，你没有权利指三道四。承认别人的不一样，也是一种尊重。",
            "人不要说得太多，言多必失。",
            "最近好无聊，有没有什么好玩的地方",
            "你们都在干嘛，怎么都没几个人出来聊天",
            "最近剧荒，现在有什么电视剧好看，推荐几个",
            "有没有人玩王者农药，一起开黑呀，我带你坑",
            "当面奉劝别人是德，背后指责别人是无德。",
            "一个人还是应该了解自己，懂得认识自己，不能当别人夸大你的时候，你真的信以为真了。",
            "今天的成绩已成为过去，当你满足的时候，就是失败的开始。",
            "都4月份了，时间过得真快，你干了什么",
            "幸福没有明天，也没有昨天，它不怀念过去，也不向往未来，它只有现在。",
            "艰苦的工作，艰难的日子，不幸的世界。生活并不总是甜蜜的。这就是生活！",
            "今天我上街，看见一算命的，让他给我算命，他给我看手相，看了半天，突然猛然抬头看我，接着跪在地上大喊“吾皇万岁万岁 万万岁”…",
            "驴是的念来过倒。",
            "下雨了，别忘了打伞，湿身是小，淋病就麻烦啦!",
            "你让我滚，我滚了。你让我回来，对不起，滚远了。",
            "早上赶公共汽车，到站台的时候，汽车已经启动了。于是我只好边追边喊：“师傅，等等我!师傅，等等我呀!”这时一乘客从车窗探出头来冲我说了一句：“悟空你就别追了。…",
            "我是藤儿你是瓜，我是鱼儿你是虾，我是盆儿你是花，每天逗你笑哈哈!",
            "天不怕，地不怕，就怕老师来我家。坐俺的墩儿，喝俺的茶，老师一走妈就打。",
            "上联：看背影急煞千军万马；下联：转过头吓退各路诸侯；横批：我的妈呀！ ",
            "大家都在干什么，出来冒个泡呗",
            "听说最近摩拜挺火，那不是租自行车的都要淘汰了",
            "你英语好吗，我英语好差，为啥我学不好呢",
            "你喜欢锻炼吗，我现在每天早上都起来跑跑步",
            "你天天都是几点起床，我就是早上起不来，喜欢睡懒觉",
            "你一般都是几点睡觉，我现在都是不过12点不睡了，这样真的好吗",
            "今天天气好好呀，但是不知道去哪玩",
            "今天又下雨了，真的烦呀",
            "感冒了，好难受，什么药好呀，我去买点",
            "你真的好笨，玩个游戏那么菜，真是猪队友",
            "最近有没有什么项目一起合作 ，现在闲得慌",
            "真正的好朋友，并不是在一起就有聊不完的话题，而是在一起，就算不说话，也不会觉得尴尬",
            "你喜不喜欢我，喜欢你就说啊，万一我也喜欢你呢",
            "有时候，不是对方不在乎你，而是你把对方看的太重",
            "我不是广场上算卦的，唠不出那么多你爱听的嗑。",
            "是金子总要发光的，但当满地都是金子的时候，我自己也不知道自己是哪颗了",
            "去披萨店买披萨!服务员问我是要切成8块还是12块?我想了想说：还是8块吧!12块吃不完!",
            "我心眼儿有些小，但是不缺;我脾气很好，但不是没有!",
            "初见倾心，再见痴心。终日费心，欲得芳心。煞费苦心，想得催心。难道你心，不懂我心!",
            "给你点阳光你就灿烂，给你点洪水你就泛滥。我让老太太抹红嘴唇儿，给你点颜色看看。",
            "不要和我比懒，我懒得和你比。",
            "不要整天抱怨生活，生活根本就不会知道你是谁，更别说它会听你的抱怨。",
            "大师兄，你知道吗?二师兄的肉现在比师傅的都贵了",
            "云很轻，眼皮很重，现在你在做什么？",
            "我要让全世界的人知道，你这个磨人的小妖精被我承包了。",
            "过去，闹钟响的时候，我常常有把它拍了再继续睡的毛病，但是自从我在闹钟旁边放了三个老鼠夹之后，我的毛病就根除了。",
            "妈妈小时候告诉我，不要做一个不三不四的人，所以现在我很二。",
            "我尝试着做一个有趣的人，后来跑偏了，成了一个逗逼。",
            "我的性格就是懒，兴趣就是玩，特长就是吃，技能就是睡。",
            "后来，终于在眼泪中明白，有些人，一旦黑了就白不回来",
            "你骂我我笑着，你装逼我忍着，你阴我我挺着，草泥马你等着",
            "我一定要在你平庸无奇的人生里，做一个闪闪发光的逗比"
            };     

 ---搜手机号验证信息/page_yanzheng.lua
text_yanzheng={"你好呀","你好","嗨","哈喽"};   

--打招呼内容 /page_zhaohu.lua  附近的人和我的瓶子打招呼
text_zhaohu={"你好呀","你好","嗨","哈喽"} ;                 

--回应瓶子内容/page_huiying.lua
text_huiying={"你好呀，很高兴认识你","你好,加个朋友吧","认识一下啦","嗨"}; 

--扔瓶子内容/page_rengpingzi.lua
text_renpingzi= {"我有一个梦，就是想和你见一面","唯品会一家专门做特卖的网站","港荣蒸蛋糕，好吃不上火","跟我走跟我走",""};        

--修改名字/page_mingzi.lua
text_mingzi={"花花","微微","素素","芊芊","浅浅","琪琪","浅语歌","石莲","柳萍","欢欢","提莫","慕慕","露露","璐璐"};    

--个性签名 / page_qianming.lua
text_qianming={"我爱的人他不爱我","我有一个梦，就是想和你见一面","你瞅啥","取其沉沦而死！不如踏浪与歌"}

---转发朋友圈的朋友名字/page_sousuo.lua
text_pengyou={"《》微⃝信⃝"}--,"泗县小微","泗县便民信息平台","泗县城市网","泗县微服务"}; 

--群发消息内容/page_qunfa.lua
text_qunfa={"你好","嗨","哈喽"}; 

--发朋友圈文字/page_shuoshuo.lua
text_pengyouquan={"今天天气真好","今天放假真爽","今天好开心，哈哈哈"}; 

 ---gps伪装/page_faxian.lua
gps_x = {22.7168510000,22.5807680000,22.5546030000,22.6987150000,22.5206880000,22.5682200000,22.6007890000};
gps_y = {114.2532870000,114.2550120000,113.9117870000,114.0923110000,114.0572410000,113.9931380000,114.0948980000};

--功能
action = {         
     --微信消息：1
     "智能回复"   ,     --1.1   
     "回复消息"  ,      --1.4

     --微信通讯录：2
     "搜索手机加好友" ,  --2.11  --添加朋友 
     "加公众号"   ,      --2.12
     "通讯录加好友" ,    --2.2
     "微信群加好友",     --2.3
     "转发说说 文章"  ,  --2.4
     "转发公众号文章" ,  --2.5
     "发消息给随机好友" ,--2.6  

     --微信发现  3
     "附近人打招呼"  ,  --3.1
     "漂流瓶"     ,     --3.2  
     "发朋友圈"    ,    --3.3
     "保存图片到相册发朋友圈" , --3.31
     "站街扫街"    ,    --3.4
     "朋友圈提取号码",  --3.5

     --我  4
     "修改名字签名头像",  --4.1
     "清理缓存"      ,  --4.2
     "群发消息"      ,  --4.3

     --手机 5
     "删除照片"     ,  --5.1
     "增加联系人"    , --5.2
     "删除联系人"     --5.3
}

--全局配置参数
gongneng = 1.5 ;       ---对应action{}

