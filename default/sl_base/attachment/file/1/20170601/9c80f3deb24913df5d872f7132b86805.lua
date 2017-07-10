------------sl_func_photo_book_ip4.lua------------
--                                              --
--                                              --
--170601  18:07:32    luoshui package 
--                                              --
--                                              --
--                                              --
--------------------------------------------------








----------------------begin: sl_package_config.lua---------------------------------
--begin sl_package_config.lua--
package.path = package.path .. ";/d/kobe doc/code/github/LUA_code/phone_book_operate/package/?.lua" --直接用git-bash 就可以看到地址
package.path = package.path .. ";/private/var/touchelf/scripts/?.lua" .. ";/private/var/touchelf/scripts/sl/?.lua"

sl_globle_para = {  --全局变量
	is_package = true;    --是否是打包的程序
	package_info = "luoshui_V0.1"
}

--end sl_package_config.lua--

------------------end: sl_package_config.lua-------------------------------------




----------------------begin:  lib\lib_file_operate.lua---------------------------------
--begin lib_file_log.lua
require "string"
--------------------------------文件地址操作-------
--得到文件的全部路径
function get_FILE_path( ... )
    local __FILE__ = debug.getinfo(1,'S').source:sub(2)
    return __FILE__;
    -- body
end

--得到文件的路径
function get_dir_name(str)  
    if str:match(".-/.-") then  
        local name = string.gsub(str, "(.*/)(.+)", "%1")  
        return name  
    elseif str:match(".-\\.-") then  
        local name = string.gsub(str, "(.*\\)(.+)", "%1")  
        return name  
    else  
        return nil
    end  
end  

--获取路径，去除文件名  
function strip_file_name(filename)  --
    if filename:match(".-/.-") then 
        return string.match(filename, "(.+)/[^/]*%.%w+$")   --*nix system 
    elseif filename:match(".-\\.-") then   
        return string.match(filename, "(.+)\\[^\\]*%.%w+$") -- windows
    else  
        return nil
    end   
end    


--获取文件名  ，去除文件路径  
function strip_path(filename)
    if filename:match(".-/.-") then 
        return string.match(filename, ".+/([^/]*%.%w+)$")   -- *nix system  
    elseif filename:match(".-\\.-") then   
        return string.match(filename, ".+\\([^\\]*%.%w+)$") -- *nix system
    else  
        return nil
    end    
end  

--去除扩展名 
function strip_extension(filename)  
    local idx = filename:match(".+()%.%w+$")  
    if(idx) then  
        return filename:sub(1, idx-1)  
    else  
        return filename  
    end  
end  
  
--获取扩展名  
function get_extension(filename)  
    return filename:match(".+%.(%w+)$")  
end  

--得到当前目录
function get_current_dir(myfile)
    -- body
     --myfile = __FILE__;
     if myfile:match(".-/.-") then  
        local name = string.gsub(myfile, "(.*/)(.+)", "%1")  
        return name  
    elseif myfile:match(".-\\.-") then  
        local name = string.gsub(myfile, "(.*\\)(.+)", "%1")  
        return name  
    else  
        return nil
    end  
end

--得到根目录
function get_prj_root_dir(root_dir, num)  --往上num级目录
    --local root_dir = __FILE__;
    for i=1,num do
        root_dir = get_dir_name(root_dir);
        --print(root_dir);
        root_dir = string.sub(root_dir, 1, -2)
        --print(root_dir);
        root_dir = root_dir .. ".del"
    end
    root_dir = get_dir_name(root_dir);
    return root_dir;
end

-----------------------------------------------------------

 
--判断文件是否存在
function file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
end

--将二进制的文件转换成--
function fileToHexString(file)  
        local file = io.open(file, 'rb');
        local data = file:read("*all");
        notifyMessage( type(data) )
        file:close();
        local t = {};
        for i = 1, string.len(data),1 do
                local code = tonumber(string.byte(data, i, i));
                table.insert(t, string.format("%02x", code));
        end
        return table.concat(t, "");
end

--在文件（文本文件）中，找特定的字串--
function isStringInFile(mystring, file) 
    local BUFSIZE = 8192
    local f = io.open(file, 'r')  --打开输入文件
    
    while true do
        local lines,rest = f:read(BUFSIZE,"*line")
        if not lines then
            break
        end
        if rest then
            lines = lines .. rest .. "\n"
        end
        
        local i = string.find(lines,mystring);
        if nil ~= i then
            f:close();
            return true;
        end
    end
     f:close();
    return false;
 end   

--写字串到到文件中--
function writeStrToFile(mystring, file)
    local f = io.open(file, 'a');
    f:write(mystring .. "\r\n");
    f:close();
end


--------------------------------------------------------------log----------------------------------------
--初始化log文件
function logFileInit(log_file_name)   
    rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    rightnow_time = os.date("%H:%M:%S");
    local file_path = strip_file_name(log_file_name)
    if false == file_exists(file_path) then  --创建自己的临时文件夹
          os.execute("mkdir -p " .. file_path);
    end
    writeStrToFile(rightnow_data .. " " .. rightnow_time .. "   ++++begin+++", log_file_name); 
end

if sl_log_file == nil then  --设置默认log文件
    sl_log_file = "/private/var/touchelf/scripts/sl/sl_log.txt";
end

--得到本机当前时间
function get_local_time()
    local rightnow_data = os.date("%Y%m%d");   --得到当前日期和时间
    local rightnow_time = os.date("%H:%M:%S");
    local my_time = rightnow_data .. ": " .. rightnow_time .. ": "
    return my_time;
end 

--输出信息到文件
function log_info(out_info)  ---错误处理函数   
    --notifyMessage(out_info);
    local time = get_local_time(); 
    writeStrToFile("info:  " .. time .. out_info , sl_log_file);    
end

function error_info_exit(out_info)  ---错误处理函数   
    local time = get_local_time(); 
    writeStrToFile("fatal error:  " .. time .. out_info , sl_log_file); 
    notifyMessage("致命错误：".. out_info);   
    mSleep(3000);
    --page_array["page_main"]:enter();  --重新开始
    os.execute("reboot");
    --os.exit(1);
end

error_time = 10 ;
function error_info(out_info)  ---错误处理函数   
    logFileInit(sl_log_file);
    local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage("错误：" .. out_info);
    mSleep(1200);
    if nil ~= sl_error_time then
        error_time = error_time - 1;
        if error_time <= sl_error_time then
            error_info_exit("错误次数太多");
        elseif error_time == 3 then
            warning_info("错误3次,继续下一个");
            appKill("com.tencent.xin");
            mSleep(4000);
            return false
        else 
            mSleep(1000)
           -- page_array["page_main"]:enter();  --重新开始
        end
    else
        os.exit(1);
    end
    --os.exit(1);
end

--输出警告信息到文件
function warning_info(out_info)  ---错误处理函数   
    notifyMessage("警告：" .. out_info);
    mSleep(1200);
    local time = get_local_time(); 
    writeStrToFile("warning:  " .. time .. out_info , sl_log_file);    
    if nil ~= sl_error_time then
        error_time = error_time - 1;
        if error_time <= sl_error_time then
            error_info_exit("警告次数太多");
        elseif error_time == 5 then
            warning_info("警告5次,继续下一个");
            appKill("com.tencent.xin");
            mSleep(4000);
            return false
            --page_array["page_main"]:enter();
        else 
            mSleep(1000)
           -- page_array["page_main"]:enter();  --重新开始
        end
    else
        os.exit(1);
    end
end

function  pengyou_cuowu(out_info)    --错误函数
    local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage(out_info);   
    mSleep(1000);
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(2000);
    appKill("com.tencent.xin");  --关闭微信
    mSleep(5000);
    sl_error_time = sl_error_time - 1;
    if sl_error_time == 1 then
        warning_info("错误2次,继续下一个")
        mSleep(1000);
        return false
    end
    page_array["page_main"]:enter();  --重新开始
end

function  ifile_cuowu(out_info)    --错误函数
    local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage(out_info);   
    mSleep(1000);
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(2000);
    page_array["page_main"]:enter();  --重新开始
    sl_error_time = sl_error_time - 1;
    if sl_error_time == 0 then
        warning_info("错误3次,继续下一个")
        mSleep(1000);
        return false
    end
end


function getline(sl_log_file)   --读取文本最后一行
    local t={}
    local file = io.open(sl_log_file);
    for line in file:lines() do
        table.insert(t,line);
    end
    mSleep(1000);
    file:close();
    return table.remove(t,#t);
end


function getline_1(sl_log_file)   --读取文本第一行
    local t={}
    local file = io.open(sl_log_file);
    for line in file:lines() do
        table.insert(t,line);
    end
    mSleep(1000);
    file:close();
    return table.remove(t,1);
end

------------------end:  lib\lib_file_operate.lua-------------------------------------




----------------------begin:  class\class_base_page.lua---------------------------------
--class_base_page.lua begin--
class_base_page = {
    page_name = "default_page", 
    page_image_path = "/private/var/touchelf/scripts/contact/res/full_page/default_page.bmp",
    page_action_list = {},  --进入这个页面的处理
    page_error_code = 101   --错误码
   -- page_snap_iamge = {} --截图数组，hash数组
} 


function class_base_page:new(o) --新建页面--
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self   
    return o    --最后返回构造后的对象实例
end

--step1
function class_base_page:enter()        --进入页面后的动作--
    print("class_base_page:enter");
    --print(self.page_name);
end

--step2
function class_base_page:check_page()  --检查是否是在当前页面--
    print("class_base_page:check_page");
    --print(self.page_name)
    return true;
end

function class_base_page:quick_check_page() --快速检查页面--
    print("class_base_page:check_page");
    --print(self.page_name)
    return true;
end


--step3
function class_base_page:action()     --执行这个页面的操作--
    print("class_base_page:check_page");
    --print(self.page_name)
    return true;
end

--
function class_base_page:get_page_name()  --得到这个页面的名字
    return self.page_name;
end
--

function class_base_page:error_handling()  --在这个页面的错误处理
    -- body
    if self.page_error_code == 101  then    --默认错误处理，
        mSleep(2000)
        error_info(self:get_page_name());
        mSleep(5000)
        tongzhi()
        local current_page = get_current_page(); --得到当前的page
        if false ~= current_page then 
            page_array[current_page]:enter(); --直接进当前页面的处理
        else
            rotateScreen(0);
            mSleep(637);
            keyDown('HOME');
            mSleep(141);
            keyUp('HOME');

            mSleep(159);
            keyDown('HOME');
            mSleep(64);
            keyUp('HOME');

            mSleep(1025);
            touchDown(3, 62, 534)
            mSleep(8);
            touchMove(3, 66, 494)
            mSleep(16);
            touchMove(3, 72, 418)
            mSleep(22);
            touchMove(3, 94, 322)
            mSleep(13);
            touchMove(3, 128, 196)
            mSleep(14);
            touchMove(3, 176, 56)
            mSleep(19);
            touchUp(3)

            mSleep(1167);
            touchDown(5, 302, 614)
            mSleep(9);
            touchMove(5, 302, 578)
            mSleep(20);
            touchMove(5, 304, 508)
            mSleep(19);
            touchMove(5, 306, 406)
            mSleep(16);
            touchMove(5, 312, 296)
            mSleep(14);
            touchMove(5, 326, 164)
            mSleep(15);
            touchMove(5, 346, 38)
            mSleep(15);
            touchUp(5)
            mSleep(1917);
            keyDown('HOME');
            mSleep(176);
            keyUp('HOME');
            mSleep(2000);
            error_info(self:get_page_name());
            return false
        end
    end
end

------------------end:  class\class_base_page.lua-------------------------------------




----------------------begin:  page\page_all_data.lua---------------------------------
----begin page_all_data.lua
--文件说明： 初始化页面数组；
page_array = {} --所有的page table

--初始化页面
function init_page(b)  
    if b.page_name then --如果是用打包的方式，页面初始化已经在各自的页面文件里面
    	if true == sl_globle_para.is_package then 
    		--donothing
            --page_array[b.page_name] = b.page_name:new() --放在各个page里面
    	else
	        require(b.page_name) --初始化页面对象
	        print("test");
	    end
    end
end

--得到当前的页面，返回页面的名称
function get_current_page()
    for k,v in pairs(page_array) do 
        if true == page_array[k]:quick_check_page() then
            return k;
        end
    end
    return false
end



------------------end:  page\page_all_data.lua-------------------------------------




----------------------begin:  func\photo_book\config_fengzhuang.lua---------------------------------
function  cicky(x,y,m)   ---点击函数
    touchDown(0,x,y);
    mSleep(m);
    touchUp(0);
end

function  cicky2(x,y,m)   ---点击函数
    x1=math.ceil(x/640*w);
    y1=math.ceil(y/1136*h);
    touchDown(0,x1,y1);
    mSleep(m);
    touchUp(0);
end

function  zs(x1,y1,a,x2,y2,b)--多点找色
    x = getColor(x1, y1);
    y = getColor(x2, y2);    
    if x==a and y==b then
        cicky(x1,y1,50);
        mSleep(300);          
    end
    mSleep(100);        
end

function  zs2(x1,y1,a,x2,y2,b)--多点找色
    xx1=math.ceil(x1/640*w);
    yy1=math.ceil(y1/1136*h);
    xx1=math.ceil(x2/640*w);
    yy1=math.ceil(y2/1136*h);
    a1 = getColor(xx1, yy1);
    b1 = getColor(xx1, yy1);    
    if a1==a and b1==b then
        cicky2(xx1,yy1,50);
        mSleep(300);          
    end
    mSleep(100);        
end

----系统通知
function  tongzhi()
    zs( 310,572 ,0x007AFF, 326,567 ,0x007AFF);         --通知好  点击好
    zs ( 302,560 ,0x007AFF, 339,557 ,0x007AFF);         --电量不足   点击关闭
    zs( 461,559 ,0x007AFF, 446,549 ,0x007AFF);         --访问位置  点击好
    zs( 168,570 ,0x007AFF, 236,579 ,0x007AFF);         --通知不再提示  点击不再提示
    zs(157,571 ,0x007AFF, 207,578 ,0x007AFF);        --信任
    zs(161,548 ,0x007AFF,206,546 ,0x007AFF);          --停用飞行模式  点击取消
    zs(456,570 ,0x007AFF,462,596 ,0x007AFF);          --访问地理位置   点击是
    zs(302,540 ,0x007AFF,339,535 ,0x007AFF);          --充电问题  点击关闭
    zs2(293,667 ,0x007AFF, 339,671 ,0x007AFF);        --5c充电问题  点击关闭
    zs2( 133,666 ,0x007AFF,210,669 ,0x007AFF);       --5c 通知不再提示
end


function  zt(m)   --全屏找图
    mSleep(500);
    x,y=findImage(m,80);
end

function qyzt(m,a, x1, y1, x2, y2)
    x, y = findImageInRegionFuzzy(m, a,x1,y1,x2,y2); 
end

function  qyzc(c,x1,y1,x2,y2)   ----区域找色
    mSleep(500);
    x,y=findColorInRegion(c,x1,y1,x2,y2);
    if x~=-1 and y~=-1 then
        cicky(x,y,50);
    end
end

function  ddzc(c1,i1,j1,c2,i2,j2,c3,i3,j3,c4,m,x1,y1,x2,y2);    ---4个点模糊找色
    x, y = findMultiColorInRegionFuzzy({c1,i1,j1,c2,i2,j2,c3,i3,j3,c4},m,x1,y1,x2,y2 );
end

function move(x,y,x1,y1,n)   --滑动函数
w=math.abs(x-x1)
h=math.abs(y-y1)
if w>h then
b=w/n ax=n ay=h/b
else
b=h/n ay=n ax=w/b
end
mSleep(100);
if x>x1 then x3=-ax else x3=ax end
if y>y1 then y3=-ay else y3=ay end
    touchDown(0, x, y);
  for i=1,b do
     x=x+x3 y=y+y3
    touchMove(0, x, y);
      mSleep(10);
  end
    --touchMove(0,x1,y1);
     mSleep(50);
      touchUp(0);
end

--向下滑动
function xiahua()
    rotateScreen(0);
    mSleep(701);
    touchDown(3, 412, 636)
    mSleep(62);
    touchMove(3, 408, 604)
    mSleep(2);
    touchMove(3, 408, 576)
    mSleep(15);
    touchMove(3, 408, 538)
    mSleep(20);
    touchMove(3, 408, 490)
    mSleep(13);
    touchMove(3, 410, 426)
    mSleep(20);
    touchMove(3, 418, 356)
    mSleep(13);
    touchMove(3, 430, 282)
    mSleep(15);
    touchMove(3, 446, 214)
    mSleep(20);
    touchMove(3, 458, 158)
    mSleep(13);
    touchMove(3, 466, 122)
    mSleep(15);
    touchMove(3, 482, 80)
    mSleep(33);
    touchMove(3, 520, 38)
    mSleep(2);
    touchUp(3)
    mSleep(1500);
end

--向上滑动
function shanghua()
    rotateScreen(0);
    mSleep(723);
    touchDown(5, 356, 300)
    mSleep(33);
    touchMove(5, 362, 322)
    mSleep(20);
    touchMove(5, 362, 346)
    mSleep(16);
    touchMove(5, 362, 382)
    mSleep(5);
    touchMove(5, 362, 434)
    mSleep(17);
    touchMove(5, 352, 502)
    mSleep(14);
    touchMove(5, 344, 572)
    mSleep(18);
    touchMove(5, 340, 638)
    mSleep(14);
    touchMove(5, 338, 702)
    mSleep(18);
    touchMove(5, 338, 750)
    mSleep(14);
    touchMove(5, 338, 800)
    mSleep(19);
    touchMove(5, 338, 846)
    mSleep(19);
    touchMove(5, 338, 898)
    mSleep(16);
    touchMove(5, 338, 932)
    mSleep(14);
    touchUp(5)
    mSleep(1500);

end

        
--右滑
function youhua( ... )
    rotateScreen(0);
    mSleep(1077);
    touchDown(8, 532, 560)
    mSleep(38);
    touchMove(8, 514, 558)
    mSleep(34);
    touchMove(8, 500, 558)
    mSleep(1);
    touchMove(8, 480, 558)
    mSleep(17);
    touchMove(8, 458, 558)
    mSleep(16);
    touchMove(8, 424, 556)
    mSleep(17);
    touchMove(8, 390, 556)
    mSleep(16);
    touchMove(8, 342, 554)
    mSleep(83);
    touchMove(8, 246, 546)
    mSleep(16);
    touchMove(8, 196, 538)
    mSleep(17);
    touchMove(8, 144, 528)
    mSleep(12);
    touchMove(8, 98, 524)
    mSleep(2);
    touchMove(8, 48, 524)
    mSleep(2);
    touchUp(8)

    mSleep(1500);
end

--左滑
function zuohua( ... )
    rotateScreen(0);
    mSleep(562);
    touchDown(9, 96, 444)
    mSleep(1);
    touchMove(9, 106, 444)
    mSleep(14);
    touchMove(9, 128, 444)
    mSleep(1);
    touchMove(9, 164, 444)
    mSleep(2);
    touchMove(9, 216, 444)
    mSleep(1);
    touchMove(9, 268, 440)
    mSleep(49);
    touchMove(9, 398, 432)
    mSleep(1);
    touchMove(9, 468, 426)
    mSleep(15);
    touchMove(9, 542, 422)
    mSleep(18);
    touchMove(9, 616, 414)
    mSleep(16);
    touchUp(9)

    mSleep(1000);
end
------------------end:  func\photo_book\config_fengzhuang.lua-------------------------------------




----------------------begin:  page\main\page_heiping.lua---------------------------------

default_heiping_page = {
    page_name = "heiping_page",
    page_image_path = nil
}

heiping_page = class_base_page:new(default_heiping_page);

--黑屏
local function check_page_heiping( ... )   
  x, y = findMultiColorInRegionFuzzy({ 0x000000, 193, 2, 0x000000, 463, 2, 0x000000, 565, 2, 0x000000, 600, 2, 0x000000, 595, 2, 0x000000, 582, 131, 0x000000, 582, 206, 0x000000, 572, 345, 0x000000, 565, 461, 0x000000, 568, 559, 0x000000, 559, 642, 0x000000, 562, 786, 0x000000, 584, 851, 0x000000, 472, 852, 0x000000, 237, 849, 0x000000, 71, 837, 0x000000, 10, 830, 0x000000, -6, 20, 0x000000, 18, 324, 0x000000, 30, 590, 0x000000, 12, 782, 0x000000, 74, 424, 0x000000, 104, 429, 0x000000, 338, 424, 0x000000, 497, 421, 0x000000, 281, 58, 0x000000, 300, 197, 0x000000, 305, 525, 0x000000, 297, 662, 0x000000, 288, 787, 0x000000, 146, 672, 0x000000, 353, 303, 0x000000, 461, 115, 0x000000, 493, 71, 0x000000, 258, 397, 0x000000, 385, 616, 0x000000, 520, 846, 0x000000 }, 90, 15, 23, 621, 875);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----黑屏界面----");
        return true
    else
        return false
    end
end

local function action_heiping()     --操作
    --激活屏幕
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(1000);
    page_array["page_main"]:enter()
end

--step1
function heiping_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function heiping_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_heiping() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function heiping_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_heiping();     
end

--step3  --最主要的工作都在这个里面
function heiping_page:action()
    return action_heiping();
end

page_array["page_heiping"] =  heiping_page:new()
------------------end:  page\main\page_heiping.lua-------------------------------------




----------------------begin:  page\main\page_main.lua---------------------------------

default_main_page = {
	page_name = "main_page",
	page_image_path = nil
}

main_page = class_base_page:new(default_main_page);

---手机主界面 0
local function check_page_main()
    x, y = findMultiColorInRegionFuzzy({ 0x65FC7F, 62, 4, 0x64FA7E, 74, 13, 0x61F47B, 85, 85, 0x20C23B, 70, 108, 0x03B521, -8, 100, 0x0BB928, 61, 103, 0x08B825, 43, 36, 0x57E46F, 35, 81, 0x26C541, 50, 57, 0x47D65F, 62, 57, 0x47D65F, -21, 90, 0x18BF34, -18, 93, 0x14BD30, 137, 27, 0x1C81F3, 134, 56, 0x1BA0F7, 143, 80, 0x1BBAFA, 187, 88, 0x1AC1FB, 218, 80, 0x1BBAFA, 228, 46, 0x1C96F6, 231, 12, 0x1D73F2, 176, 43, 0xFFFFFF, 221, 41, 0xFFFFFF, 189, 43, 0xFFFFFF, 179, 84, 0x1ABEFA, 164, 45, 0xFFFFFF, 217, 45, 0xFFFFFF, 221, 44, 0xFFFFFF }, 90, 35, 804, 287, 912);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----手机主界面----");
        return true
    else
        return false
    end
end

--微信通知好
local function check_page_hao()
    ddzc(0x007AFF, -6, 23, 0x007AFF, -20, 2, 0x007AFF, 4, 10, 0x007AFF , 90, 310, 569, 334, 592);  --通知好
    if x>0 and y>0 then
        return true
    else
        return false
    end
end

--锁屏界面
local  function check_page_suoping( ... )
    mSleep(500)
    x, y = findMultiColorInRegionFuzzy({ 0x216686, 25, 8, 0x256A8B, 149, 12, 0x285D79, 318, -14, 0x134B65, 101, 423, 0x479DBD, 136, 411, 0x94CDDE, 159, 411, 0x80C8DA, 160, 415, 0x8CCCDE, 407, 392, 0xA3C9D1, 430, 392, 0x5DA2B0, 376, 401, 0x71B1C0, 382, 403, 0xA4C9D4, 419, 403, 0x9EC6D0, 426, 404, 0xA4CAD3, 422, 417, 0xA4D1DF, 431, 417, 0x509CB0, 431, 417, 0x509CB0 }, 90, 195, 505, 626, 942);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true
    else 
        return false
    end
end

--操作电话本
local function action_phone_book_opt() --执行这个页面的操作--
     --关闭微信
    if appRunning("com.tencent.xin") then 
        appKill("com.tencent.xin");
        mSleep(1500);
    end
    cicky(128,834,50);   --点击电话
    mSleep(3000)
    for i=1,10 do
        cicky(350,902,50);  --点击通讯录
        mSleep(1000);
        if page_array["page_suoyoulianxiren"]:quick_check_page() == true then
            page_array["page_suoyoulianxiren"]:enter(); --添加联系人
            break
        end
        mSleep(1000)
    end
end

local  function action_suoping( ... )
        zuohua() ;   --右滑
        page_array["page_main"]:enter(); 
end

--step1 第一步
function main_page:enter()        --进入页面后的动作--
    tongzhi();    --系统通知
    mSleep(500);
	keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(2000);
    if  true == check_page_suoping() then
        return action_suoping();
    elseif true == self.check_page(self) then
    	return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function main_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_main() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function main_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_main()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function main_page:action()
    return action_phone_book_opt();
end

page_array["page_main"] = main_page:new()
--end page_main.lua
------------------end:  page\main\page_main.lua-------------------------------------




----------------------begin:  page\dianhuaben\page_suoyoulianxiren.lua---------------------------------

default_suoyoulianxiren_page = {
	page_name = "suoyoulianxiren_page",
	page_image_path = nil
}

suoyoulianxiren_page = class_base_page:new(default_suoyoulianxiren_page);

local function check_page_suoyoulianxiren( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x1B1B1B, 35, -1, 0xF7F7F7, 100, -2, 0xF7F7F7, 120, -2, 0x000000, 140, 9, 0xF7F7F7, 150, 21, 0xDEDEDE, 110, 27, 0xF0F0F0, 83, 24, 0xF7F7F7, 15, 22, 0xF7F7F7, -8, 19, 0xF7F7F7, 38, 7, 0x000000, 103, 8, 0x000000, 130, 8, 0xF7F7F7, 134, 8, 0xF7F7F7, 358, 2, 0xF7F7F7, 360, 19, 0xF7F7F7, 338, 12, 0xF7F7F7, 356, 6, 0xF7F7F7, 359, 8, 0x007AFF, 339, 5, 0xF7F7F7, 343, 11, 0xF7F7F7, 359, 15, 0xF7F7F7, 71, 799, 0xF7F7F7, 100, 820, 0x248DFE, 101, 830, 0x218BFE, 66, 835, 0x007AFF, 64, 805, 0xF7F7F7, 62, 844, 0x007AFF, 64, 858, 0xF7F7F7, 57, 867, 0xF2F4F7, 59, 874, 0x8BC0FB, 81, 874, 0x70B2FB, 98, 875, 0xEAF0F7, 81, 868, 0x6EB1FB, 67, 868, 0xF7F7F7 }, 90, 235, 70, 603, 947);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----所有联系人界面1----");
        return true;
    else
        x, y = findMultiColorInRegionFuzzy({ 0xF7F7F7, -16, 19, 0xF7F7F7, -33, -2, 0xF7F7F7, -9, -14, 0xF7F7F7, 11, -6, 0x007AFF, 14, 12, 0x007AFF, -7, 30, 0xF7F7F7, -5, 42, 0xDFEAF8, 19, 42, 0x68AEFC, 12, 49, 0xCBE0F8, -20, 50, 0x017AFF, -26, 45, 0x228BFE, 1, 40, 0xF7F7F7, -163, -834, 0xF7F7F7, -153, -830, 0xF7F7F7, -119, -829, 0xF7F7F7, -42, -827, 0xF7F7F7, -13, -827, 0xF7F7F7, -8, -818, 0xF7F7F7, -18, -807, 0xF7F7F7, -65, -805, 0x000000, -120, -804, 0xF7F7F7, -160, -813, 0x000000, -121, -815, 0x000000, -64, -816, 0xF7F7F7, -22, -819, 0xE8E8E8, -17, -819, 0x000000, 192, -822, 0xF7F7F7, 179, -803, 0xF7F7F7, 178, -822, 0xF7F7F7, 193, -822, 0xF7F7F7, 193, -820, 0x007AFF, -94, -739, 0xFFFFFF, -53, -735, 0x939398, -53, -726, 0xF2F2F2, -97, -724, 0xFFFFFF, -100, -727, 0xFFFFFF }, 90, 243, 66, 599, 950);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----所有联系人界面2----");
            return true;
        else
            return false;
        end
    end
end

local function is_exsist_contact( ... ) --在做删除操作的时候。判断是否有通讯录
    -- body
    x, y = findMultiColorInRegionFuzzy({ 0xCCCCCC, 4, 0, 0xFFFFFF, 8, 1, 
        0xCCCCCC, 11, 1, 0xCCCCCC, 15, -2, 
        0xCCCCCC, 20, 1, 0xCCCCCC, 38, 2, 
        0xCCCCCC, 47, 0, 0xCCCCCC }, 
        90, 289, 696, 336, 700);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true;
    else
        return false;
    end
end

local function action_suoyoulianxiren_delete()     --执行这个页面的操作-
    --删除次数 写入nv
    if nv_read_nv_item("Number of contact people") == nil then
        nv_write_nv_item("Number of contact people",0)
    else
        contact = nv_read_nv_item("Number of contact people") - 1 
        nv_write_nv_item("Number of contact people",contact)
    end
    mSleep(500)
    touchDown(5, 532, 278) --点击“名字”
    mSleep(127);
    touchUp(5);
    mSleep(2000);
    if page_array["page_lianxirenxiangqing"]:quick_check_page() == true then
        page_array["page_lianxirenxiangqing"]:enter();
    elseif page_array["page_suoyoulianxiren"]:quick_check_page() == true then
        shanghua();   --上滑
        page_array["page_suoyoulianxiren"]:enter()
    else
        log_info("删除联系人出现错误");
        return page_array["page_main"]:enter()
    end
end

-- local num_add = 200  --添加联系人个数
local function action_suoyoulianxiren_add()     --执行这个页面的操作--
    if nv_read_nv_item("Number of contact people") == nil then
        nv_write_nv_item("Number of contact people",1)
    else
        contact = nv_read_nv_item("Number of contact people") + 1 
        nv_write_nv_item("Number of contact people",contact)
    end
    mSleep(424);
    touchDown(3, 626, 58)    --点击加
    mSleep(68);
    touchUp(3)
    mSleep(1000);
    page_array["page_xinlianxiren"]:enter();
    return true;
end

--step1
function suoyoulianxiren_page:enter()        --进入页面后的动作--
     --关闭微信
    if appRunning("com.tencent.xin") then 
        appKill("com.tencent.xin");
        mSleep(1500);
    end
    if true == self.check_page(self) then
    	return self.action(self)
    else
        --error_info("进入所有联系人 界面错误")
        self:error_handling();
        return false
    end

end

--step2
function suoyoulianxiren_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
         mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_suoyoulianxiren() then 
            return true;
        else  
            try_time = try_time + 1;
        end
    end
    return false;
end

function suoyoulianxiren_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_suoyoulianxiren() ;
end

--step3  --最主要的工作都在这个里面
function suoyoulianxiren_page:action()     --执行这个页面的操作--
    if gongneng == 5.3 then  --删除
        if true == is_exsist_contact() then
            warning_info("联系人已经删完"); 
            mSleep(1000)
            nv_write_nv_item("Number of contact people",0)  --初始化添点联系人次数
            if  nv_read_nv_item("time") ~= nil then
                nv_write_nv_item("time",0)    --初始化时间
            end
            return reset_ms_server();   --复位
        else
            return action_suoyoulianxiren_delete();
        end
    elseif gongneng == 5.2 then --添加
        return action_suoyoulianxiren_add();
    else
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter();
    end
end

page_array["page_suoyoulianxiren"] = suoyoulianxiren_page:new()
--end page_suoyoulianxiren.lua

------------------end:  page\dianhuaben\page_suoyoulianxiren.lua-------------------------------------




----------------------begin:  page\dianhuaben\page_lianxirenxiangqing.lua---------------------------------

default_lianxirenxiangqing_page = {
	page_name = "lianxirenxiangqing_page",
	page_image_path = nil
}

lianxirenxiangqing_page = class_base_page:new(default_lianxirenxiangqing_page);

local function check_page_lianxirenxiangqing( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xF7F7F7, -4, -5, 0xF7F7F7, -8, 22, 0xF4F6F7, -19, 10, 0x53A4FC, 25, -7, 0x5AA7FC, 45, 13, 0xF7F7F7, 23, 3, 0xF7F7F7, 61, -5, 0x017AFF, 68, 14, 0xF7F7F7, 52, 2, 0xF7F7F7, 89, -10, 0xF7F7F7, 100, 9, 0xF7F7F7, 116, 6, 0xF7F7F7, 132, -6, 0x007AFF, 142, 21, 0xF7F7F7, 126, 9, 0xF7F7F7, 162, -6, 0xF7F7F7, 575, 5, 0x007AFF, 571, 9, 0x67AEFC, 560, -7, 0xE9EFF7, 538, -7, 0x007AFF, 541, 4, 0x1584FE, 528, 8, 0x4BA0FD, 294, 7, 0xF7F7F7, 245, 2, 0xF7F7F7 }, 90, 21, 69, 615, 101);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----联系人详情界面----");
        return true;
    else
        return false;
    end
end


local function action_lianxirenxiangqing_delete()   
    cicky(600, 42,50)  --点击编辑
    mSleep(1500);
    page_array["page_shanchulianxiren"]:enter();
end

--step1
function lianxirenxiangqing_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
    	return self.action(self)
    else
        --error_info("进入联系人详情 界面错误")
        self:error_handling();
        return false
    end

end

--step2
function lianxirenxiangqing_page:check_page()  --检查是否是在当前页面--
    print("lianxirenxiangqing_page:check_page");
    --print(self.page_name)
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_lianxirenxiangqing() then 
            return true;
        else          
            try_time = try_time + 1;
        end
    end
    return false;
end

function lianxirenxiangqing_page:quick_check_page()  --检查是否是在当前页面--
    return check_page_lianxirenxiangqing()
end

--step3  --最主要的工作都在这个里面,做删除联系人的操作
function lianxirenxiangqing_page:action()
    if gongneng == 5.3 then 
        return action_lianxirenxiangqing_delete();
    elseif gongneng == 5.2 then
        cicky(80,80,50);  --返回
        mSleep(1000);
        return page_array["page_suoyoulianxiren"]:enter()
    else
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter();
    end
end

page_array["page_lianxirenxiangqing"] = lianxirenxiangqing_page:new()

------------------end:  page\dianhuaben\page_lianxirenxiangqing.lua-------------------------------------




----------------------begin:  page\dianhuaben\page_xinlianxiren.lua---------------------------------

default_xinlianxiren_page = {
	page_name = "xinlianxiren_page",
    myindex = 1;
	page_image_path = nil
}

xinlianxiren_page = class_base_page:new(default_xinlianxiren_page);

local function check_page_xinlianxiren( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xECF1F7, -9, 15, 0x007AFF, 11, 25, 0x1986FE, 5, 19, 0xF7F7F7, 39, 5, 0xA0CBFA, 42, 22, 0xF7F7F7, 28, 17, 0x53A3FC, -215, 19, 0xF7F7F7, -236, 15, 0xF7F7F7, -285, 11, 0x000000, -311, 11, 0x000000, -311, 24, 0xEEEEEE, -225, 25, 0x272727, -500, 13, 0xF7F7F7, -529, 10, 0xF7F7F7, -550, 10, 0xF7F7F7, -528, 20, 0xF7F7F7, -486, 25, 0xF7F7F7, -496, 23, 0x007AFF }, 90, 25, 69, 617, 94);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----新增联系人界面----");
         return true
     else
        return false
    end
end

local function action_xinlianxiren_add()     --添加新的联系人--
    my_name, my_number = generate_contact_info(); --产生随机的信息
    touchDown(1, 550, 164)   ---点击名字
    mSleep(82);
    touchUp(1)
    mSleep(1800);
    --设置名字
    if tonumber(strategy[1]) == 1 then  --策略一  地区性加粉
        inputText(my_name);
        mSleep(1000); 
    elseif tonumber(strategy[1]) == 2 then  --策略二  精确加粉
        inputText(name())
        mSleep(1000)
    else
        warning_info("策略没设置好,使用随机姓名");
        inputText(name)
        mSleep(1500)
    end
    rotateScreen(0);
    mSleep(786);
    touchDown(8, 358, 382)
    mSleep(63);
    touchMove(8, 350, 372)
    mSleep(50);
    touchMove(8, 350, 360)
    mSleep(2);
    touchMove(8, 352, 340)
    mSleep(1);
    touchMove(8, 354, 322)
    mSleep(7);
    touchMove(8, 358, 306)
    mSleep(35);
    touchMove(8, 362, 290)
    mSleep(17);
    touchMove(8, 364, 276)
    mSleep(1);
    touchMove(8, 366, 264)
    mSleep(9);
    touchMove(8, 368, 252)
    mSleep(23);
    touchMove(8, 372, 242)
    mSleep(16);
    touchMove(8, 374, 234)
    mSleep(10);
    touchMove(8, 376, 228)
    mSleep(52);
    touchMove(8, 380, 222)
    mSleep(2);
    touchMove(8, 382, 216)
    mSleep(1);
    touchMove(8, 384, 212)
    mSleep(19);
    touchMove(8, 388, 208)
    mSleep(16);
    touchMove(8, 390, 202)
    mSleep(8);
    touchMove(8, 392, 196)
    mSleep(46);
    touchMove(8, 392, 192)
    mSleep(2);
    touchMove(8, 394, 186)
    mSleep(1);
    touchMove(8, 394, 182)
    mSleep(39);
    touchMove(8, 396, 178)
    mSleep(7);
    touchMove(8, 396, 174)
    mSleep(1);
    touchMove(8, 398, 170)
    mSleep(30);
    touchMove(8, 398, 164)
    mSleep(16);
    touchMove(8, 400, 158)
    mSleep(19);
    touchMove(8, 400, 152)
    mSleep(1);
    touchMove(8, 402, 148)
    mSleep(12);
    touchMove(8, 402, 144)
    mSleep(18);
    touchMove(8, 402, 140)
    mSleep(67);
    touchMove(8, 404, 136)
    mSleep(1);
    touchMove(8, 404, 132)
    mSleep(3);
    touchMove(8, 406, 126)
    mSleep(1);
    touchMove(8, 408, 122)
    mSleep(8);
    touchMove(8, 408, 118)
    mSleep(21);
    touchMove(8, 410, 114)
    mSleep(17);
    touchMove(8, 410, 114)
    mSleep(9);
    touchMove(8, 412, 112)
    mSleep(35);
    touchMove(8, 412, 112)
    mSleep(11);
    touchMove(8, 412, 112)
    mSleep(18);
    touchMove(8, 412, 110)
    mSleep(31);
    touchMove(8, 414, 110)
    mSleep(16);
    touchMove(8, 416, 106)
    mSleep(37);
    touchUp(8)

    mSleep(1000);
    touchDown(2, 382, 278)  --点击电话
    mSleep(127);
    touchUp(2)
    mSleep(1000);
   --设置电话号码
   if tonumber(strategy[1]) == 1 then  --策略一  地区性加粉
        inputText(my_number);
        mSleep(1032); 
    elseif tonumber(strategy[1]) == 2 then  --策略二  精确加粉
        phone_weixin(text_phone_weixin);
        mSleep(1032); 
    else
        warning_info("策略没设置好,使用随机号码");
        inputText(math.random(13014517812,13378659123));
    end
    mSleep(500)
    touchDown(4, 628, 60)   --点击完成
    mSleep(179);
    touchUp(4)
    log_info("增加联系人一次");
    mSleep(2000)
    return true
    -- return page_array["page_lianxirenxiangqing"]:enter();
end
--step1

function xinlianxiren_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
    	return self.action(self)
    else
        --error_info("进入新联系人 界面错误")
        self:error_handling();
    	return false
    end
end

--step2
function xinlianxiren_page:check_page()  --检查是否是在当前页面--
    print("xinlianxiren_page:check_page");
    --print(self.page_name)
--    return check_page();
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xinlianxiren() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function xinlianxiren_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_xinlianxiren();     
end

--step3  --最主要的工作都在这个里面
function xinlianxiren_page:action()
    if gongneng == 5.2 then
        return action_xinlianxiren_add();
    else
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter();
    end
end

page_array["page_xinlianxiren"] =  xinlianxiren_page:new()

--end page_xinlianxiren.lua
------------------end:  page\dianhuaben\page_xinlianxiren.lua-------------------------------------




----------------------begin:  page\dianhuaben\page_shanchulianxiren.lua---------------------------------
--begin page_shanchulianxiren.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

default_shanchulianxiren_page = {
    page_name = "shanchulianxiren_page",
    page_image_path = nil
}

shanchulianxiren_page = class_base_page:new(default_shanchulianxiren_page);

local function check_page_shanchulianxiren( ... )
   x, y = findMultiColorInRegionFuzzy({ 0x7FBAFB, -21, -9, 0x1685FE, -50, -12, 0x70B2FB, -52, 3, 0xF7F7F7, -45, -5, 0xF7F7F7, -18, 3, 0xF7F7F7, -5, -12, 0xA7CEFA, -589, -16, 0x69AFFC, -575, 0, 0x007AFF, -591, -6, 0xF7F7F7, -586, 8, 0x007AFF, -559, -17, 0xF7F7F7, -561, 2, 0xF7F7F7, -557, 11, 0xF7F7F7, -543, 7, 0xF7F7F7, -549, -12, 0xB9D7F9, -532, 1, 0xF7F7F7 }, 90, 25, 69, 616, 97);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----删除联系人详情界面----");
        return true;
    else
        return false;
    end
end


local function action_shanchulianxiren_delete()     --执行这个页面的操作--
    -----------滑倒最下面----
    xiahua()
    xiahua()
    xiahua()
    mSleep(1000)
    touchDown(1, 294, 722) --删除联系人
    mSleep(100);
    touchUp(1)
    mSleep(1500);  ---确认删除
    touchDown(9, 426, 792)
    mSleep(71);
    touchUp(9)
    mSleep(1500);
    if page_array["page_suoyoulianxiren"]:check_page() == true then
        log_info("删除联系人一次");
        return page_array["page_suoyoulianxiren"]:action();
    else
        cicky(350,902,50);  --点击通讯录
        mSleep(1500);
        cicky(350,902,50);  --点击通讯录
        mSleep(1000);
        return page_array["page_suoyoulianxiren"]:enter();
    end
end

--step1
function shanchulianxiren_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        --error_info("进入所有联系人 界面错误")
        self:error_handling();
        return false
    end

end

--step2
function shanchulianxiren_page:check_page()  --检查是否是在当前页面--
    print("shanchulianxiren_page:check_page");
    local try_time = 1
    while 3 > try_time do
         mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_shanchulianxiren() then 
            return true;
        else  
            try_time = try_time + 1;
        end
    end
    return false;
end

function shanchulianxiren_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_shanchulianxiren() ;
end

--step3  --最主要的工作都在这个里面
function shanchulianxiren_page:action()     --执行这个页面的操作--
    if gongneng == 5.3 then  --删除
        return action_shanchulianxiren_delete() ;
    else
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter();
    end
end

page_array["page_shanchulianxiren"] = shanchulianxiren_page:new()
--end page_shanchulianxiren.lua

------------------end:  page\dianhuaben\page_shanchulianxiren.lua-------------------------------------




----------------------begin:  func\photo_book\book_main.lua---------------------------------
--文件以"func_" 开头,说明是一个功能性的脚本
--此功能是： 微信修改头像 签名 名字


function  phone_weixin(a)   --读取文本电话号或微信 读一行 删一行
    kong();
    shengcheng() ;     --生成文件
    local t={};
    local file=io.open(a);
    for line in file:lines() do
    table.insert(t,line);
    end
    inputText(table.remove(t,1))
    local file=io.open(a,"w");
    for i,j in ipairs(t) do
    file:write(j,'\n');
    end
    file:close(); 
end                 
 
 --判断文件是不是空的
function  kong()
    if true == file_exists(text_phone_weixin) then
        local t={};
        local file=io.open(text_phone_weixin);
        for line in file:lines() do
        table.insert(t,line);
        end
        if table.remove(t,1) == nil then
            warning_info("电话号码已空,重新生成文件,请尽快更换新的电话号码");
            os.execute("rm -rf "..text_phone_weixin);
        end
    end
end

--生产文件
function  shengcheng()
    if false == file_exists(text_phone_weixin) then
        for i , v in pairs(phone_num) do
            print (v)
            os.execute("touch "..text_phone_weixin);
            local f = io.open(text_phone_weixin, 'a');
            f:write(v .. "\r\n");
            f:close();
        end 
    end
end

--下载图片
function xiazai()
    os.execute("rm -rf ".."/var/touchelf/photo");
    os.execute("mkdir ".."/var/touchelf/photo");
    for i=1,9 do
        if photo[i] ~= nil then
            flag = ftpGet("ftp://120.76.215.162/photo/"..photo[i],"/var/touchelf/photo/"..photo[i], "zhang", "H11111111h");
        end
    end
end

--随机姓名
function  name()
    return string.char(math.random(0xe5,0xe8))..string.char(math.random(0x80,0xbf))..string.char(math.random(0x80,0xbf))
    ..math.random(0,100);
end

function generate_contact_info() --产生随机号码
    local  x = math.random(9999);
    local  xx = pre_fix_phone_numb[math.random(#pre_fix_phone_numb)]
    x = (tonumber(xx) * 10000) + x

    local  y = tostring(x)
    y = string.sub(y, -3, -1)

    local my_name = pre_fix_name[math.random(#pre_fix_name)] .. y
    x = tostring(x)
    --print(x)
    --print(my_name)
    return my_name, x;
    -- body
end

function book_main() --微信主函数
    w,h = getScreenResolution();                  -- 将屏幕宽度和高度分别保存在变量w、h中
   -- notifyMessage(string.format("%d,%d\n", w,h)); -- 将宽度和高度用提示框显示到屏幕上
    ---mSleep(10000);
	logFileInit(sl_log_file);
    math.randomseed(tostring(os.time()):sub(5):reverse());   --随机种子
    local current_page = get_current_page(); --得到当前的page
    if false ~= current_page then 
       page_array[current_page]:enter(); --直接进当前页面的处理
    else
	   page_array["page_main"]:enter();
    end
end

--功能性脚本的入口程序，使用dofile调用
--在调试的时候，使用main函数封装，才能运行

    -- body
    book_main();



------------------end:  func\photo_book\book_main.lua-------------------------------------
