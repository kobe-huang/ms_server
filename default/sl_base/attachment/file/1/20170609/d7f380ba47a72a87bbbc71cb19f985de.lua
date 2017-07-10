------------sl_func_wx_jiafen_ip4.lua------------
--                                             --
--                                             --
--170609  18:22:00    luoshui package 
--                                             --
--                                             --
--                                             --
-------------------------------------------------








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
    mSleep(1000)
    local time = get_local_time(); 
    writeStrToFile("fatal error:  " .. time .. out_info , sl_log_file); 
    notifyMessage("致命错误：".. out_info);   
    mSleep(3000);
    --page_array["page_main"]:enter();  --重新开始
    os.execute("reboot");
    --os.exit(1);
end

error_time1 = 10 ;
function error_info(out_info)  ---错误处理函数   
    logFileInit(sl_log_file);
    local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage("错误：" .. out_info);
    mSleep(1200);
    if nil ~= sl_error_time then
        error_time1 = error_time1 - 1;
        if error_time1 <= sl_error_time then
            error_info_exit("错误次数太多,重启设备");
        elseif error_time1 == 5 then
            warning_info("错误5次,继续下一个");
            if appRunning("com.tencent.xin") then 
                appKill("com.tencent.xin");
                mSleep(1500);
            end
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

error_time2 = 10 ;
--输出警告信息到文件
function warning_info(out_info)  ---错误处理函数   
    notifyMessage("警告：" .. out_info);
    mSleep(1200);
    local time = get_local_time(); 
    writeStrToFile("warning:  " .. time .. out_info , sl_log_file);    
    if nil ~= sl_error_time then
        error_time2 = error_time2 - 1;
        if error_time2 <= sl_error_time then
            error_info_exit("警告次数太多,重启设备");
        elseif error_time2 == 5 then
            warning_info("警告5次,继续下一个");
            if appRunning("com.tencent.xin") then 
                appKill("com.tencent.xin");
                mSleep(1500);
            end
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
            return network_test()  --测试网络
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




----------------------begin:  func\weixinzong\config_fengzhuang.lua---------------------------------
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
    xx2=math.ceil(x2/640*w);
    yy2=math.ceil(y2/1136*h);
    a1 = getColor(xx1, yy1);
    b1 = getColor(xx2, yy2);    
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
------------------end:  func\weixinzong\config_fengzhuang.lua-------------------------------------




----------------------begin:  page\weixinzong\page_heiping.lua---------------------------------

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
    zuohua();
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
------------------end:  page\weixinzong\page_heiping.lua-------------------------------------




----------------------begin:  page\weixinzong\page_main.lua---------------------------------

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

--打开微信
local function action_weixin() --执行这个页面的操作--
    if appRunning("com.tencent.xin") then 
        appRun("com.tencent.xin");    --打开微信
        mSleep(math.random(3000,5000))
        local current_page = get_current_page(); --得到当前的page
        if false ~= current_page then 
           page_array[current_page]:enter(); --直接进当前页面的处理
        end
    else
        appRun("com.tencent.xin");    --打开微信
        mSleep(math.random(8000,12000))
        for i=1,10 do
            ---没通知
            if page_array["page_weixinzhu"]:quick_check_page() == true then
                mSleep(math.random(3000,5000))
                page_array["page_weixinzhu"]:enter(); 
                break
            end
            --有通知
            if check_page_hao() == true then 
                cicky( 320,579,50);   --点击好
                mSleep(math.random(3000,5000))
                page_array["page_weixinzhu"]:enter()
                break
            end
            if i == 10 then
                warning_info("没找到这个界面,重新打开微信");
                mSleep(1000);
                appKill("com.tencent.xin");    ---关闭微信
                mSleep(4000);
                return page_array["page_main"]:enter()
            end
            mSleep(1000);
        end
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
        else
            warning_info("所有联系人界面错误")
        end
        mSleep(1000)
    end
end

--操作照片
local function action_shanchuxiangpian()
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(2000);
    zt(path_zhaopian);
    if x>0 and y>0 then
        cicky(x,y,50);  --点击照片
        mSleep(4000);
    else   --没找到
        mSleep(2000) ;          --等一下
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        zt(path_zhaopian);
        if x>0 and y>0 then
            cicky(x,y,50);  --点击照片
            mSleep(4000);
        else
            warning_info("没找到照片");
            return false
        end
    end
    for i=1,5 do
        cicky( 534,901,50);   --点击相薄
        mSleep(2000);
        if page_array["page_xiangjijiaojuan"]:quick_check_page() == true then
            page_array["page_xiangjijiaojuan"]:enter()
            break
        elseif page_array["page_xiangbao"]:quick_check_page() == true then
            page_array["page_xiangbao"]:enter();
            break
        end
    end
   -- else
   --    warning_info("没找到这个界面,重新打开照片");
   --    page_array["page_xiangbao"]:enter();
   -- end
end

--文件管理器
local function action_ifile( ... )
    xiazai();
    mSleep(1000)
    zt(path_ifile)
    if x>0 and y>0 then
       cicky(x,y,50);
       mSleep(3000);
        if page_array["page_ifile_photo"]:check_page() == true then
             page_array["page_ifile_photo"]:enter()
        else
            cicky( 445,905,50);   --点击主页
            mSleep(1500);
            page_array["page_ifile"]:enter()
        end
    else
        youhua()   --右滑
        zt(path_ifile)
        if x>0 and y>0 then
           cicky(x,y,50);
           mSleep(3000);
            if page_array["page_ifile_photo"]:check_page() == true then
                 page_array["page_ifile_photo"]:enter()
            else
                cicky( 445,905,50);   --点击主页
                mSleep(1500);
                page_array["page_ifile"]:enter()
            end
        else
            warning_info("没找到ifile,请检查");
            return false
        end
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
    if gongneng == 5.2 or gongneng == 5.3 then
        if  nv_read_nv_item("time") == nil then  --次数
            nv_write_nv_item("time",1)           --初始化
        end
        return action_phone_book_opt();
    elseif gongneng == 5.1 then
        return action_shanchuxiangpian();
    elseif gongneng == 3.31 then
        return action_ifile();
    else
        return action_weixin();
    end
end

page_array["page_main"] = main_page:new()
--end page_main.lua
------------------end:  page\weixinzong\page_main.lua-------------------------------------




----------------------begin:  page\weixinzong\page_weixinzhu.lua---------------------------------

default_weixinzhu_page = {
    page_name = "weixinzhu_page",
    page_image_path = nil
}

weixinzhu_page = class_base_page:new(default_weixinzhu_page);

 --微信主界面 1
local function check_page_weixinzhu( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x54C252, 35, 2, 0x28B427, 7, 5, 0xF0F4F0, 30, 5, 0x53C251, 1, 12, 0xAFDFAF, 0, 12, 0x2EB62C, 188, 3, 0xF7F7F7, 206, 4, 0xF7F7F7, 155, 6, 0xF7F7F7, 164, 8, 0xE1E1E1, 346, 5, 0xA4A4A4, 355, 5, 0xF7F7F7, 491, 4, 0xC8C8C8, 511, 8, 0xF7F7F7, 523, -854, 0xFFFFFF, 523, -838, 0xFFFFFF, 518, -852, 0xFFFFFF, 545, -853, 0x121213, 542, -879, 0x111111, 519, -875, 0x111111, 519, -831, 0x131314, 547, -836, 0x131313, -39, -868, 0x111112, 0, -868, 0x111112, 1, -855, 0x121212, -41, -846, 0x121213, 10, -864, 0x111112, 0, -52, 0x1AAD19, 7, -44, 0x1AAD19, 16, -28, 0x1AAD19, -4, -38, 0x1AAD19, 7, -27, 0x1AAD19, 7, -27, 0x1AAD19, -5, -23, 0x1AAD19, -34, -24, 0xF7F7F7, 112, -20, 0xF7F7F7 }, 90, 22, 59, 610, 950);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----微信主界面----");
        return true
    else
        return false
    end
end

--邀请朋友加入微信
local function gouwaihao()
    x, y = findMultiColorInRegionFuzzy({ 0xE7EAF0, 10, 9, 0xFFFFFF, -11, -6, 0xFFFFFF, 42, 11, 0xE2E5EC, 45, 2, 0x576B95, 42, 26, 0xFFFFFF, 31, 3, 0xFFFFFF, 54, -2, 0xFFFFFF, 60, -2, 0xFFFFFF, 106, -1, 0xFFFFFF, 130, 3, 0xFFFFFF, 116, 25, 0xA2ADC4, 57, 25, 0xEBEEF2, 87, 4, 0xFFFFFF, 111, 17, 0xE8EBF0, 137, 22, 0xEAEDF2, 132, 20, 0xF8F9FA, 178, 20, 0xFFFFFF, 185, 11, 0xFFFFFF, 169, 1, 0xFBFBFC, 152, 5, 0x576B95, 236, 2, 0xFFFFFF, 255, 8, 0xFFFFFF, 245, 25, 0x64769D, 222, 15, 0xFFFFFF, 240, 4, 0x576B95, 169, 16, 0xB5BED0, 145, 9, 0xFFFFFF, 141, 4, 0xFFFFFF }, 90, 33, 260, 299, 292);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true
    end
end

local num_huifu = math.random(6,10)         --回复次数

local function action_weixinzhu()     --执行这个页面的操作--
    if gongneng == 2.11 or gongneng == 2.12 or gongneng == 2.2 or gongneng == 2.3 or gongneng ==2.4 or gongneng ==2.5 or gongneng == 2.6 or gongneng == 2.7 then
        cicky( 241,915,50);   --点击通讯录
        mSleep(1000);
        page_array["page_tongxunlu"]:enter();
    elseif gongneng == 3.1 or gongneng == 3.2 or gongneng == 3.3 or gongneng == 3.4 or gongneng == 2.41 or gongneng == 3.5 or gongneng == 3.6 or gongneng == 3.7 then
        cicky( 404,903,50);   --点击发现
        mSleep(1000);
        page_array["page_faxian"]:enter();
    elseif gongneng == 4.1 or gongneng == 4.2 or gongneng == 4.3 then
        cicky( 566,915,50);   --点击我
        mSleep(1000);
        page_array["page_wo"]:enter();
    elseif gongneng == 1.1 then  --智能回复  推送名片
        --搜索
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -3, 9, 0xA5A5A9, -25, -1, 0xFFFFFF, 33, -6, 0xFFFFFF, 60, -5, 0xC3C3C6, 64, -1, 0xB5B5B8, 36, 0, 0x919195, 34, 0, 0x919195, 0, 10, 0xFFFFFF, 72, 18, 0xFFFFFF, 74, 18, 0xFFFFFF, 44, 5, 0xFFFFFF, -13, 3, 0xFFFFFF, -18, 2, 0xFFFFFF }, 90, 270, 163, 369, 187);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            mSleep(1000)
        else
            shanghua();
            mSleep(500)
        end
        if gouwaihao() == true then
            warning_info("没有消息可回复")
            return false
        end
        --暗号语音
        x, y = findMultiColorInRegionFuzzy({ 0xF6E3E3, 4, 0, 0xD87F7F, 19, 0, 0xE3A3A3, 34, 1, 0xE09B9B, 48, 0, 0xFFFFFF, 54, 0, 0xFFFFFF, 60, 8, 0xB71414, 58, 24, 0xE3A3A3, 49, 30, 0xFFFFFF, 30, 30, 0xFFFFFF, 8, 24, 0xFFFFFF, 3, 20, 0xFFFFFF, 22, 12, 0xFFFFFF, 37, 11, 0xE2A1A1, 52, 11, 0xFFFFFF, 60, 10, 0xB71414, 122, 4, 0xFFFFFF, 120, 14, 0xFFFFFF, 16, 20, 0xC54242, 50, 8, 0xBF2E2E, 5, -2, 0xFCF6F6 }, 90, 137, 292, 259, 324);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            gongneng = 1.2   --删除消息
            log_info("不回复新号")
            mSleep(1000)
            return page_array["page_weixinzhu"]:action()
        end
        cicky(67,282,50);    --点击第一个人
        mSleep(4000);
        if page_array["page_liaotian"]:quick_check_page() == true then
            page_array["page_liaotian"]:action()
        elseif page_array["page_tengxunxinwen"]:quick_check_page() == true then
            page_array["page_tengxunxinwen"]:action()
        elseif page_array["page_weixinzhu"]:quick_check_page() == true then
            warning_info("没有可回复的");
            mSleep(500)
            return false  
       -- elseif page_array["page_dingyuehao"]:quick_check_page() == true then
        --   page_array["page_dingyuehao"]:enter()
        elseif page_array["page_qunliaotian"]:quick_check_page() == true then
            --gongneng = "拉人"
            gongneng = "保存"
            return  page_array["page_qunliaotian"]:action()
        else
            log_info("回复点到的不是朋友");
            mSleep(1000)
            cicky(50,85,50);  --返回
            mSleep(2000);
            gongneng = 1.2
            return page_array["page_weixinzhu"]:enter()
        end
    elseif gongneng == 1.4 then  --回复一下  养号
        --搜索
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -3, 9, 0xA5A5A9, -25, -1, 0xFFFFFF, 33, -6, 0xFFFFFF, 60, -5, 0xC3C3C6, 64, -1, 0xB5B5B8, 36, 0, 0x919195, 34, 0, 0x919195, 0, 10, 0xFFFFFF, 72, 18, 0xFFFFFF, 74, 18, 0xFFFFFF, 44, 5, 0xFFFFFF, -13, 3, 0xFFFFFF, -18, 2, 0xFFFFFF }, 90, 270, 163, 369, 187);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            --空的
        else
            shanghua();
            mSleep(500)
        end
        if gouwaihao() == true then
            warning_info("没有消息可回复")
            return false
        end
        if  num_huifu == 0 and strategy[1] == "3" then   --养号
            warning_info("回复次数已到上限")
            mSleep(1000)
            return true
        end
        num_huifu = num_huifu - 1  --回复一次减少一次
        cicky(67,282,50);    --点击第一个人
        mSleep(4000);
        if page_array["page_liaotian"]:quick_check_page() == true then
            page_array["page_liaotian"]:enter()
        elseif page_array["page_tengxunxinwen"]:quick_check_page() == true then
            page_array["page_tengxunxinwen"]:enter()
        elseif page_array["page_weixinzhu"]:quick_check_page() == true then
            warning_info("没有可回复的");
            mSleep(500)
            return false  
        --elseif page_array["page_dingyuehao"]:quick_check_page() == true then
        --    page_array["page_dingyuehao"]:enter()
        elseif page_array["page_qunliaotian"]:quick_check_page() == true then
            gongneng = "保存"
            page_array["page_qunliaotian"]:enter()
        else
            log_info("回复点到的不是朋友");
            mSleep(1000)
            cicky(80,85,50);  --返回
            mSleep(1500);
            gongneng = 1.2
            return page_array["page_weixinzhu"]:enter()
        end
    elseif gongneng == 1.12 then  --随机发消息
       --搜索
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -3, 9, 0xA5A5A9, -25, -1, 0xFFFFFF, 33, -6, 0xFFFFFF, 60, -5, 0xC3C3C6, 64, -1, 0xB5B5B8, 36, 0, 0x919195, 34, 0, 0x919195, 0, 10, 0xFFFFFF, 72, 18, 0xFFFFFF, 74, 18, 0xFFFFFF, 44, 5, 0xFFFFFF, -13, 3, 0xFFFFFF, -18, 2, 0xFFFFFF }, 90, 270, 163, 369, 187);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            --空的
        else
            shanghua();
            mSleep(500)
        end
        mSleep(1000)
        if gouwaihao() == true then
            warning_info("没有消息可回复")
            return false
        end
        local a = math.random(217,858)
        cicky(67,a,50);  --随机点击
        mSleep(4000);
        if page_array["page_liaotian"]:quick_check_page() == true then
            page_array["page_liaotian"]:enter()
        elseif page_array["page_tengxunxinwen"]:quick_check_page() == true then
            page_array["page_tengxunxinwen"]:enter()
        elseif page_array["page_weixinzhu"]:quick_check_page() == true then
            warning_info("没点到");
            local try_time=try_time+1
            if try_time > 3 then
                warning_info("没有消息可回复")
                return false
            end
            page_array["page_weixinzhu"]:enter()
        --elseif page_array["page_dingyuehao"]:quick_check_page() == true then
        --    page_array["page_dingyuehao"]:enter()
      --  elseif page_array["page_qunliaotian"]:quick_check_page() == true then
       --     page_array["page_qunliaotian"]:enter()
        else
            cicky(50,85,50);  --返回 
            mSleep(1500);
            page_array["page_weixinzhu"]:enter()
        end
    elseif gongneng == 1.2 then  --删除信息
        if gong_neng == "邀请" then   --群拉人需要邀请
            --滑动
            rotateScreen(0);
            mSleep(1231);
            touchDown(4, 280, 288)
            mSleep(38);
            touchMove(4, 268, 286)
            mSleep(20);
            touchMove(4, 250, 286)
            mSleep(80);
            touchMove(4, 226, 286)
            mSleep(3);
            touchMove(4, 202, 284)
            mSleep(2);
            touchMove(4, 174, 282)
            mSleep(12);
            touchMove(4, 148, 282)
            mSleep(2);
            touchMove(4, 116, 280)
            mSleep(2);
            touchMove(4, 84, 274)
            mSleep(12);
            touchMove(4, 44, 268)
            mSleep(18);
            touchMove(4, 22, 254)
            mSleep(16);
            touchMove(4, 10, 238)
            mSleep(19);
            touchUp(4)
            mSleep(2000);
            touchDown(3, 574, 268)    --点击删除
            mSleep(104);
            touchUp(3)
            mSleep(5000);
        end
        --滑动
        rotateScreen(0);
        mSleep(1231);
        touchDown(4, 280, 288)
        mSleep(38);
        touchMove(4, 268, 286)
        mSleep(20);
        touchMove(4, 250, 286)
        mSleep(80);
        touchMove(4, 226, 286)
        mSleep(3);
        touchMove(4, 202, 284)
        mSleep(2);
        touchMove(4, 174, 282)
        mSleep(12);
        touchMove(4, 148, 282)
        mSleep(2);
        touchMove(4, 116, 280)
        mSleep(2);
        touchMove(4, 84, 274)
        mSleep(12);
        touchMove(4, 44, 268)
        mSleep(18);
        touchMove(4, 22, 254)
        mSleep(16);
        touchMove(4, 10, 238)
        mSleep(19);
        touchUp(4)
        mSleep(2000);
        touchDown(3, 574, 268)    --点击删除
        mSleep(104);
        touchUp(3)
        mSleep(4000);
        ---群聊删除
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 39, -2, 0xFFFFFF, 39, -2, 0xFFFFFF, 52, -2, 0xFCEBEA, 56, 20, 0xFCEFEF, 46, 21, 0xFFFFFF, 11, 22, 0xED7D7B, 6, 16, 0xEA6563, -1, 6, 0xFADADA, 2, 5, 0xE64340, 33, 5, 0xE64340, 60, 8, 0xFFFFFF, 30, -7, 0xFFFFFF, -13, -5, 0xFFFFFF, 0, 6, 0xFADADA }, 90, 280, 787, 353, 816);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);    --点击删除
            mSleep(2000)
        end
        if strategy[1] == "3"  then
            gongneng = 1.4   --回复一下
        elseif strategy[1] == "1" or strategy[1] == "2" then
            gongneng = 1.1   --发消息去 推送
        else
            warning_info("回复消息错误")
            mSleep(1000)
            return false
        end
        mSleep(1000)
        return page_array["page_weixinzhu"]:action()  --直接做动作
    elseif gongneng == 1.3 then  --遇到订阅号
        --滑动下一个
        rotateScreen(0);
        mSleep(1064);
        touchDown(5, 328, 652)
        mSleep(102);
        touchMove(5, 328, 640)
        mSleep(24);
        touchMove(5, 328, 632)
        mSleep(11);
        touchMove(5, 328, 626)
        mSleep(15);
        touchMove(5, 328, 620)
        mSleep(16);
        touchMove(5, 330, 616)
        mSleep(16);
        touchMove(5, 332, 612)
        mSleep(35);
        touchMove(5, 332, 608)
        mSleep(2);
        touchMove(5, 334, 606)
        mSleep(15);
        touchMove(5, 336, 602)
        mSleep(19);
        touchMove(5, 336, 600)
        mSleep(14);
        touchMove(5, 338, 596)
        mSleep(15);
        touchMove(5, 338, 594)
        mSleep(16);
        touchMove(5, 340, 592)
        mSleep(17);
        touchMove(5, 340, 590)
        mSleep(15);
        touchMove(5, 342, 588)
        mSleep(16);
        touchMove(5, 342, 586)
        mSleep(18);
        touchMove(5, 342, 586)
        mSleep(16);
        touchMove(5, 344, 584)
        mSleep(15);
        touchMove(5, 344, 582)
        mSleep(15);
        touchMove(5, 344, 582)
        mSleep(17);
        touchMove(5, 344, 580)
        mSleep(8);
        touchMove(5, 346, 578)
        mSleep(16);
        touchMove(5, 346, 576)
        mSleep(16);
        touchMove(5, 346, 574)
        mSleep(16);
        touchMove(5, 348, 574)
        mSleep(32);
        touchMove(5, 348, 572)
        mSleep(2);
        touchMove(5, 350, 570)
        mSleep(15);
        touchMove(5, 350, 570)
        mSleep(21);
        touchMove(5, 350, 568)
        mSleep(13);
        touchMove(5, 352, 566)
        mSleep(16);
        touchMove(5, 352, 566)
        mSleep(21);
        touchMove(5, 352, 564)
        mSleep(14);
        touchMove(5, 354, 564)
        mSleep(15);
        touchMove(5, 354, 562)
        mSleep(21);
        touchMove(5, 354, 560)
        mSleep(12);
        touchMove(5, 356, 560)
        mSleep(14);
        touchMove(5, 356, 560)
        mSleep(35);
        touchMove(5, 356, 558)
        mSleep(1);
        touchMove(5, 356, 558)
        mSleep(16);
        touchMove(5, 358, 556)
        mSleep(30);
        touchMove(5, 358, 556)
        mSleep(2);
        touchMove(5, 358, 554)
        mSleep(15);
        touchMove(5, 358, 554)
        mSleep(29);
        touchMove(5, 358, 552)
        mSleep(23);
        touchMove(5, 360, 552)
        mSleep(6);
        touchMove(5, 360, 552)
        mSleep(50);
        touchMove(5, 360, 550)
        mSleep(32);
        touchMove(5, 360, 550)
        mSleep(15);
        touchMove(5, 360, 548)
        mSleep(18);
        touchMove(5, 362, 548)
        mSleep(31);
        touchMove(5, 362, 548)
        mSleep(30);
        touchMove(5, 362, 548)
        mSleep(18);
        touchMove(5, 362, 546)
        mSleep(80);
        touchMove(5, 362, 546)
        mSleep(62);
        touchMove(5, 364, 546)
        mSleep(114);
        touchMove(5, 364, 542)
        mSleep(14);
        touchUp(5)
        mSleep(1000);
        cicky(229,323,50);    --点击第一个人
        mSleep(4000);
        if page_array["page_liaotian"]:quick_check_page() == true then
            page_array["page_liaotian"]:enter()
        elseif page_array["page_tengxunxinwen"]:quick_check_page() == true then
            page_array["page_tengxunxinwen"]:enter()
        elseif page_array["page_weixinzhu"]:quick_check_page() == true then
            warning_info("没有可回复的");
            return false
        --elseif page_array["page_dingyuehao"]:quick_check_page() == true then
        --   gongneng = 1.1  --发消息去
        --    page_array["page_dingyuehao"]:enter()
       -- elseif page_array["page_qunliaotian"]:quick_check_page() == true then
     --       page_array["page_qunliaotian"]:enter()
        else
            mSleep(3000)
            cicky(50,85,50);  --返回
            gongneng = 1.2
            mSleep(2000);
            page_array["page_weixinzhu"]:enter()
        end
    elseif gongneng == 1.5 then  --跟新号发消息
          --搜索
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -3, 9, 0xA5A5A9, -25, -1, 0xFFFFFF, 33, -6, 0xFFFFFF, 60, -5, 0xC3C3C6, 64, -1, 0xB5B5B8, 36, 0, 0x919195, 34, 0, 0x919195, 0, 10, 0xFFFFFF, 72, 18, 0xFFFFFF, 74, 18, 0xFFFFFF, 44, 5, 0xFFFFFF, -13, 3, 0xFFFFFF, -18, 2, 0xFFFFFF }, 90, 270, 163, 369, 187);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            --空的
        else
            shanghua();
            mSleep(1000)
        end
        if gouwaihao() == true then
            warning_info("没有消息可回复")
            return false
        end
        mSleep(500)
        cicky( 285,175,50)  --点击搜索
        mSleep(1500)
        return page_array["page_sousuo"]:enter()
    elseif gongneng == 5.1 or gongneng == 5.2 or gongneng == 5.3 or gongneng == 3.31 then
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter()
    elseif gongneng == "返回" then    --返回微信首界面
        mSleep(math.random(1000,8888))
    else
        warning_info("错误")
        return false
    end
    return true;
end

--step1
function weixinzhu_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function weixinzhu_page:check_page()  --检查是否是在当前页面--
    local time = 0
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_weixinzhu() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function weixinzhu_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_weixinzhu() ;
end

--step3  --最主要的工作都在这个里面
function weixinzhu_page:action()     --执行这个页面的操作--
    return  action_weixinzhu();
end

page_array["page_weixinzhu"] = weixinzhu_page:new()

------------------end:  page\weixinzong\page_weixinzhu.lua-------------------------------------




----------------------begin:  page\weixinzong\page_tongxunlu.lua---------------------------------

default_tongxunlu_page = {
    page_name = "tongxunlu_page",
    myindex = 1;
    page_image_path = nil
}

tongxunlu_page = class_base_page:new(default_tongxunlu_page);

--微信通讯录  2
local function check_page_tongxunlu( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0xCAE9CA, 19, 0, 0xF7F7F7, 35, 1, 0x1AAF18, 42, 1, 0x37B835, 0, 9, 0x3DBA3B, 41, 8, 0xF7F7F7, 44, 8, 0x7ACE79, 20, -52, 0x1AAD19, -3, -29, 0xF7F7F7, 30, -27, 0x1AAD19, 30, -27, 0x1AAD19, -146, -2, 0xC4C4C4, -124, 1, 0xF7F7F7, -124, 1, 0xF7F7F7, 182, 2, 0xF7F7F7, 185, 2, 0xF7F7F7, 193, 2, 0xA0A0A0, 341, 0, 0xC2C2C2, 371, -869, 0xFFFFFF, 364, -853, 0xD7D7D7, 376, -847, 0xFFFFFF, 389, -854, 0x121213, 389, -857, 0xFFFFFF, 389, -857, 0xFFFFFF, 389, -857, 0xFFFFFF, 63, -874, 0xFFFFFF, 108, -874, 0xFFFFFF, 153, -872, 0x111112, 87, -861, 0x121212, 123, -861, 0x6A6A6A, 153, -861, 0xEFEFEF, 81, -851, 0x121213, 126, -851, 0x121213, 139, -851, 0xFFFFFF, 147, -852, 0x121213, 104, -855, 0x121213, 108, -855, 0x121213 }, 90, 70, 69, 605, 952);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----微信通讯录界面----");
        return true
    else
        return false
    end 
end

local function action_tongxunlu()     --操作
    --搜索
    x, y = findMultiColorInRegionFuzzy({ 0xB7B7BA, 22, 1, 0xFFFFFF, 57, 2, 0x98989D, 72, 3, 0xECECED, 80, 5, 0xD2D2D4, 87, 13, 0xFFFFFF, 78, 19, 0xFFFFFF, 54, 13, 0xD8D8D9, 34, 12, 0xFFFFFF, 15, 12, 0xFFFFFF, -2, 8, 0xFFFFFF, 16, 22, 0xA5A5A9, 49, 26, 0xFFFFFF, 78, 20, 0xFFFFFF, 82, 20, 0x8E8E93, 50, 17, 0xFFFFFF }, 90, 262, 159, 351, 185);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        --空的
    else
        shanghua()
        mSleep(1000)
         --搜索
        x, y = findMultiColorInRegionFuzzy({ 0xB7B7BA, 22, 1, 0xFFFFFF, 57, 2, 0x98989D, 72, 3, 0xECECED, 80, 5, 0xD2D2D4, 87, 13, 0xFFFFFF, 78, 19, 0xFFFFFF, 54, 13, 0xD8D8D9, 34, 12, 0xFFFFFF, 15, 12, 0xFFFFFF, -2, 8, 0xFFFFFF, 16, 22, 0xA5A5A9, 49, 26, 0xFFFFFF, 78, 20, 0xFFFFFF, 82, 20, 0x8E8E93, 50, 17, 0xFFFFFF }, 90, 262, 159, 351, 185);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            --空的
        else
            for i=0,50 do
                mSleep(200)
                x,y = findColorInRegion(0x555555, 615,130+10*i,631, 630,140+10*i);
                if x ~= -1 and y ~= -1 then  -- 如果找到了 
                    touchDown(0,x,y+13);   --点击搜索
                    mSleep(50);
                    touchUp(0);
                    mSleep(1500);
                    break
                end
            end
            x, y = findMultiColorInRegionFuzzy({ 0xB7B7BA, 22, 1, 0xFFFFFF, 57, 2, 0x98989D, 72, 3, 0xECECED, 80, 5, 0xD2D2D4, 87, 13, 0xFFFFFF, 78, 19, 0xFFFFFF, 54, 13, 0xD8D8D9, 34, 12, 0xFFFFFF, 15, 12, 0xFFFFFF, -2, 8, 0xFFFFFF, 16, 22, 0xA5A5A9, 49, 26, 0xFFFFFF, 78, 20, 0xFFFFFF, 82, 20, 0x8E8E93, 50, 17, 0xFFFFFF }, 90, 262, 159, 351, 185);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                ---空的
            else
                shanghua()
            end
        end
    end
    if gongneng == 2.11 or gongneng == 2.12 then   --搜索手机号微信号加好友 --加公众号
        mSleep(1000)
        cicky(  589,86,50);   --点击人头加
        mSleep(1500);
        page_array["page_tianjiapengyou"]:enter();  
    elseif gongneng == 2.2 then  ---通讯录加好友
        mSleep(1000)
        cicky( 184,271,50);   --点击新的朋友
        mSleep(1500);
        page_array["page_xindepengyou"]:enter();
    elseif gongneng == 2.3 then  --微信群加好友
        mSleep(1000)
        cicky(  58,408 ,50);   --点击群聊
        mSleep(1500);       
        page_array["page_qunliao"]:enter();
    elseif gongneng == 2.4 then  --转发朋友圈
        mSleep(1000)
        cicky( 307,172,50);   --点击搜索
        mSleep(2000);    
        page_array["page_sousuo"]:enter();
    elseif gongneng == 2.5 then  --转发文章
        mSleep(1000)
        cicky(58,636,50);
        mSleep(1500);
        if page_array["page_gongzhonghao"]:check_page() == true then
            page_array["page_gongzhonghao"]:enter()
        else
            warning_info("没关注公众号")
            return false
        end
    elseif gongneng == 2.6 then  --随机发信息给好友  养号
        a = math.random(tonumber(num_huadong[1]),tonumber(num_huadong[2]))
        mSleep(1500);
        for i=1,a do
           move( 355,347 ,355,215 ,5);
           mSleep(500)
        end
        local c = 1
        while true do
            mSleep(500)
            local b = math.random(680)
            if c>5 then
                warning_info("发消息错误5次");
                return false
            end
            cicky( 193,170+b,50);    --随机点击好友
            mSleep(2000)
            if page_array["page_txlzl"]:quick_check_page() == true then
                mSleep(2000)
                return page_array["page_txlzl"]:enter()
            elseif page_array["page_tongxunlu"]:quick_check_page() == true then
                move( 355,347 ,355,215 ,5);
                c=c+1
            else
                cicky(  79,85,50);       --点击返回
                mSleep(2000)
                if page_array["page_tongxunlu"]:check_page() == true then
                    move( 355,347 ,355,215 ,5);
                    c=c+1
                else
                    warning_info("随机发消息出现错误");
                    mSleep(1000);
                    return false
                end
            end
        end
    elseif gongneng == 2.7 then  --统计好友数量
        mSleep(1000)
        for i=0,26 do
            mSleep(200)
            x,y = findColorInRegion(0x555555,618,840-28*i,631,857-28*i);
            if x ~= -1 and y ~= -1 then  -- 如果找到了 
                touchDown(0,x,y+3);  --点击#
                mSleep(50);
                touchUp(0);
                mSleep(1500);
                break
            end
        end
        while true do
            mSleep(1000)
            a = getColor(  40,182 );
            b = getColor(   46,256 );
            c = getColor(   53,372 )
            d = getColor(  58,485  )
            e = getColor(   50,584 )
            xiahua()
            mSleep(1500)
            a2 = getColor(  40,182 );
            b2 = getColor(   46,256 );
            c2 = getColor(   53,372 );
            d2 = getColor(  58,485  );
            e2 = getColor(   50,584  );
            mSleep(500)
            if a == a2 and b == b2 and c == c2 and d == d2 and e == e2 then
                break
            end
        end
        mSleep(1000)
        --1000+人数
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 12, 2, 0xFFFFFF, 58, 3, 0xFFFFFF, 66, 3, 0xC3C3C3, 97, 0, 0xFFFFFF, 101, 0, 0xFFFFFF, 111, 10, 0xFFFFFF, 112, 22, 0x898989, 109, 22, 0xFFFFFF, 72, 21, 0xFFFFFF, 35, 25, 0x808080, 5, 28, 0xFFFFFF, -9, 21, 0xCDCDCD, -9, 4, 0xA8A8A8, -6, 4, 0xFFFFFF, 48, 7, 0xFFFFFF, 73, 10, 0xFDFDFD, 96, 13, 0xFFFFFF, 110, 10, 0xFFFFFF, 94, 24, 0xB8B8B8, 37, 23, 0x868686, 15, 23, 0xE4E4E4, -1, 22, 0xFFFFFF, -6, 4, 0xFFFFFF, 13, 1, 0xFFFFFF, 63, -2, 0xFFFFFF, 88, -2, 0xFFFFFF, 103, -1, 0x808080 }, 90, 296, 797, 417, 827);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            -- notifyMessage(111)
            mSleep(1000)
            code = localOcrText("/var/touchelf/tessdata","eng",  -- 识别数字
                  200,798 , 280,829 , "0123456789"  )                                 
            if code == "" then
                warning_info("识别失败或者没有识别包1");
            else
                warning_info(string.format("识别成功1: %s", code));
            end
        else
            --100+
            x, y = findMultiColorInRegionFuzzy({ 0x808080, 95, 0, 0xFFFFFF, 95, 0, 0xFFFFFF, 111, 9, 0xFFFFFF, 120, 13, 0xFFFFFF, 118, 26, 0xE7E7E7, 65, 28, 0xFFFFFF, 17, 34, 0xFFFFFF, -5, 30, 0xFFFFFF, -8, 15, 0xFFFFFF, -2, 15, 0xB6B6B6, 42, 15, 0xA6A6A6, 98, 15, 0xFFFFFF, 103, 9, 0xFFFFFF, 49, 6, 0x949494, 38, 6, 0xFFFFFF, 73, 10, 0x808080, 125, 9, 0xFFFFFF }, 90, 282, 797, 415, 831);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                -- notifyMessage(222)
                mSleep(1000)
                code = localOcrText("/var/touchelf/tessdata","eng",  -- 识别数字
                       213,793  ,  279,833  , "0123456789"  )                                 
                if code == "" then
                    warning_info("识别失败或者没有识别包2");
                else
                    warning_info(string.format("识别成功2: %s", code));
                end
            else
                --10+
                -- notifyMessage(333)
                mSleep(1000)
                code = localOcrText("/var/touchelf/tessdata","eng",  -- 识别数字
                     232,796 , 271,826, "0123456789"  )                                 
                if code == "" then
                    warning_info("识别失败或者没有识别包3");
                else
                    warning_info(string.format("识别成功3: %s", code));
                end
            end
        end
        local time_1 = get_local_time();    --获取本地时间
        ---写入信息
        track_write_record_item(time_1.."Number of friends",code);   
        mSleep(1000)
        --[[
        ---创建文件夹
        file_path = strip_file_name(sl_wx_count)
        if file_exists(file_path) ==false then
            os.execute("mkdir -p " .. file_path)
        end
        ---创建文件
        if file_exists(sl_wx_count) == false then
            os.execute("touch " .. sl_wx_count)
        end
        time = get_local_time()    --获取时间
        writeStrToFile(time.."好友数量:"..code,sl_wx_count)   --存入文件
        --]]
    elseif gongneng == 3.1 or gongneng == 3.2 or 
        gongneng == 3.3 or gongneng == 3.4 or gongneng == 2.41 or gongneng == 3.5 or gongneng == 3.6 or gongneng == 3.7 then
        cicky( 404,903,50);   --点击发现
        mSleep(1500);
        page_array["page_faxian"]:enter();
    elseif gongneng == 4.1 or gongneng == 4.2 or gongneng == 4.3 then
        cicky( 566,915,50);   --点击我
        mSleep(1500);
        page_array["page_wo"]:enter();
    elseif gongneng == 1.1 or gongneng == 1.12 or gongneng == 1.4 or gongneng == 1.5  then   --回复
        cicky(  81,911,50);  --点击微信
        mSleep(1500);
        page_array["page_weixinzhu"]:enter()
    elseif gongneng == 5.1 or gongneng == 5.2 or gongneng == 5.3 or gongneng == 3.31 then
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter()
    elseif gongneng == "返回" then    --返回微信首界面
        mSleep(math.random(1000,8888))
    else
        warning_info("错误")
        return false
    end
    return true;
end

--step1
function tongxunlu_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function tongxunlu_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_tongxunlu() then 
            return true;
        else
            time = time + 1;
        end
    end
    return false;
end

function tongxunlu_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_tongxunlu();     
end

--step3  --最主要的工作都在这个里面
function tongxunlu_page:action()
    return action_tongxunlu();
end

page_array["page_tongxunlu"] =  tongxunlu_page:new()
------------------end:  page\weixinzong\page_tongxunlu.lua-------------------------------------




----------------------begin:  page\weixinzong\page_faxian.lua---------------------------------

default_faxian_page = {
    page_name = "faxian_page",
    page_image_path = nil
}

faxian_page = class_base_page:new(default_faxian_page);

 --发现 3
local function check_page_faxian( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x111111, 42, 3, 0x111112, 60, 3, 0x111112, 23, 14, 0x5A5A5A, 77, 14, 0x121112, 77, 14, 0x121112, 15, 27, 0x424243, 56, 27, 0xFFFFFF, 72, 27, 0x121213, 75, 28, 0x121213, -237, 9, 0x111112, -193, 21, 0x121213, -261, 22, 0x121213, -255, 20, 0x121212, 285, 11, 0x111112, 320, 22, 0x121213, 301, 40, 0x131313, 269, 25, 0x121213, 304, 20, 0x121212, 94, 874, 0xF7F7F7, 123, 877, 0xF7F7F7, 129, 883, 0x61C660, 97, 887, 0xF7F7F7, 98, 878, 0x20B11E, 136, 890, 0xF7F7F7, 95, 820, 0x3EBA3D, 115, 823, 0x1AAD19, 125, 839, 0x1AAD19, 124, 846, 0x1AAD19, 108, 845, 0x1AAD19, 97, 835, 0x1AAD19, 94, 829, 0x1AAD19, 108, 844, 0x1AAD19, 116, 845, 0x1AAD19 }, 90, 27, 64, 608, 954);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----微信发现界面----");
        return true
    else
        return false
    end
end

local function action_faxian()     --执行这个页面的操作--
    if gongneng == 3.1 or gongneng == 3.4 then   --打招呼   站街扫街
        ---附近的人
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 25, 6, 0xFFFFFF, 8, 35, 0x10AEFF, -9, 23, 0xEAF8FF, 26, 7, 0xFFFFFF, 37, 27, 0xFFFFFF, 53, 32, 0xFFFFFF, 89, 32, 0xFFFFFF, 102, 22, 0xFFFFFF, 77, 10, 0xFFFFFF, 87, 26, 0xFFFFFF, 123, 22, 0xFFFFFF, 116, 7, 0xFFFFFF, 118, 29, 0x3D3D3D, 154, 35, 0x000000, 168, 23, 0xFFFFFF, 142, 5, 0xFFFFFF, 149, 27, 0x5A5A5A, 197, 25, 0xFFFFFF, 192, 6, 0xFFFFFF, 173, 23, 0xFFFFFF, 188, 18, 0xFFFFFF, 112, 8, 0xFFFFFF, 39, 7, 0xFFFFFF, 167, 14, 0xFFFFFF, 163, 46, 0xFFFFFF, 26, 40, 0xFFFFFF, 13, 36, 0xFFFFFF }, 90, 42, 522, 248, 568);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            mSleep(200)
        else 
            warning_info("附近的人功能关闭")
            return false
        end
        gong_neng = gongneng       --保存一下
        shanghua();  --向上滑动
        mSleep(1000); 
        if gps_x ~= nil or gps_y ~= nil then
            gps=math.random(#gps_x)
            fakeGPS("com.tencent.xin" ,tonumber(gps_x[gps]),tonumber(gps_y[gps]));  -- 将微信的GPS地理位置伪装为指定纬度和经度
        end
        mSleep(1000); 
        cicky(199,543,50);    --附近的人
        mSleep(4000)
        --知道了.bmp
        x, y = findMultiColorInRegionFuzzy({ 0xF9F7FA, 0, 26, 0x0BBB09, 8, 6, 0xF9F7FA, 14, 6, 0xF9F7FA, 21, 28, 0xF9F7FA, 47, 13, 0x29C328, 54, 20, 0xF9F7FA, 37, 23, 0x09BB07, 37, 23, 0x09BB07, 80, 1, 0x09BB07, 85, 18, 0xA9E3AA, 84, 25, 0x09BB07 }, 90, 272, 747, 357, 775);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);   --点击知道了
            mSleep(4000);
        end
        --访问位置.bmp
        x, y = findMultiColorInRegionFuzzy({ 0x067DFF, -1, 17, 0x007AFF, 14, 0, 0x007AFF, 10, 20, 0xF3F3F3, 18, 9, 0xF3F3F3, 33, 9, 0xF3F3F3 }, 90, 446, 646, 480, 666);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);   --点击好
            mSleep(3000)
        end
        --有人打招呼.bmp
        x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, 57, 8, 0xFFFFFF, 86, 9, 0x1AAD19, 116, 11, 0x1AAD19, 170, 15, 0x1AAD19, 200, 12, 0xFFFFFF, 234, 10, 0x1AAD19, 291, 7, 0x1AAD19, 234, 36, 0x1AAD19, 135, -14, 0x1AAD19 }, 90, 186, 748, 477, 798);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);  ---点击查看附近的人
            mSleep(1000);
            if strategy[1] ~= "3" then
                gongneng = 3.12    ---接受朋友请求去
            end
        end
        mSleep(3000);
        for i=1,10 do
            local  m = math.random(3,8);
            if  page_array["page_fujinderen"]:quick_check_page() == true then
                mSleep(2000)
                if gongneng == 3.1 then
                    for i=1,m do
                        n = math.random(40,400)
                        o = math.random(300,400)
                        p = math.random(450,600) 
                        move( n,p, n,o,5)
                        mSleep(math.random(500,1500))
                    end
                end
                return page_array["page_fujinderen"]:action();  --直接做动作
            end
            if i == 10 then
                warning_info("进入附近的人时网络卡");
                return false
            end
            mSleep(1000)
        end
    elseif gongneng == 3.2 then    ---漂流瓶
        shanghua();  --向上滑动
        ---进入漂流瓶
        x, y = findMultiColorInRegionFuzzy({ 0x9BDEFF, -21, 18, 0x10AEFF, -16, 24, 0x10AEFF, -19, 38, 0xFFFFFF, 49, 1, 0x151515, 57, 28, 0xFFFFFF, 67, 7, 0x000000, 98, 6, 0xFFFFFF, 100, 23, 0xFFFFFF, 129, 23, 0x000000, 131, 4, 0x000000, 133, 14, 0x000000 }, 90, 46, 618, 200, 656);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);
            mSleep(1500);
            page_array["page_jianpingzi"]:enter();
        else  ---没开启
             cicky( 560,909);   --点击我
             mSleep(2000);
             gongneng = 3.21 ;         ---去打开漂流瓶
             page_array["page_wo"]:enter();
        end
    elseif gongneng == 3.3 or gongneng == 2.41 or gongneng == 3.5 or gongneng == 3.6 or gongneng == 3.7 then    --朋友圈
        shanghua();  --向上滑动
        cicky( 297,209,50);     
        mSleep(3000);
        ---是不是第一次打开
         x, y = findMultiColorInRegionFuzzy({ 0xF9F7FA, 54, -7, 0xF9F7FA, 87, -7, 0xF9F7FA, 78, 23, 0xF9F7FA, 23, 17, 0xF9F7FA, 45, 10, 0xF9F7FA, 10, 3, 0x7CCD7C }, 90, 269, 652, 356, 682);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
           cicky(x,y,50); --点击知道了
           mSleep(2000);
        end     
        page_array["page_pengyouquan"]:enter();
    elseif gongneng == 1.1 or gongneng == 1.12 or gongneng == 1.4 or gongneng == 1.5 then   --回复
        cicky(  81,911,50);  --点击微信
        mSleep(1500);
        page_array["page_weixinzhu"]:enter()
    elseif gongneng == 2.11 or gongneng == 2.12 or gongneng == 2.2 or gongneng == 2.3 or gongneng ==2.4 or gongneng == 2.5 or gongneng == 2.6  or gongneng == 2.7 then
        cicky( 241,915,50);   --点击通讯录
        mSleep(2000);
        page_array["page_tongxunlu"]:enter();
    elseif gongneng == 4.1 or gongneng == 4.2 or gongneng == 4.3 then
        cicky( 566,915,50);   --点击我
        mSleep(2000);
        page_array["page_wo"]:enter();
    elseif gongneng == 5.1 or gongneng == 5.2 or gongneng == 5.3 or gongneng == 3.31 then
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter()
    elseif gongneng == "返回" then    --返回微信首界面
        mSleep(math.random(1000,8888))
    else
        warning_info("错误")
        return false
    end
    return true 
end

--step1
function faxian_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function faxian_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_faxian() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function faxian_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_faxian() ;
end

--step3  --最主要的工作都在这个里面
function faxian_page:action()     --执行这个页面的操作--
    return  action_faxian();
end

page_array["page_faxian"] = faxian_page:new()

------------------end:  page\weixinzong\page_faxian.lua-------------------------------------




----------------------begin:  page\weixinzong\page_wo.lua---------------------------------

default_wo_page = {
    page_name = "wo_page",
    page_image_path = nil
}

wo_page = class_base_page:new(default_wo_page);

 --我 4
local function check_page_wo( ... )
   x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, -14, 24, 0x1AAD19, 15, 21, 0x1AAD19, 0, 26, 0x1AAD19, 7, 57, 0xF7F7F7, 5, 46, 0x1DB01B, 2, 46, 0xA6DDA5, -172, 55, 0xBFBFBF, -156, 56, 0xB0B0B0, -146, 54, 0xCACACA, -152, 50, 0xF4F4F4, -172, 46, 0xF0F0F0, -167, -10, 0xF7F7F7, -154, 1, 0x7A7E83, -165, 6, 0xC6C8CA, -156, 18, 0xF7F7F7, -142, 16, 0xD4D6D7, -326, 3, 0xF7F7F7, -321, 25, 0xF7F7F7, -309, 30, 0xF7F7F7, -343, 48, 0xF4F4F4, -298, 57, 0xCBCBCB, -305, 50, 0xE7E7E7, -357, 45, 0xF7F7F7, -336, 49, 0x999999, -311, 49, 0xF7F7F7, -297, 49, 0xF7F7F7, -484, 52, 0xB7B7B7, -463, 52, 0xEBEBEB, -488, 49, 0xC2C2C2, -492, 49, 0xD0D0D0, -476, -1, 0xF7F7F7, -498, 22, 0xF7F7F7, -454, 25, 0xF7F7F7, -472, 8, 0xF7F7F7, -472, 8, 0xF7F7F7 }, 90, 62, 883, 575, 950);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----微信我界面----");
        return true
    else
        return false
    end
end

local function action_wo()     --执行这个页面的操作--
    if gongneng == 2.11 or gongneng == 2.12 or gongneng == 2.2 or gongneng == 2.3 or gongneng ==2.4 or gongneng == 2.5 or gongneng == 2.6 or gongneng == 2.7 then
        cicky( 241,915,50);   --点击通讯录
        mSleep(1500);
        page_array["page_tongxunlu"]:enter();
    elseif gongneng == 3.1 or gongneng == 3.2 or gongneng == 3.3 or gongneng == 3.4 or gongneng == 3.5 or gongneng == 2.41 or gongneng == 3.6 or gongneng == 3.7 then
        cicky( 404,903,50);   --点击发现
        mSleep(1500);
        page_array["page_faxian"]:enter();
    elseif gongneng == 4.1 then  --修改头像签名名字
        shanghua();  --向上滑动
        cicky(  89,282,50);    --点击自己
        mSleep(1500);
        page_array["page_gerenxinxi"]:enter();
    elseif gongneng == 4.2 or gongneng == 4.3 or gongneng == 3.21 then  --清理缓存
        xiahua();   --向下滑动
        cicky(73,756,50);   --点击设置
        mSleep(1500);
        page_array["page_shezhi"]:enter();
    elseif gongneng == 1.1 or gongneng == 1.12 or gongneng == 1.4 or gongneng == 1.5  then  --回复
        cicky(  81,911,50);  --点击微信
        mSleep(1500);
        page_array["page_weixinzhu"]:enter()
    elseif gongneng == 5.1 or gongneng == 5.2 or gongneng == 5.3 or gongneng == 3.31 then
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter()
    elseif gongneng == "返回" then   --返回微信首界面
        mSleep(math.random(1000,8888))
    else
        warning_info("错误")
        return false
    end
    return true;
end

--step1
function wo_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function wo_page:check_page()  --检查是否是在当前页面--
    local time = 0
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_wo() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function wo_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_wo() ;
end

--step3  --最主要的工作都在这个里面
function wo_page:action()     --执行这个页面的操作--
    return  action_wo();
end

page_array["page_wo"] = wo_page:new()

------------------end:  page\weixinzong\page_wo.lua-------------------------------------




----------------------begin:  page\weixinzong\page_tianjiapengyou.lua---------------------------------

default_tianjiapengyou_page = {
    page_name = "tianjiapengyou_page",
    page_image_path = nil
}

tianjiapengyou_page = class_base_page:new(default_tianjiapengyou_page);

--添加朋友  2.1
local function check_page_tianjiapengyou( ... )   
   x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -4, 20, 0x121213, 5, 22, 0x121213, 16, 1, 0xF3F3F3, 30, 17, 0xFFFFFF, 35, 6, 0x111112, 61, 11, 0xC6C6C6, 65, 17, 0x121213, 102, 27, 0x131213, 92, 15, 0xDFDFDF, 88, 4, 0x111112, 228, 6, 0xE5E5E5, 217, 21, 0x121213, 244, 22, 0x121213, 263, 12, 0x3E3E3E, 272, 22, 0x121213, 300, 14, 0x121212, 283, 19, 0x121213, 298, 7, 0x1F1E1F, 340, 17, 0x121213, 350, 8, 0x121112, 331, 4, 0xFFFFFF, 324, 14, 0x121212, 534, 12, 0x121212, 574, 15, 0x121212, 561, 25, 0x121213, 377, 9, 0x121112, 416, 11, 0x121212 }, 90, 34, 69, 612, 96);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----微信添加朋友界面----");
        return true
    else
        return false
    end
end

local function action_tianjiapengyou()     --操作
    if gongneng == 2.11 then
        cicky( 182,202,50);       --点击搜索
        mSleep(2000);
        page_array["page_sousuojiahaoyou"]:enter();
    elseif gongneng == 2.12 then
        cicky(  198,892,50);   --点击公众号
        mSleep(2000);
        page_array["page_jiagongzhonghao"]:enter();
    else
        cicky(75,88,50);   --点击返回
        mSleep(1500);
        page_array["page_tongxunlu"]:enter();
    end
end

--step1
function tianjiapengyou_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function tianjiapengyou_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_tianjiapengyou() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function tianjiapengyou_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_tianjiapengyou();     
end

--step3  --最主要的工作都在这个里面
function tianjiapengyou_page:action()
    return action_tianjiapengyou();
end

page_array["page_tianjiapengyou"] =  tianjiapengyou_page:new()
------------------end:  page\weixinzong\page_tianjiapengyou.lua-------------------------------------




----------------------begin:  page\dianhuaben\page_suoyoulianxiren.lua---------------------------------
--begin page_suoyoulianxiren.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

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

local function action_suoyoulianxiren_delete()     --执行这个页面的操作--
    if nv_read_nv_item("photo") ~= nil then
        if nv_read_nv_item("time") < 21  then  --10天删除一次联系人
            warning_info("没到时间，不删除联系人");
            mSleep(1000)
            return true
        end
    else
        warning_info("没到时间，不删除联系人");
        mSleep(1000)
        return true
    end
    --删除次数 写入nv
    if nv_read_nv_item("Number of contact people") == nil then
        nv_write_nv_item("Number of contact people",1)
    else
        contact = nv_read_nv_item("Number of contact people") - 1 
        nv_write_nv_item("Number of contact people",contact)
    end
    mSleep(1000)
    touchDown(5, 532, 278) --点击“名字”
    mSleep(127);
    touchUp(5);
    mSleep(2000);
    if page_array["page_lianxirenxiangqing"]:quick_check_page() == true then
        page_array["page_lianxirenxiangqing"]:enter();
    elseif page_array["page_suoyoulianxiren"]:quick_check_page() == true then
        shanghua();   --上滑
        return page_array["page_suoyoulianxiren"]:action()
    else
        log_info("删除联系人出现错误");
        return page_array["page_main"]:enter()
    end
end

local num_book_add = math.random(200,250)  --添加联系人数量
local function action_suoyoulianxiren_add()     --执行这个页面的操作--
    --读取nv（本地文件） 看添加过联系人没
    if nv_read_nv_item("photo") ~= nil then
        if nv_read_nv_item("photo") == 1  then
            time = nv_read_nv_item("time") + 1
            nv_write_nv_item("time", time)   --更新天数 这是2倍的天数 一天会运行2次 
            warning_info("联系人已加,不用在加");
            mSleep(1000)
            return true
        else
            mSleep(1000)
        end
    else
        mSleep(500)
    end
    if num_book_add <= 0 then
        nv_write_nv_item("photo", 1)   --添加信息写入nv（本地文件）中
        nv_write_nv_item("time", 0)
        warning_info("联系人已加完");
        mSleep(1000)
        return reset_ms_server()  --加完复位
    end
    --添加次数 写入nv
    if nv_read_nv_item("Number of contact people") == nil then
        nv_write_nv_item("Number of contact people",1)
    else
        contact = nv_read_nv_item("Number of contact people") +1
        nv_write_nv_item("Number of contact people",contact)
    end
    num_book_add = num_book_add -1   --添加数量
    mSleep(500)
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
    if  nv_read_nv_item("time") == nil then  --次数
        nv_write_nv_item("time",1)           --初始化
    end
    if gongneng == 5.3 then  --删除
        if true == is_exsist_contact() then
            warning_info("联系人已经删完"); 
            mSleep(1000)
            nv_write_nv_item("photo", 0)  --初始化添加联系人信息
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
        cicky(80,80,50); --返回
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
--begin page_xinlianxiren.lua
--package.path=package.path .. ";/Users/huangyinke/Desktop/Code/lua/lua_server/scripts/add_contact/?.lua"
--require "class_base_page"

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
    if strategy == nil then
        strategy = {"1"}
    end
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
        phone_weixin(text_phone,phone_num);     --电话号码  
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
    return page_array["page_lianxirenxiangqing"]:enter();
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
    elseif gongneng == 5.2 then  --增加联系人
        cicky(80,80,50);  --取消
        mSleep(1000)
        page_array["page_lianxirenxiangqing"]:enter()
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




----------------------begin:  page\shanchuxiangpian\page_xiangbao.lua---------------------------------

default_xiangbao_page = {
    page_name = "xiangbao_page",
    page_image_path = nil
}

xiangbao_page = class_base_page:new(default_xiangbao_page);

--相薄.bmp
local function check_page_xiangbao( ... )   
   x, y = findMultiColorInRegionFuzzy({ 0xF7F7F7, 13, -9, 0xF7F7F7, 14, -47, 0x007AFF, -218, 0, 0xBCBCBC, -192, -8, 0xF7F7F7, -173, -39, 0xCDCDCD, -425, -2, 0xF6F6F6, -404, -2, 0xD8D8D8, -476, -879, 0x007AFF, -473, -867, 0xF7F7F7, -470, -863, 0x007AFF, -483, -856, 0xF7F7F7, -236, -866, 0xF7F7F7, -220, -847, 0x999999, -222, -874, 0x000000, -227, -870, 0x6C6C6C, -222, -864, 0x000000, -196, -870, 0xF7F7F7, -168, -852, 0xF7F7F7, -185, -871, 0xDDDDDD, -195, -869, 0xEDEDED, -192, -874, 0x9A9A9A, -190, -866, 0x161616, -186, -861, 0x000000, 64, -868, 0xF7F7F7, 97, -861, 0xF7F7F7, 66, -843, 0xF7F7F7, -461, -882, 0xF7F7F7, -504, -860, 0xF7F7F7, -468, -855, 0xF7F7F7, -460, -855, 0xF7F7F7 }, 90, 21, 63, 622, 945);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----相薄界面----");
        return true
    else
        return false
    end
end

local function action_xiangbao()     --操作
    if gongneng == 5.1 then  
        cicky(  92,219,50);   --点击相机胶卷
        mSleep(2000);
        page_array["page_xiangjijiaojuan"]:enter();
    else
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter();
    end
    return true
end

--step1
function xiangbao_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function xiangbao_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xiangbao() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function xiangbao_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_xiangbao();     
end

--step3  --最主要的工作都在这个里面
function xiangbao_page:action()
    return action_xiangbao();
end

page_array["page_xiangbao"] =  xiangbao_page:new()  


------------------end:  page\shanchuxiangpian\page_xiangbao.lua-------------------------------------




----------------------begin:  page\shanchuxiangpian\page_xiangjijiaojuan.lua---------------------------------

default_xiangjijiaojuan_page = {
    page_name = "xiangjijiaojuan_page",
    page_image_path = nil
}

xiangjijiaojuan_page = class_base_page:new(default_xiangjijiaojuan_page);

--相机胶圈.bmp
local function check_page_xiangjijiaojuan( ... )   
   x, y = findMultiColorInRegionFuzzy({ 0xF7F7F7, -10, 14, 0x007AFF, -13, 21, 0x52A4FC, 1, 33, 0x007AFF, 30, 3, 0xF7F7F7, 37, 26, 0xF7F7F7, 55, 25, 0xF7F7F7, 50, 9, 0xF7F7F7, 39, 6, 0xF7F7F7, 45, 24, 0xF7F7F7, 64, 15, 0xF4F5F7, 77, 25, 0x2B8FFE, 79, 3, 0xF5F5F7, 64, 4, 0x5AA7FC, 78, 27, 0xF7F7F7, 83, 14, 0x67AEFC, 76, 13, 0x007AFF, 232, 22, 0xF7F7F7, 254, 16, 0xF7F7F7, 240, -2, 0xF7F7F7, 224, 14, 0xF7F7F7, 235, 17, 0xF7F7F7, 237, 14, 0x000000, 263, 33, 0xE6E6E6, 289, 18, 0xF7F7F7, 268, 4, 0xF7F7F7, 280, 23, 0x1D1D1D, 278, 15, 0x2D2D2D, 262, 12, 0x000000, 307, 22, 0x000000, 318, 13, 0xF7F7F7, 292, 4, 0xE5E5E5, 309, 16, 0xF7F7F7, 320, 10, 0xF7F7F7, 342, 33, 0x8B8B8B, 339, 0, 0xF7F7F7, 328, 11, 0x303030, 341, 21, 0x000000 }, 90, 19, 64, 374, 99);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----相机胶圈界面----");
        return true
    else
        return false
    end
end

local function action_xiangjijiaojuan()     --操作
    if gongneng == 5.1 then  
         --没有照片1.bmp
        x, y = findMultiColorInRegionFuzzy({ 0x999999, 85, 13, 0xF7F7F7, 164, 22, 0xC6C6C6, 203, 14, 0xFFFFFF, 248, 8, 0xFFFFFF, 293, 38, 0x999999, 192, 32, 0xFEFEFE, 292, 16, 0x999999 }, 90, 167, 383, 460, 421);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("没有照片了");
            return false
        end
        cicky(597,82,50);   --点击选择
        mSleep(1000);
        cicky( 137,161  );   --点击第一张
        mSleep(500);  
        cicky( 284,158   );    ----2
        mSleep(500);
        cicky( 443,163   );     ----3
        mSleep(500);
        cicky( 607,160 );       ----4
        mSleep(500);
        cicky( 133,320 );          ---5
        mSleep(500);
        cicky( 283,328   );       --6
        mSleep(500);
        cicky( 439,325  );       --7
        mSleep(500);
        cicky( 600,322  );      --8
        mSleep(500);
        cicky( 125,484  );       --9
        mSleep(500);
        cicky(604,906);     --删除
        mSleep(2000);
        cicky( 384,795 );    --确认删除 
        mSleep(2000); 
        log_info("删除照片一次");
      --  page_array["page_xiangjijiaojuan"]:enter()
    else
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        page_array["page_main"]:enter();
    end
    return true
end

--step1
function xiangjijiaojuan_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function xiangjijiaojuan_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xiangjijiaojuan() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function xiangjijiaojuan_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_xiangjijiaojuan();     
end

--step3  --最主要的工作都在这个里面
function xiangjijiaojuan_page:action()
    return action_xiangjijiaojuan();
end

page_array["page_xiangjijiaojuan"] =  xiangjijiaojuan_page:new()  


------------------end:  page\shanchuxiangpian\page_xiangjijiaojuan.lua-------------------------------------




----------------------begin:  page\wx_zhinenghuifu_1.1\page_tengxunxinwen.lua---------------------------------

default_tengxunxinwen_page = {
    page_name = "tengxunxinwen_page",
    page_image_path = nil
}

tengxunxinwen_page = class_base_page:new(default_tengxunxinwen_page);

 --腾讯新闻.bmp
local function check_page_tengxunxinwen( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 21, -7, 0xFFFFFF, 40, 7, 0x121212, 25, 24, 0x121213, 18, 23, 0xFFFFFF, -316, -11, 0x111112, -295, 13, 0xDEDEDE, -306, -7, 0xFFFFFF, -307, 6, 0xFFFFFF, -283, 5, 0x121112, -277, 20, 0x121213, -261, 8, 0xA7A7A7, -267, -16, 0x111112, -242, 13, 0x565656, -225, 15, 0x121212, -221, -4, 0x121212, -231, -5, 0x888888, -197, 25, 0x131213, -181, 11, 0xFFFFFF, -180, -7, 0x1B1B1B, -197, 7, 0x333333, -195, 13, 0xE1E1E1, -543, -4, 0x111111, -546, 2, 0x111112, -540, 16, 0xFFFFFF, -530, 23, 0x898989, -509, -1, 0xFFFFFF, -489, 19, 0x121212, -478, 13, 0x121212, -477, 6, 0x141314, -506, -12, 0x111112, -513, -6, 0x121212, -478, 7, 0x121212, -473, 7, 0x121212 }, 90, 25, 61, 611, 102);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----腾讯新闻消息界面----")
        return true
    else
        return false
    end
end

local function action_tengxunxinwen()     --操作
    if gongneng == 1.1 or gongneng == 1.3 or gongneng == 1.12 or gongneng == 1.4  then   --发送公众号名片
        local m = math.random(345,854)
        cicky( 264,m,50);   ---点击新闻
        mSleep(7000);
        x, y = findMultiColorInRegionFuzzy({ 0xFDFDFD, 16, 2, 0xFFFFFF, 35, 2, 0xB6B6B6, -325, -11, 0xD6D6D6, -301, 11, 0xFBFBFB, -298, -20, 0x0B0B0C, -279, 16, 0x0C0C0C, -264, -3, 0x0C0C0C, -241, 15, 0x5A5A5A, -221, -8, 0x0B0B0C, -202, 16, 0x0C0C0C, -197, 1, 0xFFFFFF, -488, -1, 0x464646, -301, -1, 0xFFFFFF, -99, -1, 0x0C0C0C, -26, 2, 0x0C0C0C }, 90, 88, 60, 611, 96);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            for i= 1 , math.random(1,4) do
                xiahua();
                mSleep(1000)
            end
            mSleep(1000)
            for i=1 , math.random(1,4) do
                shanghua();
                mSleep(1000)
            end
            mSleep(2000);
            cicky(  58,79,50);  --返回腾讯新闻
            mSleep(2000);
            cicky(89,80,50);    --返回微信
            mSleep(2000);
            log_info("浏览腾讯新闻一次")
            mSleep(500)
            if gongneng == 1.12  then
                return  page_array["page_weixinzhu"]:enter()
            else 
                gongneng = 1.2  --删除
                return  page_array["page_weixinzhu"]:enter()
            end
        end
    else
        cicky(  68,80,50);   --返回微信
        mSleep(1500);
        page_array["page_weixinzhu"]:enter()
    end
end

--step1
function tengxunxinwen_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function tengxunxinwen_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_tengxunxinwen() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function tengxunxinwen_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_tengxunxinwen();     
end

--step3  --最主要的工作都在这个里面
function tengxunxinwen_page:action()
    return action_tengxunxinwen();
end

page_array["page_tengxunxinwen"] =  tengxunxinwen_page:new() 


------------------end:  page\wx_zhinenghuifu_1.1\page_tengxunxinwen.lua-------------------------------------




----------------------begin:  page\wx_zhinenghuifu_1.1\page_xuanzegzh.lua---------------------------------

default_xuanzegzh_page = {
    page_name = "xuanzegzh_page",
    page_image_path = nil
}

xuanzegzh_page = class_base_page:new(default_xuanzegzh_page);

 --选择公众号.bmp
local function check_page_xuanzegzh( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x121112, -17, 11, 0x121212, -6, 25, 0x131313, 21, 6, 0xFFFFFF, 27, 17, 0x121213, 33, 14, 0x121213, 21, 21, 0x909090, 49, 15, 0x171718, 76, 14, 0x121213, 37, 7, 0x121212, 85, 19, 0x6A696A, 113, 24, 0x131313, 93, 8, 0x121212, 112, 23, 0x131313, 118, 11, 0xB1B1B1, 135, 11, 0x121212, 226, 14, 0xFFFFFF, 234, 21, 0x939393, 249, 3, 0x939393, 271, 6, 0x121212, 324, 6, 0xFFFFFF, 353, 7, 0x121212, 266, 40, 0x141414, 248, 22, 0xFFFFFF, 344, 20, 0x131313, 579, 11, 0x121212, 550, 21, 0x131313, 530, 16, 0x121213, 457, 13, 0x121213, 561, 12, 0x121213 }, 90, 25, 67, 621, 107);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----推送名片选择公众号界面----")
        return true
    else
        return false
    end
end

local function action_xuanzegzh()     --操作
    if gongneng == 1.1  then   --发送公众号名片
        cicky( 320,163,50);  --点击搜索
        mSleep(2000);
        inputText(text_gzhmingpian[math.random(#text_gzhmingpian)]);
        mSleep(2000);
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -7, 18, 0xFFFFFF, 15, 18, 0xFFFFFF, 3, 0, 0xCCCCCC, 45, 20, 0xCCCCCC, 60, 16, 0xD5D5D5, 49, 2, 0xFFFFFF, 89, 22, 0xFFFFFF, 95, 13, 0xDBDBDB, 90, -3, 0xFFFFFF }, 90, 267, 247, 369, 272);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            notifyMessage("没有这个公众号");
            mSleep(1000)
            log_info("没有这个公众号");
            cicky( 597,77,50);    --点击取消
            mSleep(1500);
            gongneng = "选择朋友"  --推送朋友的名片
            page_array["page_xuanzegzh"]:enter()
            return false
        end
        cicky(  72,165,50);  --点击第一个公众号
        mSleep(2000);
        cicky( 451,535,50);   --点击发送
        mSleep(3000);
        log_info("推送公众号名片一次");
        ---还不是朋友 
        x, y = findMultiColorInRegionFuzzy({ 0xCECECE, 23, 0, 0x0D7FFC, 44, 0, 0xCECECE, 67, 0, 0x8DB3DD, 91, 3, 0xCECECE, 130, 8, 0xCECECE, 144, 8, 0xBDC7D2, 14, 8, 0xCECECE, 52, 8, 0x6EA6E5, 85, 8, 0xCECECE, 112, 8, 0x4395EF, 149, 9, 0x338EF3, 36, 12, 0x0A7EFD, 34, 12, 0x60A1E8, 29, 12, 0xCECECE, 85, 13, 0xCDCDCE, 118, 13, 0xCBCCCF, 145, 13, 0xCECECE, 145, 13, 0xCECECE }, 90, 330, 373, 479, 386);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);  --点击发送朋友验证
            mSleep(3000);
            for i=1,5 do
                ---验证
                x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 29, 3, 0xFFFFFF, 76, 4, 0xFFFFFF, 194, 8, 0xFFFFFF, 318, 9, 0xFFFFFF, 411, 3, 0xFFFFFF, 35, 18, 0xFFFFFF, 51, 18, 0xFFFFFF, 288, 18, 0xFFFFFF, 421, 18, 0xFFFFFF, 424, 17, 0xFFFFFF, 73, 33, 0xFFFFFF, 177, 32, 0xFFFFFF, 377, 17, 0xFFFFFF, 413, 18, 0xFFFFFF, 329, 123, 0x007AFF, 365, 114, 0x007AFF, 103, 114, 0x007AFF }, 90, 111, 296, 535, 419);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    inputText("我好像在哪见过你");
                    mSleep(2000);
                    cicky( 457,419,50);   --点击发送
                    mSleep(3000);
                    break
                end
                mSleep(1000)
            end
            --错误
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -7, 23, 0xFFFFFF, 11, 25, 0xFFFFFF, -551, -1, 0xFFFFFF, -556, 6, 0xFFFFFF, -555, 20, 0xFFFFFF, -497, 0, 0xFFFFFF, -519, 15, 0xFFFFFF, -11, 25, 0xFFFFFF, 12, 25, 0xFFFFFF, 5, 4, 0xFFFFFF }, 90, 30, 71, 598, 97);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(66,86,50);   --返回微信
                mSleep(1500);
                gongneng = 1.2  --删除
                log_info("验证朋友一次")
                mSleep(1000)
                return page_array["page_weixinzhu"]:enter()
            else
                warning_info("验证朋友错误");
                mSleep(1000)
                gongneng = 1.2  --删除
                cicky(66,86,50);   --返回微信
                mSleep(1500)
                return page_array["page_weixinzhu"]:enter()
            end
        end
        if text_gerenmingpian[1] ~= nil then
            if test == "名片2" then
                cicky(397,798,50)  --点击个人名片2
            else
                cicky(80, 638,50)   --点击个人名片1
            end
            mSleep(3000);
            gongneng = "选择朋友"      --推送朋友的名片
            return page_array["page_xuanzepengyou"]:enter()
        end
        mSleep(1000)
        cicky( 110,461 ,50);   --点击输入框 
        mSleep(2500);
        if text_huifu1[1] ~= nil then
            inputText(text_huifu1[math.random(#text_huifu1)]); 
            mSleep(2000);
            cicky( 435,917,50);   --点击空格
            mSleep(1500);
            cicky( 598,909,50);   --点击发送
            mSleep(3000); 
        end
        inputText(text_huifu2[math.random(#text_huifu2)])
        mSleep(5000);
        cicky( 435,917,50);   --点击空格
        mSleep(1500);
        cicky( 598,909,50);   --点击发送
        mSleep(3000);
        ---还不是朋友 
        x, y = findMultiColorInRegionFuzzy({ 0xCECECE, 23, 0, 0x0D7FFC, 44, 0, 0xCECECE, 67, 0, 0x8DB3DD, 91, 3, 0xCECECE, 130, 8, 0xCECECE, 144, 8, 0xBDC7D2, 14, 8, 0xCECECE, 52, 8, 0x6EA6E5, 85, 8, 0xCECECE, 112, 8, 0x4395EF, 149, 9, 0x338EF3, 36, 12, 0x0A7EFD, 34, 12, 0x60A1E8, 29, 12, 0xCECECE, 85, 13, 0xCDCDCE, 118, 13, 0xCBCCCF, 145, 13, 0xCECECE, 145, 13, 0xCECECE }, 90, 330, 373, 479, 386);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);  --点击发送朋友验证
            mSleep(3000);
            for i=1,5 do
                ---验证
                x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 29, 3, 0xFFFFFF, 76, 4, 0xFFFFFF, 194, 8, 0xFFFFFF, 318, 9, 0xFFFFFF, 411, 3, 0xFFFFFF, 35, 18, 0xFFFFFF, 51, 18, 0xFFFFFF, 288, 18, 0xFFFFFF, 421, 18, 0xFFFFFF, 424, 17, 0xFFFFFF, 73, 33, 0xFFFFFF, 177, 32, 0xFFFFFF, 377, 17, 0xFFFFFF, 413, 18, 0xFFFFFF, 329, 123, 0x007AFF, 365, 114, 0x007AFF, 103, 114, 0x007AFF }, 90, 111, 296, 535, 419);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    inputText("我好像在哪见过你");
                    mSleep(2000);
                    cicky( 457,419,50);   --点击发送
                    mSleep(3000);
                    break
                end
                mSleep(1000)
            end
            --错误
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -7, 23, 0xFFFFFF, 11, 25, 0xFFFFFF, -551, -1, 0xFFFFFF, -556, 6, 0xFFFFFF, -555, 20, 0xFFFFFF, -497, 0, 0xFFFFFF, -519, 15, 0xFFFFFF, -11, 25, 0xFFFFFF, 12, 25, 0xFFFFFF, 5, 4, 0xFFFFFF }, 90, 30, 71, 598, 97);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(66,86,50);   --返回微信
                mSleep(1500);
                gongneng = 1.2  --删除
                log_info("验证朋友一次")
                mSleep(1000)
                return page_array["page_weixinzhu"]:enter()
            else
                warning_info("验证朋友错误");
                mSleep(1000)
                gongneng = 1.2  --删除
                cicky(66,86,50);   --返回微信
                mSleep(1500)
                return page_array["page_weixinzhu"]:enter()
            end
        end
        log_info("智能回复消息一次")
        mSleep(1000)
        gongneng = 1.2   --删除
        cicky(80,80,50);   --返回微信
        mSleep(1500)
        if page_array["page_weixinzhu"]:check_page() == true then
            page_array["page_weixinzhu"]:action()
        else
            warning_info("回复完返回错误")
            return false
        end
    else
        cicky(  68,80,50);   --返回选择朋友
        mSleep(1500);
        page_array["page_xuanzepengyou"]:enter()
    end
end

--step1
function xuanzegzh_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function xuanzegzh_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xuanzegzh() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function xuanzegzh_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_xuanzegzh();     
end

--step3  --最主要的工作都在这个里面
function xuanzegzh_page:action()
    return action_xuanzegzh();
end

page_array["page_xuanzegzh"] =  xuanzegzh_page:new() 


------------------end:  page\wx_zhinenghuifu_1.1\page_xuanzegzh.lua-------------------------------------




----------------------begin:  page\wx_zhinenghuifu_1.1\page_xuanzepengyou.lua---------------------------------

default_xuanzepengyou_page = {
    page_name = "xuanzepengyou_page",
    page_image_path = nil
}

xuanzepengyou_page = class_base_page:new(default_xuanzepengyou_page);

 --选择朋友.bmp
local function check_page_xuanzepengyou( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0xB3B3B3, 3, 21, 0x131313, 5, 1, 0xD1D1D1, -14, 9, 0x121213, 29, 7, 0x121212, 38, 16, 0x2D2D2D, 41, -1, 0x6C6C6C, 35, 7, 0x6D6D6D, 221, 19, 0xFFFFFF, 241, 15, 0x131213, 235, -13, 0x111111, 265, 31, 0x131314, 279, 22, 0xFFFFFF, 269, 5, 0xF8F8F8, 301, 19, 0xBCBCBC, 314, 18, 0x373737, 305, -1, 0x121212, 334, 17, 0xFFFFFF, 350, 21, 0x131313, 352, -3, 0x121112, 346, 4, 0x4C4C4C, 580, 10, 0x121213, 593, 25, 0x131313, 554, 18, 0x131313, 558, -1, 0x121212, 560, -2, 0x121212 }, 90, 18, 58, 625, 102);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----推送名片选择好友界面----")
        return true
    else
        return false
    end
end

local function action_xuanzepengyou()     --操作
    if gongneng == 1.1  then   --发送公众号名片
        ---公众号
        x, y = findMultiColorInRegionFuzzy({ 0x2782D7, 44, 9, 0x2782D7, 34, 33, 0x2782D7, 4, 25, 0x2782D7, 37, 52, 0x2782D7, 66, 47, 0xFFFFFF, 88, 22, 0xFFFFFF, 113, 31, 0xFFFFFF, 152, 31, 0xFFFFFF, 167, 20, 0xFFFFFF, 137, 14, 0xFFFFFF, 113, 16, 0xFFFFFF, 130, 28, 0xBFBFBF, 149, 27, 0xFFFFFF }, 90, 33, 245, 200, 297);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            if text_gzhmingpian[1] == nil then
                gongneng = "选择朋友"
                return page_array["page_xuanzepengyou"]:enter()
            end
            cicky( 116,263,50);   --点击公众号
            mSleep(1500);
            return page_array["page_xuanzegzh"]:enter() 
        else
            warning_info("没有关注公众号或者是卡了");
            mSleep(1000)
            gongneng = "选择朋友"
            return page_array["page_xuanzepengyou"]:enter()
        end
    elseif gongneng == "选择朋友" then
        mSleep(500)
        if text_gerenmingpian[1] ~= nil then
            cicky( 311,175,50);  --点击搜索
            mSleep(2000)
            inputText(text_gerenmingpian[math.random(#text_gerenmingpian)]);
            mSleep(2000);
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -7, 18, 0xFFFFFF, 15, 18, 0xFFFFFF, 3, 0, 0xCCCCCC, 45, 20, 0xCCCCCC, 60, 16, 0xD5D5D5, 49, 2, 0xFFFFFF, 89, 22, 0xFFFFFF, 95, 13, 0xDBDBDB, 90, -3, 0xFFFFFF }, 90, 267, 247, 369, 272);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                notifyMessage("没有这个好友");
                mSleep(1000)
                log_info("没有这个好友");
                cicky( 597,77,50);    --点击取消
                mSleep(2000);
                cicky(80,80,50);  --点击取消
                mSleep(2000); 
            else
                cicky(  72,165,50);  --点击第一个好友
                mSleep(3000);
                cicky( 451,535,50);   --点击发送
                mSleep(3000);
                log_info("推送个人名片一次");
                mSleep(1000) 
            end 
        else
            cicky(80,80,50);  --点击取消
            mSleep(2000);
        end
        mSleep(500)
        cicky( 110,461 ,50);   --点击输入框 
        mSleep(2500);
        if text_huifu1[1] ~= nil then
            inputText(text_huifu1[math.random(#text_huifu1)]); 
            mSleep(2000);
            cicky( 435,917,50);   --点击空格
            mSleep(1500);
            cicky( 598,909,50);   --点击发送
            mSleep(3000); 
        end
        inputText(text_huifu2[math.random(#text_huifu2)])
        mSleep(5000);
        cicky( 435,917,50);   --点击空格
        mSleep(1500);
        cicky( 598,909,50);   --点击发送
        mSleep(3000);
        log_info("智能回复消息一次")
        mSleep(500)
        gongneng = 1.2   --删除
        cicky(80,80,50);   --返回微信
        mSleep(2000)
        if page_array["page_weixinzhu"]:quick_check_page() == true then
            page_array["page_weixinzhu"]:action()
        else
            warning_info("回复完返回错误")
            return false
        end
    else
        cicky(89,80,50);    --点击取消
        mSleep(3000);
        cicky(89,80,50);    --返回微信
        mSleep(2000);
        return page_array["page_weixinzhu"]:enter()
    end
end

--step1
function xuanzepengyou_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function xuanzepengyou_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xuanzepengyou() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function xuanzepengyou_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_xuanzepengyou();     
end

--step3  --最主要的工作都在这个里面
function xuanzepengyou_page:action()
    return action_xuanzepengyou();
end

page_array["page_xuanzepengyou"] =  xuanzepengyou_page:new() 


------------------end:  page\wx_zhinenghuifu_1.1\page_xuanzepengyou.lua-------------------------------------




----------------------begin:  page\wx_zhinenghuifu_1.1\page_dingyuehao.lua---------------------------------

default_dingyuehao_page = {
    page_name = "dingyuehao_page",
    page_image_path = nil
}

dingyuehao_page = class_base_page:new(default_dingyuehao_page);

 --订阅号消息.bmp
local function check_page_dingyuehao( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x0B0B0C, -8, 16, 0xFFFFFF, 11, 42, 0x0C0C0C, 40, 41, 0x0C0C0C, 35, 13, 0x5B5B5B, 22, -4, 0x0B0B0C, 25, 12, 0x0C0C0C, 56, 27, 0x0C0C0C, 68, 18, 0x0C0C0C, 65, 10, 0x0C0C0C, 65, 10, 0x0C0C0C, 217, 11, 0x0C0C0C, 240, 9, 0x0C0C0C, 238, 20, 0x0C0C0C, 246, 8, 0x0C0B0C, 250, 22, 0x0C0C0C, 277, 18, 0xC6C6C6, 293, 20, 0x252525, 290, 8, 0x0C0B0C, 285, 15, 0x8E8E8E, 318, 25, 0x8C8C8C, 330, 21, 0x0C0C0C, 317, 7, 0x0C0B0C, 317, 21, 0x0C0C0C, 320, 7, 0x0C0B0C, 355, 9, 0x0C0C0C, 347, 28, 0x0C0C0C, 569, 8, 0x0C0B0C, 567, 27, 0x0C0C0C, 554, 19, 0x0C0C0C, 548, 7, 0x0C0B0C, 522, 11, 0x0C0C0C }, 90, 28, 62, 605, 108);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----订阅号消息界面----")
        return true
    else
        return false
    end
end

local function action_dingyuehao()     --操作
    if gongneng == 1.1 then   --智能回复
        cicky(  68,80,50);   --返回微信
        mSleep(1500);
        gongneng = 1.3  --滑动
        log_info("是订阅号 回复下一个")
        mSleep(500)
        local try_time = try_time +1 
        if try_time > 3 then
            log_info("重新开始回复")
            gongneng = 1.1
        end
        page_array["page_weixinzhu"]:enter()
    else
        cicky(  68,80,50);   --返回微信
        mSleep(1500);
        page_array["page_weixinzhu"]:enter()
    end
end

--step1
function dingyuehao_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function dingyuehao_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_dingyuehao() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function dingyuehao_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_dingyuehao();     
end

--step3  --最主要的工作都在这个里面
function dingyuehao_page:action()
    return action_dingyuehao();
end

page_array["page_dingyuehao"] =  dingyuehao_page:new() 


------------------end:  page\wx_zhinenghuifu_1.1\page_dingyuehao.lua-------------------------------------




----------------------begin:  page\wx_sssjh_2.11\page_sousuojiahaoyou.lua---------------------------------
 
default_sousuojiahaoyou_page = {
    page_name = "sousuojiahaoyou_page",
    page_image_path = nil
}

sousuojiahaoyou_page = class_base_page:new(default_sousuojiahaoyou_page);

--搜索手机号微信号2.1.1   /开始搜索.bmp
local function check_page_sousuojiahaoyou( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 0, 13, 0xFFFFFF, -2, 29, 0xFFFFFF, -2, 29, 0xFFFFFF, -13, 24, 0xFFFFFF, -13, 38, 0xFFFFFF, 49, 8, 0xE7E7E8, 74, 10, 0xB1B1B5, 122, 13, 0xFFFFFF, 177, 19, 0xFFFFFF, 192, 19, 0xB2B2B5, 65, 19, 0xFFFFFF, 124, 19, 0xFFFFFF, 170, 19, 0xC6C6C8, 195, 19, 0xB1B1B4, 68, 28, 0xB8B8BB, 131, 28, 0xFFFFFF, 173, 28, 0xFFFFFF, 198, 25, 0x8E8E93, 538, 2, 0xEFEFF4, 594, 3, 0xEFEFF4, 592, 16, 0xEFEFF4, 563, 36, 0xEFEFF4, 521, 23, 0x06BF04, 496, 9, 0xEFEFF4, 494, 9, 0xEFEFF4, 567, 33, 0xEFEFF4, 565, 12, 0x06BF04, 534, 9, 0xEFEFF4, 533, 12, 0xEFEFF4 }, 90, 27, 62, 634, 100);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----搜索手机号界面----")
      --  mSleep(1000)
        return true
    else
        return false
    end
end

local function action_sousuojiahaoyou()     --操作
    if gongneng == 2.11 then
        my_name, my_number = generate_contact_info(); --产生随机的信息
        mSleep(500);
        --设置电话号码
        if gong_neng == "新号" then   --加新号为好友
            xinhao_path = "/private/var/touchelf/scripts/sl/xinhao_info.lua"   --新养的号信息文件本地存放位置
            xinhao_name = "xinhao_info.lua"             --新养的号信息的文件名
             --新养的号信息文件服务器存放地址
            sl_url  = "http://lua-script.oss-cn-shenzhen.aliyuncs.com/xinhao_info.lua"   
            if tmp_download_file(xinhao_path,sl_url) == true then   --新号的信息下载下来
                dofile(xinhao_path);
            else
                wrning_info("没有新号数据或者网络卡")
                return false
            end
            --读取nv中添加新号次数
            if nv_read_nv_item("xinhao_info_add_num") == nil then
                nv_write_nv_item("xinhao_info_add_num",1)
            else   --每次加1
                xinhao_add_num = nv_read_nv_item("xinhao_info_add_num") + 1
                nv_write_nv_item("xinhao_info_add_num",xinhao_add_num)
            end
            --添加次数
            local add_num = nv_read_nv_item("xinhao_info_add_num")
            if add_num > 5 and add_num < 28 then  --一天加4次
                warning_info("已经添加完5个新号，不再添加新号")
                gongneng = "返回"   --返回微信首界面
                mSleep(1000)
                return page_array["page_sousuojiahaoyou"]:action()
            elseif add_num > 28 then
                nv_write_nv_item("xinhao_info_add_num",0)   --初始化
            end
            if nv_read_nv_item("xinhao_info_add_num") == 1 then
                xinhao_info1 = xinhao_wxh[math.random(#xinhao_wxh)]  --随机获取一个新养的号的微信号 
                xinhao_info2 = xinhao_wxh[math.random(#xinhao_wxh)]
                xinhao_info3 = xinhao_wxh[math.random(#xinhao_wxh)]
                xinhao_info4 = xinhao_wxh[math.random(#xinhao_wxh)]
                xinhao_info5 = xinhao_wxh[math.random(#xinhao_wxh)]
                xinhao_info = {
                xinhao_info1,
                xinhao_info2,
                xinhao_info3,
                xinhao_info4,
                xinhao_info5
                }
                nv_write_nv_item("xinhao_info",xinhao_info)    --数据写入nv
            end
            if nv_read_nv_item("xinhao_info") ~= nil then
                info = nv_read_nv_item("xinhao_info")           -- 读取数据
            else
                warning_info("搜索读取新号数据时出现错误");
                return false
            end
            mSleep(500)
            inputText(info[add_num]);       --输入微信号
            mSleep(500)
        elseif gong_neng == "指定" then   --加指定微信号
            if nv_read_nv_item("Add") ~= nil then
                add = nv_read_nv_item("Add")  + 1
                nv_write_nv_item("Add", add)   --更新添加次数 
                if nv_read_nv_item("Add") > 3 and nv_read_nv_item("Add") < math.random(10,15)  then
                    warning_info("已经添加3次,不在添加指定好友");
                    mSleep(1000)
                    inputText(my_number); 
                    mSleep(500)  
                elseif  nv_read_nv_item("Add") <= 3 then
                    inputText(text_weixinhao[math.random(#text_weixinhao)]);
                    mSleep(500)
                else
                    nv_write_nv_item("Add", 1)   --初始化
                    mSleep(1000)
                    inputText(text_weixinhao[math.random(#text_weixinhao)]);
                    mSleep(500)
                end
            else
                nv_write_nv_item("Add", 1)   --添加信息写入nv（本地文件）中
                mSleep(1000)
                inputText(text_weixinhao[math.random(#text_weixinhao)]);
                mSleep(500)
            end           
        elseif tonumber(strategy[1]) == 1 then  --策略一  地区性加粉
            inputText(my_number); 
            mSleep(500)
        elseif tonumber(strategy[1]) == 2 then  --策略二  精确加粉
            phone_weixin(text_weixin,weixin_num);
            mSleep(1000)
        else
            wrning_info("策略没设置好,使用随机号码");
            inputText(math.random(13014517812,13378659123));
            mSleep(500)
        end 
        mSleep(1500);
        cicky( 110,186,50);      --点击搜索
        mSleep(3000);
        for i=1,5 do
            --操作频繁.bmp  --版本6.3.21
            x, y = findMultiColorInRegionFuzzy({ 0xF7F7F7, -14, 19, 0xF8F8F8, -28, 10, 0xF8F8F8, -56, 5, 0x000000, -50, 21, 0x000000, -30, 20, 0xF8F8F8, -29, 14, 0xF8F8F8, -74, 5, 0x000000, -80, 15, 0xF7F7F7, -69, 17, 0xF8F8F8, -66, 8, 0x303030, -66, 4, 0x595959, -98, 5, 0xF7F7F7, -96, 20, 0xF7F7F7, -96, 20, 0xF7F7F7, -115, 6, 0xF6F6F6 }, 90, 221, 448, 336, 469);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky( 332,563,50);
                mSleep(2000);
                warning_info("搜索手机号操作频繁");
                cicky( 501,87,50);   --点叉叉
                mSleep(2000)
                break
            end
            mSleep(500)
            --操作频繁2.bmp   --版本6.5.3
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -3, 14, 0xFFFFFF, -15, 1, 0xD4D4D4, -37, -9, 0xFFFFFF, -42, -10, 0xFFFFFF, -44, 2, 0x9D9D9D, -39, 15, 0xFFFFFF, -26, 9, 0xFFFFFF, -50, -3, 0xEFEFEF, -67, -4, 0xFFFFFF, -74, 5, 0xFFFFFF, 73, 5, 0x888888, 127, 5, 0xFFFFFF, 153, 5, 0xFFFFFF, 164, 5, 0xFFFFFF }, 90, 227, 208, 465, 233);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                mSleep(1000);
                warning_info("搜索手机号操作频繁");
                cicky( 501,87,50);   --点叉叉
                mSleep(2000)
                break
            end
            mSleep(500)
            --查找失败 /查找失败.bmp
            x, y = findMultiColorInRegionFuzzy({ 0xB6B6B6, 16, 10, 0x6B6B6B, 36, 2, 0xF4F4F4, 63, 17, 0x949494, 79, 10, 0x292929, 107, 4, 0x292929, 128, 9, 0xF7F7F7, 184, 11, 0xF8F8F8, 144, 11, 0xF8F8F8, 238, 13, 0xF8F8F8, 246, 5, 0xF7F7F7, 269, 6, 0xF7F7F7, 326, 8, 0xF6F6F6, 359, 9, 0xF5F5F5, 378, 10, 0xF5F5F5, 395, 10, 0xF4F4F4 }, 90, 132, 450, 527, 467);        
            if x>0 and y>0 then
                warning_info("搜索手机号 查找失败");
                cicky( 323,560,50);
                mSleep(2000);
                cicky( 501,87,50);   --点叉叉
                mSleep(2000)
                break
            end
            ---无结果
            x, y = findMultiColorInRegionFuzzy({ 0xCCCCCC, -6, 12, 0xFFFFFF, -1, 23, 0xFFFFFF, 41, 20, 0xCCCCCC, 31, 3, 0xFFFFFF, 38, 17, 0xFFFFFF, 38, -1, 0xFFFFFF, 53, 5, 0xFFFFFF, 49, 17, 0xCCCCCC, 73, 17, 0xCCCCCC, 91, 25, 0xCCCCCC, 93, 2, 0xCCCCCC, 81, 2, 0xCCCCCC, 85, 13, 0xFFFFFF, 78, 5, 0xCCCCCC }, 90, 273, 332, 372, 358);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                mSleep(500);
                warning_info("没搜到该用户")
                cicky( 501,87,50);   --点叉叉
                mSleep(2000)
                break
            end
            if page_array["page_soudaole"]:check_page() == true then       ---搜到了
                page_array["page_soudaole"]:enter()
                break
            end
            if i == 5 then
                warning_info("没搜到该用户或者网络太卡");
                cicky( 501,87,50);   --点叉叉
                mSleep(2000)
                return false
                --page_array["page_sousuojiahaoyou"]:enter
            end
            mSleep(500);
        end
    else
        cicky( 582,75,50);   --点击取消
        mSleep(1500);
        page_array["page_tianjiapengyou"]:enter();
    end
    return true
end

--step1
function sousuojiahaoyou_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function sousuojiahaoyou_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_sousuojiahaoyou() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function sousuojiahaoyou_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_sousuojiahaoyou();     
end

--step3  --最主要的工作都在这个里面
function sousuojiahaoyou_page:action()
    return action_sousuojiahaoyou();
end

page_array["page_sousuojiahaoyou"] =  sousuojiahaoyou_page:new()
------------------end:  page\wx_sssjh_2.11\page_sousuojiahaoyou.lua-------------------------------------




----------------------begin:  page\wx_sssjh_2.11\page_soudaole.lua---------------------------------

default_soudaole_page = {
    page_name = "soudaole_page",
    page_image_path = nil
}

soudaole_page = class_base_page:new(default_soudaole_page);

--搜索手机号微信号2.1.1   搜到了  /添加到通讯录.lua
local function check_page_soudaole( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 34, -4, 0x121112, 45, -4, 0x121112, 21, -33, 0x101011, 17, 7, 0x121213, -8, 13, 0x121213, -309, -14, 0x535354, -204, -18, 0x111111, -183, -18, 0x111111, -176, 12, 0x121213, -199, 26, 0x131314, -279, 20, 0x131313, -298, 11, 0xA6A6A6, -312, 5, 0x121213, -242, 1, 0x4D4D4D, -216, 5, 0x121213, -199, 5, 0xC2C2C2, -182, 5, 0xFFFFFF, -537, -14, 0x111112, -473, -10, 0x111112, -421, -10, 0x434344, -411, -7, 0x111112, -402, 2, 0x141414, -435, 22, 0x131313, -503, 24, 0x131314, -517, 17, 0x131313, -548, 9, 0x121213, -549, 6, 0x121213, -514, -3, 0x1F1F1F, -464, -3, 0x121212, -442, -3, 0x767676, -423, 0, 0x121212, -407, 3, 0x121213 }, 90, 22, 49, 616, 108);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----搜索手机号搜到了界面----")
        return true
    else
        return false
    end
end

local function action_soudaole()     --操作
    if  gongneng == 2.11 then 
        xiahua();
        ---添加到通讯录1.bmp
        x1, y1 = findMultiColorInRegionFuzzy({ 0x1AAD19, 37, 3, 0xFFFFFF, 65, 3, 0x6BCA6A, 115, 3, 0x1BAD1A, 178, 6, 0xEFF9EF, 214, 6, 0x1AAD19, 205, 27, 0x1AAD19, 157, 38, 0x1AAD19, 85, 32, 0x1AAD19, 32, 18, 0x1AAD19, 13, 14, 0x1AAD19, 2, 12, 0x1AAD19, 93, 11, 0xFFFFFF, 127, 13, 0xFFFFFF, 195, 23, 0xF7FCF7, 224, 7, 0x1AAD19, 147, -16, 0x1AAD19, 43, -17, 0x1AAD19, -26, -3, 0x1AAD19, -24, 31, 0x1AAD19, 158, 43, 0x1AAD19, 240, 29, 0x1AAD19, 246, 13, 0x1AAD19 }, 90, 196, 729, 468, 789);
         ---添加到通讯录2.bmp
        x2, y2 = findMultiColorInRegionFuzzy({ 0x1AAD19, 49, 0, 0x1AAD19, 89, 0, 0x1AAD19, 172, 0, 0x1AAD19, 198, 9, 0xFFFFFF, 206, 12, 0x24B123, 174, 36, 0x1AAD19, 95, 45, 0x1AAD19, 29, 46, 0x1AAD19, -10, 27, 0x1AAD19, 10, 12, 0x1AAD19, 73, 15, 0x1AAD19, 167, 21, 0x1AAD19, 201, 12, 0x1AAD19, 167, -4, 0x1AAD19, 79, 8, 0xFFFFFF, -2, 8, 0x1AAD19, -52, -5, 0x1AAD19, -7, 34, 0x1AAD19, 162, 44, 0x1AAD19, 284, 33, 0x1AAD19, 288, 25, 0x1AAD19, 249, 7, 0x1AAD19, 90, 9, 0x1AAD19, -25, 3, 0x1AAD19, -23, 19, 0x1AAD19, 53, 25, 0x1EAF1E, 155, 22, 0x42BB41 }, 90, 162, 825, 502, 876);
        if x1>0 or x2>0 then
            if x1>0 then
                cicky(x1,y1,50);   ---点击添加到通讯录
            else
                cicky(x2,y2,50);   ---点击添加到通讯录
            end
            mSleep(5000);
            for i=1,5 do
                ---需要验证
                if  page_array["page_yanzheng"]:quick_check_page() == true then
                    page_array["page_yanzheng"]:enter()      ---验证
                    break
                end
                ---不需要验证
                if page_array["page_soudaole"]:quick_check_page() == true then
                    cicky(85,84);  --返回添加朋友
                    mSleep(2000);
                    cicky( 501,87,50);   --点叉叉
                    mSleep(2000)
                    log_info("搜索添加好友一次")
                    return true
                end
                if i<=5 then
                    mSleep(1000);
                    ddzc(0x007AFF, -28, 4, 0x007AFF, -45, 8, 0x007AFF, -12, 19, 0x007AFF, 90, 230, 228, 275, 247);    --隐私   /隐私.bmp
                    if x>0 and y>0 then
                        warning_info("添加朋友失败，对方设置了隐私")
                        cicky(x,y,50);  --点击确定
                        mSleep(1000);
                        cicky(85,84);  --返回添加朋友
                        mSleep(2000);
                        cicky( 501,87,50);   --点叉叉
                        mSleep(2000)
                        break
                    end
                end
            end
        else         ----已经是好友的
            cicky(93,88,50);    --返回
            mSleep(2000);
            cicky( 501,87,50);   --点叉叉
            mSleep(2000)
            log_info("搜索添加已经是好友")
            return false
          --  page_array["page_sousuojiahaoyou"]:enter()
        end
    else
        cicky(85,84,50);   ---返回搜索
        mSleep(2000);
        cicky( 501,87,50);   --点叉叉
        mSleep(2000)
        page_array["page_sousuojiahaoyou"]:enter();
    end
end

--step1
function soudaole_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function soudaole_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_soudaole() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function soudaole_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_soudaole();     
end

--step3  --最主要的工作都在这个里面
function soudaole_page:action()
    return action_soudaole();
end

page_array["page_soudaole"] =  soudaole_page:new()
------------------end:  page\wx_sssjh_2.11\page_soudaole.lua-------------------------------------




----------------------begin:  page\wx_sssjh_2.11\page_yanzheng.lua---------------------------------

default_yanzheng_page = {
    page_name = "yanzheng_page",
    page_image_path = nil
}

yanzheng_page = class_base_page:new(default_yanzheng_page);

--朋友验证2.1.1   /朋友验证.bmp
local function check_page_yanzheng( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x9C9C9C, 15, 13, 0x121213, 43, 8, 0x121212, 45, 2, 0x111112, 50, 19, 0x121213, 230, 13, 0x121213, 259, 14, 0x121213, 279, 18, 0x949495, 287, 7, 0x727272, 305, 7, 0xD1D1D1, 357, 18, 0xC4C4C5, 345, 19, 0x9E9E9F, 314, 17, 0xD4D4D4, 550, 2, 0x111112, 592, 20, 0x121813, 585, 8, 0x186317 }, 90, 24, 72, 616, 92);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----搜索手机号朋友验证界面----")
        return true
    else
        return false
    end
end

local function action_yanzheng()     --操作
    if gongneng == 2.11 then
        cicky( 586,253,50);    --点击叉叉
        mSleep(1000);
        inputText(text_yanzheng[math.random(#text_yanzheng)]);   --验证消息
        mSleep(1000);
        cicky( 574,76,50);     --点击发送
        mSleep(5000);
        for i=1,10 do
            if page_array["page_soudaole"]:check_page() == true then
                cicky(85,84);  --返回添加朋友
                mSleep(2000);
                cicky( 501,87,50);   --点叉叉
                mSleep(2000)
                log_info("搜索添加好友一次")
                return true
            ---page_array["page_sousuojiahaoyou"]:enter()
            end
            if i == 10 then   ---卡了  网速不好
                warning_info("搜索添加好友发送验证时网络卡了")
                cicky(85,84);  --点击取消
                mSleep(2000);
                cicky(85,84);  --返回添加朋友
                mSleep(2000);
                cicky( 501,87,50);   --点叉叉
                mSleep(2000)
                return false
            ---page_array["page_sousuojiahaoyou"]:enter()
            end
            mSleep(1000);
        end
    else
        cicky(38,81,50);     --点击取消
        mSleep(1500);
        page_array["page_soudaole"]:enter()
    end
    return true
end

--step1
function yanzheng_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function yanzheng_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_yanzheng() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function yanzheng_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_yanzheng();     
end

--step3  --最主要的工作都在这个里面
function yanzheng_page:action()
    return action_yanzheng();
end

page_array["page_yanzheng"] =  yanzheng_page:new()
------------------end:  page\wx_sssjh_2.11\page_yanzheng.lua-------------------------------------




----------------------begin:  page\wx_jgzh_2.12\page_jiagongzhonghao.lua---------------------------------

default_jiagongzhonghao_page = {
    page_name = "jiagongzhonghao_page",
    page_image_path = nil
}

jiagongzhonghao_page = class_base_page:new(default_jiagongzhonghao_page);

--添加公众号 2.12 /6.5.3版本
local function check_page_jiagongzhonghao_1( ... )   
    mSleep(200)
    x, y = findMultiColorInRegionFuzzy({ 0xEFEFF4, 10, 24, 0x06BF04, -5, 17, 0xBFE4C2, -7, 6, 0x4ACC4A, 52, 8, 0xEFEFF4, 30, 16, 0xE1ECE6, 34, -2, 0xEFEFF4, -514, 7, 0xEFEFF4, -525, 17, 0xEFEFF4, -498, 22, 0xEFEFF4, -534, 22, 0xB6B6B6, -557, 18, 0xEFEFF4, -385, 12, 0xD8D8DA, -393, 18, 0xFFFFFF, -406, 34, 0xFFFFFF, -392, 27, 0xD8D8D9, -420, 15, 0x9A9A9F, -420, 25, 0xC7C7C9, -410, 10, 0xFEFEFE, -424, 9, 0xFFFFFF, -421, 25, 0x909095, -467, 9, 0xFFFFFF, -468, 19, 0xFFFFFF, -463, 26, 0xEEEEEF, -463, 13, 0xFFFFFF }, 90, 12, 60, 621, 96);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----搜索公众号界面----");
        return true
    else
        return false
    end
end

--添加公众号 2.1.2 /6.2.31版本
local function check_page_jiagongzhonghao_2( ... )   
    mSleep(200)
    x, y = findMultiColorInRegionFuzzy({ 0x06BF04, -7, 15, 0xC1E5C4, -46, 0, 0x74D576, -25, 1, 0xEFEFF4, -18, -4, 0xEFEFF4, -414, 9, 0xFFFFFF, -430, 6, 0xFFFFFF, -431, 6, 0xFFFFFF, -441, 21, 0xFFFFFF, -450, 19, 0xFFFFFF, -457, 15, 0xFFFFFF, -469, 4, 0xD0D0D2, -477, 12, 0xEBEBEC, -482, -1, 0xFFFFFF, -497, 9, 0xFFFFFF, -498, 12, 0xDEDEE0, -509, -4, 0xFFFFFF, -509, 11, 0xFFFFFF, -572, -2, 0xFFFFFF, -577, 14, 0xFFFFFF, -580, 15, 0xFFFFFF, -574, 17, 0xFFFFFF }, 90, 32, 70, 612, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true
    else
        return false
    end
end

local function action_jiagongzhonghao()     --操作
    if gongneng == 2.12 then
        --判断需不需要关注指定公众号
        if gongzhonghao ~= nil then
            --判断关注指定公众号没
            if nv_read_nv_item("gzhguanzhu") ~= nil then
                if  nv_read_nv_item("gzhguanzhu") > 10 then   --5天初始化一次
                    nv_write_nv_item("gzhguanzhu",1)  --初始化关注
                    mSleep(1000);
                    inputText(gongzhonghao[math.random(#gongzhonghao)]);     --输入指定公众号
                else
                    local  gzh = nv_read_nv_item("gzhguanzhu") + 1    --每次加1
                    nv_write_nv_item("gzhguanzhu",gzh)   
                    mSleep(1000);
                    inputText(gongzhonghao2[math.random(#gongzhonghao2)]);     --输入随机一个
                end
            else
                nv_write_nv_item("gzhguanzhu",1)  --初始化关注
                mSleep(1000);
                inputText(gongzhonghao[math.random(#gongzhonghao)]);     --输入指定公众号
            end
        else
            mSleep(1000);
            inputText(gongzhonghao2[math.random(#gongzhonghao2)]);     --输入随机一个
        end
        mSleep(1500);
        cicky( 411,913,50);    --点击空格
        mSleep(1000);
        cicky( 592,932,50);     --确认搜索
        mSleep(5000);
        for i=1,5 do
            cicky( 190,295 );      --点击第一个
            mSleep(2000);
            if page_array["page_guanzhu"]:quick_check_page() == true then
                page_array["page_guanzhu"]:enter();
                break
            end
            if i == 5 then
                cicky( 502,83,50);   --点击叉叉
                mSleep(2000);
                cicky( 582,81,50);    --点击取消
                mSleep(1500);
                warning_info("网络卡或者没有这个公众号");
                return false
            end
        end
    else
        cicky( 582,81,50);    --点击取消
        mSleep(1500);
        page_array["page_tianjiapengyou"]:enter();
    end
    return true
end

--step1
function jiagongzhonghao_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function jiagongzhonghao_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_jiagongzhonghao_1() then 
            return true;
        elseif true == check_page_jiagongzhonghao_2() then
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function jiagongzhonghao_page:quick_check_page()  --快速检查是否是在当前页面--
    if true ==  check_page_jiagongzhonghao_1() then 
            return  check_page_jiagongzhonghao_1();
    elseif true == check_page_jiagongzhonghao_2() then
          return  check_page_jiagongzhonghao_2();
    end 
end

--step3  --最主要的工作都在这个里面
function jiagongzhonghao_page:action()
    return action_jiagongzhonghao();
end

page_array["page_jiagongzhonghao"] =  jiagongzhonghao_page:new()
------------------end:  page\wx_jgzh_2.12\page_jiagongzhonghao.lua-------------------------------------




----------------------begin:  page\wx_jgzh_2.12\page_guanzhu.lua---------------------------------

default_guanzhu_page = {
    page_name = "guanzhu_page",
    page_image_path = nil
}

guanzhu_page = class_base_page:new(default_guanzhu_page);

--添加公众号 2.12  关注/ 关注公众号_6.5.3.bmp
local function check_page_guanzhu_1( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x898889, -1, 7, 0x898989, 40, -3, 0x111112, 51, 13, 0x121213, 68, 11, 0x7C7C7D, 66, -3, 0x111112, 10, 287, 0x353535, 32, 295, 0xFFFFFF, 60, 290, 0x000000, 49, 286, 0xFFFFFF, 63, 305, 0xFFFFFF, 124, 291, 0x1F1F1F, 122, 297, 0x5A5A5A }, 90, 28, 73, 153, 381);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----关注公众号界面----");
        return true
    else
        return false
    end
end

--添加公众号 2.12  关注/ 关注公众号_6.2.31.bmp
local function check_page_guanzhu_2( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x111112, -13, 14, 0xFFFFFF, -13, 18, 0xEDEDED, -5, 35, 0x131313, -10, 28, 0x121213, 20, 5, 0x111112, 25, 19, 0x373738, 41, 25, 0x121213, 31, 9, 0xD6D6D6, 22, 33, 0x131313, 51, 12, 0x545354, 51, 18, 0xA8A8A8, 62, 13, 0x787878, 60, 5, 0xE4E4E4, 85, 4, 0xFFFFFF, 94, 4, 0xFFFFFF, 86, 18, 0xFBFBFB, 95, 24, 0xDADADA, 122, 5, 0xFFFFFF, 129, 29, 0x121213, 108, 18, 0x121212, 152, 2, 0x111112, 152, 6, 0x111112, 154, 15, 0xFFFFFF, 161, 24, 0xFFFFFF }, 90, 27, 66, 201, 101);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        return true
    else
        return false
    end
end

local function action_guanzhu()     --操作
    if gongneng == 2.12 then
        xiahua()  --下滑
        xiahua()
        mSleep(500)
        x, y = findImageInRegion(path_guanzhu,4,465 , 619,948 , 0x000000);--关注     
        if x>0 and y>0 then
            cicky(x,y,50);
            mSleep(5000);
            ddzc(0x007AFF, -5, -14, 0x057CFF, -7, 2, 0x007AFF, -17, 10, 0x007AFF, 90, 445, 569, 462, 593);       --访问地理位置
            if x>0 and y>0 then
                cicky(x,y,50);
                mSleep(2000);
            end
            cicky(89,81,50);   --返回微信主界面
            mSleep(2000);
            log_info("关注公众号一次")
            return true
         --   page_array["page_weixinzhu"]:enter();
        else
            mSleep(1000);
            cicky(76,85,50);    --点击返回
            mSleep(2000);
            cicky( 502,83,50);   --点击叉叉
            mSleep(2000);
            return true
        ---page_array["page_jiagongzhonghao"]:enter();
        end   
    else
        cicky(76,85,50);    --点击返回
        mSleep(1500);
        page_array["page_jiagongzhonghao"]:enter();
    end
end

--step1
function guanzhu_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function guanzhu_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_guanzhu_1() then 
            return true;
        elseif true == check_page_guanzhu_2() then
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function guanzhu_page:quick_check_page()  --快速检查是否是在当前页面--
    if true ==  check_page_guanzhu_1() then 
        return  check_page_guanzhu_1();
    elseif true == check_page_guanzhu_2() then
       return  check_page_guanzhu_2();  
    end   
end

--step3  --最主要的工作都在这个里面
function guanzhu_page:action()
    return action_guanzhu();
end

page_array["page_guanzhu"] =  guanzhu_page:new()  


------------------end:  page\wx_jgzh_2.12\page_guanzhu.lua-------------------------------------




----------------------begin:  page\wx_xindepengyou_2.2\page_xindepengyou.lua---------------------------------

default_xindepengyou_page = {
    page_name = "xindepengyou_page",
    page_image_path = nil
}

xindepengyou_page = class_base_page:new(default_xindepengyou_page);

--新的朋友2.2
local function check_page_xindepengyou( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x808081, 10, 21, 0x121213, -22, 11, 0x121212, 32, 10, 0x848484, 47, 11, 0x121212, 68, 6, 0x121112, 70, 20, 0x121213, 78, -2, 0x1B1B1C, 192, -1, 0x111112, 213, 24, 0xFFFFFF, 196, 5, 0x121112, 238, 17, 0x121213, 259, 16, 0x121213, 244, 2, 0x9E9E9E, 281, 16, 0xFFFFFF, 284, 4, 0x111112, 322, 21, 0x121213, 334, 21, 0x121213, 312, -3, 0xFFFFFF, 309, -7, 0x111111, 447, 14, 0x121213, 448, 18, 0xDCDCDC, 486, 13, 0x121212, 488, 13, 0x121212, 520, 10, 0x121212, 528, 19, 0x121213, 556, 11, 0x121212, 556, 11, 0x121212, -28, 1, 0x888889, -33, 6, 0x898889, -27, 22, 0xFFFFFF }, 90, 28, 64, 617, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
          log_info("----新的朋友界面----")
      --  mSleep(1000)
        return true
    else
        return false
    end
end

local function action_xindepengyou()     --操作
    if  gongneng == 2.2  then 
        if nv_read_nv_item("Accept friends")  ~= nil and strategy[1] == "3" then  --养号
            if nv_read_nv_item("Accept friends") > 100 then
                warning_info("不能在添加新的朋友了，回复消息去")
                mSleep(1000)
                gongneng = 1.4 --养号回复
                return page_array["page_xindepengyou"]:enter()
            end
        end
        if num_cs <= 0 then
            warning_info("朋友加完,回复去")
            if strategy[1] == "3" then
                gongneng = 1.4 --养号回复
            else
                gongneng = 1.1 --智能回复
            end
            return page_array["page_xindepengyou"]:enter()
        end
        num_cs = num_cs - 1
        --没朋友                                                                
        ddzc(0x71D01D, 543, 11, 0xC7C7CC, 269, 2, 0x000000, 177, 2, 0x000000, 90, 61, 280, 604, 291) ;
        if x>0 and y>0 then
            warning_info("没有朋友可添加,回复去");
            if strategy[1] == "3" then
                gongneng = 1.4 --养号回复
            else
                gongneng = 1.1 --智能回复
            end
            return page_array["page_xindepengyou"]:enter()
        end
        shanghua()
        mSleep(500)
        if gong_neng == "网络卡" then
            shanghua()
            touchDown(0, 326,471 );
            mSleep(20);
            touchMove(0, 253,471);
            mSleep(20);
            touchMove(0, 163,469 );
            mSleep(20);
            touchUp(0);
            mSleep(1000);
            cicky( 593,474,50);   ---点击删除
            mSleep(2000);
        end
        --接受
        x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, 30, -2, 0x1AAD19, 68, -2, 0x1AAD19, 65, 26, 0x1AAD19, 50, 37, 0x1AAD19, 25, 40, 0x1AAD19, -6, 31, 0x1AAD19, -4, 13, 0x1AAD19, 13, 13, 0x27B227, 39, 17, 0xF4FBF4, 53, 15, 0x1AAD19, 23, 9, 0x1AAD19, 19, 11, 0xFFFFFF, 18, 20, 0x4BBF4B, 49, 29, 0xB8E6B8, 27, 18, 0x1AAD19, 17, 18, 0x48BD47 }, 90, 530, 456, 604, 498);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky( 572,477,50);   --点击接受
            mSleep(5000);
            if nv_read_nv_item("Accept friends")  == nil  then   ---养号
                nv_write_nv_item("Accept friends",1)    --接受加好友数 
            else
                a = nv_read_nv_item("Accept friends") +1 
                nv_write_nv_item(a)
            end
        else
            cicky( 572,477,50);   --点击添加或者验证
            mSleep(5000);
        end
        for i=1,10 do
            --朋友请求过期
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -15, -1, 0x007AFF, -16, 5, 0x007AFF, -16, 12, 0x007AFF, -19, 18, 0x007AFF, 0, 17, 0x007AFF, 39, 25, 0x007AFF, 34, 12, 0x007AFF, 24, 12, 0x007AFF }, 90, 156, 548, 214, 574);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50)  --点击取消
                mSleep(1500)
                touchDown(0, 326,471 );
                mSleep(20);
                touchMove(0, 253,471);
                mSleep(20);
                touchMove(0, 163,469 );
                mSleep(20);
                touchUp(0);
                mSleep(1000);
                cicky( 593,474,50);   ---点击删除
                mSleep(1500);
                return page_array["page_xindepengyou"]:enter();
            end
            ---设置隐私了
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 0, -5, 0x007AFF, 6, -3, 0x007AFF, -19, -3, 0x007AFF, -31, -2, 0x007AFF, -33, 4, 0x007AFF, -39, 10, 0x007AFF, -41, 16, 0x017AFF, -45, 7, 0x007AFF, -51, 4, 0x007AFF, -49, 0, 0x077DFF, -46, -8, 0x007AFF }, 90, 292, 567, 349, 591);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);   --点击确定
                mSleep(1500);
                touchDown(0, 326,471 );
                mSleep(20);
                touchMove(0, 253,471);
                mSleep(20);
                touchMove(0, 163,469 );
                mSleep(20);
                touchUp(0);
                mSleep(1000);
                cicky( 593,474,50);   ---点击删除
                mSleep(1500);
                page_array["page_xindepengyou"]:enter();
                break
            end
            if page_array["page_buyanzheng"]:quick_check_page() == true  then ---不需要验证
                page_array["page_buyanzheng"]:enter();
                break
            end
            if page_array["page_yaoyanzheng"]:quick_check_page() == true  then --要验证
               page_array["page_yaoyanzheng"]:enter();
               break
            end
            if i == 10 then
                warning_info("添加新的朋友时卡住了");
                cicky(  71,85,50);    --返回通讯录
                mSleep(2000);
                gong_neng = "网络卡"
                page_array["page_xindepengyou"]:enter()
            end
            mSleep(1000);
        end
    else
        cicky(  71,85,50);    --返回通讯录
        mSleep(2000);
        page_array["page_tongxunlu"]:enter()
    end
end

--step1
function xindepengyou_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function xindepengyou_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xindepengyou() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function xindepengyou_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_xindepengyou();     
end

--step3  --最主要的工作都在这个里面
function xindepengyou_page:action()
    return action_xindepengyou();
end

page_array["page_xindepengyou"] =  xindepengyou_page:new()    


------------------end:  page\wx_xindepengyou_2.2\page_xindepengyou.lua-------------------------------------




----------------------begin:  page\wx_xindepengyou_2.2\page_buyanzheng.lua---------------------------------

default_buyanzheng_page = {
    page_name = "buyanzheng_page",
    page_image_path = nil
}

buyanzheng_page = class_base_page:new(default_buyanzheng_page);

--新的朋友2.2  不要验证   /不验证.bmp
local function check_page_buyanzheng( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x898889, 2, 13, 0x121213, 38, 2, 0xFFFFFF, 74, 4, 0xA9A9A9, 96, 5, 0x121212, 131, 8, 0x323232, 235, 12, 0xFFFFFF, 282, 15, 0x121213, 303, 5, 0x121212, 350, 8, 0xFFFFFF, 539, 4, 0xFFFFFF, 559, 7, 0xFFFFFF, 573, 6, 0xFFFFFF }, 90, 34, 77, 607, 92);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----添加通讯录朋友不验证界面----")
        return true
    else
        return false
    end
end

local function action_buyanzheng()     --操作
    if gongneng == 2.2 then 
        cicky(  67,82,50);   --返回新的朋友
        mSleep(2000);
        touchDown(0, 326,471 );
        mSleep(20);
        touchMove(0, 253,471);
        mSleep(20);
        touchMove(0, 163,469 );
        mSleep(20);
        touchUp(0);
        mSleep(1000);
        cicky( 593,474,50);   ---点击删除
        mSleep(1500);
        log_info("添加通讯录朋友一次");
        mSleep(math.random(200,5969));
        shanghua();  --会卡住 滑一下
        return page_array["page_xindepengyou"]:enter();
    else
        cicky(  77,87,50);   --点击返回新的朋友
        mSleep(1500);
        page_array["page_xindepengyou"]:enter();
    end
end

--step1;
function buyanzheng_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function buyanzheng_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_buyanzheng() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function buyanzheng_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_buyanzheng();     
end

--step3  --最主要的工作都在这个里面
function buyanzheng_page:action()
    return action_buyanzheng();
end

page_array["page_buyanzheng"] =  buyanzheng_page:new()  


------------------end:  page\wx_xindepengyou_2.2\page_buyanzheng.lua-------------------------------------




----------------------begin:  page\wx_xindepengyou_2.2\page_yaoyanzheng.lua---------------------------------

default_yaoyanzheng_page = {
    page_name = "yaoyanzheng_page",
    page_image_path = nil
}

yaoyanzheng_page = class_base_page:new(default_yaoyanzheng_page);

--新的朋友2.2  添加要验证  /要验证.bmp
local function check_page_yaoyanzheng( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 14, 11, 0x121212, 9, 0, 0x132A14, 7, 21, 0x121213, 28, -4, 0x111112, 47, 21, 0x121213, 46, 6, 0x20D81F, -196, 2, 0xF3F3F3, -181, 23, 0xFFFFFF, -181, 1, 0xDFDFDF, -213, -2, 0x111112, -217, 21, 0x29292A, -234, 6, 0x111112, -269, 0, 0x111112, -252, 22, 0x121213, -254, 8, 0x121112, -304, 6, 0x111112, -290, 7, 0x121112, -304, 26, 0x9B9B9B, -535, 1, 0xFFFFFF, -519, 4, 0x111112, -531, 10, 0x121212, -496, 0, 0x111112, -465, 16, 0x121213, -492, 2, 0x111112 }, 90, 26, 65, 608, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----添加通讯录朋友验证界面----")
        return true
    else
        return false
    end
end

local function action_yaoyanzheng()     --操作
    if gongneng == 2.2 then
        cicky( 586,253,50);    --点击叉叉
        mSleep(1000);
        inputText(text_yanzheng[math.random(#text_yanzheng)]);   --验证消息
        mSleep(1000);
        cicky( 594,86,50);    --点击发送
        mSleep(3000);
        for i=1,7 do
            if page_array["page_xindepengyou"]:quick_check_page() == true then
                mSleep(math.random(1111,2222));
                touchDown(0, 326,471 );
                mSleep(20);
                touchMove(0, 253,471);
                mSleep(20);
                touchMove(0, 163,469 );
                mSleep(20);
                touchUp(0);
                mSleep(1000);
                cicky( 593,474,50);   ---点击删除
                mSleep(1500);
                log_info("添加通讯录朋友一次")
                mSleep(math.random(200,5555));
                page_array["page_xindepengyou"]:enter();
                 break
            end
            --发送失败
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -5, -9, 0x007AFF, -5, 9, 0x007AFF, 10, 8, 0x007AFF, 18, 8, 0x007AFF, 30, 9, 0x007AFF, 38, 7, 0x007AFF, 39, 14, 0x007AFF, 39, -8, 0x007AFF }, 90, 293, 549, 337, 572);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);
                mSleep(1500);
                page_array["page_yaoyanzheng"]:enter()
                break
            end
            if i == 7 then
                warning_info("发送时,网络太卡,返回");
                cicky(  68,81,50);   --点击取消
                mSleep(1500);
                page_array["page_xindepengyou"]:enter();
            end
            mSleep(1000);
        end
    elseif gongneng == 2.31 then
        -- if text_yanzheng ~= nil then
        --     cicky( 586,253,50);    --点击叉叉
        --     mSleep(1000);
        --     inputText(text_yanzheng[math.random(#text_yanzheng)]);   --验证消息
        --     mSleep(1000);
        -- end
        cicky( 594,86,50);    --点击发送
        mSleep(3000);
        for i=1,7 do
            if page_array["page_qunrenxxzl"]:quick_check_page() == true then
                mSleep(1000)
                cicky(89,80,50);    --返回
                mSleep(math.random(2222,6412));
                page_array["page_qunchengyuan"]:enter()
                break
            end
            mSleep(500)
            --操作繁忙
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 0, -14, 0x007AFF, -6, -16, 0x007AFF, -10, -21, 0x007AFF, -23, -21, 0x007AFF, -24, 3, 0x007AFF, 11, -2, 0x007AFF, 26, -5, 0x017AFF, 28, 4, 0x007AFF }, 90, 292, 548, 344, 573);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                touchDown(0, x, y);   -- 点击确定
                mSleep(50)
                touchUp(0);
                mSleep(1500)
                cicky(  68,81,50);   --点击取消
                mSleep(math.random(2222,6451));
                page_array["page_qunrenxxzl"]:enter()
                break
            end
            --发送失败
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -5, -9, 0x007AFF, -5, 9, 0x007AFF, 10, 8, 0x007AFF, 18, 8, 0x007AFF, 30, 9, 0x007AFF, 38, 7, 0x007AFF, 39, 14, 0x007AFF, 39, -8, 0x007AFF }, 90, 293, 549, 337, 572);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);
                mSleep(1500);
                cicky(  68,81,50);   --点击取消
                mSleep(math.random(2222,6432));
                page_array["page_qunrenxxzl"]:enter()
                break
            end
            if i == 7 then
                warning_info("网络卡，加下一个")
                cicky(  68,81,50);   --点击取消
                mSleep(1500);
                if page_array["page_qunrenxxzl"]:check_page() == true then
                    cicky(  68,81,50);   --点击返回
                    mSleep(math.random(2222,5142));
                    return page_array["page_qunchengyuan"]:enter()
                elseif page_array["page_qunchengyuna"]:quick_check_page() == true then
                    return page_array["page_qunchengyuan"]:action()
                else
                    warning_info("加群成员时卡了")
                    return false
                end
            end
            mSleep(500)
        end
    else
        cicky(  68,81,50);   --点击取消
        mSleep(2000);
        if page_array["page_xindepengyou"]:quick_check_page() == true then
            page_array["page_xindepengyou"]:action();
        elseif page_array["page_qunrenxxzl"]:quick_check_page() == true then
            page_array["page_qunrenxxzl"]:action()
        end
    end
    return true
end

--step1
function yaoyanzheng_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function yaoyanzheng_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_yaoyanzheng() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function yaoyanzheng_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_yaoyanzheng();     
end

--step3  --最主要的工作都在这个里面
function yaoyanzheng_page:action()
    return action_yaoyanzheng();
end

page_array["page_yaoyanzheng"] =  yaoyanzheng_page:new()   


------------------end:  page\wx_xindepengyou_2.2\page_yaoyanzheng.lua-------------------------------------




----------------------begin:  page\wx_qunliao_2.3\page_qunliaotian.lua---------------------------------

default_qunliaotian_page = {
    page_name = "qunliaotian_page",
    page_image_path = nil
}

qunliaotian_page = class_base_page:new(default_qunliaotian_page);

 --群聊聊天  3.3  /群聊聊天.bmp
local function check_page_qunliaotian( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -10, 10, 0xFFFFFF, -3, 23, 0xFFFFFF, 14, -6, 0x111111, 34, 20, 0xFFFFFF, 22, -2, 0x999999, 50, 21, 0xFFFFFF, 68, 15, 0xCECECE, 57, -1, 0x111112, 56, 11, 0x141414, 56, 11, 0x141414, 550, 2, 0xFFFFFF, 538, 20, 0xFFFFFF, 575, 18, 0x121212, 559, 3, 0xDEDEDE, 572, 18, 0xFFFFFF, 581, 3, 0x111112, 574, 24, 0x121213, 541, 26, 0xFFFFFF, 534, 20, 0x121213, 536, 1, 0x111112, 565, 9, 0xFFFFFF, 568, 17, 0xFFFFFF, 63, 17, 0x121212, 68, 5, 0x7A7A7A, 47, -1, 0x111112, 41, -1, 0x111112, 17, 6, 0x4A4A4B, 27, 13, 0x121212, 37, 5, 0x111112, 33, -5, 0x111111 }, 90, 28, 66, 619, 98);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群聊天界面----");
        return true
    else
        return false
    end
end

local function action_qunliaotian()     --操作
    if gongneng == 2.32 then   --微信群加好友
        mSleep(2000)
        if strategy[1] == "3"  then
            cicky( 210,914,50);    --点击输入框
            mSleep(2000);
            if text_qunliaotian[1] ~= nil then
                inputText(text_qunliaotian[math.random(#text_qunliaotian)]);
            else
                inputText("你们好")
            end
            mSleep(2000);
            cicky( 445,914,50);  --点击空格
            mSleep(1000);
            cicky( 589,898,50);  --点击发送
            mSleep(3000);
        end
        cicky( 584,86,50);    --点击人头
        mSleep(2000);
        page_array["page_liaotianxinxi"]:enter()
        return true
    elseif gongneng == 1.12 then   --养号
        mSleep(1000)
        cicky( 210,914,50);    --点击输入框
        mSleep(2000);
        if text_huifu[1] ~= nil then
            inputText(text_huifu[math.random(#text_huifu)]);
        else
            inputText("大家好")
        end
        mSleep(2000);
        cicky( 445,914,50);  --点击空格
        mSleep(1000);
        cicky( 589,898,50);  --点击发送
        mSleep(3000);
        cicky(89,80,50);    --返回微信
        mSleep(1500);
        log_info("群里发消息一次")
     --   page_array["page_weixinzhu"]:enter() 
    elseif gongneng == "拉人" or gongneng == "保存" then
        mSleep(2000);
        cicky( 584,86,50);    --点击人头
        mSleep(2000);
        page_array["page_liaotianxinxi"]:enter()
    else
        cicky(89,80,50);    --返回微信
        mSleep(2000);
        page_array["page_weixinzhu"]:enter()
    end
end

--step1
function qunliaotian_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function qunliaotian_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_qunliaotian() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function qunliaotian_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_qunliaotian();     
end

--step3  --最主要的工作都在这个里面
function qunliaotian_page:action()
    return action_qunliaotian();
end

page_array["page_qunliaotian"] =  qunliaotian_page:new() 


------------------end:  page\wx_qunliao_2.3\page_qunliaotian.lua-------------------------------------




----------------------begin:  page\wx_qunliao_2.3\page_qunliao.lua---------------------------------

default_qunliao_page = {
    page_name = "qunliao_page",
    page_image_path = nil
}

qunliao_page = class_base_page:new(default_qunliao_page);

 --群聊   3.3  /群聊.bmp
local function check_page_qunliao( ... )   
    ---有群
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 17, 0, 0x111112, 32, 0, 0x111112, 65, 1, 0x111112, 100, 1, 0x111112, 114, 9, 0x121112, 93, 19, 0x121213, 70, 13, 0xD9D9D9, 28, 13, 0x787878, 6, 11, 0x121212, -15, 21, 0x121213, -1, 28, 0x131213, 69, 21, 0xFFFFFF, 95, 17, 0x676767, 95, 17, 0x676767, 277, 1, 0xE7E7E7, 324, 1, 0x464647, 326, 21, 0x121213, 317, 25, 0xDADADA, 261, 10, 0x888888, 280, 11, 0xFFFFFF, 307, 17, 0x909091, 254, 29, 0x131213, 291, 32, 0x131313, 318, 32, 0xFFFFFF, 313, 19, 0xFFFFFF, 577, 7, 0x111112, 592, 19, 0x121213, 545, 31, 0x131313, 552, 10, 0x121112, 566, 15, 0x121212, 566, 19, 0x121213, 365, 14, 0x121212, 387, 14, 0x121212, 217, 11, 0x121212, 252, 10, 0x121112, 253, 10, 0x121112 }, 90, 14, 68, 621, 100);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群聊有群界面----");
       --mSleep(1000)
        return true
    else
        --没群
        x, y = findMultiColorInRegionFuzzy({ 0x111011, 45, 13, 0x636364, 89, 15, 0x111112, 120, 18, 0x121112, -8, 25, 0x121212, 29, 25, 0x121212, 77, 25, 0xFFFFFF, 106, 26, 0x121212, 1, 39, 0x131213, 60, 36, 0x121213, 85, 33, 0xFFFFFF, 110, 33, 0x121213, 110, 33, 0x121213, 289, 18, 0xFFFFFF, 327, 18, 0xA0A0A0, 334, 19, 0x121112, 277, 25, 0xAAAAAA, 314, 25, 0x121212, 331, 25, 0xFFFFFF, 314, 44, 0x131313, 338, 37, 0x121213, 334, 16, 0x111112, 293, 1, 0x111111, 246, 16, 0x111112, 254, 46, 0x131313, 299, 47, 0x131314, 568, 14, 0x111112, 590, 21, 0x121212, 599, 34, 0x121213, 561, 42, 0x131313, 571, 18, 0x121112, 598, 27, 0x121213 }, 90, 13, 58, 620, 105);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
           log_info("----群聊没群界面----");
         --   mSleep(1000)
            return true
        else
            return false
        end
    end
end

local function action_qunliao()     --操作
    if gongneng == 2.3  then   --微信群加好友
        ----没群
        x, y = findMultiColorInRegionFuzzy({ 0xF6F6F6, 40, 5, 0xFFFFFF, 86, 4, 0xFFFFFF, 104, 4, 0xC5C5C5, 141, 3, 0x858585, 168, 3, 0xE8E8E8, 203, 3, 0xFFFFFF, 120, 40, 0x808080, 199, 43, 0xFFFFFF, 254, 51, 0xFFFFFF, 362, 50, 0xFFFFFF, 309, 34, 0x808080, 330, 2, 0xFFFFFF, 494, 12, 0xFFFFFF, 501, 12, 0xFFFFFF }, 90, 72, 542, 573, 593);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("没群,请加群");
            return false
        end
         if file_exists("/var/touchelf/scripts/shuju.txt") == false then
            os.execute("touch ".."/var/touchelf/scripts/shuju.txt")
            writeStrToFile(1, "/var/touchelf/scripts/shuju.txt");
            writeStrToFile(1, "/var/touchelf/scripts/shuju.txt");
        end
        if jiawan ~= 1 then   --刚运行时
            num_qunjiaren = math.random(tonumber(Min[1]),tonumber(Max[1]))   --群加人参数
        end
        log_info(num_qunjiaren)
        mSleep(1000)
        a = tonumber(getline_1("/var/touchelf/scripts/shuju.txt"));     --第几个群
        b = tonumber(getline("/var/touchelf/scripts/shuju.txt")) - 1 ;  --滑动次数  
        b2 = b + 1  --第几个开始加
        jiawan = 0   ---初始化加群  
        num = 0      ---初始化点击第几个人
        notifyMessage("从第"..a.."个群第"..b2.."个人开始加");
        mSleep(2000);
        rotateScreen(0);
        mSleep(616);
        touchDown(5, 346, 614)
        mSleep(113);
        touchMove(5, 354, 596)
        mSleep(17);
        touchMove(5, 354, 592)
        mSleep(18);
        touchMove(5, 354, 586)
        mSleep(17);
        touchMove(5, 354, 580)
        mSleep(17);
        touchMove(5, 356, 576)
        mSleep(17);
        touchMove(5, 356, 572)
        mSleep(16);
        touchMove(5, 358, 566)
        mSleep(17);
        touchMove(5, 360, 560)
        mSleep(16);
        touchMove(5, 362, 554)
        mSleep(17);
        touchMove(5, 364, 550)
        mSleep(16);
        touchMove(5, 364, 548)
        mSleep(17);
        touchMove(5, 366, 544)
        mSleep(17);
        touchMove(5, 366, 544)
        mSleep(16);
        touchMove(5, 368, 542)
        mSleep(17);
        touchMove(5, 368, 540)
        mSleep(31);
        touchMove(5, 368, 540)
        mSleep(20);
        touchMove(5, 368, 538)
        mSleep(80);
        touchMove(5, 368, 536)
        mSleep(34);
        touchMove(5, 368, 536)
        mSleep(83);
        touchMove(5, 370, 532)
        mSleep(18);
        touchMove(5, 370, 532)
        mSleep(15);
        touchMove(5, 372, 532)
        mSleep(19);
        touchMove(5, 372, 530)
        mSleep(16);
        touchMove(5, 372, 530)
        mSleep(15);
        touchMove(5, 372, 528)
        mSleep(19);
        touchMove(5, 372, 526)
        mSleep(16);
        touchMove(5, 372, 524)
        mSleep(17);
        touchMove(5, 374, 524)
        mSleep(15);
        touchMove(5, 374, 522)
        mSleep(18);
        touchMove(5, 374, 522)
        mSleep(16);
        touchMove(5, 374, 520)
        mSleep(18);
        touchMove(5, 376, 516)
        mSleep(16);
        touchMove(5, 376, 516)
        mSleep(15);
        touchMove(5, 376, 516)
        mSleep(19);
        touchMove(5, 376, 514)
        mSleep(16);
        touchMove(5, 378, 514)
        mSleep(15);
        touchMove(5, 378, 514)
        mSleep(19);
        touchMove(5, 378, 512)
        mSleep(31);
        touchMove(5, 378, 512)
        mSleep(35);
        touchMove(5, 378, 512)
        mSleep(18);
        touchMove(5, 378, 510)
        mSleep(15);
        touchMove(5, 380, 510)
        mSleep(49);
        touchMove(5, 382, 510)
        mSleep(50);
        touchMove(5, 382, 510)
        mSleep(100);
        touchUp(5)
        mSleep(1500);
        a1 = a - 1   --点击第几个群 初始为1    +a1
        if a <= 7 then 
            touchDown(0 ,173/640*w,175+110*a1)          --点击第一个群
            mSleep(50);
            touchUp(0);
            mSleep(2000);
            if page_array["page_qunliaotian"]:quick_check_page() == true then
                gongneng = 2.32
                page_array["page_qunliaotian"]:enter()
            elseif page_array["page_qunliao"]:quick_check_page() == true then
                warning_info("没有第"..a.."个群，下次重新从第一个群开始加");
                local f = io.open("var/touchelf/scripts/shuju.txt","w+");  --更新文件
                f:write(1 .. "\r\n");
                f:write(1 .. "\r\n");
                f:close();
                mSleep(1000);
                cicky(89,80,50);    --返回通讯录
                mSleep(1500);
                if strategy[1] == "3" then
                    gongneng = 1.4 --养号回复
                else
                    gongneng = 1.1 --智能回复
                end
                return page_array["page_tongxunlu"]:enter()
            else
                warning_info("进入群聊天错误");
                mSleep(1000)
                --点击到搜索了
                x, y = findMultiColorInRegionFuzzy({ 0x06BF04, 32, 2, 0xB4E2B8, 39, 31, 0xEFEFF4, 39, 31, 0xEFEFF4, -11, 22, 0xEFEFF4, -13, 19, 0x06BF04, 6, 6, 0xEFEFF4, 22, 7, 0x9EDEA0, 38, 8, 0xEFEFF4, 38, 8, 0xEFEFF4 }, 90, 562, 68, 614, 99);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    cicky(x,y,50);
                    mSleep(1500);
                    return page_array["page_qunliao"]:enter()
                end
            end
        else
            a2 = math.floor(a/7)   --取整数
            mSleep(1000)
            for i= 1, 7*a2 do    ---滑动的次数
                mSleep(200)
                m = getColor( 65,178)
                n = getColor(208,181)
                z = getColor(244,184)
                o = getColor(  39,156 )
                move( 355,347 ,355,215 ,5)
                mSleep(700);
                m2 = getColor( 65,178)
                n2 = getColor(208,181)
                z2 = getColor(244,184)
                o2 = getColor(  39,156 )
                mSleep(200)
                if z2 == z and n2 == n and m2 == m and o2 == o  then     ---滑不动了
                    e = 7*a2-i+1  ---剩余没滑的次数
                    if e > 7 then
                        warning_info("没有第"..a.."个群，下次重新从第一个群开始加");
                        local f = io.open("var/touchelf/scripts/shuju.txt","w+");  --更新文件
                        f:write(1 .. "\r\n");
                        f:write(1 .. "\r\n");
                        f:close();
                        mSleep(1000);
                        cicky(89,80,50);    --返回通讯录
                        mSleep(1500);
                        if strategy[1] == "3" then
                            gongneng = 1.4 --养号回复
                        else
                            gongneng = 1.1 --智能回复
                        end
                        return page_array["page_tongxunlu"]:enter()
                    end
                    mSleep(1000)
                    touchDown(0 ,173/640*w,175+110*(e-1))          --点击第e个群
                    mSleep(50);
                    touchUp(0);
                    mSleep(2000);
                    break
                end
            end
            if page_array["page_qunliaotian"]:quick_check_page() == true then
                gongneng = 2.32
                page_array["page_qunliaotian"]:enter()
            elseif page_array["page_qunliao"]:quick_check_page() == true then
                warning_info("没有第"..a.."个群，下次重新从第一个群开始加");
                local f = io.open("var/touchelf/scripts/shuju.txt","w+");  --更新文件
                f:write(1 .. "\r\n");
                f:write(1 .. "\r\n");
                f:close();
                mSleep(1000);
                cicky(89,80,50);    --返回通讯录
                mSleep(1500);
                if strategy[1] == "3" then
                    gongneng = 1.4 --养号回复
                else
                    gongneng = 1.1 --智能回复
                end
                return page_array["page_tongxunlu"]:enter() 
            end
        end
    else
        cicky(89,80,50);    --返回通讯录
        mSleep(1500);
        page_array["page_tongxunlu"]:enter()
    end
    return true
end

--step1
function qunliao_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function qunliao_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_qunliao() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function qunliao_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_qunliao();     
end

--step3  --最主要的工作都在这个里面
function qunliao_page:action()
    return action_qunliao();
end

page_array["page_qunliao"] =  qunliao_page:new() 


------------------end:  page\wx_qunliao_2.3\page_qunliao.lua-------------------------------------




----------------------begin:  page\wx_qunliao_2.3\page_liaotianxinxi.lua---------------------------------

default_liaotianxinxi_page = {
    page_name = "liaotianxinxi_page",
    page_image_path = nil
}

liaotianxinxi_page = class_base_page:new(default_liaotianxinxi_page);

 --聊天信息  2.3 /聊天信息.bmp
local function check_page_liaotianxinxi( ... )   
    ---10-
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 44, 1, 0x7F7F80, 58, 7, 0x979697, 26, 7, 0xA8A7A8, 53, 10, 0x121212, 64, 22, 0xFFFFFF, 67, 22, 0x121213, 211, 7, 0x121112, 304, -2, 0x111112, 307, -2, 0xFFFFFF, 214, 8, 0xFFFFFF, 253, 8, 0x121112, 295, 8, 0x121112, 318, 12, 0xFFFFFF, 232, 18, 0x565657, 289, 18, 0x121213, 291, 18, 0x121213, 543, 1, 0x111112, 575, 9, 0x121112, 583, 17, 0x121213, 516, 4, 0x111112, 560, 24, 0x121213 }, 90, 44, 67, 627, 93);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群聊天信息10-界面----");
        return true
    else
        --10+
       x, y = findMultiColorInRegionFuzzy({ 0x111112, 64, 10, 0xC3C2C3, 93, 11, 0x121112, 3, 17, 0xFFFFFF, 47, 16, 0xFFFFFF, 90, 15, 0x121212, 34, 24, 0xC9C9C9, 70, 21, 0x121213, 72, 21, 0x121213, 197, 0, 0x111112, 242, 0, 0x111112, 262, 0, 0x111112, 308, 0, 0x111112, 319, 0, 0xFFFFFF, 201, 14, 0x121212, 234, 14, 0xFFFFFF, 265, 14, 0x121212, 308, 14, 0x121212, 315, 14, 0xFFFFFF, 269, 27, 0x121213, 304, 27, 0x121213, 312, 27, 0x121213, 562, 12, 0x121212, 606, 6, 0x111112, 563, 22, 0x121213, 607, 22, 0x121213, 550, 25, 0x121213, 593, 43, 0x131314 }, 90, 22, 67, 629, 110);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----群聊天信息10+界面----");
            return true
        else
            --100+
            x, y = findMultiColorInRegionFuzzy({ 0x111111, 43, 4, 0x111112, 67, 12, 0x807F80, 6, 14, 0x121112, 36, 12, 0xA8A7A8, 54, 12, 0xC3C2C3, 62, 23, 0x8E8E8E, 64, 23, 0x7F7F7F, 71, 23, 0x939394, 188, 3, 0x111112, 270, 2, 0x111112, 311, 0, 0x111111, 313, 0, 0x111111, 182, 24, 0xA1A1A2, 240, 24, 0x121213, 279, 22, 0x121213, 296, 20, 0x121212, 190, 38, 0x131313, 262, 29, 0x898989, 294, 24, 0x1B1B1C, 297, 22, 0xFFFFFF, 540, 1, 0x111112, 600, 10, 0x111112, 564, 22, 0x121213, 580, 22, 0x121213, 561, 33, 0x131213 }, 90, 32, 64, 632, 102);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("----群聊天信息100+界面----");
                return true
            else
                return false
            end
        end
    end
end

local function action_liaotianxinxi()     --操作
    if gongneng == 2.32 or gongneng == "拉人"  then   --微信群加好友
        xiahua();  --下滑
        xiahua();
        xiahua();
        mSleep(1000)
        rotateScreen(0);
        mSleep(1074);
        touchDown(4, 380, 404)
        mSleep(52);
        touchMove(4, 380, 412)
        mSleep(15);
        touchMove(4, 380, 418)
        mSleep(16);
        touchMove(4, 380, 424)
        mSleep(82);
        touchMove(4, 380, 430)
        mSleep(2);
        touchMove(4, 378, 440)
        mSleep(1);
        touchMove(4, 374, 452)
        mSleep(1);
        touchMove(4, 372, 462)
        mSleep(1);
        touchMove(4, 370, 472)
        mSleep(169);
        touchMove(4, 368, 482)
        mSleep(2);
        touchMove(4, 366, 490)
        mSleep(3);
        touchMove(4, 364, 496)
        mSleep(1);
        touchMove(4, 364, 502)
        mSleep(1);
        touchMove(4, 362, 508)
        mSleep(1);
        touchMove(4, 362, 512)
        mSleep(7);
        touchMove(4, 362, 518)
        mSleep(3);
        touchMove(4, 362, 522)
        mSleep(53);
        touchMove(4, 362, 530)
        mSleep(1);
        touchMove(4, 362, 538)
        mSleep(8);
        touchMove(4, 362, 548)
        mSleep(2);
        touchMove(4, 362, 558)
        mSleep(33);
        touchMove(4, 360, 568)
        mSleep(17);
        touchMove(4, 360, 578)
        mSleep(16);
        touchMove(4, 360, 586)
        mSleep(68);
        touchMove(4, 360, 596)
        mSleep(48);
        touchMove(4, 360, 604)
        mSleep(1);
        touchMove(4, 360, 614)
        mSleep(29);
        touchMove(4, 360, 620)
        mSleep(1);
        touchMove(4, 360, 626)
        mSleep(1);
        touchMove(4, 360, 630)
        mSleep(1);
        touchMove(4, 360, 634)
        mSleep(16);
        touchMove(4, 360, 638)
        mSleep(1);
        touchMove(4, 358, 642)
        mSleep(118);
        touchMove(4, 358, 646)
        mSleep(16);
        touchMove(4, 358, 650)
        mSleep(17);
        touchMove(4, 358, 656)
        mSleep(17);
        touchMove(4, 358, 662)
        mSleep(33);
        touchMove(4, 358, 668)
        mSleep(34);
        touchMove(4, 358, 676)
        mSleep(32);
        touchMove(4, 356, 684)
        mSleep(1);
        touchMove(4, 356, 690)
        mSleep(28);
        touchMove(4, 354, 700)
        mSleep(1);
        touchMove(4, 354, 710)
        mSleep(1);
        touchMove(4, 352, 718)
        mSleep(1);
        touchMove(4, 352, 728)
        mSleep(16);
        touchMove(4, 352, 736)
        mSleep(35);
        touchMove(4, 352, 742)
        mSleep(1);
        touchMove(4, 352, 746)
        mSleep(10);
        touchMove(4, 352, 748)
        mSleep(1);
        touchMove(4, 352, 750)
        mSleep(1);
        touchMove(4, 352, 750)
        mSleep(2);
        touchMove(4, 352, 752)
        mSleep(9);
        touchMove(4, 352, 754)
        mSleep(1);
        touchMove(4, 352, 754)
        mSleep(2);
        touchMove(4, 350, 756)
        mSleep(1);
        touchMove(4, 350, 756)
        mSleep(1);
        touchMove(4, 350, 758)
        mSleep(535);
        touchDown(5, 378, 390)
        mSleep(67);
        touchMove(5, 374, 406)
        mSleep(24);
        touchMove(5, 374, 412)
        mSleep(8);
        touchMove(5, 374, 420)
        mSleep(32);
        touchMove(5, 374, 428)
        mSleep(2);
        touchMove(5, 368, 444)
        mSleep(29);
        touchMove(5, 364, 460)
        mSleep(2);
        touchMove(5, 356, 480)
        mSleep(30);
        touchMove(5, 350, 498)
        mSleep(2);
        touchMove(5, 346, 514)
        mSleep(55);
        touchMove(5, 342, 530)
        mSleep(2);
        touchMove(5, 340, 552)
        mSleep(16);
        touchMove(5, 338, 566)
        mSleep(16);
        touchMove(5, 336, 580)
        mSleep(15);
        touchMove(5, 336, 596)
        mSleep(17);
        touchMove(5, 334, 608)
        mSleep(120);
        touchMove(5, 334, 620)
        mSleep(17);
        touchMove(5, 334, 632)
        mSleep(16);
        touchMove(5, 334, 644)
        mSleep(1);
        touchMove(5, 334, 656)
        mSleep(16);
        touchMove(5, 334, 666)
        mSleep(16);
        touchMove(5, 334, 674)
        mSleep(1);
        touchMove(5, 334, 682)
        mSleep(32);
        touchMove(5, 334, 696)
        mSleep(46);
        touchMove(5, 334, 702)
        mSleep(2);
        touchMove(5, 336, 708)
        mSleep(1);
        touchMove(5, 336, 712)
        mSleep(1);
        touchMove(5, 338, 716)
        mSleep(1);
        touchMove(5, 338, 720)
        mSleep(80);
        touchMove(5, 338, 724)
        mSleep(2);
        touchMove(5, 338, 726)
        mSleep(32);
        touchMove(5, 338, 730)
        mSleep(31);
        touchMove(5, 338, 734)
        mSleep(1);
        touchMove(5, 338, 738)
        mSleep(2);
        touchMove(5, 338, 740)
        mSleep(1);
        touchMove(5, 340, 742)
        mSleep(1);
        touchMove(5, 340, 744)
        mSleep(7);
        touchMove(5, 340, 746)
        mSleep(1);
        touchMove(5, 340, 748)
        mSleep(1);
        touchMove(5, 340, 748)
        mSleep(1);
        touchMove(5, 340, 750)
        mSleep(1);
        touchMove(5, 340, 750)
        mSleep(52);
        touchUp(5)

        mSleep(495);
        touchDown(6, 406, 336)
        mSleep(72);
        touchMove(6, 390, 362)
        mSleep(2);
        touchMove(6, 390, 368)
        mSleep(34);
        touchMove(6, 388, 376)
        mSleep(33);
        touchMove(6, 384, 388)
        mSleep(48);
        touchMove(6, 376, 406)
        mSleep(48);
        touchMove(6, 368, 422)
        mSleep(3);
        touchMove(6, 360, 440)
        mSleep(1);
        touchMove(6, 354, 456)
        mSleep(52);
        touchMove(6, 348, 474)
        mSleep(13);
        touchMove(6, 342, 494)
        mSleep(2);
        touchMove(6, 338, 512)
        mSleep(1);
        touchMove(6, 334, 530)
        mSleep(7);
        touchMove(6, 332, 546)
        mSleep(2);
        touchMove(6, 330, 558)
        mSleep(6);
        touchMove(6, 330, 570)
        mSleep(67);
        touchMove(6, 328, 580)
        mSleep(1);
        touchMove(6, 328, 590)
        mSleep(32);
        touchMove(6, 328, 596)
        mSleep(2);
        touchMove(6, 328, 602)
        mSleep(33);
        touchMove(6, 326, 608)
        mSleep(32);
        touchMove(6, 326, 614)
        mSleep(1);
        touchMove(6, 326, 620)
        mSleep(62);
        touchMove(6, 326, 626)
        mSleep(1);
        touchMove(6, 326, 632)
        mSleep(1);
        touchMove(6, 326, 638)
        mSleep(25);
        touchMove(6, 326, 646)
        mSleep(1);
        touchMove(6, 326, 654)
        mSleep(2);
        touchMove(6, 326, 662)
        mSleep(1);
        touchMove(6, 326, 670)
        mSleep(1);
        touchMove(6, 326, 676)
        mSleep(6);
        touchMove(6, 326, 696)
        mSleep(67);
        touchMove(6, 324, 698)
        mSleep(33);
        touchMove(6, 324, 702)
        mSleep(17);
        touchMove(6, 324, 706)
        mSleep(50);
        touchMove(6, 324, 710)
        mSleep(16);
        touchMove(6, 324, 714)
        mSleep(34);
        touchMove(6, 324, 716)
        mSleep(17);
        touchMove(6, 324, 720)
        mSleep(32);
        touchMove(6, 324, 722)
        mSleep(1);
        touchMove(6, 324, 724)
        mSleep(66);
        touchMove(6, 324, 726)
        mSleep(32);
        touchMove(6, 324, 728)
        mSleep(32);
        touchMove(6, 324, 730)
        mSleep(16);
        touchMove(6, 324, 732)
        mSleep(54);
        touchMove(6, 324, 736)
        mSleep(17);
        touchMove(6, 324, 738)
        mSleep(17);
        touchMove(6, 324, 740)
        mSleep(16);
        touchMove(6, 324, 742)
        mSleep(34);
        touchMove(6, 324, 746)
        mSleep(16);
        touchMove(6, 324, 748)
        mSleep(16);
        touchMove(6, 324, 752)
        mSleep(33);
        touchMove(6, 324, 756)
        mSleep(17);
        touchMove(6, 324, 758)
        mSleep(17);
        touchMove(6, 324, 762)
        mSleep(17);
        touchMove(6, 322, 764)
        mSleep(17);
        touchMove(6, 322, 766)
        mSleep(32);
        touchMove(6, 322, 768)
        mSleep(13);
        touchMove(6, 322, 770)
        mSleep(2);
        touchMove(6, 322, 772)
        mSleep(1);
        touchMove(6, 322, 776)
        mSleep(1);
        touchMove(6, 322, 778)
        mSleep(5);
        touchMove(6, 322, 780)
        mSleep(2);
        touchMove(6, 322, 784)
        mSleep(1);
        touchMove(6, 322, 786)
        mSleep(1);
        touchMove(6, 322, 788)
        mSleep(1);
        touchMove(6, 322, 790)
        mSleep(5);
        touchMove(6, 322, 792)
        mSleep(2);
        touchMove(6, 322, 794)
        mSleep(2);
        touchMove(6, 322, 798)
        mSleep(1);
        touchMove(6, 322, 800)
        mSleep(2);
        touchMove(6, 322, 802)
        mSleep(18);
        touchUp(6)
        touchUp(4)
        mSleep(2000);
            --自己的群0
        x, y = findMultiColorInRegionFuzzy({ 0xFAFAFA, 13, 0, 0xFFFFFF, 53, 0, 0xEFEFEF, 80, 0, 0xFFFFFF, 84, 0, 0xFFFFFF, 119, 0, 0xFFFFFF, 124, 0, 0x3C3C3C, 132, 0, 0xFFFFFF, -3, 12, 0xCCCCCC, 77, 12, 0xFFFFFF, 101, 12, 0x525252, 133, 12, 0x818181, -1, 19, 0xFFFFFF, 93, 19, 0xEDEDED, 105, 19, 0x0F0F0F, 128, 19, 0x9E9E9E, 128, 19, 0x9E9E9E, 128, 19, 0x9E9E9E }, 90, 48, 367, 184, 386);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);   --点击全部群成员
            mSleep(1500);
            if gongneng == 2.32 then
                c = b2 + num_qunjiaren  --更新的人数
            end
            page_array["page_qunchengyuan"]:enter()
            return true
        end
        --别人的群0
        x, y = findMultiColorInRegionFuzzy({ 0x656565, 25, 0, 0x585858, 62, 3, 0x030303, 104, 4, 0xA7A7A7, 137, 4, 0xFFFFFF, 45, 11, 0xEFEFEF, 94, 11, 0x151515, 126, 11, 0xFFFFFF, 142, 9, 0x4F4F4F, 3, 26, 0xF2F2F2, 72, 24, 0xFFFFFF, 108, 20, 0x000000, 128, 19, 0x020202, 129, 19, 0x242424, 141, 16, 0xFFFFFF }, 90, 44, 502, 186, 528);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);   --点击全部群成员
            mSleep(1500);
            if gongneng == 2.32 then
                c = b2 + num_qunjiaren  --更新的人数
            end
            page_array["page_qunchengyuan"]:enter()
            return true
        end
        --别人的群1_5c 
        a1 = getColor(182,639-176);
        b1 = getColor(155,641-176);    
        if a1==0x020202 and b1==0x000000 then
            cicky(182,639-176,50);
            mSleep(1000); 
            if gongneng == 2.32 then
                c = b2 + num_qunjiaren  --更新的人数
            end
            page_array["page_qunchengyuan"]:enter()
            return true         
        end
        --别人的群2
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 24, 1, 0xFFFFFF, 81, 1, 0x131313, 127, 1, 0xFFFFFF, 143, 3, 0x4E4E4E, 8, 6, 0x8B8B8B, 60, 10, 0xF5F5F5, 95, 10, 0xFFFFFF, 138, 10, 0xFFFFFF, 13, 21, 0x999999, 69, 21, 0x131313, 115, 21, 0xF8F8F8, 141, 20, 0xE7E7E7, 140, 16, 0xCFCFCF }, 90, 40, 415, 183, 436);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);   --点击全部群成员
            mSleep(1500);
            if gongneng == 2.32 then
                c = b2 + num_qunjiaren  --更新的人数
            end
            page_array["page_qunchengyuan"]:enter()
            return true
        end
        --别人的群3
        x, y = findMultiColorInRegionFuzzy({ 0xF7F7F7, 50, 1, 0xFFFFFF, 83, 1, 0xFFFFFF, 111, 3, 0x5F5F5F, 127, 3, 0xFCFCFC, 30, 10, 0x282828, 74, 10, 0x171717, 106, 10, 0xFFFFFF, 135, 10, 0x505050, 6, 22, 0xFFFFFF, 79, 22, 0xFFFFFF, 109, 20, 0xFFFFFF, 128, 19, 0xFFFFFF, 133, 18, 0x000000, 133, 18, 0x000000 }, 90, 49, 341, 184, 363);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
             cicky(x,y,50);   --点击全部群成员
            mSleep(1500);
            if gongneng == 2.32 then
                c = b2 + num_qunjiaren  --更新的人数
            end
            page_array["page_qunchengyuan"]:enter()
            return true
        end
        warning_info("进入全部群成员错误");
        mSleep(1000)
        return false
    elseif gongneng == "保存" then 
        xiahua();  --下滑
        xiahua();
        xiahua();
        rotateScreen(0);
        mSleep(557);
        touchDown(2, 458, 404)
        mSleep(63);
        touchMove(2, 454, 412)
        mSleep(2);
        touchMove(2, 454, 422)
        mSleep(52);
        touchMove(2, 450, 432)
        mSleep(15);
        touchMove(2, 446, 444)
        mSleep(1);
        touchMove(2, 440, 456)
        mSleep(31);
        touchMove(2, 436, 464)
        mSleep(27);
        touchMove(2, 432, 472)
        mSleep(1);
        touchMove(2, 428, 482)
        mSleep(2);
        touchMove(2, 426, 488)
        mSleep(1);
        touchMove(2, 422, 496)
        mSleep(22);
        touchMove(2, 420, 502)
        mSleep(1);
        touchMove(2, 416, 510)
        mSleep(247);
        touchMove(2, 414, 516)
        mSleep(2);
        touchMove(2, 412, 522)
        mSleep(1);
        touchMove(2, 410, 530)
        mSleep(16);
        touchMove(2, 408, 536)
        mSleep(1);
        touchMove(2, 406, 542)
        mSleep(30);
        touchMove(2, 404, 548)
        mSleep(2);
        touchMove(2, 402, 552)
        mSleep(25);
        touchMove(2, 398, 558)
        mSleep(2);
        touchMove(2, 396, 564)
        mSleep(1);
        touchMove(2, 394, 572)
        mSleep(1);
        touchMove(2, 390, 580)
        mSleep(1);
        touchMove(2, 388, 588)
        mSleep(1);
        touchMove(2, 384, 596)
        mSleep(48);
        touchMove(2, 382, 608)
        mSleep(1);
        touchMove(2, 378, 618)
        mSleep(4);
        touchMove(2, 376, 626)
        mSleep(1);
        touchMove(2, 374, 638)
        mSleep(8);
        touchMove(2, 372, 650)
        mSleep(1);
        touchMove(2, 370, 662)
        mSleep(2);
        touchMove(2, 368, 674)
        mSleep(21);
        touchMove(2, 368, 686)
        mSleep(1);
        touchMove(2, 368, 696)
        mSleep(26);
        touchMove(2, 368, 706)
        mSleep(22);
        touchMove(2, 368, 716)
        mSleep(1);
        touchMove(2, 366, 724)
        mSleep(1);
        touchMove(2, 366, 732)
        mSleep(31);
        touchMove(2, 366, 740)
        mSleep(1);
        touchMove(2, 366, 746)
        mSleep(1);
        touchMove(2, 366, 752)
        mSleep(16);
        touchMove(2, 366, 758)
        mSleep(1);
        touchMove(2, 366, 762)
        mSleep(67);
        touchMove(2, 366, 768)
        mSleep(17);
        touchMove(2, 366, 776)
        mSleep(16);
        touchMove(2, 366, 784)
        mSleep(17);
        touchMove(2, 366, 792)
        mSleep(32);
        touchMove(2, 364, 800)
        mSleep(16);
        touchMove(2, 364, 808)
        mSleep(17);
        touchMove(2, 364, 814)
        mSleep(16);
        touchMove(2, 364, 820)
        mSleep(16);
        touchMove(2, 362, 824)
        mSleep(16);
        touchMove(2, 362, 826)
        mSleep(30);
        touchMove(2, 362, 830)
        mSleep(1);
        touchMove(2, 362, 832)
        mSleep(17);
        touchMove(2, 362, 832)
        mSleep(16);
        touchMove(2, 362, 834)
        mSleep(3);
        touchMove(2, 362, 836)
        mSleep(1);
        touchMove(2, 362, 836)
        mSleep(1);
        touchMove(2, 362, 838)
        mSleep(5);
        touchMove(2, 360, 838)
        mSleep(1);
        touchMove(2, 360, 840)
        mSleep(9);
        touchMove(2, 360, 840)
        mSleep(22);
        touchMove(2, 358, 840)
        mSleep(11);
        touchMove(2, 358, 840)
        mSleep(65);
        touchUp(2)
        mSleep(1500);
        --自己的群  消息免打扰
        x1, y1 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 15, 0, 0xFFFFFF, 46, 1, 0xFFFFFF, 89, 4, 0xFFFFFF, 140, 4, 0xFFFFFF, 166, 12, 0xFFFFFF, 143, 30, 0xFFFFFF, 140, 31, 0xFFFFFF, 75, 31, 0xF7F7F7, 30, 31, 0xFFFFFF, 17, 9, 0xAFAFAF, 108, 14, 0xFFFFFF, 140, 14, 0xFFFFFF, 141, 14, 0xFFFFFF, 46, 8, 0x6C6C6C, 9, 11, 0x787878 }, 90, 42, 249, 208, 280);
         --别人的群  消息免打扰
        x2, y2 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 13, 7, 0xFFFFFF, 26, 7, 0xFCFCFC, 64, 11, 0xFFFFFF, 75, 11, 0x141414, 95, 6, 0xFFFFFF, 117, 6, 0xFFFFFF, 137, 6, 0xFFFFFF, 159, 6, 0xFFFFFF, 163, 7, 0xFFFFFF, 154, 16, 0x555555, 121, 20, 0xBABABA, 50, 17, 0xF5F5F5, 17, 17, 0xFDFDFD, 9, 13, 0x000000, 24, 3, 0x1F1F1F, 44, -1, 0x141414, 63, -1, 0x151515, 99, -1, 0x151515, 142, 6, 0xECECEC, 160, 15, 0xFFFFFF, 148, 24, 0xFFFFFF, 49, 26, 0xFFFFFF, 2, 25, 0xFFFFFF, -1, 15, 0xFFFFFF, 44, 6, 0x232323, 87, 6, 0xFFFFFF, 138, 9, 0x101010, 153, 13, 0x030303 }, 90, 34, 127, 198, 154);
        if x1 ~= -1  then  -- 如果找到了
            --点击按钮1
            x3, y3 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 12, 29, 0xFFFFFF, -3, 36, 0xFEFEFE, -16, 14, 0xF9F9F9, -4, 2, 0xFFFFFF, -10, 27, 0xFBFBFB, -42, 21, 0xFFFFFF, -46, 3, 0xFFFFFF, -13, 3, 0xFDFDFD, -50, 24, 0xFFFFFF, -60, 5, 0xFFFFFF, -60, -2, 0xFFFFFF, -60, 23, 0xFFFFFF, -61, 8, 0xFFFFFF, -62, 21, 0xFFFFFF, -32, 34, 0xFFFFFF, -9, 29, 0xFBFBFB, -3, 0, 0xFFFFFF, -35, -3, 0xFFFFFF, -48, 4, 0xFFFFFF, -17, 28, 0xF5F5F5, -16, 28, 0xF6F6F6 }, 90, 525, 244, 599, 283);
            if x3 ~= -1 and y3 ~= -1 then  -- 如果找到了
                cicky(x3,y3,50)
                mSleep(1500)
                log_info("群消息添加到免打扰1")
            else
                log_info("群消息已添加到免打扰")
                mSleep(1000)
            end
        elseif x2 ~= -1 then
            --点击按钮2
            x4, y4 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 24, 0, 0xFFFFFF, 38, 1, 0xE2E2E2, 64, 3, 0xFFFFFF, 73, 9, 0xFFFFFF, 73, 10, 0xFFFFFF, 63, 22, 0xFFFFFF, 35, 30, 0xEFEFEF, 14, 25, 0xFFFFFF, 8, 17, 0xFFFFFF, 38, 9, 0xF7F7F7, 59, 12, 0xFEFEFE, 17, 20, 0xFFFFFF, 3, 9, 0xFFFFFF, 29, 7, 0xFFFFFF, 49, 11, 0xFBFBFB, 61, 16, 0xFFFFFF, 62, 17, 0xFFFFFF }, 90, 528, 132, 601, 162);
            if x4 ~= -1 and y4 ~= -1 then  -- 如果找到了
                cicky(x4,y4,50)
                mSleep(1500)
                log_info("群消息添加到免打扰2")
            else
                log_info("群消息已添加到免打扰")
                mSleep(1000)
            end
        else
            warning_info("群消息添加到免打扰错误1")
        end
        --别人的群保存
        x, y = findMultiColorInRegionFuzzy({ 0x040404, 37, 6, 0x010101, 68, 6, 0xF6F6F6, 129, 6, 0xFFFFFF, 182, 6, 0x1A1A1A, 191, 6, 0xFFFFFF, 12, 7, 0xFFFFFF, 55, 7, 0xFFFFFF, 130, 7, 0xFFFFFF, 187, 7, 0xFDFDFD, 51, 21, 0xFFFFFF, 117, 21, 0xFFFFFF, 151, 21, 0x040404, 163, 21, 0xFFFFFF, 178, 20, 0xF4F4F4, 202, 20, 0xFFFFFF, 183, 18, 0xB9B9B9 }, 90, 40, 427, 242, 448);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            mSleep(500)
            --没保存
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -8, 16, 0xFFFFFF, -13, -1, 0xFFFFFF, 1, 9, 0xFFFFFF, -18, 22, 0xFFFFFF, -20, 9, 0xFFFFFF }, 90, 523, 428, 544, 451);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50)
                mSleep(1500);
                if text_quntianjia[1] ~= nil then
                    gongneng = "拉人"
                    mSleep(1000)
                    return page_array["page_liaotianxinxi"]:enter()
                end
                log_info("保存到群聊")
                gongneng = 1.2  --删除这条消息
                cicky(89,80,50);    --返回
                mSleep(1500);
                return page_array["page_qunliaotian"]:enter()
            else
                if text_quntianjia[1] ~= nil then
                    gongneng = "拉人"
                    mSleep(1000)
                    return page_array["page_liaotianxinxi"]:enter()
                end
                log_info("已经保存到群聊")
                gongneng = 1.2  --删除这条消息
                cicky(89,80,50);    --返回
                mSleep(1500);
                return page_array["page_qunliaotian"]:enter()
            end
        end
        --自己的群保存
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 20, 4, 0xE5E5E5, 59, 6, 0xA4A4A4, 119, 6, 0xFFFFFF, 157, 7, 0xFFFFFF, 182, 7, 0xFFFFFF, 7, 16, 0xCACACA, 116, 18, 0xFFFFFF, 170, 18, 0x0A0A0A, 110, 31, 0xE1E1E1, 151, 31, 0xFFFFFF, 172, 30, 0xFFFFFF, 172, 30, 0xFFFFFF }, 90, 47, 297, 229, 328);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            mSleep(500)
            --没保存
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 6, 20, 0xFFFFFF, -16, 14, 0xFFFFFF, -18, -10, 0xFFFFFF, 6, -1, 0xFFFFFF, -10, 29, 0xFFFFFF, -18, 21, 0xFFFFFF, -18, 9, 0xFFFFFF }, 90, 528, 293, 552, 332);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50)
                mSleep(1500);
                 if text_quntianjia[1] ~= nil then
                    gongneng = "拉人"
                    mSleep(1000)
                    return page_array["page_liaotianxinxi"]:enter()
                end
                log_info("保存到群聊")
                gongneng = 1.2  --删除这条消息
                cicky(89,80,50);    --返回
                mSleep(1500);
                return page_array["page_qunliaotian"]:enter()
            else
                if text_quntianjia[1] ~= nil then
                    gongneng = "拉人"
                    mSleep(1000)
                    return page_array["page_liaotianxinxi"]:enter()
                end
                log_info("已经保存到群聊")
                gongneng = 1.2  --删除这条消息
                cicky(89,80,50);    --返回
                mSleep(1500);
                return page_array["page_qunliaotian"]:enter()
            end
        end
        mSleep(1000)
        log_info("保存到群聊失败");
        mSleep(500)
        notifyMessage("保存到群聊失败");
        mSleep(1000);
        gongneng = 1.2  --删除
        cicky(89,80,50);    --返回
        mSleep(1500);
        return page_array["page_qunliaotian"]:enter()
    else
        cicky(89,80,50);    --返回
        mSleep(1500);
        page_array["page_qunliaotian"]:enter()
    end
end

--step1
function liaotianxinxi_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function liaotianxinxi_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_liaotianxinxi() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function liaotianxinxi_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_liaotianxinxi();     
end

--step3  --最主要的工作都在这个里面
function liaotianxinxi_page:action()
    return action_liaotianxinxi();
end

page_array["page_liaotianxinxi"] =  liaotianxinxi_page:new() 


------------------end:  page\wx_qunliao_2.3\page_liaotianxinxi.lua-------------------------------------




----------------------begin:  page\wx_qunliao_2.3\page_qunchengyuan.lua---------------------------------

default_qunchengyuan_page = {
    page_name = "qunchengyuan_page",
    page_image_path = nil
}

qunchengyuan_page = class_base_page:new(default_qunchengyuan_page);

 --群成员  2.3  /群成员.bmp
local function check_page_qunchengyuan( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x111112, -5, 9, 0xFFFFFF, 8, 24, 0x121213, 23, 3, 0x2B2B2C, 48, 19, 0x121213, 55, 7, 0x121112, 70, 6, 0x111112, 75, 7, 0xC3C2C3, 39, 7, 0xABABAB, 32, 1, 0x4B4B4C, 213, 23, 0x303031, 237, 13, 0xFFFFFF, 222, 4, 0x111112, 220, 14, 0xAAAAAA, 245, 23, 0x121213, 280, 14, 0x121212, 272, -3, 0x111112, 271, 8, 0x121112, 301, 30, 0x131313, 311, 12, 0x9C9C9C, 303, 6, 0x111112, 299, 3, 0x111112, 300, 22, 0xFFFFFF, 553, 33, 0x131313, 585, 15, 0x121212, 532, 1, 0x111112, 574, 0, 0x111112, 579, 12, 0x121212, 546, 19, 0x121213, 543, 18, 0x20D81F, 566, 11, 0x121212, 572, 11, 0x121212 }, 90, 29, 66, 619, 102);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群成员10-界面----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -11, 11, 0xFFFFFF, 5, 22, 0x121213, 16, 9, 0x121112, 78, 23, 0x121213, 69, 17, 0x434344, 41, 8, 0x121112, 107, 8, 0x121112, 198, 4, 0x111112, 217, 26, 0x121213, 228, 5, 0x7A7A7B, 210, -2, 0x111112, 210, 0, 0x696969, 212, 9, 0xCFCECF, 247, 0, 0x111112, 237, 23, 0xFFFFFF, 263, 18, 0x121213, 245, 4, 0x484849, 256, 6, 0xFFFFFF, 285, 23, 0xFFFFFF, 294, 12, 0x919191, 293, -1, 0x111112, 294, 22, 0x121213, 271, 14, 0x121212, 527, 5, 0x111112, 567, 31, 0x131313, 578, 17, 0x20D81F, 503, 5, 0x111112, 579, 5, 0x165B16, 597, 6, 0x111112, 536, 26, 0x1DAD1C, 552, 5, 0x111112 }, 90, 27, 67, 635, 100);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----群成员10+界面----");
            return true
        else
           x, y = findMultiColorInRegionFuzzy({ 0x111112, 81, 23, 0x121213, 51, 10, 0x121112, 22, 8, 0x121112, 33, 11, 0xFFFFFF, 114, 24, 0x121213, 114, 24, 0x121213, 168, 10, 0x121112, 199, 5, 0x111112, 226, 19, 0x121213, 196, 3, 0x7B7B7C, 246, 7, 0xFFFFFF, 255, 26, 0xFEFEFE, 237, 16, 0xFFFFFF, 281, 21, 0x121213, 288, 25, 0x1A1A1B, 294, 6, 0xFFFFFF, 289, 26, 0xFFFFFF, 542, 2, 0x1EC81D, 551, 23, 0x121213, 586, 15, 0x20D81F, 577, 8, 0x165015, 596, 8, 0x121112, 563, 26, 0x20D81F, 578, 26, 0x20D81F, 198, 5, 0x111112, 276, 6, 0xFFFFFF, 288, 8, 0xC5C5C5, 222, 28, 0x131213, 269, 27, 0x121213, 286, 27, 0x121213 }, 90, 30, 68, 626, 96);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("----群成员100+界面----");
                return true
            else
                return false
            end
        end
    end
end

local function action_qunchengyuan()     --操作
    if gongneng == 2.32  then   --微信群加好友
        mSleep(1000)
        rotateScreen(0);
        mSleep(616);
        touchDown(5, 346, 614)
        mSleep(113);
        touchMove(5, 354, 596)
        mSleep(17);
        touchMove(5, 354, 592)
        mSleep(18);
        touchMove(5, 354, 586)
        mSleep(17);
        touchMove(5, 354, 580)
        mSleep(17);
        touchMove(5, 356, 576)
        mSleep(17);
        touchMove(5, 356, 572)
        mSleep(16);
        touchMove(5, 358, 566)
        mSleep(17);
        touchMove(5, 360, 560)
        mSleep(16);
        touchMove(5, 362, 554)
        mSleep(17);
        touchMove(5, 364, 550)
        mSleep(16);
        touchMove(5, 364, 548)
        mSleep(17);
        touchMove(5, 366, 544)
        mSleep(17);
        touchMove(5, 366, 544)
        mSleep(16);
        touchMove(5, 368, 542)
        mSleep(17);
        touchMove(5, 368, 540)
        mSleep(31);
        touchMove(5, 368, 540)
        mSleep(20);
        touchMove(5, 368, 538)
        mSleep(80);
        touchMove(5, 368, 536)
        mSleep(34);
        touchMove(5, 368, 536)
        mSleep(83);
        touchMove(5, 370, 532)
        mSleep(18);
        touchMove(5, 370, 532)
        mSleep(15);
        touchMove(5, 372, 532)
        mSleep(19);
        touchMove(5, 372, 530)
        mSleep(16);
        touchMove(5, 372, 530)
        mSleep(15);
        touchMove(5, 372, 528)
        mSleep(19);
        touchMove(5, 372, 526)
        mSleep(16);
        touchMove(5, 372, 524)
        mSleep(17);
        touchMove(5, 374, 524)
        mSleep(15);
        touchMove(5, 374, 522)
        mSleep(18);
        touchMove(5, 374, 522)
        mSleep(16);
        touchMove(5, 374, 520)
        mSleep(18);
        touchMove(5, 376, 516)
        mSleep(16);
        touchMove(5, 376, 516)
        mSleep(15);
        touchMove(5, 376, 516)
        mSleep(19);
        touchMove(5, 376, 514)
        mSleep(16);
        touchMove(5, 378, 514)
        mSleep(15);
        touchMove(5, 378, 514)
        mSleep(19);
        touchMove(5, 378, 512)
        mSleep(31);
        touchMove(5, 378, 512)
        mSleep(35);
        touchMove(5, 378, 512)
        mSleep(18);
        touchMove(5, 378, 510)
        mSleep(15);
        touchMove(5, 380, 510)
        mSleep(49);
        touchMove(5, 382, 510)
        mSleep(50);
        touchMove(5, 382, 510)
        mSleep(100);
        touchUp(5)
        mSleep(1500);
        if b > 0 then  --滑动次数
            for i= 1, b2 do
                mSleep(200)
                m = getColor( 65,178  )
                n = getColor( 208,181 )
                z = getColor( 244,184 )
                o = getColor(  39,156 )
                p = getColor(  62,542 )
                q = getColor(  70,652 )
                move( 355,347 ,355,215 ,5)
                mSleep(700);
                m2 = getColor( 65,178)
                n2 = getColor(208,181)
                z2 = getColor(244,184)
                o2 = getColor( 39,156)
                p2 = getColor(  62,542 )
                q2 = getColor(  70,652 )
                mSleep(200)
                if z2 == z and n2 == n and m2 == m and o2 == o and p2 == p and q2 == q then
                    mSleep(1000)
                    i2 = i-1+ 7   ---有多少人
                    warning_info("群里总共有"..i2.."人")
                    mSleep(1000);
                    bb = i2 - b2   ---还剩几个人
                    mSleep(500)
                    if bb <= 0 then
                        mSleep(1000)
                        cicky( 285,884,50)     --点击最后一个人
                        mSleep(2000);
                        jiawan = 1  --加完
                        if page_array["page_qunrenxxzl"]:quick_check_page() == true then
                            return page_array["page_qunrenxxzl"]:enter()
                        elseif page_array["page_qunchengyuan"]:quick_check_page() == true then
                            gongneng = 2.31 
                            return page_array["page_qunchengyuan"]:enter()
                        else
                            warning_info("点击群成员错误")
                            return false
                        end
                    else
                        num = 7 - bb   --点击第几个人
                        touchDown(0 ,173,175+110*num)          --点击第num+1个人
                        mSleep(50);
                        touchUp(0);
                        mSleep(2000);
                        return page_array["page_qunrenxxzl"]:enter()
                    end
                end
                i = i + 1
            end
        end
        mSleep(1000)
        touchDown(0 ,173,175)          --点击第一个人
        mSleep(50);
        touchUp(0);
        mSleep(2000);
        return page_array["page_qunrenxxzl"]:enter()
    elseif gongneng == 2.31 then
        gongneng = 2.32    --加好友
        log_info("群加好友一次")
        mSleep(1000)
        num_qunjiaren = num_qunjiaren -1
        num = num + 1 
        log_info(num_qunjiaren)
        mSleep(1000)
        if jiawan == 1 then   ---群加完了  加下个群
            notifyMessage("第"..a.."个群好友已经加完,继续加下一个")
            local file = io.open("var/touchelf/scripts/shuju.txt","w+");  --更新文件
            file:write(a+1 .. "\r\n");
            file:write(1 .. "\r\n");
            file:close();
            gongneng = 2.3   --重新开始加
            return page_array["page_qunchengyuan"]:enter()
        end
        if  num_qunjiaren <= 0 then
            mSleep(1000)
            local file = io.open("var/touchelf/scripts/shuju.txt","w+");  --更新文件
            file:write(a .. "\r\n");
            file:write(c .. "\r\n");
            file:close();
            if strategy[1] == "3" then
                gongneng = 1.4 --养号回复
            else
                gongneng = 1.1 --智能回复
            end
            warning_info("群好友加完了，回复去");
            return page_array["page_qunchengyuan"]:enter()
        end
        if num <= 6 then 
            touchDown(0 ,173,175+110*num)          --点击第num+1个人
            mSleep(50);
            touchUp(0);
            mSleep(2000);
            return page_array["page_qunrenxxzl"]:enter()
        elseif num > 6 and jiawan == 1 then
                notifyMessage("第"..a.."个群好友已经加完,继续加下一个")
                local file = io.open("var/touchelf/scripts/shuju.txt","w+");  --更新文件
                file:write(a+1 .. "\r\n");
                file:write(1 .. "\r\n");
                file:close();
                gongneng = 2.3   --重新开始加
                return page_array["page_qunchengyuan"]:enter()
        else
           for i= 1, 7 do
                mSleep(200)
                m = getColor( 65,178  )
                n = getColor( 208,181 )
                z = getColor( 244,184 )
                o = getColor(  39,156 )
                p = getColor(  62,542 )
                q = getColor(  70,652 )
                mSleep(200)
                move( 355,347 ,355,215 ,5)
                mSleep(700);
                m2 = getColor( 65,178)
                n2 = getColor(208,181)
                z2 = getColor(244,184)
                o2 = getColor( 39,156)
                p2 = getColor(  62,542 )
                q2 = getColor(  70,652 )
                if z2 == z and n2 == n and m2 == m and o2 == o and p2 == p and q2 == q then
                    aa = 7-i+1
                    if aa > 6 then
                        mSleep(1000)
                        cicky(253,922,50)     --点击最后一个人
                        mSleep(2000);
                        jiawan = 1  --加完
                        return page_array["page_qunrenxxzl"]:enter()
                    else
                        num =  aa - 1  
                        touchDown(0 ,173,175+110*num)          --点击第num+1个人
                        mSleep(50);
                        touchUp(0);
                        mSleep(2000);
                        return page_array["page_qunrenxxzl"]:enter()
                    end
                end
            end
            num = 0   --初始化
            touchDown(0 ,173,175+110*num)          --点击第num+1个人
            mSleep(50);
            touchUp(0);
            mSleep(2000);
            return page_array["page_qunrenxxzl"]:enter()
        end
    elseif gongneng == "拉人" then   --拉人
        cicky( 594,80,50);  --点击添加
        mSleep(1500);
        page_array["page_xuanzelianxiren"]:enter()
    else
        cicky(89,80,50);    --返回
        mSleep(1500);
        page_array["page_liaotianxinxi"]:enter()
    end
    return true
end

--step1
function qunchengyuan_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function qunchengyuan_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_qunchengyuan() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function qunchengyuan_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_qunchengyuan();     
end

--step3  --最主要的工作都在这个里面
function qunchengyuan_page:action()
    return action_qunchengyuan();
end

page_array["page_qunchengyuan"] =  qunchengyuan_page:new() 


------------------end:  page\wx_qunliao_2.3\page_qunchengyuan.lua-------------------------------------




----------------------begin:  page\wx_qunliao_2.3\page_xuanzelianxiren.lua---------------------------------

default_xuanzelianxiren_page = {
    page_name = "xuanzelianxiren_page",
    page_image_path = nil
}

xuanzelianxiren_page = class_base_page:new(default_xuanzelianxiren_page);

 --选择联系人.bmp
local function check_page_xuanzelianxiren( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x8C8C8D, 19, -4, 0x111112, 17, 12, 0xF3F3F3, -1, 7, 0x121112, 35, 3, 0x111112, 52, 27, 0x131313, 54, 12, 0xD5D5D5, 49, 12, 0xD5D5D5, 221, 3, 0xD9D9D9, 221, 14, 0x121213, 261, 27, 0x131313, 267, 14, 0x121213, 261, 25, 0x131213, 265, 16, 0xFFFFFF, 294, 4, 0x111112, 302, 19, 0xD1D1D2, 292, 25, 0xBFBFBF, 292, 10, 0xB6B6B6, 325, 15, 0xFFFFFF, 343, 20, 0x9D9D9E, 322, 19, 0x121213, 320, 21, 0x121213, 371, 11, 0xFFFFFF, 356, 21, 0x121213, 383, 16, 0x121213, 399, 23, 0x121213, 373, 7, 0x121112, 388, 7, 0x121112, 544, 9, 0x515151, 595, 3, 0x111112, 552, 21, 0x121213, 545, 9, 0x5A5A5A, 602, 5, 0x121112, 555, 5, 0x212021 }, 90, 22, 67, 625, 98);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群拉人选择联系人界面----");
        return true
    else
        return false
    end
end

local function action_xuanzelianxiren()     --操作
    if gongneng == "拉人"  then   --微信群加好友
        cicky(  96,180,50);   --点击搜索
        mSleep(1500);
        if text_quntianjia[1] == nil then
            warning_info("请设置群拉好友的微信号")
            return false
        end
        inputText(text_quntianjia[math.random(#text_quntianjia)])
        mSleep(1500);
        cicky( 589,930,50);  --点击搜索
        mSleep(5000)
        ---已经在群里面
        x, y = findMultiColorInRegionFuzzy({ 0xC9C9C9, 16, 11, 0xC9C9C9, 15, 24, 0xC9C9C9, -2, 31, 0xC9C9C9, -14, 28, 0xC9C9C9, -9, 2, 0xC9C9C9, -1, 2, 0xC9C9C9, 3, 6, 0xC9C9C9, 7, 12, 0xC9C9C9, 8, 13, 0xC9C9C9, 9, 14, 0xE7E7E7, 4, 23, 0xCBCBCB, -4, 23, 0xFFFFFF, -8, 14, 0xC9C9C9, 12, 16, 0xC9C9C9, 16, 16, 0xC9C9C9, 11, 13, 0xFEFEFE, -7, 21, 0xE1E1E1 }, 90, 23, 284, 53, 315);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("已经在群里面");
            mSleep(1000)
            cicky(89,80,50);    --点击取消
            mSleep(1500);
            gongneng = 1.2 --删除
            return page_array["page_qunchengyuan"]:enter()
        else
            ---点击添加
            x, y = findMultiColorInRegionFuzzy({ 0xC9C9C9, 15, 6, 0xC9C9C9, 19, 22, 0xFFFFFF, 6, 48, 0xFFFFFF, 10, 35, 0xFFFFFF, 15, 43, 0xFFFFFF, 17, 36, 0xD7D7D7, 4, 40, 0xFFFFFF, -17, 33, 0xFFFFFF, -20, 27, 0xFFFFFF, -23, 22, 0xC9C9C9, -22, 15, 0xCFCFCF, -11, 3, 0xD0D0D0, 9, 3, 0xE8E8E8, 6, 17, 0xFFFFFF, -1, 29, 0xFFFFFF, -9, 11, 0xFFFFFF, -19, -3, 0xFFFFFF, -19, 23, 0xFFFFFF, -19, 51, 0xFFFFFF, -17, 39, 0xFFFFFF, 6, -10, 0xFFFFFF, 13, 15, 0xFFFFFF, 11, 47, 0xFFFFFF, -8, 43, 0xDADADA, -17, 36, 0xC9C9C9 }, 90, 17, 270, 59, 331);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                  cicky(  40,295,50);   --点击添加
                  mSleep(1500)
                  warning_info("拉人进入群一次")
                  mSleep(1000)
            else
                warning_info("群拉人没有好友");
                mSleep(1000)
                cicky(89,80,50);    --点击取消
                mSleep(1500);
                gongneng = 1.2 --删除
                return page_array["page_qunchengyuan"]:enter()
            end
        end
        cicky( 599,88,50);   --点击确定
        mSleep(3000);
        for i=1 ,10 do
            ---人数过多 确认邀请
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 0, -5, 0x007AFF, -5, -5, 0x007AFF, -9, -8, 0x007AFF, 21, 6, 0x007AFF, 27, -8, 0x007AFF, 34, 11, 0x007AFF, -8, 16, 0x007AFF }, 90, 440, 572, 483, 596);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);  --点击邀请
                mSleep(3000);
                  --知道了
                x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -34, -4, 0x007AFF, -35, 13, 0x007AFF, -23, 13, 0x057CFF, 12, 17, 0x007AFF, 41, 12, 0x007AFF, 43, -1, 0x007AFF, 76, -3, 0x007AFF, 74, 7, 0x007AFF }, 90, 262, 549, 373, 570);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    cicky(x,y,50);  --点击知道了
                    mSleep(1500);
                    gongneng = 1.2  --删除这条消息
                    gong_neng = "邀请"   --删除2次
                    return page_array["page_qunchengyuan"]:enter()
                else
                    warning_info("邀人进群时网络卡了");
                    mSleep(1000)
                    return false
                end
            end
          
            if page_array["page_qunchengyuan"]:quick_check_page() == true then
                gongneng = 1.2   ---删除
                return page_array["page_qunchengyuan"]:enter()
            end
            mSleep(1000)
            if i == 10 then
                warning_info("添加朋友进群时网络卡");
                return false
            end
        end
    else
        cicky(89,80,50);    --点击取消
        mSleep(1500);
        page_array["page_qunchengyuan"]:enter()
    end
    return true
end

--step1
function xuanzelianxiren_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function xuanzelianxiren_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xuanzelianxiren() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function xuanzelianxiren_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_xuanzelianxiren();     
end

--step3  --最主要的工作都在这个里面
function xuanzelianxiren_page:action()
    return action_xuanzelianxiren();
end

page_array["page_xuanzelianxiren"] =  xuanzelianxiren_page:new() 


------------------end:  page\wx_qunliao_2.3\page_xuanzelianxiren.lua-------------------------------------




----------------------begin:  page\wx_qunliao_2.3\page_qunrenxxzl.lua---------------------------------

default_qunrenxxzl_page = {
    page_name = "qunrenxxzl_page",
    page_image_path = nil
}

qunrenxxzl_page = class_base_page:new(default_qunrenxxzl_page);

 --群成员详细资料2.3
local function check_page_qunrenxxzl( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x111111, 61, 7, 0x111112, 81, 9, 0xFFFFFF, 101, 12, 0x111112, 109, 19, 0xFEFEFE, 103, 30, 0xA5A5A5, 85, 33, 0xFFFFFF, 46, 35, 0x131213, 18, 34, 0x121213, 13, 23, 0x121212, 45, 23, 0x121212, 66, 23, 0x121212, 83, 23, 0x121212, 219, 15, 0x121112, 244, 12, 0x303031, 287, 12, 0x424243, 336, 13, 0xFFFFFF, 364, 13, 0x111112, 244, 17, 0xFFFFFF, 344, 18, 0xCBCBCB, 359, 18, 0xFFFFFF, 251, 34, 0x121213, 339, 34, 0x121213, 363, 36, 0x131213, 397, 12, 0x111112, 430, 20, 0x121212, 458, 20, 0x121212, 458, 20, 0x121212 }, 90, 25, 61, 483, 97);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群成员详细资料界面----");
        return true
    else
        return false
    end
end

local function action_qunrenxxzl()     --操作
    if gongneng == 2.32  then   --微信群加好友
        xiahua()
        mSleep(500)
        gongneng = 2.31
        --添加到通讯录1
        x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, 44, 4, 0x78CF78, 98, 5, 0xA6DFA6, 159, 3, 0x33B632, 191, 3, 0xF1FAF1, 204, 8, 0x24B123, 206, 26, 0x1AAD19, 206, 28, 0xFFFFFF, 186, 23, 0x30B52F, 169, 14, 0x1AAD19, 154, 16, 0xF2FAF2, 148, 23, 0x83D383, 114, 23, 0x1AAD19, 107, 11, 0x1AAD19, 118, 14, 0x5CC55C, 74, 22, 0x52C151, 79, 14, 0x63C762, 83, 19, 0x1AAD19, 50, 29, 0x68C967, 40, 16, 0x1AAD19, 61, 21, 0x1AAD19, 39, 33, 0x1AAD19, -5, 19, 0x1AAD19, 7, 12, 0x1AAD19, 18, 29, 0x1AAD19, 3, 27, 0x22B021 }, 90, 211, 830, 422, 863);
         if  x ~= -1 and y ~= -1  then  -- 如果找到了
            touchDown(0,x,y);
            mSleep(50);
            touchUp(0)
            mSleep(5000)
        end
        --添加到通讯录2
        x, y = findMultiColorInRegionFuzzy({ 0x3CB93B, 31, 3, 0x1AAD19, 88, 3, 0xFBFDFA, 99, 2, 0x1AAD19, 144, -1, 0x1AAD19, 171, 1, 0x1AAD19, 182, 7, 0x3EBA3D, 195, 16, 0x1AAD19, 195, 24, 0x1AAD19, 182, 21, 0xF2FAF1, 157, 12, 0x1AAD19, 122, 10, 0x74CD73, 111, 10, 0x1AAD19, 59, 10, 0xFFFFFF, 19, 10, 0x3FBA3E, -10, 10, 0x1AAD19, -5, 24, 0x1AAD19, 28, 25, 0x1AAD19, 76, 23, 0xFFFFFF, 115, 22, 0x1AAD19, 158, 22, 0x1AAD19, 186, 16, 0x1AAD19, 187, 7, 0x27B227, 44, 7, 0x1AAD19, 11, 7, 0xFFFFFF, -2, 5, 0x1AAD19, -10, 17, 0x1AAD19, -10, 23, 0x1AAD19 }, 90, 210, 658, 415, 684);
        if  x ~= -1 and y ~= -1  then  -- 如果找到了
            touchDown(0,x,y);
            mSleep(50);
            touchUp(0)
            mSleep(5000)
        end
        --添加通讯录3
        x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, 18, 6, 0x1AAD19, 23, 6, 0x1AAD19, 82, 10, 0x1AAD19, 116, 10, 0x1AAD19, 134, 10, 0x1AAD19, 186, 10, 0x1AAD19, 208, 8, 0x1AAD19, 200, 34, 0x1AAD19, 189, 30, 0x1AAD19, 144, 34, 0x1AAD19, 68, 36, 0x1AAD19, 37, 35, 0xFFFFFF, 14, 35, 0xE9F7E8, 0, 19, 0x1AAD19, 9, 16, 0x1AAD19, 23, 16, 0x1AAD19, 69, 18, 0x1AAD19, 117, 18, 0xFFFFFF, 148, 18, 0x8ED68D, 184, 18, 0xFFFFFF, 204, 15, 0x24B123, 174, 1, 0x1AAD19, 41, 0, 0x1AAD19, 3, 2, 0x1AAD19, -8, 10, 0x1AAD19, 3, 25, 0xC6EBC6, 112, 39, 0x1AAD19, 238, 34, 0x1AAD19, 246, 29, 0x1AAD19, 221, 22, 0x1AAD19, 221, 22, 0x1AAD19 }, 90, 208, 740, 462, 779);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            touchDown(0,x,y);
            mSleep(50);
            touchUp(0)
            mSleep(5000)
        end
        for i=1,10 do
          ---设置隐私了
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 0, -5, 0x007AFF, 6, -3, 0x007AFF, -19, -3, 0x007AFF, -31, -2, 0x007AFF, -33, 4, 0x007AFF, -39, 10, 0x007AFF, -41, 16, 0x017AFF, -45, 7, 0x007AFF, -51, 4, 0x007AFF, -49, 0, 0x077DFF, -46, -8, 0x007AFF }, 90, 292, 567, 349, 591);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);   --点击确定
                mSleep(1500);
                cicky(89,80,50);    --返回
                mSleep(1500);
                return page_array["page_qunchengyuan"]:enter()
            end
            if page_array["page_yaoyanzheng"]:quick_check_page() == true then
                return page_array["page_yaoyanzheng"]:enter()
            end
              --操作繁忙
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 0, -14, 0x007AFF, -6, -16, 0x007AFF, -10, -21, 0x007AFF, -23, -21, 0x007AFF, -24, 3, 0x007AFF, 11, -2, 0x007AFF, 26, -5, 0x017AFF, 28, 4, 0x007AFF }, 90, 292, 548, 344, 573);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                touchDown(0, x, y);   -- 点击确定
                mSleep(50)
                touchUp(0);
                mSleep(1500)
                cicky(89,80,50);    --返回
                mSleep(math.random(2222,4444));
                return page_array["page_qunchengyuan"]:enter()
            end
            if page_array["page_qunrenxxzl"]:quick_check_page() == true then
                mSleep(1000)
                cicky(89,80,50);    --返回
                mSleep(math.random(2222,4444));
                return page_array["page_qunchengyuan"]:enter()
            end
            mSleep(1000)
        end
    else
        cicky(89,80,50);    --返回
        mSleep(1500);
        page_array["page_qunchengyuan"]:enter()
    end
    return true
end

--step1
function qunrenxxzl_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function qunrenxxzl_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_qunrenxxzl() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function qunrenxxzl_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_qunrenxxzl();     
end

--step3  --最主要的工作都在这个里面
function qunrenxxzl_page:action()
    return action_qunrenxxzl();
end

page_array["page_qunrenxxzl"] =  qunrenxxzl_page:new() 


------------------end:  page\wx_qunliao_2.3\page_qunrenxxzl.lua-------------------------------------




----------------------begin:  page\wx_sousuozhuanfa_2.4\page_sousuo.lua---------------------------------

default_sousuo_page = {
    page_name = "sousuo_page",
    page_image_path = nil
}

sousuo_page = class_base_page:new(default_sousuo_page);

---搜索  /2.4   
local function check_page_sousuo( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -13, 13, 0xFFFFFF, -23, 7, 0xFFFFFF, -23, 6, 0xFFFFFF, 71, 3, 0xFFFFFF, 72, 4, 0xD3D3D5, 63, 22, 0xFFFFFF, 39, 7, 0xFFFFFF, 55, 5, 0x98989C, 55, 5, 0x98989C, 447, 11, 0xC5C5C5, 462, 15, 0xFFFFFF, 456, -5, 0xFFFFFF, 445, 8, 0xC5C5C5, 549, -3, 0x1EC31D, 586, -2, 0xEFEFF4, 563, 13, 0x7BD77C, 524, 8, 0xEFEFF4, 520, -2, 0x59D05A, 549, 2, 0xEFEFF4, 268, 138, 0xFFFFFF, 301, 173, 0xFFFFFF, 260, 184, 0xFFFFFF, 245, 151, 0xFFFFFF, 68, 207, 0xFFFFFF, 113, 144, 0xFFFFFF, 80, 140, 0xBBBBBB, 77, 171, 0xFFFFFF, 433, 188, 0xFFFFFF, 484, 176, 0xFFFFFF, 473, 142, 0xFFFFFF, 461, 167, 0x555555 }, 90, 26, 67, 635, 279);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----转发说说搜索朋友界面----");
       -- mSleep(1000)
        return true
    else
        return false
    end
end

local function action_sousuo()     --执行这个页面的操作--
    if gongneng == 2.4 then  -- 转发朋友圈
        if text_pengyou[1] ~= nil then
            inputText(text_pengyou[math.random(#text_pengyou)]);
        else
            warning_info("没有朋友可转发")
        end
        mSleep(5000);   
        for i=1,5 do
            --等待   搜索.bmp 
            x, y = findMultiColorInRegionFuzzy({ 0x5D5D5D, -2, 86, 0xF6F8F3, 30, 110, 0xF7F8F6, 31, 110, 0xF7F8F7, 194, -1, 0xFFFFFF, 202, 107, 0xFAFAFA, 212, 109, 0x5F5F5F, 398, 12, 0x555555, 382, 109, 0xFAFAFA, 445, 109, 0xFAFAFA, 450, 109, 0xFAFAFA }, 90, 115, 233, 567, 344);
            if x <0 and y<0 then  -- 如果找到了
               mSleep(500)
               break
            end
            mSleep(1000)
        end
        ---没搜到
        x, y = findMultiColorInRegionFuzzy({ 0xFEFEFE, 15, 2, 0xFEFEFE, 8, 22, 0xFEFEFE, 50, 11, 0xFEFEFE, 87, 1, 0xC9C9C9, 80, 11, 0xF2F2F2, 77, 5, 0x000000 }, 90, 151, 166, 238, 188);
        if x>0 and y>0 then 
            warning_info("转发说说时没有这个好友1");
            mSleep(2000);
            cicky( 502,79,50);   --点击叉叉
            mSleep(2000);
            cicky(  590,86,50);   --点击取消
            mSleep(1500);
            return false 
        else
            cicky( 187,260,50);   --点击第一个
            mSleep(2000);
            if page_array["page_liaotian"]:check_page() == true then
                page_array["page_liaotian"]:action()
            elseif page_array["page_txlzl"]:quick_check_page() == true then
                xiahua()
                mSleep(1000)
                x, y = findColorInRegion(0x1AAD19,30,466, 623,917);  --区域找色
                if x ~= -1 and y ~= -1 then  
                    cicky(x,y,50);  --点击添加
                    mSleep(2000);
                    if page_array["page_yaoyanzheng"]:check_page() == true then
                        cicky( 594,86,50);    --点击发送
                        mSleep(3000);
                        if page_array["page_txlzl"]:check_page() == true then
                           cicky(  80,86,50);   --点击返回
                            mSleep(1500);
                            cicky(  590,86,50);   --点击取消
                            mSleep(1500);
                            return true
                        else
                            warning_info("搜索好友添加发送验证时，网络卡")
                            return false
                        end
                    end
                end
            else
                warning_info("转发说说时没有这个好友2");
                cicky(  80,86,50);   --点击返回
                mSleep(1500);
                cicky(  590,86,50);   --点击取消
                mSleep(1500);
                return false
                --page_array["page_tongxunlu"]:enter()
            end
        end
    elseif gongneng == 1.5 then  --跟新号发消息
        if nv_read_nv_item("xinhao_info") == nil then  --读取新号的信息
            warning_info("还没有添加新号为好友")
            mSleep(1000)
            return false
        else
            xinhao_info = nv_read_nv_item("xinhao_info")
            --读取nv中添加新号次数
            if nv_read_nv_item("xinhao_info_add_num") ~= nil then
                add_num = nv_read_nv_item("xinhao_info_add_num")
            else
                warning_info("还没有添加新号为好友")
                mSleep(1000)
                return false
            end
        end
        if add_num > 5 then     -- 5个新号
            xinhao_data = xinhao_info[math.random(#xinhao_info)] 
        else
            xinhao_data = xinhao_info[add_num] 
        end
        inputText(xinhao_data)
        mSleep(5000); 
        for i=1,5 do
            --等待   搜索.bmp 
            x, y = findMultiColorInRegionFuzzy({ 0x5D5D5D, -2, 86, 0xF6F8F3, 30, 110, 0xF7F8F6, 31, 110, 0xF7F8F7, 194, -1, 0xFFFFFF, 202, 107, 0xFAFAFA, 212, 109, 0x5F5F5F, 398, 12, 0x555555, 382, 109, 0xFAFAFA, 445, 109, 0xFAFAFA, 450, 109, 0xFAFAFA }, 90, 115, 233, 567, 344);
            if x <0 and y<0 then  -- 如果找到了
               mSleep(500)
               break
            end
            mSleep(1000)
        end
         ---没搜到1
        x, y = findMultiColorInRegionFuzzy({ 0xFEFEFE, 15, 2, 0xFEFEFE, 8, 22, 0xFEFEFE, 50, 11, 0xFEFEFE, 87, 1, 0xC9C9C9, 80, 11, 0xF2F2F2, 77, 5, 0x000000 }, 90, 151, 166, 238, 188); 
         ---没搜到2
        x2, y2 = findMultiColorInRegionFuzzy({ 0xC1E3C9, 9, 25, 0xFFFFFF, 20, 29, 0x2BA245, 27, 25, 0xFFFFFF, 29, 17, 0x6ABE7C, -6, 45, 0x49AF5F, -28, 40, 0x2BA245, -17, 23, 0x2BA245, -12, 23, 0x2BA245, -41, -15, 0x2BA245, 0, -14, 0x2BA245, 22, -8, 0x2BA245, 29, 26, 0xFFFFFF, 30, 28, 0xFCFEFC }, 90, 30, 233, 101, 293);
        if x>0 or x2 > 0  then
            warning_info("发消息给新号时没有这个好友1")
            cicky(  590,86,50);   --点击取消
            mSleep(1500);
            return false
        else
            cicky( 187,260,50);   --点击第一个
            mSleep(2000);
            if page_array["page_liaotian"]:check_page() == true then
                page_array["page_liaotian"]:action()
            else
                warning_info("发消息给新号时没有这个好友2")
                cicky(  80,86,50);   --点击返回
                mSleep(1500);
                cicky(  590,86,50);   --点击取消
                mSleep(1500);
                return false
            end
        end
    else
        cicky(  590,86,50);   --点击取消
        mSleep(2000);
        if page_array["page_tongxunlu"]:check_page() == true then
            page_array["page_tongxunlu"]:enter();
        elseif page_array["page_weixinzhu"]:quick_check_page() == true then
            page_array["page_weixinzhu"]:enter()
        end
    end
    return true 
end

--step1
function sousuo_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function sousuo_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_sousuo() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function sousuo_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_sousuo() ;
end

--step3  --最主要的工作都在这个里面
function sousuo_page:action()     --执行这个页面的操作--
    return  action_sousuo();
end

page_array["page_sousuo"] = sousuo_page:new()

------------------end:  page\wx_sousuozhuanfa_2.4\page_sousuo.lua-------------------------------------




----------------------begin:  page\wx_sousuozhuanfa_2.4\page_liaotian.lua---------------------------------

default_liaotian_page = {
    page_name = "liaotian_page",
    page_image_path = nil
}

liaotian_page = class_base_page:new(default_liaotian_page);

---聊天界面  /2.4   /聊天界面.bmp
local function check_page_liaotian( ... )
   x, y = findMultiColorInRegionFuzzy({ 0x111111, -9, 12, 0x121212, 4, 21, 0x121212, 7, 23, 0x121213, 25, 15, 0x121212, 26, 18, 0x121212, 35, 8, 0x222223, 59, 7, 0x111112, 72, 8, 0x727273, 68, 2, 0x111112, 68, 11, 0x121112, 555, 12, 0xFFFFFF, 545, 27, 0xFFFFFF, 568, 25, 0xFFFFFF, 566, 826, 0xF5F5F7, 571, 855, 0x7F8389, 545, 830, 0xBEC0C4, 494, 820, 0xF5F5F7, 489, 837, 0xF5F5F7, 507, 847, 0x7F8389, 508, 859, 0xF5F5F7, 496, 861, 0xF5F5F7, 480, 845, 0x7F8389, 515, 818, 0xF5F5F7, -6, 829, 0xF5F5F7, 6, 845, 0xF5F5F7, 6, 845, 0xF5F5F7, 4, 827, 0xF5F5F7, 33, 832, 0xF5F5F7, 127, 833, 0xFCFCFC, 210, 833, 0xFCFCFC, 292, 845, 0xFCFCFC, 416, 847, 0xFCFCFC, 475, 847, 0xF5F5F7, 566, 842, 0x7F8389 }, 90, 23, 69, 603, 930);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----聊天界面1----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0xF5F5F7, 4, 18, 0xF5F5F7, -16, 10, 0x7F8389, -17, 3, 0x7F8389, 201, 11, 0xE9E9EB, 291, 17, 0xE2E2E4, 306, 16, 0xF6F6F8, 239, 7, 0xF6F6F8, 493, 5, 0xF5F5F7, 483, 20, 0x7F8389, 570, 6, 0xF5F5F7, 578, 32, 0xF5F5F7, 554, 22, 0xF5F5F7, -15, -820, 0x121112, -22, -809, 0x121212, 10, -805, 0x121213, 44, -810, 0x121212, 54, -821, 0x131314, 19, -830, 0x252525, 14, -830, 0x111111, 66, -828, 0x111112, 56, -815, 0x121212, 14, -821, 0x111112, 14, -827, 0xDDDDDE, 553, -824, 0xFFFFFF, 545, -805, 0xFFFFFF, 533, -806, 0x121213, 560, -807, 0x585858, 560, -807, 0x585858, 551, -816, 0xFFFFFF, 550, -815, 0xFFFFFF, 580, -833, 0x111111, 588, -809, 0x121212, 578, -814, 0x121212 }, 90, 18, 66, 628, 931);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----聊天界面2----");
            return true
        else
            return false
        end
    end
end

local function action_liaotian()     --执行这个页面的操作--
    if gongneng == 2.4 then  -- 转发朋友圈
        cicky( 588,92,50);  --点击人头
        mSleep(3000);
        cicky(100, 256,50);  --点击头像
        mSleep(2000);
        page_array["page_xiangxizl"]:enter();
    elseif gongneng == 1.1   then  --1.1 智能回复
        --添加
        x, y = findMultiColorInRegionFuzzy({ 0x05BF03, 44, 0, 0xFBFBFB, -13, 7, 0x05BE03, 22, 7, 0x4FD14D, 30, 6, 0x05BE03, 5, 14, 0x04BD02, 27, 14, 0xD8F5D7, 15, 27, 0x03BC01, 33, 26, 0x03BC01, 33, 26, 0x03BC01 }, 90, 563, 171, 620, 198);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);
            mSleep(2000);
            for i=1,5 do
                --发送验证
                x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 38, 6, 0x007AFF, 36, -1, 0x007AFF, 25, 16, 0x007AFF, 45, 14, 0x007AFF, 45, -1, 0x007AFF, 35, -5, 0x007AFF }, 90, 437, 399, 482, 420);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    mSleep(500)
                    inputText("我好像在哪见过你")
                    mSleep(1000)
                    cicky(x,y,50);
                    mSleep(1500);
                    cicky( 84,84,50);   --返回微信
                    mSleep(2500);
                    gongneng = 1.2 --删除
                    return page_array["page_weixinzhu"]:enter()
                end
                --添加失败
                x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -4, 3, 0x007AFF, 1, 15, 0x007AFF, 12, 14, 0x007AFF, 19, 5, 0x007AFF, 36, 21, 0x007AFF, 47, 14, 0x007AFF }, 90, 293, 549, 344, 570);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    cicky(x,y,50);
                    mSleep(2000);
                    cicky( 84,84,50);   --返回微信
                    mSleep(2500);
                    gongneng = 1.2 --删除
                    return page_array["page_weixinzhu"]:enter()
                end
                if page_array["page_liaotian"]:quick_check_page() == true then
                    return page_array["page_liaotian"]:enter()
                end
                mSleep(1000)
            end
        end
        --群邀请 接受
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 15, 1, 0xFFFFFF, 52, 4, 0x080808, 76, 6, 0x4C4C4C, 142, 6, 0xFFFFFF, 197, 4, 0xD7D7D7, 199, 4, 0x676767, 201, 13, 0xFFFFFF, 181, 25, 0xFFFFFF, 148, 28, 0xFFFFFF, 93, 27, 0xFFFFFF, 48, 27, 0x363636, 1, 13, 0x666666, 9, 10, 0x1F1F1F, 137, 18, 0x7A7A7A, 182, 18, 0xFFFFFF, 204, 8, 0xF3F3F3, 84, 0, 0xFFFFFF, 38, 0, 0xFFFFFF, 12, 1, 0xFFFFFF }, 90, 164, 240, 368, 268);
        if x ~= -1  then  -- 如果找到了
            cicky(x,y,50);   --点击
            mSleep(2000);
            for i=1,10 do
                --加入群聊1
                x, y = findMultiColorInRegionFuzzy({ 0x04BE02, 20, 5, 0xFFFFFF, 95, 5, 0x04BE02, 137, 7, 0xECFAEC, 151, 15, 0xA9E9A9, 151, 34, 0x04BE02, 91, 41, 0x04BE02, 42, 35, 0x04BE02, 10, 32, 0x04BE02, 24, 19, 0x04BE02, 39, 18, 0x04BE02, 113, 26, 0x9DE69C, 153, 23, 0x04BE02, 158, 5, 0x04BE02, 51, -5, 0x04BE02, -42, -5, 0x04BE02, -36, 26, 0x04BE02, 91, 45, 0x04BE02, 186, 34, 0x04BE02, 238, 18, 0x04BE02 }, 90, 196, 698, 476, 748);
                --加入群聊2
                x2, y2 = findMultiColorInRegionFuzzy({ 0x04BE02, 15, 5, 0x04BE02, 58, 13, 0x04BE02, 119, 8, 0xFFFFFF, 139, 26, 0x04BE02, 114, 38, 0x04BE02, 47, 41, 0x04BE02, -8, 41, 0x04BE02, -12, 28, 0x04BE02, 31, 24, 0x04BE02, 100, 29, 0x04BE02, 122, 23, 0xD0F3CF, 33, 15, 0x04BE02, 39, 15, 0x04BE02 }, 90, 245, 761, 396, 802);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    cicky(304,753,50);  --点击加入群聊
                    gong_neng = "邀请";
                    mSleep(5000)
                    if page_array["page_qunliaotian"]:check_page() == true then
                       return page_array["page_qunliaotian"]:action()
                    else
                        warning_info("加入群聊错误1");
                        mSleep(1000)
                        return false
                    end
                end
                if i == 10 then 
                    warning_info("加入群聊错误2或者已经加入");
                    mSleep(500)
                    cicky(80,80,50);  --点击返回
                    mSleep(1500)
                    gongneng = 1.2 --删除
                    return page_array["page_liaotian"]:enter()
                end
                mSleep(1000)
            end
        end
        mSleep(500)
        cicky( 600,910,50);   --点击加
        mSleep(3000);
        ---个人名片2
        x, y = findMultiColorInRegionFuzzy({ 0xBFBFC0, 19, 0, 0xF5F5F7, 63, 2, 0xF5F5F7, 73, 1, 0xF5F5F7, 74, 11, 0xBBBBBC, 71, 20, 0xF5F5F7, 45, 20, 0xEFEFF0, 27, 19, 0xF5F5F7, 14, 15, 0xF5F5F7, 0, 8, 0xF5F5F7, 2, 4, 0xF5F5F7, 30, 8, 0xF5F5F7, 68, 7, 0xD4D4D5, 74, 7, 0xF5F5F7, 38, -81, 0x7A7E83, 26, -62, 0x7A7E83, 16, -61, 0xC1C3C6, 61, -59, 0x898D91, 64, -59, 0xFBFBFC, 51, -110, 0xFBFBFC, 40, -117, 0xFBFBFC, 19, -115, 0xFBFBFC, -9, -82, 0xFBFBFC, 9, -46, 0xFBFBFC, 55, -38, 0xFBFBFC, 97, -79, 0xDCDCDD, 67, -112, 0xFBFBFC, 44, -120, 0xFBFBFC, 0, -1, 0xEFEFF0, 25, -3, 0xF5F5F7, 74, 0, 0xF5F5F7, 76, 5, 0x8E8E8E, 47, 22, 0xF5F5F7, 21, 13, 0xC5C5C6, 17, 11, 0xF5F5F7 }, 90, 349, 753, 455, 895);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            test = "名片2"    --点击
            cicky( 397,798,50);   --点击个人名片2
            mSleep(2000);
            return page_array["page_xuanzepengyou"]:enter()
        end
        --滑动
        rotateScreen(0);
        mSleep(1287);
        touchDown(4, 398, 752)
        mSleep(1);
        touchMove(4, 354, 738)
        mSleep(28);
        touchMove(4, 290, 704)
        mSleep(2);
        touchMove(4, 220, 666)
        mSleep(37);
        touchMove(4, 146, 632)
        mSleep(1);
        touchMove(4, 74, 606)
        mSleep(14);
        touchMove(4, 20, 588)
        mSleep(18);
        touchUp(4)

        mSleep(955);
        touchDown(6, 340, 758)
        mSleep(1);
        touchMove(6, 306, 752)
        mSleep(15);
        touchMove(6, 252, 726)
        mSleep(15);
        touchMove(6, 180, 690)
        mSleep(16);
        touchMove(6, 94, 662)
        mSleep(14);
        touchMove(6, 26, 648)
        mSleep(17);
        touchMove(6, 6, 636)
        mSleep(17);
        touchMove(6, 2, 624)
        mSleep(18);
        touchUp(6)
        mSleep(2000);
        ---个人名片
        x, y = findMultiColorInRegionFuzzy({ 0x7A7E83, -19, 34, 0xFBFBFC, -14, 39, 0x7A7E83, 0, 42, 0x7A7E83, 21, 40, 0xC2C4C7, 26, 22, 0xFBFBFC, 16, 4, 0xFBFBFC, -20, 0, 0xFBFBFC, -35, 30, 0xFBFBFC, 2, 19, 0x7A7E83, -55, -31, 0xF5F5F7, 32, -19, 0xFBFBFC, 53, 38, 0xFBFBFC, -44, 104, 0xE7E7E9, -34, 104, 0x9B9B9C, 5, 104, 0xCECECF, 38, 104, 0xF1F1F3, 39, 104, 0xF5F5F7, 39, 120, 0xE8E8EA, 24, 110, 0xF5F5F7, 1, 108, 0xF5F5F7, -30, 106, 0xE6E6E8, -47, 106, 0xF1F1F3, -8, 116, 0x8D8D8D, 23, 116, 0xF5F5F7, 42, 116, 0xF5F5F7, 43, 99, 0xF5F5F7, 42, 29, 0xFBFBFC, -8, 73, 0xFBFBFC, -50, 12, 0xFBFBFC, -40, -13, 0xFBFBFC }, 90, 39, 546, 147, 697);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(80, 638,50)   --点击个人名片
            mSleep(2000);
             page_array["page_xuanzepengyou"]:enter()
        else
            cicky( 604,479,50);   --点击加
            mSleep(2500);
            cicky( 604,479,50);   --点击加
            mSleep(2500);
            touchDown(4, 398, 752)
            mSleep(1);
            touchMove(4, 354, 738)
            mSleep(28);
            touchMove(4, 290, 704)
            mSleep(2);
            touchMove(4, 220, 666)
            mSleep(37);
            touchMove(4, 146, 632)
            mSleep(1);
            touchMove(4, 74, 606)
            mSleep(14);
            touchMove(4, 20, 588)
            mSleep(18);
            touchUp(4)
            mSleep(1287);
            touchDown(4, 398, 752)
            mSleep(1);
            touchMove(4, 354, 738)
            mSleep(28);
            touchMove(4, 290, 704)
            mSleep(2);
            touchMove(4, 220, 666)
            mSleep(37);
            touchMove(4, 146, 632)
            mSleep(1);
            touchMove(4, 74, 606)
            mSleep(14);
            touchMove(4, 20, 588)
            mSleep(18);
            touchUp(4)
            mSleep(2000)
            --个人名片
            x, y = findMultiColorInRegionFuzzy({ 0x7A7E83, -19, 34, 0xFBFBFC, -14, 39, 0x7A7E83, 0, 42, 0x7A7E83, 21, 40, 0xC2C4C7, 26, 22, 0xFBFBFC, 16, 4, 0xFBFBFC, -20, 0, 0xFBFBFC, -35, 30, 0xFBFBFC, 2, 19, 0x7A7E83, -55, -31, 0xF5F5F7, 32, -19, 0xFBFBFC, 53, 38, 0xFBFBFC, -44, 104, 0xE7E7E9, -34, 104, 0x9B9B9C, 5, 104, 0xCECECF, 38, 104, 0xF1F1F3, 39, 104, 0xF5F5F7, 39, 120, 0xE8E8EA, 24, 110, 0xF5F5F7, 1, 108, 0xF5F5F7, -30, 106, 0xE6E6E8, -47, 106, 0xF1F1F3, -8, 116, 0x8D8D8D, 23, 116, 0xF5F5F7, 42, 116, 0xF5F5F7, 43, 99, 0xF5F5F7, 42, 29, 0xFBFBFC, -8, 73, 0xFBFBFC, -50, 12, 0xFBFBFC, -40, -13, 0xFBFBFC }, 90, 39, 546, 147, 697);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(80, 638,50)   --点击个人名片
                mSleep(2000);
                page_array["page_xuanzepengyou"]:enter()
            else
                warning_info("选择名片出现错误");
                mSleep(1000)
                cicky( 84,84,50);   --返回微信
                mSleep(1500);
                gongneng = 1.2   --删除
                page_array["page_weixinzhu"]:enter()
            end
        end
        return true
    elseif gongneng == 1.4 then   ---回复一下  --养号
        --添加
        x, y = findMultiColorInRegionFuzzy({ 0x05BF03, 44, 0, 0xFBFBFB, -13, 7, 0x05BE03, 22, 7, 0x4FD14D, 30, 6, 0x05BE03, 5, 14, 0x04BD02, 27, 14, 0xD8F5D7, 15, 27, 0x03BC01, 33, 26, 0x03BC01, 33, 26, 0x03BC01 }, 90, 563, 171, 620, 198);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);
            mSleep(2000);
            for i=1,5 do
                --错误
                x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -4, 3, 0x007AFF, 1, 15, 0x007AFF, 12, 14, 0x007AFF, 19, 5, 0x007AFF, 36, 21, 0x007AFF, 47, 14, 0x007AFF }, 90, 293, 549, 344, 570);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    cicky(x,y,50);
                    mSleep(2000);
                    cicky( 84,84,50);   --返回微信
                    mSleep(2500);
                    gongneng = 1.2 --删除
                    return page_array["page_weixinzhu"]:enter()
                end
                mSleep(1000)
            end
        end
        --群邀请 接受
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 15, 1, 0xFFFFFF, 52, 4, 0x080808, 76, 6, 0x4C4C4C, 142, 6, 0xFFFFFF, 197, 4, 0xD7D7D7, 199, 4, 0x676767, 201, 13, 0xFFFFFF, 181, 25, 0xFFFFFF, 148, 28, 0xFFFFFF, 93, 27, 0xFFFFFF, 48, 27, 0x363636, 1, 13, 0x666666, 9, 10, 0x1F1F1F, 137, 18, 0x7A7A7A, 182, 18, 0xFFFFFF, 204, 8, 0xF3F3F3, 84, 0, 0xFFFFFF, 38, 0, 0xFFFFFF, 12, 1, 0xFFFFFF }, 90, 164, 240, 368, 268);
        if x ~= -1  then  -- 如果找到了
            cicky(x,y,50);   --点击
            mSleep(2000);
            for i=1,10 do
                --加入群聊1
                x, y = findMultiColorInRegionFuzzy({ 0x04BE02, 20, 5, 0xFFFFFF, 95, 5, 0x04BE02, 137, 7, 0xECFAEC, 151, 15, 0xA9E9A9, 151, 34, 0x04BE02, 91, 41, 0x04BE02, 42, 35, 0x04BE02, 10, 32, 0x04BE02, 24, 19, 0x04BE02, 39, 18, 0x04BE02, 113, 26, 0x9DE69C, 153, 23, 0x04BE02, 158, 5, 0x04BE02, 51, -5, 0x04BE02, -42, -5, 0x04BE02, -36, 26, 0x04BE02, 91, 45, 0x04BE02, 186, 34, 0x04BE02, 238, 18, 0x04BE02 }, 90, 196, 698, 476, 748);
                --加入群聊2
                x2, y2 = findMultiColorInRegionFuzzy({ 0x04BE02, 15, 5, 0x04BE02, 58, 13, 0x04BE02, 119, 8, 0xFFFFFF, 139, 26, 0x04BE02, 114, 38, 0x04BE02, 47, 41, 0x04BE02, -8, 41, 0x04BE02, -12, 28, 0x04BE02, 31, 24, 0x04BE02, 100, 29, 0x04BE02, 122, 23, 0xD0F3CF, 33, 15, 0x04BE02, 39, 15, 0x04BE02 }, 90, 245, 761, 396, 802);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    cicky(304,753,50);  --点击加入群聊
                    gong_neng = "邀请";
                    mSleep(5000)
                    if page_array["page_qunliaotian"]:check_page() == true then
                       return page_array["page_qunliaotian"]:action()
                    else
                        warning_info("加入群聊错误1");
                        mSleep(1000)
                        return false
                    end
                end
                if i == 10 then 
                    warning_info("加入群聊错误2或者已经加入");
                    mSleep(500)
                    cicky(80,80,50);  --点击返回
                    mSleep(1500)
                    gongneng = 1.2 --删除
                    return page_array["page_liaotian"]:enter()
                end
                mSleep(1000)
            end
        end
        --发文字
        x, y = findMultiColorInRegionFuzzy({ 0xF5F5F7, 7, 13, 0x7F8389, -5, 23, 0x7F8389, -7, -5, 0xF5F5F7, -13, -5, 0xF5F5F7, -19, 18, 0xF5F5F7, 1, 15, 0xF5F5F7, -10, 0, 0xF5F5F7, -33, 12, 0x888C91, 0, 26, 0xF5F5F7, 15, 3, 0xF5F5F7, -11, -5, 0xF5F5F7 }, 90, 9, 892, 57, 923);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50)  --点击切换文字
            mSleep(1500)
        else
            cicky( 115,915,50);   --点击输入框 
            mSleep(2500);
        end
        a =math.random(2) 
        for i=1,a do
            if text_huifu ~= nil then
                inputText(text_huifu[math.random(#text_huifu)]); 
            else
                warning_info("请设置回复内容");
                mSleep(1000)
                inputText("哈哈")
            end
            mSleep(2000);
            cicky( 435,917,50);   --点击空格
            mSleep(1500);
            cicky( 598,909,50);   --点击发送
            mSleep(2000);
            ---还不是朋友 
            x, y = findMultiColorInRegionFuzzy({ 0xCECECE, 23, 0, 0x0D7FFC, 44, 0, 0xCECECE, 67, 0, 0x8DB3DD, 91, 3, 0xCECECE, 130, 8, 0xCECECE, 144, 8, 0xBDC7D2, 14, 8, 0xCECECE, 52, 8, 0x6EA6E5, 85, 8, 0xCECECE, 112, 8, 0x4395EF, 149, 9, 0x338EF3, 36, 12, 0x0A7EFD, 34, 12, 0x60A1E8, 29, 12, 0xCECECE, 85, 13, 0xCDCDCE, 118, 13, 0xCBCCCF, 145, 13, 0xCECECE, 145, 13, 0xCECECE }, 90, 330, 373, 479, 386);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);  --点击发送朋友验证
                mSleep(3000);
                for i=1,5 do
                    ---验证
                    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 29, 3, 0xFFFFFF, 76, 4, 0xFFFFFF, 194, 8, 0xFFFFFF, 318, 9, 0xFFFFFF, 411, 3, 0xFFFFFF, 35, 18, 0xFFFFFF, 51, 18, 0xFFFFFF, 288, 18, 0xFFFFFF, 421, 18, 0xFFFFFF, 424, 17, 0xFFFFFF, 73, 33, 0xFFFFFF, 177, 32, 0xFFFFFF, 377, 17, 0xFFFFFF, 413, 18, 0xFFFFFF, 329, 123, 0x007AFF, 365, 114, 0x007AFF, 103, 114, 0x007AFF }, 90, 111, 296, 535, 419);
                    if x ~= -1 and y ~= -1 then  -- 如果找到了
                        inputText("我好像在哪见过你");
                        mSleep(2000);
                        cicky( 457,419,50);   --点击发送
                        mSleep(3000);
                        break
                    end
                    mSleep(1000)
                end
                if page_array["page_liaotian"]:check_page() == true then
                    cicky(66,86,50);   --返回微信
                    mSleep(1500);
                    gongneng = 1.2  --删除
                    log_info("验证朋友一次")
                    mSleep(500)
                    return page_array["page_weixinzhu"]:enter()
                else
                    warning_info("验证朋友错误");
                    return false
                end
            end
            mSleep(math.random(15000,30000));
        end
        cicky(  39,474 ,50)  --切换成语言
        mSleep(1500)
        local a =math.random(2)
        for i=1,a do
            local aa = math.random(2000,8000)
            cicky( 293,914,aa)   --点击发语言
            mSleep(500)
            --访问语言
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -6, 0, 0x007AFF, -2, -6, 0x007AFF, 17, -5, 0x007AFF, 17, 7, 0x007AFF, 14, 10, 0x007AFF, 11, 20, 0x007AFF, -4, 19, 0x007AFF }, 90, 442, 526, 465, 552);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50)  --点击好
                mSleep(1000)
                cicky( 293,914,aa)   --点击发语言
            end
            mSleep(1000)
        end
        log_info("智能回复消息一次")
        mSleep(1000)
        cicky(75,80,50);     --返回微信
        mSleep(1500);
        gongneng = 1.2    --删除 
        return page_array["page_weixinzhu"]:enter();
    elseif gongneng == 2.6 or gongneng == 1.12  then  ---2.6随机发消息 1.12--回复消息
         --发文字
        x, y = findMultiColorInRegionFuzzy({ 0xF5F5F7, 7, 13, 0x7F8389, -5, 23, 0x7F8389, -7, -5, 0xF5F5F7, -13, -5, 0xF5F5F7, -19, 18, 0xF5F5F7, 1, 15, 0xF5F5F7, -10, 0, 0xF5F5F7, -33, 12, 0x888C91, 0, 26, 0xF5F5F7, 15, 3, 0xF5F5F7, -11, -5, 0xF5F5F7 }, 90, 9, 892, 57, 923);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50)  --点击切换文字
            mSleep(1500)
        else
            cicky( 115,915,50);   --点击输入框 
            mSleep(2500);
        end 
        e = math.random(1,3);
        for i=1,e do
            mSleep(500);
            if text_huifu ~= nil then
                inputText(text_huifu[math.random(#text_huifu)]); 
            else
                warning_info("请设置回复内容");
                mSleep(1000)
                inputText("哈哈")
            end
            mSleep(2000);
            cicky( 435,917,50);   --点击空格
            mSleep(1500);
            cicky( 598,909,50);   --点击发送
            log_info("发消息给朋友一次")
            mSleep(math.random(2222,4444)); 
        end
        cicky(75,80,50);     --返回微信
        mSleep(2000);
        m = math.random(600000,1200000)
        n = m/1000
        warning_info("发消息完成,等待"..n.."秒");
        mSleep(m);
        return false
    elseif gongneng == 1.5 then     --发消息给新号
        --发文字
        x, y = findMultiColorInRegionFuzzy({ 0xF5F5F7, 7, 13, 0x7F8389, -5, 23, 0x7F8389, -7, -5, 0xF5F5F7, -13, -5, 0xF5F5F7, -19, 18, 0xF5F5F7, 1, 15, 0xF5F5F7, -10, 0, 0xF5F5F7, -33, 12, 0x888C91, 0, 26, 0xF5F5F7, 15, 3, 0xF5F5F7, -11, -5, 0xF5F5F7 }, 90, 9, 892, 57, 923);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50)  --点击切换文字
            mSleep(1500)
        else
            cicky( 115,915,50);   --点击输入框 
            mSleep(2500);
        end
        e = math.random(2);
        for i=1,e do
            mSleep(500);
            if text_huifu ~= nil and text_huifu[1] ~= nil  then
                inputText(text_huifu[math.random(#text_huifu)]); 
            else
                warning_info("请设置回复内容");
                mSleep(1000)
                inputText("哈哈")
            end
            mSleep(2000);
            cicky( 435,917,50);   --点击空格
            mSleep(1500);
            cicky( 598,909,50);   --点击发送
            log_info("发消息给朋友一次")
            mSleep(math.random(10000,20000)); 
        end
        cicky(  39,474 ,50)  --切换成语言
        mSleep(1500)
        for i=1,e do
            local aa = math.random(2000,6000)
            cicky( 293,914,aa)   --点击发语言
            mSleep(500)
            --访问语言
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -6, 0, 0x007AFF, -2, -6, 0x007AFF, 17, -5, 0x007AFF, 17, 7, 0x007AFF, 14, 10, 0x007AFF, 11, 20, 0x007AFF, -4, 19, 0x007AFF }, 90, 442, 526, 465, 552);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50)  --点击好
                mSleep(1000)
                cicky( 293,914,aa)   --点击发语言
            end
            mSleep(1000)
        end
        warning_info("发消息完成,回复消息去");
        mSleep(1000)
        gongneng = 1.2 --删除发的那条消息
        return page_array["page_liaotian"]:action()  --直接做动作
    else
        cicky( 84,84,50);   --返回微信
        mSleep(2500);
        if page_array["page_weixinzhu"]:quick_check_page() == true then
            page_array["page_weixinzhu"]:enter()
            return true
        end
        cicky(596,75,50);   --点击取消
        mSleep(1500);  
        if page_array["page_tongxunlu"]:check_page() == true then
        page_array["page_tongxunlu"]:enter();
        elseif page_array["page_weixinzhu"]:quick_check_page() == true then
            page_array["page_weixinzhu"]:enter()
        end
        return true
    end
end

--step1
function liaotian_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function liaotian_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_liaotian() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function liaotian_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_liaotian() ;
end

--step3  --最主要的工作都在这个里面
function liaotian_page:action()     --执行这个页面的操作--
    return  action_liaotian();
end

page_array["page_liaotian"] = liaotian_page:new()

------------------end:  page\wx_sousuozhuanfa_2.4\page_liaotian.lua-------------------------------------




----------------------begin:  page\wx_sousuozhuanfa_2.4\page_xiangxizl.lua---------------------------------

default_xiangxizl_page = {
    page_name = "xiangxizl_page",
    page_image_path = nil
}

xiangxizl_page = class_base_page:new(default_xiangxizl_page);

---详细资料  /2.4   /详细资料.bmp
local function check_page_xiangxizl( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x121212, -13, 0, 0x838383, -27, 0, 0xFFFFFF, -18, -13, 0x111112, -11, 12, 0x121213, -214, -10, 0xFFFFFF, -216, 18, 0x5A5A5A, -237, -8, 0x444445, -231, 19, 0x131313, -270, -11, 0x111112, -256, -11, 0x111112, -271, 8, 0xFFFFFF, -253, 9, 0xFFFFFF, -286, 12, 0xE4E4E4, -299, -6, 0xFFFFFF, -298, 0, 0xBDBDBD, -309, 10, 0x121213, -308, -1, 0xFFFFFF, -342, -14, 0x111112, -344, 3, 0x121212, -329, -10, 0x111112, -329, 13, 0xA6A6A6, -561, -12, 0xFFFFFF, -574, -4, 0x121112, -539, -9, 0xDDDDDE, -526, 2, 0xB2B2B2, -495, -11, 0x111112, -494, 9, 0x121213, -479, -15, 0x111112, -462, 5, 0x121213, -445, -17, 0x111111, -427, 5, 0xFFFFFF }, 90, 25, 63, 599, 99);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----转发朋友说说的详细资料界面----");
        return true
    else
        return false
    end
end

local function action_xiangxizl()     --执行这个页面的操作--
    if gongneng == 2.4 then  -- 转发朋友圈
        xiahua();  ---向下滑
        mSleep(1000);
         --个人相册
        ddzc(0xFFFFFF, -39, -6, 0x404040, -73, -6, 0xDEDEDE,-101,-14,0xC4C4C4, 90, 43, 450, 144, 464)
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);  --点击个人相册
            mSleep(3000);
            page_array["page_pengyoushuoshuo"]:enter()
        else
            pengyou_cuowu("朋友没说说");
        end
    else
        cicky(  73,83,50);   --返回聊天详情
        mSleep(2500);
        cicky(  73,83,50);   --点击返回
        mSleep(2500);
        if page_array["page_liaotian"]:quick_check_page() == true and gongneng == 1.1 or gongneng == 2.6 or gongneng == 1.12 or gongneng == 1.5   then
            cicky(  73,83,50);   --点击返回
            mSleep(2500);
            cicky(596,75,50);   --点击取消
            mSleep(2000);  
            return page_array["page_tongxunlu"]:enter();
        else
            return page_array["page_liaotian"]:enter()
        end
    end
    return true 
end

--step1
function xiangxizl_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function xiangxizl_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xiangxizl() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function xiangxizl_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_xiangxizl() ;
end

--step3  --最主要的工作都在这个里面
function xiangxizl_page:action()     --执行这个页面的操作--
    return  action_xiangxizl();
end

page_array["page_xiangxizl"] = xiangxizl_page:new()

------------------end:  page\wx_sousuozhuanfa_2.4\page_xiangxizl.lua-------------------------------------




----------------------begin:  page\wx_sousuozhuanfa_2.4\page_pengyoushuoshuo.lua---------------------------------

default_pengyoushuoshuo_page = {
    page_name = "pengyoushuoshuo_page",
    page_image_path = nil
}

pengyoushuoshuo_page = class_base_page:new(default_pengyoushuoshuo_page);

---朋友说说 /2.4   /朋友说说.bmp
local function check_page_pengyoushuoshuo( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x0C0C0C, -11, 13, 0xFFFFFF, -3, 32, 0xFFFFFF, -9, 28, 0x868686, 3, 20, 0x0C0C0D, 18, 1, 0x0C0C0D, 18, 23, 0x0C0C0D, 16, 32, 0x0D0D0D, 26, 6, 0x5E5E5E, 34, 6, 0x19191A, 35, 24, 0x0C0C0D, 31, 28, 0x5B5B5C, 28, 12, 0x0C0C0D, 39, 22, 0x9B9B9B, 51, 13, 0xFFFFFF, 52, 19, 0xABABAB, 52, 25, 0xFBFBFB, 60, 6, 0xA4A4A4, 63, 26, 0xFFFFFF, 71, 10, 0xF4F4F4, 59, 11, 0x303031, 84, 5, 0x0C0C0D, 97, 5, 0xCACACA, 81, 7, 0x252525, 90, 20, 0xC0C0C0, 101, 22, 0x0C0C0D, 82, 25, 0x525252, 115, 2, 0xA7A7A8, 115, 28, 0x828283, 136, 23, 0x0C0C0D, 126, 10, 0xDFDFDF, 128, 3, 0x0C0C0C, 140, 14, 0x0C0C0D, 140, 27, 0x0D0C0D, 147, 11, 0x0C0C0D, 147, 9, 0x0C0C0D, 572, 13, 0x0C0C0D, 574, 28, 0x0D0D0D, 576, 29, 0x0C0C0D, 582, 8, 0x0C0C0C, 578, 7, 0x0C0C0D }, 90, 29, 66, 622, 98);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----朋友说说界面----");
        return true
    else
        return false
    end
end

local function action_pengyoushuoshuo()     --执行这个页面的操作--
    if gongneng == 2.4 then  -- 转发朋友圈
        rotateScreen(0);
        mSleep(527);
        touchDown(2, 398, 806)
        mSleep(53);
        touchMove(2, 398, 788)
        mSleep(41);
        touchMove(2, 398, 774)
        mSleep(18);
        touchMove(2, 398, 760)
        mSleep(1);
        touchMove(2, 400, 742)
        mSleep(6);
        touchMove(2, 402, 724)
        mSleep(41);
        touchMove(2, 408, 702)
        mSleep(1);
        touchMove(2, 412, 682)
        mSleep(1);
        touchMove(2, 414, 660)
        mSleep(84);
        touchMove(2, 418, 642)
        mSleep(13);
        touchMove(2, 422, 628)
        mSleep(1);
        touchMove(2, 426, 614)
        mSleep(1);
        touchMove(2, 428, 604)
        mSleep(1);
        touchMove(2, 430, 594)
        mSleep(1);
        touchMove(2, 434, 586)
        mSleep(16);
        touchMove(2, 436, 578)
        mSleep(12);
        touchMove(2, 438, 572)
        mSleep(21);
        touchMove(2, 440, 564)
        mSleep(12);
        touchMove(2, 444, 556)
        mSleep(16);
        touchMove(2, 448, 548)
        mSleep(16);
        touchMove(2, 450, 540)
        mSleep(16);
        touchMove(2, 454, 530)
        mSleep(16);
        touchMove(2, 458, 522)
        mSleep(16);
        touchMove(2, 460, 514)
        mSleep(16);
        touchMove(2, 464, 506)
        mSleep(16);
        touchMove(2, 466, 498)
        mSleep(11);
        touchMove(2, 468, 494)
        mSleep(48);
        touchMove(2, 470, 488)
        mSleep(2);
        touchMove(2, 472, 484)
        mSleep(8);
        touchMove(2, 474, 480)
        mSleep(7);
        touchMove(2, 476, 476)
        mSleep(14);
        touchMove(2, 478, 474)
        mSleep(16);
        touchMove(2, 480, 472)
        mSleep(17);
        touchMove(2, 482, 470)
        mSleep(15);
        touchMove(2, 482, 468)
        mSleep(18);
        touchMove(2, 484, 466)
        mSleep(16);
        touchMove(2, 484, 466)
        mSleep(31);
        touchMove(2, 484, 464)
        mSleep(22);
        touchMove(2, 486, 464)
        mSleep(8);
        touchMove(2, 486, 464)
        mSleep(41);
        touchUp(2)

        mSleep(294);
        touchDown(5, 378, 772)
        mSleep(68);
        touchMove(5, 384, 762)
        mSleep(22);
        touchMove(5, 384, 752)
        mSleep(17);
        touchMove(5, 384, 736)
        mSleep(13);
        touchMove(5, 386, 720)
        mSleep(20);
        touchMove(5, 390, 708)
        mSleep(29);
        touchMove(5, 392, 696)
        mSleep(1);
        touchMove(5, 394, 684)
        mSleep(17);
        touchMove(5, 396, 672)
        mSleep(15);
        touchMove(5, 398, 660)
        mSleep(15);
        touchMove(5, 402, 650)
        mSleep(16);
        touchMove(5, 406, 640)
        mSleep(9);
        touchMove(5, 408, 632)
        mSleep(16);
        touchMove(5, 412, 622)
        mSleep(42);
        touchMove(5, 418, 610)
        mSleep(7);
        touchMove(5, 422, 598)
        mSleep(2);
        touchMove(5, 428, 586)
        mSleep(15);
        touchMove(5, 432, 578)
        mSleep(15);
        touchMove(5, 436, 568)
        mSleep(16);
        touchMove(5, 440, 560)
        mSleep(16);
        touchMove(5, 442, 552)
        mSleep(17);
        touchMove(5, 446, 542)
        mSleep(19);
        touchMove(5, 450, 534)
        mSleep(33);
        touchMove(5, 454, 526)
        mSleep(2);
        touchMove(5, 458, 518)
        mSleep(17);
        touchMove(5, 462, 512)
        mSleep(14);
        touchMove(5, 466, 504)
        mSleep(15);
        touchMove(5, 468, 500)
        mSleep(18);
        touchMove(5, 470, 494)
        mSleep(15);
        touchMove(5, 472, 488)
        mSleep(16);
        touchMove(5, 474, 484)
        mSleep(16);
        touchMove(5, 476, 480)
        mSleep(16);
        touchMove(5, 478, 476)
        mSleep(16);
        touchMove(5, 480, 472)
        mSleep(17);
        touchMove(5, 482, 468)
        mSleep(15);
        touchMove(5, 484, 466)
        mSleep(16);
        touchMove(5, 486, 464)
        mSleep(10);
        touchMove(5, 488, 462)
        mSleep(16);
        touchMove(5, 488, 462)
        mSleep(14);
        touchMove(5, 490, 462)
        mSleep(19);
        touchMove(5, 490, 462)
        mSleep(59);
        touchUp(5)

        mSleep(215);
        touchDown(6, 362, 806)
        mSleep(63);
        touchMove(6, 366, 796)
        mSleep(15);
        touchMove(6, 366, 790)
        mSleep(24);
        touchMove(6, 366, 782)
        mSleep(7);
        touchMove(6, 368, 772)
        mSleep(50);
        touchMove(6, 370, 760)
        mSleep(13);
        touchMove(6, 372, 748)
        mSleep(2);
        touchMove(6, 374, 736)
        mSleep(1);
        touchMove(6, 376, 726)
        mSleep(17);
        touchMove(6, 380, 716)
        mSleep(13);
        touchMove(6, 382, 708)
        mSleep(17);
        touchMove(6, 384, 700)
        mSleep(19);
        touchMove(6, 386, 694)
        mSleep(15);
        touchMove(6, 386, 690)
        mSleep(16);
        touchMove(6, 388, 686)
        mSleep(34);
        touchMove(6, 390, 682)
        mSleep(1);
        touchMove(6, 390, 676)
        mSleep(16);
        touchMove(6, 392, 672)
        mSleep(34);
        touchMove(6, 392, 668)
        mSleep(1);
        touchMove(6, 392, 666)
        mSleep(32);
        touchMove(6, 394, 664)
        mSleep(15);
        touchMove(6, 394, 664)
        mSleep(2);
        touchMove(6, 394, 662)
        mSleep(16);
        touchMove(6, 394, 662)
        mSleep(29);
        touchMove(6, 394, 660)
        mSleep(1);
        touchMove(6, 394, 660)
        mSleep(16);
        touchMove(6, 394, 658)
        mSleep(17);
        touchMove(6, 394, 658)
        mSleep(16);
        touchMove(6, 396, 656)
        mSleep(8);
        touchMove(6, 396, 654)
        mSleep(16);
        touchMove(6, 396, 652)
        mSleep(16);
        touchMove(6, 396, 652)
        mSleep(16);
        touchMove(6, 396, 650)
        mSleep(16);
        touchMove(6, 398, 648)
        mSleep(16);
        touchMove(6, 398, 648)
        mSleep(17);
        touchMove(6, 398, 646)
        mSleep(17);
        touchMove(6, 398, 646)
        mSleep(16);
        touchMove(6, 398, 644)
        mSleep(17);
        touchMove(6, 400, 644)
        mSleep(33);
        touchMove(6, 400, 642)
        mSleep(2);
        touchMove(6, 400, 642)
        mSleep(15);
        touchMove(6, 400, 640)
        mSleep(26);
        touchMove(6, 402, 640)
        mSleep(32);
        touchMove(6, 402, 638)
        mSleep(32);
        touchMove(6, 402, 638)
        mSleep(54);
        touchMove(6, 402, 636)
        mSleep(69);
        touchMove(6, 402, 636)
        mSleep(536);
        touchMove(6, 404, 636)
        mSleep(18);
        touchUp(6)
        mSleep(1000);
        ---没说说.bmp
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 9, 0, 0xFFFFFF, -105, -30, 0xFFFFFF, -41, -39, 0xFFFFFF, -52, -9, 0xFFFFFF, -18, -9, 0xFFFFFF, -68, 6, 0xFFFFFF, -39, 4, 0xFFFFFF, -44, 31, 0xFFFFFF, -30, 31, 0xFFFFFF, -79, 48, 0xFFFFFF, -61, 53, 0xFFFFFF, -23, 65, 0xFFFFFF, 108, 65, 0xFFFFFF, 189, 65, 0xFFFFFF, 301, 65, 0xFFFFFF, 395, 71, 0xFFFFFF, 470, -13, 0xFFFFFF, 435, -35, 0xFFFFFF, 394, -16, 0xFFFFFF, 395, -10, 0xFFFFFF, 405, -7, 0xFFFFFF, 404, -36, 0xFFFFFF, 352, -25, 0xFFFFFF, 324, -2, 0xE5E5E5, 372, 5, 0xFFFFFF, 359, -12, 0xFFFFFF, 283, -25, 0xFFFFFF, 243, 17, 0xFFFFFF, 269, 8, 0xFFFFFF, 261, -22, 0xFFFFFF, 192, -22, 0xFFFFFF, 209, -3, 0xFFFFFF, 153, -42, 0xFFFFFF, 79, 0, 0xFFFFFF, 162, -9, 0xFFFFFF, 29, -44, 0xFFFFFF, 58, 16, 0xFFFFFF, 119, -20, 0xFFFFFF, 65, -7, 0xFFFFFF, 204, -2, 0xE5E5E5, 237, -2, 0xE5E5E5, 413, -4, 0xFFFFFF, 481, -19, 0xFFFFFF, -97, -70, 0xFFFFFF, 13, -74, 0xFFFFFF, 58, -76, 0xFFFFFF, 107, -76, 0xFFFFFF, 168, -76, 0xFFFFFF, 216, -76, 0xFFFFFF, 294, -76, 0xFFFFFF, 401, -75, 0xFFFFFF, 469, -74, 0xFFFFFF, 489, -74, 0xFFFFFF }, 90, 11, 806, 605, 953);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("朋友没说说,请换个人");
            return false
        end
        mSleep(1000)
        --不是对方朋友说说.bmp
        x, y = findMultiColorInRegionFuzzy({ 0x989898, 15, 1, 0xB2B2B2, -20, -13, 0xA6A6A6, -19, -5, 0xABABAB, -55, -5, 0xEEEEEE, -56, -3, 0x181818, -81, -10, 0x111111, -100, -10, 0x000000, -113, -12, 0x040404, -119, -12, 0xFFFFFF, -219, -15, 0xFFFFFF, -256, -15, 0xFFFFFF, -309, -17, 0x131313, -411, -17, 0xFFFFFF, -337, -15, 0xFFFFFF, -261, -15, 0xFFFFFF, -195, -15, 0xFFFFFF, -79, -14, 0xF4F4F4, -77, -14, 0xEFEFEF }, 90, 109, 871, 535, 889);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("不是对方朋友");
            return false
        end
        cicky(207,213,50);   --点击第一个说说
        mSleep(5000);
        if page_array["page_noshuoshuo"]:quick_check_page() == true then
            page_array["page_noshuoshuo"]:enter();
        elseif page_array["page_shishuoshuo"]:quick_check_page()  == true  then
            page_array["page_shishuoshuo"]:enter();
        elseif  page_array["page_pengyoushuoshuo"]:quick_check_page() == true then
            gongneng = 7
            page_array["page_pengyoushuoshuo"]:enter()
        else
            warning_info("转发说说出现错误");
            return false
        end
    elseif gongneng == 7 then
        try_time = try_time +1
        if try_time > 5 then
           warning_info("该好友最近5次都没发过图片说说或者文章");
           return false
        end 
        rotateScreen(0);
        mSleep(867);
        touchDown(1, 446, 660)
        mSleep(70);
        touchMove(1, 458, 616)
        mSleep(18);
        touchMove(1, 458, 604)
        mSleep(13);
        touchMove(1, 460, 594)
        mSleep(16);
        touchMove(1, 462, 580)
        mSleep(16);
        touchMove(1, 462, 570)
        mSleep(16);
        touchMove(1, 464, 560)
        mSleep(11);
        touchMove(1, 464, 550)
        mSleep(30);
        touchMove(1, 466, 542)
        mSleep(8);
        touchMove(1, 466, 536)
        mSleep(8);
        touchMove(1, 468, 530)
        mSleep(16);
        touchMove(1, 468, 526)
        mSleep(16);
        touchMove(1, 470, 524)
        mSleep(16);
        touchMove(1, 470, 522)
        mSleep(16);
        touchMove(1, 470, 520)
        mSleep(147);
        touchMove(1, 470, 520)
        mSleep(29);
        touchMove(1, 470, 518)
        mSleep(35);
        touchMove(1, 470, 518)
        mSleep(55);
        touchMove(1, 470, 516)
        mSleep(17);
        touchMove(1, 470, 516)
        mSleep(14);
        touchMove(1, 470, 514)
        mSleep(1);
        touchMove(1, 470, 514)
        mSleep(16);
        touchMove(1, 470, 512)
        mSleep(15);
        touchMove(1, 472, 512)
        mSleep(1);
        touchMove(1, 472, 510)
        mSleep(1);
        touchMove(1, 472, 508)
        mSleep(16);
        touchMove(1, 472, 506)
        mSleep(15);
        touchMove(1, 472, 504)
        mSleep(6);
        touchMove(1, 472, 502)
        mSleep(16);
        touchMove(1, 472, 502)
        mSleep(16);
        touchMove(1, 472, 500)
        mSleep(16);
        touchMove(1, 474, 500)
        mSleep(19);
        touchMove(1, 474, 498)
        mSleep(18);
        touchMove(1, 474, 498)
        mSleep(29);
        touchMove(1, 474, 496)
        mSleep(49);
        touchMove(1, 474, 496)
        mSleep(6);
        touchMove(1, 474, 494)
        mSleep(24);
        touchMove(1, 474, 494)
        mSleep(79);
        touchMove(1, 474, 492)
        mSleep(193);
        touchMove(1, 474, 492)
        mSleep(21);
        touchUp(1)
        mSleep(1000);
        cicky(207,213,50);   --点击第一个说说
        mSleep(5000);
        if page_array["page_noshuoshuo"]:quick_check_page() == true then
            page_array["page_noshuoshuo"]:enter();
        elseif page_array["page_shishuoshuo"]:quick_check_page()  == true  then
            page_array["page_shishuoshuo"]:enter();
        elseif  page_array["page_pengyoushuoshuo"]:quick_check_page() == true then
            gongneng = 7
            page_array["page_pengyoushuoshuo"]:enter()
        else
            warning_info("转发说说出现错误");
            return false
        end
    else
        cicky(  73,83,50);   --返回详细资料
        mSleep(1500);
        page_array["page_xiangxizl"]:enter();
    end
    return true 
end

--step1
function pengyoushuoshuo_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function pengyoushuoshuo_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_pengyoushuoshuo() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function pengyoushuoshuo_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_pengyoushuoshuo() ;
end

--step3  --最主要的工作都在这个里面
function pengyoushuoshuo_page:action()     --执行这个页面的操作--
    return  action_pengyoushuoshuo();
end

page_array["page_pengyoushuoshuo"] = pengyoushuoshuo_page:new()

------------------end:  page\wx_sousuozhuanfa_2.4\page_pengyoushuoshuo.lua-------------------------------------




----------------------begin:  page\wx_sousuozhuanfa_2.4\page_noshuoshuo.lua---------------------------------

default_noshuoshuo_page = {
    page_name = "noshuoshuo_page",
    page_image_path = nil
}

noshuoshuo_page = class_base_page:new(default_noshuoshuo_page);

---不是说说  /2.4   /不是说说.bmp
local function check_page_noshuoshuo( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -18, 8, 0x121212, -13, 22, 0x898989, -2, 32, 0xFFFFFF, 246, 2, 0x121212, 247, 18, 0x131213, 252, 36, 0x141314, 260, 1, 0x838383, 268, 24, 0xFFFFFF, 272, 1, 0xFFFFFF, 272, 7, 0xFFFFFF, 288, -5, 0x111112, 288, 23, 0xFFFFFF, 306, 1, 0x121212, 310, 23, 0xFFFFFF, 220, 6, 0x121212, 224, 8, 0x121212, 224, 16, 0x121213, 333, 16, 0x121213, 331, 27, 0x131313, 310, 21, 0xFFFFFF, 305, 28, 0x131313, 530, 14, 0x121213, 575, 9, 0x121212, 592, -5, 0x111112, 589, 30, 0x131314, 479, 11, 0x121213, 510, 11, 0x121213 }, 90, 22, 63, 632, 104);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----文章说说界面----");
        return true
    else
        return false
    end
end

function action_wenzhang( ... )  --加载文章
    mSleep(math.random(9999,16666))   --等待
    for i=1,10 do
        mSleep(1500)
        cicky(586,83,50);   --点击点
        mSleep(3000);
        --分享.bmp
       x, y = findMultiColorInRegionFuzzy({ 0xFBFBFB, 14, 0, 0xFBFBFB, 49, 0, 0xFBFBFB, 68, 24, 0xFBFBFB, 74, 44, 0xFBFBFB, 66, 69, 0xFBFBFB, 58, 88, 0xFBFBFB, 10, 90, 0xFBFBFB, 2, 85, 0xFBFBFB, 4, 22, 0xFBFBFB, 8, -1, 0xFBFBFB, 38, 17, 0xFA5452, 27, 20, 0xFF7612, 20, 25, 0xFF7612, 10, 34, 0xFBFAF7, 13, 44, 0xFFC817, 18, 49, 0xFBFBFC, 30, 53, 0xFBFBFB, 51, 55, 0x00B1FE, 58, 55, 0x00B1FE, 60, 50, 0x7A9FF3, 60, 43, 0x5283F0, 59, 32, 0x6467F0, 50, 20, 0xFBFBFB, 38, 20, 0xFA5452, 37, 29, 0xFF7612, 41, 35, 0xFBFBFB, 41, 35, 0xFBFBFB }, 90, 194, 409, 268, 500);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);   --点击分享到朋友圈
            mSleep(5000)
            break
        end
        mSleep(1000)
    end
    gongneng = 2.41 --发朋友圈去
    for i=1,15 do
        if page_array["page_shuoshuo"]:quick_check_page() == true then
            page_array["page_shuoshuo"]:action()
            break
        end
        if i == 15 then
            warning_info("转发文章出现错误或者卡了");
            return false
        end
        mSleep(1000)
    end
end

local function action_noshuoshuo()     --执行这个页面的操作--
    if gongneng == 2.4 or gongneng == 7 then  -- 转发朋友圈
        cicky(  132,210,1000);   ---长按出复制
        mSleep(1000);
        x, y = findImageInRegionFuzzy(path_fuzhi,80,8,100 ,619,178 );   --复制
        if x>0 and y>0 then    --有文字
            cicky(x,y,50);  --点击复制
            mSleep(1000);
            local i2 = 0
            for i=1,6 do  
                cicky( 308,330+i2,50)
                mSleep(3000);
                ---文章正在加载.bmp
                ddzc( 0xFFFFFF, -35, -2, 0xFFFFFF, -542, -12, 0xFFFFFF, -503, 1, 0x0C0C0C, 90, 67, 71, 609, 84)
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    action_wenzhang();   --加载文章
                    break
                end
                if i == 6 then
                    cicky(84,84,50);   --返回朋友说说
                    mSleep(1500);
                    gongneng = 7 ;  --滑动
                    page_array["page_pengyoushuoshuo"]:enter();
                end
                i2=i2+85  
            end
        else                  --没文字
            copyText("");    --初始化剪切版
            mSleep(500);
            cicky( 323,203,50);   --点击文章
            mSleep(5000);
            action_wenzhang();   --加载文章
        end
    else
        cicky(84,84,50);   --返回朋友说说
        mSleep(1500);
        page_array["page_pengyoushuoshuo"]:enter();
    end
end

--step1
function noshuoshuo_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function noshuoshuo_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_noshuoshuo() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function noshuoshuo_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_noshuoshuo() ;
end

--step3  --最主要的工作都在这个里面
function noshuoshuo_page:action()     --执行这个页面的操作--
    return  action_noshuoshuo();
end

page_array["page_noshuoshuo"] = noshuoshuo_page:new()

------------------end:  page\wx_sousuozhuanfa_2.4\page_noshuoshuo.lua-------------------------------------




----------------------begin:  page\wx_sousuozhuanfa_2.4\page_shishuoshuo.lua---------------------------------

default_shishuoshuo_page = {
    page_name = "shishuoshuo_page",
    page_image_path = nil
}

shishuoshuo_page = class_base_page:new(default_shishuoshuo_page);

---是说说 /2.4   /是说说.bmp
local function check_page_shishuoshuo( ... )
    --是说说1
    x, y = findMultiColorInRegionFuzzy({ 0xE7E7E7, -14, -1, 0x0A0A0A, -36, -1, 0xFFFFFF, -43, -1, 0x0A0A0A, -576, -20, 0x0A0A0B, -590, -3, 0x0A0A0A, -572, 18, 0xFFFFFF, -561, -11, 0x0A0A0B, -558, 0, 0x0A0A0A, -556, 2, 0x0A0A0A, -540, 10, 0x0A0A0A, -534, 10, 0x333333, -534, 9, 0x5F5F5F, -540, -2, 0x0A0A0A, -544, -4, 0x0A0A0A, -548, -10, 0xFFFFFF, -548, -13, 0x444444, -540, -15, 0x0A0A0B, -550, -10, 0x0A0A0B, -549, 2, 0xF5F5F5, -514, -13, 0x727272, -498, -10, 0x0A0A0B, -501, 5, 0x0A0A0A, -511, 0, 0x0A0A0A, -512, -3, 0x0A0A0A, -439, 841, 0xFFFFFF, -433, 841, 0xFFFFFF, -429, 836, 0xFFFFFF, -433, 822, 0xFFFFFF, -452, 822, 0xFFFFFF, -570, 819, 0xFFFFFF, -578, 827, 0xFFFFFF, -571, 841, 0xFFFFFF, -556, 839, 0xFFFFFF, -550, 828, 0xFFFFFF, -554, 820, 0xFFFFFF, -560, 820, 0xFFFFFF, -575, 820, 0xFFFFFF }, 90, 21, 63, 611, 924);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----是图片说说界面1----");
        return true
    else
        --是说说2
        x, y = findMultiColorInRegionFuzzy({ 0xCECECE, 16, -3, 0xCECECE, 32, -3, 0xCECECE, 34, -5, 0xCECECE, 34, 2, 0xCECECE, 17, -5, 0xCECECE, 0, -5, 0xCECECE, -532, -16, 0xCECECE, -534, -17, 0xCECECE, -543, -7, 0xCECECE, -549, -2, 0xCECECE, -551, -1, 0xCECECE, -542, 6, 0xCECECE, -532, 14, 0xCECECE, -534, 16, 0xCECECE, -506, -8, 0xCECECE, -506, -14, 0xCECECE, -475, -8, 0xCECECE, -475, -14, 0xCECECE, -475, 7, 0xCECECE, -486, 8, 0xCECECE, -465, 8, 0xCECECE, -526, 819, 0xFFFFFF, -539, 820, 0xFFFFFF, -538, 834, 0xFFFFFF, -526, 843, 0xFFFFFF, -514, 831, 0xFFFFFF, -512, 826, 0xFFFFFF, -518, 818, 0xFFFFFF, -396, 820, 0xFFFFFF, -391, 828, 0xFFFFFF, -395, 839, 0xFFFFFF, -413, 839, 0xFFFFFF, -411, 841, 0xFFFFFF, -416, 825, 0xFFFFFF }, 90, 22, 68, 607, 928);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----是图片说说界面2----");
            return true
        else
            return false
        end
    end
end

local function action_shishuoshuo()     --执行这个页面的操作--
    if gongneng == 2.4 or gongneng == 7 then  -- 转发朋友圈  
        ---是视频说说 返回
        x = getColor( 275,401);
        y = getColor(344,414); 
        mSleep(1000);
        x2 = getColor( 275,401 );
        y2 = getColor(344,414 ); 
        mSleep(500)
        if x~=x2 and y~= y2 then 
            warning_info("是视频说说,转发下一条")
            cicky(84,84,50);   --返回朋友说说
            mSleep(1500);
            gongneng = 7 ;     --滑动到下一个
            page_array["page_pengyoushuoshuo"]:enter()
        else
            cicky(587,912,50)  -- 点击评论
            mSleep(2500);
            page_array["page_fuzhiwenzi"]:enter()
        end
    else
        cicky(84,84,50);   --返回朋友说说
        mSleep(1500);
        page_array["page_pengyoushuoshuo"]:enter();
    end
    return true 
end

--step1
function shishuoshuo_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function shishuoshuo_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_shishuoshuo() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function shishuoshuo_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_shishuoshuo() ;
end

--step3  --最主要的工作都在这个里面
function shishuoshuo_page:action()     --执行这个页面的操作--
    return  action_shishuoshuo();
end

page_array["page_shishuoshuo"] = shishuoshuo_page:new()

------------------end:  page\wx_sousuozhuanfa_2.4\page_shishuoshuo.lua-------------------------------------




----------------------begin:  page\wx_sousuozhuanfa_2.4\page_fuzhiwenzi.lua---------------------------------

default_fuzhiwenzi_page = {
    page_name = "fuzhiwenzi_page",
    page_image_path = nil
}

fuzhiwenzi_page = class_base_page:new(default_fuzhiwenzi_page);

---复制文字 /2.4   /复制文字.bmp
local function check_page_fuzhiwenzi( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 10, 11, 0x186C18, -3, 22, 0x131313, 18, 29, 0x131313, 573, 20, 0x131213, 526, 24, 0x131313, 355, 20, 0x131213, 302, 18, 0x121213, 314, 2, 0x414141, 319, 32, 0xFFFFFF, 273, 3, 0x3A3A3A, 272, 32, 0x131314, 46, 3, 0x132113, 271, 27, 0xADADAD }, 90, 28, 66, 604, 98);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----说说复制文字界面----");
        return true
    else
        return false
    end
end

local function action_fuzhiwenzi()     --执行这个页面的操作--
     if gongneng == 2.4 or gongneng == 7 then  -- 转发朋友圈
        cicky( 132,210,1000);   ---长按出复制
        mSleep(1000);
        x, y = findImageInRegionFuzzy(path_fuzhi,80,   8,100 ,619,178 );   --复制
        if x>0 and y>0 then 
            cicky(x,y,50);  --点击复制
            mSleep(2000);
            log_info("转发朋友复制文字完成 保存图片")
            xiahua()
            xiahua()
            mSleep(500)
        else  --没有复制/就是没有文字
            copyText(""); 
            mSleep(500)
            cicky(  569,97 ,50)   --点击屏幕右上角
            mSleep(1000);
        end
        for i=0,17 do
            cicky( 177,190+40*i,50)
            mSleep(500)
            --点到电话号码了
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 39, 3, 0x525252, 47, 3, 0xFFFFFF, 49, 0, 0xFFFFFF, 65, 16, 0xFFFFFF, 55, 36, 0xFFFFFF, 24, 40, 0xFFFFFF, 9, 34, 0xFFFFFF, 6, 16, 0x131313, 44, 5, 0xE3E3E3, 38, 25, 0x383838, 13, 7, 0xFFFFFF, 34, 3, 0xFFFFFF, 34, 3, 0xFFFFFF }, 90, 290, 895, 355, 935);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50)  --点击取消
                mSleep(1000)
            end
            if check_page_fuzhiwenzi() == false then
               for i=1,9 do
                   mSleep(500)
                   cicky( 310,569,2500)   --长按保存图片
                   mSleep(500)
                   --保存图片0
                    x1, y1 = findMultiColorInRegionFuzzy({ 0x000000, 2, -7, 0x000000, 1, -12, 0x000000, -81, -10, 0x000000, -67, 4, 0x000000, 39, 4, 0x000000 }, 90, 257, 692, 377, 708);
                    --保存图片1
                    x2, y2 = findMultiColorInRegionFuzzy({ 0x000000, 8, 0, 0x000000, 23, -1, 0x000000, 44, -3, 0x000000, 59, -3, 0x000000, 92, -6, 0x000000, 127, 2, 0x000000 }, 90, 255, 595, 382, 603);
                    --保存图片2
                    x3, y3 = findMultiColorInRegionFuzzy({ 0x000000, -50, -17, 0x000000, -40, -18, 0x000000, 2, -15, 0x000000, 31, -18, 0x000000, 60, -18, 0x000000, 71, -18, 0x000000, 71, -2, 0x000000 }, 90, 257, 498, 378, 516);
                    --保存图片3
                    x4, y4 = findMultiColorInRegionFuzzy({ 0x000000, -2, -15, 0x000000, -1, -6, 0x000000, 34, -5, 0x000000, 105, 1, 0x000000, 95, 1, 0x000000, 79, 1, 0x000000, 67, -3, 0x000000 }, 90, 269, 595, 376, 611);
                    if x1 ~= -1 and y1 ~= -1 then  -- 如果找到了
                        cicky(x,y,50);
                        mSleep(2500)
                    elseif x2 ~= -1 and y2 ~= -1 then
                        cicky(x2,y2,50);
                        mSleep(2500)
                     elseif x3 ~= -1 and y3 ~= -1 then
                        cicky(x3,y3,50);
                        mSleep(2500)
                    elseif x4 ~= -1 and y4 ~= -1 then
                        cicky(x4,y4,50);
                        mSleep(2500)
                    else
                        warning_info("保存图片错误");
                        return false
                    end
                    mSleep(500)
                    a = getColor( 63,557);
                    b = getColor( 180,568);
                    c = getColor( 335,565 )
                    d = getColor( 484,566 )
                    e = getColor( 579,558 )
                    rotateScreen(0);
                    mSleep(1528);
                    touchDown(8, 494, 500)
                    mSleep(48);
                    touchMove(8, 460, 504)
                    mSleep(18);
                    touchMove(8, 432, 504)
                    mSleep(51);
                    touchMove(8, 402, 504)
                    mSleep(14);
                    touchMove(8, 284, 526)
                    mSleep(18);
                    touchMove(8, 238, 534)
                    mSleep(17);
                    touchMove(8, 202, 538)
                    mSleep(16);
                    touchMove(8, 180, 542)
                    mSleep(16);
                    touchMove(8, 162, 542)
                    mSleep(18);
                    touchUp(8)
                    mSleep(1000);
                    a2 = getColor( 63,557);
                    b2 = getColor( 180,568);
                    c2 = getColor( 335,565 )
                    d2 = getColor( 484,566 )
                    e2 = getColor( 579,558 )
                    mSleep(1000)
                    if a == a2 and b == b2 and c == c2 and d == d2 and e == e2 or page_array["page_fuzhiwenzi"]:quick_check_page() == true then
                        log_info("保存图片完成，发朋友圈去")
                        if i == 1 then
                           mSleep(500)
                        else
                            cicky( 310,569,50);  --点击屏幕
                            mSleep(1500);
                        end
                        gongneng = 2.41 --发朋友圈去
                        cicky(84,84,50);   --点击完成
                        mSleep(2000);
                        page_array["page_shishuoshuo"]:enter();
                        break
                    end
                end
               break
           end
        end
    else
        cicky(84,84,50);   --点击完成
        mSleep(2000);
        page_array["page_shishuoshuo"]:enter();
    end
    return true 
end

--step1
function fuzhiwenzi_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function fuzhiwenzi_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_fuzhiwenzi() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function fuzhiwenzi_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_fuzhiwenzi() ;
end

--step3  --最主要的工作都在这个里面
function fuzhiwenzi_page:action()     --执行这个页面的操作--
    return  action_fuzhiwenzi();
end

page_array["page_fuzhiwenzi"] = fuzhiwenzi_page:new()

------------------end:  page\wx_sousuozhuanfa_2.4\page_fuzhiwenzi.lua-------------------------------------




----------------------begin:  page\wx_zhuanfawenzhang_2.5\page_gongzhonghao.lua---------------------------------

default_gongzhonghao_page = {
    page_name = "gongzhonghao_page",
    page_image_path = nil
}

gongzhonghao_page = class_base_page:new(default_gongzhonghao_page);

---公众号界面/2.5    公众号.bmp
local function check_page_gongzhonghao( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -19, 14, 0x121213, -5, 33, 0x131314, 21, 0, 0x121112, 28, 18, 0xFFFFFF, 28, 4, 0x121212, 57, 16, 0x121213, 58, 19, 0x383838, 61, 5, 0x121212, 90, 15, 0xFFFFFF, 100, 15, 0xFFFFFF, 100, 0, 0x121112, 235, 1, 0x5B5B5B, 242, 25, 0x131313, 255, 9, 0x121212, 251, -6, 0x111112, 276, 29, 0x131313, 291, 18, 0x131213, 287, 4, 0x121212, 314, 24, 0x131313, 317, 20, 0x222222, 317, -1, 0x121112, 324, 21, 0xFFFFFF, 550, 15, 0xFFFFFF, 551, 31, 0xFFFFFF, 587, 21, 0x131313, 590, 21, 0x131313 }, 90, 20, 62, 629, 101);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----公众号界面----")
       -- mSleep(1000)
        return true
    else
        return false
    end
end

local function action_gongzhonghao()     --执行这个页面的操作--
    if gongneng == 2.5 then  -- 转发公众号文章
        cicky( 299,177,50);    --点击搜索
        mSleep(3000);
        inputText(text_gongzhonghao[math.random(#text_gongzhonghao)]);
        mSleep(2000);
        x, y = findMultiColorInRegionFuzzy({ 0xD6D6D6, -3, 29, 0xFFFFFF, 14, 29, 0xCCCCCC, 42, 3, 0xEAEAEA, 53, 25, 0xFFFFFF, 53, 4, 0xCCCCCC, 76, 2, 0xE4E4E4, 92, 27, 0xCECECE, 84, 15, 0xCCCCCC, 84, 14, 0xCCCCCC }, 90, 272, 244, 367, 273);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("没关注这个公众号,请换个公众号");
            return false
        end
        cicky( 145,183,50);  --点击第一个搜到的
        page_array["page_gongzhonghaocaozuo"]:enter()
    else
        cicky(  75,86,50);    --返回通讯录
        mSleep(1500);
        page_array["page_tongxunlu"]:enter()
    end
end

--step1
function gongzhonghao_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function gongzhonghao_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_gongzhonghao() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function gongzhonghao_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_gongzhonghao() ;
end

--step3  --最主要的工作都在这个里面
function gongzhonghao_page:action()     --执行这个页面的操作--
    return  action_gongzhonghao();
end

page_array["page_gongzhonghao"] = gongzhonghao_page:new()

------------------end:  page\wx_zhuanfawenzhang_2.5\page_gongzhonghao.lua-------------------------------------




----------------------begin:  page\wx_zhuanfawenzhang_2.5\page_gongzhonghaocaozuo.lua---------------------------------

default_gongzhonghaocaozuo_page = {
    page_name = "gongzhonghaocaozuo_page",
    page_image_path = nil
}

gongzhonghaocaozuo_page = class_base_page:new(default_gongzhonghaocaozuo_page);

---公众号操作界面/2.5    没有文章1.bmp
local function check_page_gongzhonghaocaozuo( ... )
   x, y = findMultiColorInRegionFuzzy({ 0x111111, -16, 16, 0x121112, -7, 38, 0x131313, 10, 13, 0x111112, 12, 26, 0x121212, 34, 24, 0xEAEAEA, 30, 12, 0x363637, 48, 24, 0xFFFFFF, 56, 15, 0xFFFFFF, 67, 9, 0x212122, 67, 9, 0x212122, 553, 7, 0xFFFFFF, 539, 38, 0xFFFFFF, 573, 29, 0x121213, 574, 21, 0x121212, 536, 20, 0x121212, 5, 823, 0x7F8389, -12, 862, 0xFAFAFA, 26, 855, 0xFAFAFA, 11, 845, 0x91959A, -7, 843, 0xFAFAFA, 2, 847, 0xFAFAFA, 19, 859, 0xFAFAFA, 9, 881, 0xFAFAFA, 25, 883, 0xFAFAFA, -19, 802, 0xFAFAFA, 18, 802, 0xFAFAFA, 2, 807, 0xFAFAFA, 6, 880, 0xFAFAFA }, 90, 21, 63, 614, 946);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----公众号操作界面----")
        return true
    else
        return false
    end
end

local function action_gongzhonghaocaozuo()     --执行这个页面的操作--
    if gongneng == 2.5 then  -- 转发朋友圈
       x, y = findMultiColorInRegionFuzzy({ 0xEBEBEB, 87, 0, 0xEBEBEB, 182, -2, 0xEBEBEB, 281, -2, 0xEBEBEB, 349, -1, 0xEBEBEB, 468, 1, 0xEBEBEB, 269, 8, 0xEBEBEB, 581, 9, 0xEBEBEB, 566, 21, 0xEBEBEB, 451, 95, 0xEBEBEB, 422, 203, 0xEBEBEB, 429, 385, 0xEBEBEB, 417, 459, 0xEBEBEB, 189, 429, 0xEBEBEB, 326, 439, 0xEBEBEB, 383, 436, 0xEBEBEB, 274, 201, 0xEBEBEB, 371, 201, 0xEBEBEB, 293, 147, 0xEBEBEB, 293, 301, 0xEBEBEB, 268, 326, 0xEBEBEB, 144, 186, 0xEBEBEB, 148, 375, 0xEBEBEB, 135, 404, 0xEBEBEB, 28, 159, 0xEBEBEB, 31, 362, 0xEBEBEB, 37, 407, 0xEBEBEB, 72, 456, 0xEBEBEB, 335, 441, 0xEBEBEB, 468, 373, 0xEBEBEB, 526, 124, 0xEBEBEB, 518, 389, 0xEBEBEB, 529, 409, 0xEBEBEB }, 90, 41, 146, 622, 607);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("没有文章可转发,请换个公众号");
            return false
        end
        cicky( 297,462,50);   --点击屏幕中间
        mSleep(3000);
        for i=1,10 do
            mSleep(3000)
            cicky( 588,83,50);   --点击点
            mSleep(3000);
            --分享.bmp
            x, y = findMultiColorInRegionFuzzy({ 0xFBFBFB, 14, 0, 0xFBFBFB, 49, 0, 0xFBFBFB, 68, 24, 0xFBFBFB, 74, 44, 0xFBFBFB, 66, 69, 0xFBFBFB, 58, 88, 0xFBFBFB, 10, 90, 0xFBFBFB, 2, 85, 0xFBFBFB, 4, 22, 0xFBFBFB, 8, -1, 0xFBFBFB, 38, 17, 0xFA5452, 27, 20, 0xFF7612, 20, 25, 0xFF7612, 10, 34, 0xFBFAF7, 13, 44, 0xFFC817, 18, 49, 0xFBFBFC, 30, 53, 0xFBFBFB, 51, 55, 0x00B1FE, 58, 55, 0x00B1FE, 60, 50, 0x7A9FF3, 60, 43, 0x5283F0, 59, 32, 0x6467F0, 50, 20, 0xFBFBFB, 38, 20, 0xFA5452, 37, 29, 0xFF7612, 41, 35, 0xFBFBFB, 41, 35, 0xFBFBFB }, 90, 194, 409, 268, 500);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                mSleep(500)
                cicky(x,y,50);   --点击分享到朋友圈
                mSleep(5000)
                break
            end
            mSleep(1000)
        end
        gongneng = 2.41 --发朋友圈去
        for i=1,10 do
            if page_array["page_shuoshuo"]:quick_check_page() == true then
                copyText("");  --初始化剪切
                page_array["page_shuoshuo"]:enter()
                break
            end
            if i == 10 then
                warning_info("转发文章出现错误");
                return false
            end
            mSleep(1000)
        end
    else
        cicky( 84,84,50);   --返回公众号
        mSleep(2000); 
        page_array["page_weixinzhu"]:enter();
    end
    return true 
end

--step1
function gongzhonghaocaozuo_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function gongzhonghaocaozuo_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_gongzhonghaocaozuo() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function gongzhonghaocaozuo_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_gongzhonghaocaozuo() ;
end

--step3  --最主要的工作都在这个里面
function gongzhonghaocaozuo_page:action()     --执行这个页面的操作--
    return  action_gongzhonghaocaozuo();
end

page_array["page_gongzhonghaocaozuo"] = gongzhonghaocaozuo_page:new()

------------------end:  page\wx_zhuanfawenzhang_2.5\page_gongzhonghaocaozuo.lua-------------------------------------




----------------------begin:  page\wx_faxiaoxi_2.6\page_txlzl.lua---------------------------------

default_txlzl_page = {
    page_name = "txlzl_page",
    page_image_path = nil
}

txlzl_page = class_base_page:new(default_txlzl_page);

 --通讯录详细资料.bmp
local function check_page_txlzl( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -12, 9, 0xFFFFFF, 6, 29, 0x131313, 18, 2, 0x111112, 33, 14, 0x121212, 15, 1, 0x5E5E5F, 20, 11, 0x262626, 44, 8, 0xDDDCDD, 64, 16, 0x121213, 59, 21, 0xC6C6C7, 59, 22, 0xC7C7C7, 79, 12, 0x121212, 104, 15, 0x121212, 90, 13, 0xD7D7D7, 90, 38, 0x131314, 206, 1, 0x111112, 224, 26, 0x121213, 226, 4, 0x121213, 223, 10, 0x121212, 252, 11, 0xFEFEFE, 272, 22, 0x121213, 260, -2, 0x111112, 258, 20, 0x39393A, 290, 11, 0x121212, 303, 17, 0x5A5A5B, 307, 0, 0x111112, 304, 24, 0x121213, 324, 17, 0xCFCFCF, 343, 9, 0x3C3B3C, 349, 15, 0x121212, 548, 8, 0x121112, 551, 10, 0xB7B7B7, 536, 10, 0x4B4B4B, 558, 14, 0x121212, 572, 14, 0x121212, 554, 6, 0x111112, 553, 15, 0xFFFFFF }, 90, 28, 67, 612, 107);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----通讯录详细资料界面----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x111112, 22, 2, 0x5E5E5F, 60, 3, 0x111112, 67, 8, 0x838383, 74, 19, 0x121213, 26, 41, 0x131314, -3, 36, 0x131313, -17, 22, 0x121213, -4, 21, 0x121213, 24, 21, 0x7D7D7D, 33, 21, 0x121213, 216, 7, 0x909090, 302, 6, 0xFFFFFF, 368, 6, 0x111112, 366, 19, 0x121213, 351, 40, 0x131314, 240, 37, 0x131313, 200, 32, 0x131313, 243, 12, 0x121112, 290, 20, 0x121213, 339, 25, 0xFFFFFF, 549, 16, 0xB7B7B7, 566, 13, 0x121212, 552, 0, 0x111112, 519, 0, 0x111112, 547, 31, 0x131213, 579, 22, 0x121213, 530, -4, 0x111111, 516, -4, 0x111111, -14, 27, 0x121213 }, 90, 19, 62, 615, 107);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----微信详细资料界面----");
            return true
        else
            return false
        end
    end
end

local function action_txlzl()     --操作
    if gongneng == 2.6  then   --随机发消息
        xiahua()
        mSleep(3000)
        x, y = findColorInRegion(0x1AAD19,30,466, 623,917);  --区域找色
        if x ~= -1 and y ~= -1 then  
            cicky(x,y,50);
            mSleep(2000);
            page_array["page_liaotian"]:enter()
        end
    else
        cicky(89,80,50);    --返回通讯录
        mSleep(2000);
        ---搜索
        x, y = findMultiColorInRegionFuzzy({ 0xC1E5C4, 14, 0, 0xEFEFF4, 15, 1, 0x08BF06, 15, 13, 0xEFEFF4, -19, 16, 0x06BF04, -42, 6, 0xEFEFF4, -25, 2, 0x82D884, -1, 3, 0xEFEFF4, 0, 4, 0xEFEFF4, 6, 10, 0x06BF04, 6, 10, 0x06BF04 }, 90, 558, 70, 615, 86);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);  --点击取消
            mSleep(1500);
            page_array["page_tongxunlu"]:enter()
        end
        if page_array["page_weixinzhu"]:check_page() == true then
            page_array["page_weixinzhu"]:action()
        end
    end
    return true
end

--step1
function txlzl_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function txlzl_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_txlzl() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function txlzl_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_txlzl();     
end

--step3  --最主要的工作都在这个里面
function txlzl_page:action()
    return action_txlzl();
end

page_array["page_txlzl"] =  txlzl_page:new() 


------------------end:  page\wx_faxiaoxi_2.6\page_txlzl.lua-------------------------------------




----------------------begin:  page\wx_fujinderen_3.1-3.4\page_fujinderen.lua---------------------------------
 
default_fujinderen_page = {
    page_name = "fujinderen_page",
    page_image_path = nil
}

fujinderen_page = class_base_page:new(default_fujinderen_page);

--附近的人 3.1 +  站街 3.4  /附近的人.bmp      
local function check_page_fujinderen( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x888889, -1, 24, 0xFFFFFF, 15, 3, 0x111112, 30, 6, 0xE4E4E4, 29, 23, 0xFFFFFF, 61, 1, 0x5C5C5C, 71, 22, 0x121213, 68, 8, 0xFFFFFF, 86, 8, 0x121112, 120, 8, 0x121112, 213, 22, 0xFFFFFF, 235, 24, 0x121213, 227, 11, 0xFFFFFF, 262, 25, 0xFFFFFF, 281, 5, 0x6B6B6B, 262, 4, 0x717172, 298, 23, 0xFFFFFF, 313, 3, 0xFFFFFF, 295, 6, 0x121112, 326, 4, 0x111112, 350, 9, 0x121212, 343, 15, 0xFFFFFF, 442, 13, 0x121212, 503, 13, 0x121212, 547, 13, 0x121212, 556, 13, 0xFFFFFF, 570, 11, 0xFFFFFF, 550, 9, 0x121212, 550, 18, 0x121213 }, 90, 34, 70, 605, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----附近的人界面1----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x111112, 46, 5, 0x111112, 135, 15, 0x121212, 138, 16, 0x121212, 165, 23, 0x121213, 115, 34, 0x131313, 57, 41, 0x131314, 16, 36, 0x131313, -6, 25, 0x121213, 22, 22, 0x121213, 78, 22, 0xC4C4C5, 114, 16, 0x121212, 158, 16, 0x121212, 247, 3, 0xFFFFFF, 335, 3, 0x111112, 366, 3, 0x111112, 370, 6, 0x111112, 367, 31, 0x131313, 303, 40, 0x131314, 253, 28, 0x121213, 248, 20, 0xFFFFFF, 310, 15, 0xFFFFFF, 347, 15, 0x121212, 369, 15, 0x121212, 562, 21, 0x121213, 591, 20, 0xFFFFFF, 614, 12, 0x121212, 574, -2, 0x111112, 548, 15, 0x121212, 600, 34, 0x131313, 604, 10, 0x121112, 569, -4, 0x111111, 80, 11, 0xABABAB, 145, 24, 0x121213, 38, 24, 0xFFFFFF, 15, 24, 0xFFFFFF }, 90, 9, 63, 629, 108);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----附近的人的附近的人界面")
            return true
        else
            return false
        end
    end
end

--附近的人2
function fujinderen( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 16, 0, 0xFFFFFF, 34, 4, 0xFFFFFF, -199, -5, 0xFFFFFF, -264, -6, 0xFFFFFF, -299, -7, 0xFFFFFF, -325, -6, 0xFFFFFF, -319, -14, 0xFFFFFF, -311, 10, 0xFFFFFF, -300, 10, 0xFFFFFF, -267, 14, 0xFFFFFF, -239, 2, 0xFFFFFF, -239, -8, 0xFFFFFF, -230, -9, 0xFFFFFF }, 90, 248, 68, 607, 96);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----附近的人界面2----");
        return true
    else
        return false
    end
end

--附近有打招呼的界面
local function zhaohu()
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 17, 2, 0x111112, 71, 6, 0x111112, 78, 7, 0x111112, 4, 17, 0x121212, 44, 17, 0x121212, 78, 12, 0x121112, 52, 26, 0x121213, 76, 21, 0xFFFFFF, 107, 21, 0x121213, 269, 6, 0x7A7A7A, 347, 5, 0xFFFFFF, 364, 5, 0x111112, 299, 22, 0x121213, 350, 22, 0xFFFFFF, 320, 22, 0x414142, 232, 30, 0x131213, 300, 30, 0x131213, 346, 30, 0x131213, 347, 30, 0x131213, 562, 3, 0x111112, 602, 21, 0x121213, 523, 22, 0x121213, 517, 14, 0x121212, 481, 13, 0x121212 }, 90, 28, 66, 630, 96);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----附近有打招呼的界面----")
        return true
    else
        return false
    end
end

local fj_time = 1
local function action_fujinderen()     --操作
    --附近没人
    x, y = findMultiColorInRegionFuzzy({ 0xC9C9C9, -3, 13, 0xC9C9C9, -7, 7, 0xC9C9C9, 21, 68, 0xFFFFFF, 106, 69, 0xFFFFFF, 121, 39, 0xFFFFFF, 88, 0, 0xC9C9C9, 90, -1, 0xC9C9C9, 91, 14, 0xC9C9C9, 74, 107, 0xC9C9C9, 53, 157, 0xC9C9C9, 138, 160, 0xE2E2E2, 118, 132, 0xC9C9C9, 101, 94, 0xC9C9C9, -1, 78, 0xC9C9C9, -14, 105, 0xC9C9C9, -55, 140, 0xFFFFFF, -30, 124, 0xC9C9C9, 3, 93, 0xC9C9C9, 36, 145, 0xC9C9C9, 50, 176, 0xFFFFFF, 43, 168, 0xFFFFFF, -49, 135, 0xFFFFFF, 52, 140, 0xC9C9C9, 118, 134, 0xC9C9C9 }, 90, 219, 242, 412, 419);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        warning_info("附近的人错误，没有获取位置或者没人");
        cicky(  85,84,50);  --返回发现
        mSleep(2000);
        return false
    end
    if gongneng == 3.1 then
        if num_cs <= 0 then
            warning_info("招呼打完,回复去")
            mSleep(1000)
            if strategy[1] == "3" then
                gongneng = 1.4 --养号回复
            else
                gongneng = 1.1 --智能回复
            end
            return page_array["page_fujinderen"]:action()
        end
        num_cs = num_cs - 1
        mSleep(math.random(1000,3255))
        m = math.random(21,467)
        n = math.random(192,956)
        cicky( m,n,50);   --点击一个人
        mSleep(2000);
        if page_array["page_dazhaohu"]:check_page() == true then
            return page_array["page_dazhaohu"]:enter();
        elseif fujinderen() == true then
            fj_time = fj_time +1
            if fj_time == 5 then
                warning_info("附近的人打招呼错误5次")
                return false
            end
            return page_array["page_fujinderen"]:action()
        else
            --备注信息
            x, y = findMultiColorInRegionFuzzy({ 0x111112, 34, 1, 0x20D81F, 34, 19, 0x121213, 1, 20, 0x132114, -2, 9, 0x20D81F, 2, 8, 0x175616, -540, -6, 0x111111, -494, -1, 0x111112, -493, 5, 0x111112, -526, 21, 0x121213, -506, 10, 0x121212, -485, 15, 0xFFFFFF, -458, 21, 0x121213 }, 90, 32, 63, 606, 90);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(80,80,50);
                mSleep(1500)
                return page_array["page_dazhaohu"]:enter();
            else
                warning_info("附近的人打招呼错误")
                return false
            end
        end
    elseif gongneng == 3.12 then   --有人打招呼
        cicky( 586,82,50);   --点击点
        mSleep(2000);
        cicky( 327,712,50);  --点击附近打招呼的人
        mSleep(1500);
        return page_array["page_fujindazhaohuderen"]:enter()
    elseif gongneng == 3.4 then    --站街
        mSleep(math.random(2000,6000));
        local m = math.random(3,6)
        for i=1,m do
            n = math.random(40,400)
            o = math.random(200,350)
            p = math.random(450,800) 
            move( n,p, n,o,4)
            mSleep(math.random(2000,6000));
        end
        cicky(85,84,50);    --返回发现
        mSleep(math.random(1500,5000));
        log_info("站街一次")
        if strategy[1] == "3" then
            gongneng = 1.4 --养号回复
        else
            gongneng = 1.1 --智能回复
        end
        if zhaohu() == true then
            cicky(  85,84,50);  --返回发现
            mSleep(2000);
            return page_array["page_faxian"]:enter();
        else
            return page_array["page_faxian"]:enter();
        end
    else
        cicky(  85,84,50);  --返回发现
        mSleep(2000);
        if zhaohu() == true then
            cicky(  85,84,50);  --返回发现
            mSleep(2000);
            page_array["page_faxian"]:enter();
        else
            page_array["page_faxian"]:enter();
        end
    end
    return true
end

--step1
function fujinderen_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function fujinderen_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_fujinderen() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function fujinderen_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_fujinderen();     
end

--step3  --最主要的工作都在这个里面
function fujinderen_page:action()
    return action_fujinderen();
end

page_array["page_fujinderen"] =  fujinderen_page:new()    


------------------end:  page\wx_fujinderen_3.1-3.4\page_fujinderen.lua-------------------------------------




----------------------begin:  page\wx_fujinderen_3.1-3.4\page_dazhaohu.lua---------------------------------

default_dazhaohu_page = {
    page_name = "dazhaohu_page",
    page_image_path = nil
}

dazhaohu_page = class_base_page:new(default_dazhaohu_page);

--详细资料 3.1  /详细资料d.bmp
local function check_page_dazhaohu( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 0, 21, 0x121213, 6, 28, 0x131313, 21, 2, 0x111112, 34, 0, 0x5C5C5C, 37, 12, 0x121213, 65, 1, 0x111112, 80, 10, 0xFFFFFF, 114, -1, 0x111112, 142, 11, 0x121212, 229, -5, 0x111112, 248, 2, 0xFFFFFF, 227, 15, 0x121213, 262, 20, 0x131314, 282, 0, 0x424243, 269, 3, 0xF5F5F5, 298, 22, 0x121213, 324, -1, 0x49494A, 295, 2, 0x111112, 338, 18, 0xFFFFFF, 359, -5, 0x313132, 346, -5, 0x111112, 382, 5, 0x121112, 398, 6, 0x121212, 562, -3, 0x111112, 549, 8, 0xFDFDFD, 590, 6, 0x121212, 580, 7, 0xFFFFFF, 559, 22, 0x121213, 507, 11, 0x121212 }, 90, 28, 68, 618, 101);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----打招呼详细资料界面1----");
        return true
    else
        return false
    end
end

local function action_dazhaohu()     --操作
    if gongneng == 3.1  then
        xiahua()  --下滑
        mSleep(500)
        ---点击打招呼
        x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, 20, 1, 0xAFE2AF, 28, 26, 0x1EAE1D, 6, 9, 0x1AAD19, 6, 23, 0x1AAD19, 48, 9, 0xFFFFFF, 47, 21, 0xE0F4E0, 47, 23, 0xE0F4E0, 65, 9, 0x1AAD19, 64, 23, 0x1AAD19, 51, 23, 0x1AAD19, 69, 20, 0x1AAD19, 98, 15, 0xFFFFFF, 97, -6, 0x1AAD19, 79, 7, 0xA5DFA5, 116, 20, 0x1AAD19, 113, 17, 0x1AAD19, 144, 15, 0x1AAD19 }, 90, 263, 703, 407, 735);
        if x>0 and y>0 then   --打招呼
            cicky(x,y,50);
            mSleep(1500);
            return page_array["page_zhaohu"]:enter();
        else   --已经是朋友了
            log_info("是朋友下一个");
            mSleep(2000)
            cicky(85,84,50);  --返回附近的人
            mSleep(2000);
            m = math.random(21,467)
            o = math.random(130,400)
            p = math.random(500,950)
            move(m,p, m,o,5) --随机滑动 
            mSleep(math.random(2000,3333))
            ---附近的人界面2
            if fujinderen() == true then
               return page_array["page_fujinderen"]:action()
            else
                warning_info("附近的人错误");
                mSleep(1000)
                return false
            end
        end
    else 
        cicky(  85,84,50);  --返回附近的人
        mSleep(2000);
        page_array["page_fujinderen"]:enter();
    end
    return true
end

--step1
function dazhaohu_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function dazhaohu_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_dazhaohu() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function dazhaohu_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_dazhaohu();     
end

--step3  --最主要的工作都在这个里面
function dazhaohu_page:action()
    return action_dazhaohu();
end

page_array["page_dazhaohu"] =  dazhaohu_page:new() 


------------------end:  page\wx_fujinderen_3.1-3.4\page_dazhaohu.lua-------------------------------------




----------------------begin:  page\wx_fujinderen_3.1-3.4\page_zhaohu.lua---------------------------------

default_zhaohu_page = {
    page_name = "zhaohu_page",
    page_image_path = nil
}

zhaohu_page = class_base_page:new(default_zhaohu_page);

--打招呼 3.1  /打招呼.bmp
local function check_page_zhaohu( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x5A5A5A, 14, 3, 0xD4D4D4, 8, -11, 0x878787, 36, -4, 0x121212, 53, -4, 0xFFFFFF, 45, -15, 0x848484, -9, -6, 0x121212, 90, -6, 0x121212, 125, -9, 0x121112, 243, -12, 0x363637, 274, -3, 0x121212, 254, -10, 0x121112, 292, 4, 0xFFFFFF, 308, -5, 0x121212, 304, 12, 0xA6A6A6, 314, -13, 0xFFFFFF, 334, -4, 0xFFFFFF, 328, -12, 0x111112, 547, -13, 0x111112, 551, 1, 0xF1F1F1, 554, -22, 0x111111, 573, -8, 0x121112, 585, -8, 0x121112, 585, -9, 0x121112, 25, 97, 0xEFEFF4, 62, 97, 0xEFEFF4, 92, 100, 0xEFEFF4, 161, 98, 0xEFEFF4, 209, 97, 0xBDBDBF }, 90, 17, 64, 611, 186);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----打招呼界面----");
        return true
    else
        return false
    end
end

---打招呼详细资料界面2  
local function ziliao( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 18, -1, 0xFFFFFF, 37, 0, 0xFFFFFF, -284, 3, 0xFFFFFF, -285, -6, 0xFFFFFF, -281, -15, 0xFFFFFF, -243, 0, 0xFFFFFF, -233, 0, 0xFFFFFF, -207, 0, 0xFFFFFF, -194, 4, 0xFFFFFF, -187, 3, 0xFFFFFF }, 90, 287, 70, 609, 89);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----打招呼详细资料界面2----");
        return true
    else
        return false
    end
end

local function action_zhaohu()     --操作
    if gongneng == 3.1 or gongneng == 3.2  then
        mSleep(500)
        inputText(text_zhaohu[math.random(#text_zhaohu)]);      --输入内容
        mSleep(1500);
        cicky( 602,83,50);   --点击发送
        mSleep(3000);
        for i=1 ,5 do
            if ziliao() == true then
                mSleep(1000)
                cicky(  85,84,50);  --点击返回
                mSleep(2000);
                if fujinderen() == true then
                    log_info("附近的人打招呼一次")
                    mSleep(500)
                    m =math.random(2,5)
                    for i=1,m do
                        move( 370,517, 370,377,5)
                        mSleep(500)
                    end
                    mSleep(math.random(2000,3333))
                    ---附近的人界面2
                    return page_array["page_fujinderen"]:action()
                else
                    warning_info("附近的人错误");
                    mSleep(1000)
                    return false
                end
            end
            if page_array["page_pingzidazhaohu"]:quick_check_page() == true then
                cicky(  85,84,50);  --点击返回
                mSleep(2000);
                cicky(  85,84,50);  --点击返回
                mSleep(2000);
                log_info("捡瓶子打招呼一次")
            --    gongneng = 3.22   --扔瓶子去
            --   page_array["page_jianpingzi"]:enter()
                return true
            end
            mSleep(1000);
            if i == 5 then   --卡了
                warning_info("打招呼时网络卡了")
                mSleep(1000)
                cicky(  85,84,50);  --点击取消
                mSleep(2000);
                cicky(  85,84,50);  --点击返回
                mSleep(2000);
                return false
            end
        end
    else
        cicky(  85,84,50);  --点击取消
        mSleep(2000);
        if page_array["page_dazhaohu"]:quick_check_page() == true then
           page_array["page_dazhaohu"]:enter();
        elseif page_array["page_pingzidazhaohu"]:quick_check_page() == true then
            page_array["page_pingzidazhaohu"]:enter()
        end
    end
    return true 
end

--step1
function zhaohu_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function zhaohu_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_zhaohu() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function zhaohu_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_zhaohu();     
end

--step3  --最主要的工作都在这个里面
function zhaohu_page:action()
    return action_zhaohu();
end

page_array["page_zhaohu"] =  zhaohu_page:new() 


------------------end:  page\wx_fujinderen_3.1-3.4\page_zhaohu.lua-------------------------------------




----------------------begin:  page\wx_fujinderen_3.1-3.4\page_fujindazhaohuderen.lua---------------------------------

default_fujindazhaohuderen_page = {
    page_name = "fujindazhaohuderen_page",
    page_image_path = nil
}

fujindazhaohuderen_page = class_base_page:new(default_fujindazhaohuderen_page);

--附近打招呼的人.bmp     
local function check_page_fujindazhaohuderen( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x111112, 23, 4, 0x111112, 59, 12, 0x121212, 95, 12, 0xFFFFFF, 146, 10, 0x121112, 151, 17, 0x121212, 111, 31, 0x131313, 52, 34, 0x131313, 13, 34, 0x131313, -13, 23, 0x121213, 15, 16, 0x121212, 50, 16, 0x121212, 83, 17, 0x474747, 144, 17, 0x121212, 198, 1, 0x111112, 273, 6, 0xE6E6E6, 341, 5, 0xFFFFFF, 406, -1, 0x111112, 419, 1, 0x111112, 438, 27, 0x121213, 434, 35, 0x131313, 374, 35, 0x131313, 295, 40, 0x131314, 245, 43, 0x131314, 187, 29, 0x8C8C8C, 191, 28, 0x121213, 249, 22, 0x121213, 344, 22, 0x121213, 395, 24, 0x121213, 415, 24, 0xFFFFFF, 416, 17, 0x121212, 390, 9, 0xD8D8D8, 315, 12, 0xFFFFFF, 255, 12, 0x121212, 233, 8, 0x111112, 221, 5, 0x111112 }, 90, 10, 66, 461, 110);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----附近打招呼的人界面----");
        return true
    else
        return false
    end
end

local function action_fujindazhaohuderen()     --操作
    if gongneng == 3.12  then
        ---没打招呼的人.bmp
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 13, 0, 0xFFFFFF, 46, 0, 0xFFFFFF, 87, 0, 0x000000, 115, 2, 0xF6F6F6, 146, 3, 0xFFFFFF, 174, 5, 0xFFFFFF, 224, 2, 0x010101, 253, 3, 0xFFFFFF, 289, -1, 0xFFFFFF }, 90, 190, 448, 479, 454);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("没打招呼的人了")
            mSleep(1000)
            cicky(  67,87,50);  --返回附近的人
            mSleep(2000);
            gongneng = gong_neng --返回打招呼
            m = math.random(3,8);
            if gongneng == 3.1 then
                for i=1,m do
                    n = math.random(40,400)
                    o = math.random(300,400)
                    p = math.random(450,700) 
                    move( n,p, n,o,4)  --随机滑动
                    mSleep(math.random(500,1500))
                end
            end
            return page_array["page_fujinderen"]:enter()
        end
         --有打招呼的人
        shanghua()
        mSleep(math.random(2000))
        --已经添加的
        x, y = findMultiColorInRegionFuzzy({ 0xEAEAEA, 42, 1, 0xFFFFFF, 65, 2, 0xDFDFDF, 65, 2, 0xDFDFDF, 70, 20, 0xB8B8B8, 46, 25, 0xFFFFFF, 17, 25, 0xFFFFFF, 1, 21, 0xB3B3B3, 0, 18, 0xFFFFFF, 13, 10, 0xFFFFFF, 29, 10, 0xB5B5B5, 65, 14, 0xFFFFFF, 68, 8, 0xFFFFFF, 25, 4, 0xFFFFFF, -1, 6, 0xFFFFFF, -4, 16, 0xFFFFFF, 51, 20, 0xB3B3B3, 52, 20, 0xE5E5E5, 58, 18, 0xFFFFFF, 67, 17, 0xFFFFFF }, 90, 522, 178, 596, 203);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            rotateScreen(0);
            mSleep(793);
            touchDown(3, 474, 196)
            mSleep(1);
            touchMove(3, 462, 190)
            mSleep(19);
            touchMove(3, 440, 190)
            mSleep(40);
            touchMove(3, 416, 188)
            mSleep(16);
            touchMove(3, 382, 186)
            mSleep(15);
            touchMove(3, 344, 184)
            mSleep(14);
            touchMove(3, 290, 184)
            mSleep(2);
            touchMove(3, 240, 184)
            mSleep(13);
            touchMove(3, 186, 184)
            mSleep(20);
            touchMove(3, 134, 184)
            mSleep(11);
            touchMove(3, 84, 180)
            mSleep(15);
            touchMove(3, 40, 176)
            mSleep(20);
            touchUp(3)
            mSleep(1500);
            touchDown(7, 594, 198)  --点击删除
            mSleep(60);
            touchUp(7)
            mSleep(1500);
            return page_array["page_fujindazhaohuderen"]:enter()
        end
        cicky( 185,186,50);  --点击第一个打招呼的人
        mSleep(1500);
        return page_array["page_dazhaohuderen_ziliao"]:enter()
    else
        cicky(  67,87,50);  --返回附近的人
        mSleep(1500);
        page_array["page_fujinderen"]:enter()
    end
end

--step1
function fujindazhaohuderen_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function fujindazhaohuderen_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_fujindazhaohuderen() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function fujindazhaohuderen_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_fujindazhaohuderen();     
end

--step3  --最主要的工作都在这个里面
function fujindazhaohuderen_page:action()
    return action_fujindazhaohuderen();
end

page_array["page_fujindazhaohuderen"] =  fujindazhaohuderen_page:new()    


------------------end:  page\wx_fujinderen_3.1-3.4\page_fujindazhaohuderen.lua-------------------------------------




----------------------begin:  page\wx_fujinderen_3.1-3.4\page_dazhaohuderen_ziliao.lua---------------------------------

default_dazhaohuderen_ziliao_page = {
    page_name = "dazhaohuderen_ziliao_page",
    page_image_path = nil
}

dazhaohuderen_ziliao_page = class_base_page:new(default_dazhaohuderen_ziliao_page);

--打招呼的人资料.bmp     
local function check_page_dazhaohuderen_ziliao( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -12, 22, 0x121213, -1, 34, 0x131313, 12, 0, 0xC4C4C4, 24, 19, 0xF9F9F9, 29, -1, 0x111112, 51, 14, 0x121212, 64, 18, 0xD1D1D2, 60, 3, 0x111112, 60, 11, 0x121212, 94, 23, 0x121213, 106, 6, 0x121112, 99, 2, 0xF8F8F8, 71, 3, 0x111112, 117, 16, 0x121213, 132, 17, 0x121213, 126, -7, 0x111111, 151, 16, 0x121213, 158, 18, 0x121213, 232, 3, 0x111112, 225, 19, 0x121213, 234, 11, 0x121212, 274, 23, 0x121213, 282, 22, 0x121213, 281, 5, 0x111112, 315, 28, 0xC4C4C4, 328, 14, 0x121212, 316, -3, 0x111112, 343, 26, 0x131213, 360, 18, 0xFFFFFF, 346, 2, 0x717172, 418, 20, 0x121213, 529, 13, 0xE8E8E8, 560, 12, 0x121212, 555, -12, 0x111011, 548, 27, 0x131213, 512, 5, 0x111112 }, 90, 28, 58, 600, 104);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----打招呼的人详细资料界面----");
        return true
    else
        return false
    end
end

local function action_dazhaohuderen_ziliao()     --操作
    if gongneng == 3.12   then
        xiahua();   --下滑
        x,y=findColor(0x1AAD19);
        if x>0 and y>0 then
            cicky(x,y,50);    --添加到通讯录
            mSleep(4000);
        else
            warning_info("添加到通讯录错误");
            return false
        end
        for i=1,10 do
            ---朋友请求过期
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -15, -1, 0x007AFF, -16, 5, 0x007AFF, -16, 12, 0x007AFF, -19, 18, 0x007AFF, 0, 17, 0x007AFF, 39, 25, 0x007AFF, 34, 12, 0x007AFF, 24, 12, 0x007AFF }, 90, 156, 548, 214, 574);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                warning_info("附近的人朋友请求过期")
                cicky(x,y,50)    --点击取消
                mSleep(1500)
                cicky(80,80,50);  --返回
                mSleep(2000)
                ---删除
                rotateScreen(0);
                mSleep(793);
                touchDown(3, 474, 196)
                mSleep(1);
                touchMove(3, 462, 190)
                mSleep(19);
                touchMove(3, 440, 190)
                mSleep(40);
                touchMove(3, 416, 188)
                mSleep(16);
                touchMove(3, 382, 186)
                mSleep(15);
                touchMove(3, 344, 184)
                mSleep(14);
                touchMove(3, 290, 184)
                mSleep(2);
                touchMove(3, 240, 184)
                mSleep(13);
                touchMove(3, 186, 184)
                mSleep(20);
                touchMove(3, 134, 184)
                mSleep(11);
                touchMove(3, 84, 180)
                mSleep(15);
                touchMove(3, 40, 176)
                mSleep(20);
                touchUp(3)
                mSleep(1500);
                touchDown(7, 594, 198)  --点击删除
                mSleep(60);
                touchUp(7)
                mSleep(1500);
                return page_array["page_fujindazhaohuderen"]:enter()
            end
            ---不需要验证
            if  page_array["page_dazhaohuderen_ziliao"]:quick_check_page() == true then
                cicky(  67,87,50);  --返回附近打招呼的人
                mSleep(2000);
                rotateScreen(0);
                mSleep(793);
                touchDown(3, 474, 196)
                mSleep(1);
                touchMove(3, 462, 190)
                mSleep(19);
                touchMove(3, 440, 190)
                mSleep(40);
                touchMove(3, 416, 188)
                mSleep(16);
                touchMove(3, 382, 186)
                mSleep(15);
                touchMove(3, 344, 184)
                mSleep(14);
                touchMove(3, 290, 184)
                mSleep(2);
                touchMove(3, 240, 184)
                mSleep(13);
                touchMove(3, 186, 184)
                mSleep(20);
                touchMove(3, 134, 184)
                mSleep(11);
                touchMove(3, 84, 180)
                mSleep(15);
                touchMove(3, 40, 176)
                mSleep(20);
                touchUp(3)
                mSleep(1500);
                touchDown(7, 594, 198)  --点击删除
                mSleep(60);
                touchUp(7)
                mSleep(1500);
                log_info("添加打招呼的人一次")
                return page_array["page_fujindazhaohuderen"]:enter()
            end
            --打招呼的人验证.bmp
            x, y = findMultiColorInRegionFuzzy({ 0x111112, 38, 10, 0x121212, 217, 4, 0xFFFFFF, 264, 4, 0x121112, 310, 6, 0xFFFFFF, 340, 9, 0x121212, 537, 9, 0x121212, 573, 15, 0x121213, 537, 18, 0x1FD71E, 534, 7, 0x1DAD1C }, 90, 35, 74, 608, 92);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                mSleep(1500);
                cicky( 599,82,50);   --点击发送
                mSleep(4000);
                for i=1,10 do
                    if page_array["page_dazhaohuderen_ziliao"]:quick_check_page() == true then
                        cicky(  67,87,50);  --返回附近打招呼的人
                        mSleep(2000);
                        rotateScreen(0);
                        mSleep(793);
                        touchDown(3, 474, 196)
                        mSleep(1);
                        touchMove(3, 462, 190)
                        mSleep(19);
                        touchMove(3, 440, 190)
                        mSleep(40);
                        touchMove(3, 416, 188)
                        mSleep(16);
                        touchMove(3, 382, 186)
                        mSleep(15);
                        touchMove(3, 344, 184)
                        mSleep(14);
                        touchMove(3, 290, 184)
                        mSleep(2);
                        touchMove(3, 240, 184)
                        mSleep(13);
                        touchMove(3, 186, 184)
                        mSleep(20);
                        touchMove(3, 134, 184)
                        mSleep(11);
                        touchMove(3, 84, 180)
                        mSleep(15);
                        touchMove(3, 40, 176)
                        mSleep(20);
                        touchUp(3)
                        mSleep(1500);
                        touchDown(7, 594, 198)  --点击删除
                        mSleep(60);
                        touchUp(7)
                        mSleep(1500);
                        log_info("添加打招呼的人一次");
                        return page_array["page_fujindazhaohuderen"]:enter()
                    end
                    if i == 10 then
                        warning_info("附近的人发送添加验证时，网络卡");
                        mSleep(1000);
                        return false
                    end
                    mSleep(1000)
                end
            end
            if i == 10 then
                warning_info("接受附近的人添加请求时，网络卡");
                mSleep(1000);
                return false
            end
            mSleep(1000)
        end
    else
        cicky(  67,87,50);  --返回附近打招呼的人
        mSleep(1500);
        page_array["page_fujindazhaohuderen"]:enter()
    end
end

--step1
function dazhaohuderen_ziliao_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function dazhaohuderen_ziliao_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_dazhaohuderen_ziliao() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function dazhaohuderen_ziliao_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_dazhaohuderen_ziliao();     
end

--step3  --最主要的工作都在这个里面
function dazhaohuderen_ziliao_page:action()
    return action_dazhaohuderen_ziliao();
end

page_array["page_dazhaohuderen_ziliao"] =  dazhaohuderen_ziliao_page:new()    


------------------end:  page\wx_fujinderen_3.1-3.4\page_dazhaohuderen_ziliao.lua-------------------------------------




----------------------begin:  page\wx_piaoliuping_3.2\page_jianpingzi.lua---------------------------------

default_jianpingzi_page = {
    page_name = "jianpingzi_page",
    page_image_path = nil
}

jianpingzi_page = class_base_page:new(default_jianpingzi_page);

 --漂流瓶   3.3  /漂流瓶.bmp
local function check_page_jianpingzi( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x90A797, 7, 0, 0x8BA596, -5, -20, 0xBEAF84, 365, -3, 0x7C7A77, 405, -1, 0xA8A8AA, 387, -13, 0xBBBBBD, 371, -17, 0xD2D4D7, 204, -8, 0xECFDF2, 231, -8, 0xB7F2EA, 163, -20, 0xD3C150, 226, -18, 0xD6C453 }, 90, 116, 886, 526, 906);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----漂流瓶界面----");
        return true
    else
        return false
    end
end

local function action_jianpingzi()     --操作
    if gongneng == 3.2  then   --漂流瓶
        cicky( 321,887,50);   --点击捡瓶子
        mSleep(5000);
        for i=1,3 do
            --捡瓶子没次数了     /捡完瓶子.bmp
            ddzc(0xF9F7FA, 19, 3, 0xA3DAA4, 76, 3, 0x57C158, 118, 16, 0x20AF1F, 90, 258, 591, 376, 607);
            if x>0 and y>0 then
                cicky(x,y,50);
                mSleep(2000);  --点击不谢谢
                warning_info("瓶子捡完了");
                gongneng = 3.22 ;    --扔瓶子
                page_array["page_jianpingzi"]:enter();
                break
            else
                --海上刮大风    刮大风.bmp
                ddzc(0x1AAD19, 64, 26, 0x1AAD19, 51, 10, 0xFFFFFF, 29, 13, 0xFFFFFF, 90, 287, 426, 351, 452);
                if x>0 and y>0 then
                    cicky(x,y,50);   --点击确定
                    mSleep(2000);
                end  
                cicky(339,624,50);   --点击屏幕
                mSleep(2000);
                ---捡到瓶子
                ddzc( 0x9B9B9B, 24, -3, 0x818181, 45, -14, 0x969696, 47, 15, 0x3E3E3E, 90, 425, 847, 472, 876);
                if x>0 and y>0 then
                    cicky(x,y,50);    --点击回应
                    mSleep(2000);
                    page_array["page_huiying"]:enter();  
                    break
                else  ---海星
                    warning_info("捡到海星");
                    return false
                end
            end
            mSleep(1000);
        end
    elseif gongneng == 3.22 then
        cicky( 124,887,50);   --点击扔一个
        mSleep(1500);
        ---瓶子扔完了
        x, y = findMultiColorInRegionFuzzy({ 0x1AAD19, 26, 8, 0x1AAD19, 12, -12, 0x3AB939, 38, -16, 0xFFFFFF, 45, -6, 0x1AAD19, 53, -14, 0x1AAD19, 51, 1, 0x1AAD19, 33, 2, 0xFFFFFF, -54, -3, 0x1AAD19, 92, 4, 0x1AAD19, 13, 16, 0x1AAD19, 35, -10, 0x94D994 }, 90, 241, 405, 387, 437);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);
            mSleep(1500);
            warning_info("瓶子扔完了");
            return false
        end
        page_array["page_rengpingzi"]:enter();
    else
        x, y = findMultiColorInRegionFuzzy({ 0x0C0E11, -6, 22, 0x0C0F12, 21, 10, 0x0C0F11, 24, 5, 0x0C0F11, 17, -20, 0x0C0E10, 1, -20, 0x0C0E10, 33, -1, 0x0C0E10, 52, -15, 0x0C0E10, 39, -2, 0xE2E3E3, 45, 5, 0x0C0F11, 55, 8, 0xD6D7D7, 60, 10, 0xFFFFFF, 86, -20, 0x0C0E10, 80, -1, 0x0C0E10, 90, 12, 0xFFFFFF, 98, 7, 0xFFFFFF, 91, 0, 0xFFFFFF, 80, -1, 0x0C0E10 }, 90, 261, 63, 365, 105);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
           cicky(  65,87,50);   --点击返回发现
           mSleep(1500);  
           page_array["page_faxian"]:enter();
        else
            cicky(339,624,50);   --点击屏幕
            mSleep(2000);
            cicky(71,79,50);   --返回发现
            mSleep(1500);
            page_array["page_faxian"]:enter();
        end
    end
    return true
end

--step1
function jianpingzi_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function jianpingzi_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_jianpingzi() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function jianpingzi_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_jianpingzi();     
end

--step3  --最主要的工作都在这个里面
function jianpingzi_page:action()
    return action_jianpingzi();
end

page_array["page_jianpingzi"] =  jianpingzi_page:new() 


------------------end:  page\wx_piaoliuping_3.2\page_jianpingzi.lua-------------------------------------




----------------------begin:  page\wx_piaoliuping_3.2\page_huiying.lua---------------------------------

default_huiying_page = {
    page_name = "huiying_page",
    page_image_path = nil
}

huiying_page = class_base_page:new(default_huiying_page);

 --回应瓶子  3.3  /回应瓶子.bmp
local function check_page_huiying( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x111111, 11, 19, 0x121212, 11, 19, 0x121212, -16, 5, 0xFFFFFF, -5, 24, 0x121213, -27, 4, 0xFFFFFF, -34, 26, 0xFFFFFF, -15, 26, 0xFFFFFF, -41, 12, 0x121212, -50, 20, 0x121212, -578, -1, 0x111111, -599, 10, 0x121112, -573, 24, 0x121213, -573, 27, 0x898989, -553, 12, 0x747474, -540, -2, 0x111111, -540, 16, 0xEAEAEA, -551, 6, 0xD5D5D5, -516, -1, 0x313131, -493, -4, 0x111111, -511, 7, 0xB7B7B7, -511, 22, 0x121213, -529, 12, 0x121212, -523, -2, 0x111111 }, 90, 14, 66, 624, 97);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----回应瓶子界面----");
        return true
    else
        return false
    end
end

local function action_huiying()     --操作
    if gongneng == 3.2 then   --漂流瓶
        cicky( 292,913,50);   --点击输入框
        mSleep(2000);
        if text_huiying ~= nil then
            inputText(text_huiying[math.random(#text_huiying)]);     --内容
            mSleep(2000);
            cicky( 417,928,50);   --点击空格
            mSleep(2000);
            cicky( 603,901,50);   --点击发送
            mSleep(2000);
        end
        log_info("捡到瓶子回应一次 打招呼去")
        cicky( 588,88,50);    --点击人头
        mSleep(2000);
        page_array["page_pingzidazhaohu"]:enter()
    else
        cicky(72,87,50);   --返回漂流瓶
        mSleep(2000);
        page_array["page_jianpingzi"]:enter();
    end
end

--step1
function huiying_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function huiying_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_huiying() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function huiying_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_huiying();     
end

--step3  --最主要的工作都在这个里面
function huiying_page:action()
    return action_huiying();
end

page_array["page_huiying"] =  huiying_page:new() 


------------------end:  page\wx_piaoliuping_3.2\page_huiying.lua-------------------------------------




----------------------begin:  page\wx_piaoliuping_3.2\page_pingzidazhaohu.lua---------------------------------

default_pingzidazhaohu_page = {
    page_name = "pingzidazhaohu_page",
    page_image_path = nil
}

pingzidazhaohu_page = class_base_page:new(default_pingzidazhaohu_page);

 --详细资料  3.3  /详细资料.bmp
local function check_page_pingzidazhaohu( ... )   
    x, y = findMultiColorInRegionFuzzy({ 0x121212, -18, -1, 0x121212, -10, -20, 0x111111, -16, 20, 0x131313, -221, -18, 0x111111, -224, 9, 0x3D3D3E, -237, -8, 0xFFFFFF, -279, -12, 0x111112, -275, 7, 0x121213, -264, 2, 0xFFFFFF, -321, -10, 0x111112, -297, 10, 0x121213, -297, -7, 0x111112, -356, -14, 0xA5A5A6, -350, 3, 0x121213, -331, 2, 0xFFFFFF, -335, -7, 0xFFFFFF, -570, -14, 0x888889, -579, -1, 0xFFFFFF, -570, 14, 0xFFFFFF, -549, -14, 0x111112, -546, 8, 0xFFFFFF, -534, -6, 0xABABAB, -517, -11, 0xFFFFFF, -512, -6, 0x858585, -502, 6, 0x121213 }, 90, 28, 62, 607, 102);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
         log_info("----瓶子的人的详细资料界面----");
        return true
    else
        return false
    end
end

local function action_pingzidazhaohu()     --操作
    if gongneng == 3.2 then   --漂流瓶
       x, y = findColorInRegion(0x1AAD19, 7,289 ,620,862); 
        if x>0 and y>0 then
            cicky(x,y,50);  --点击打招呼
            mSleep(2000);
            page_array["page_zhaohu"]:enter();    ---wx_fujinderen_3.1-3.4
        end
    else
        cicky(  68,84,50);  --返回回应瓶子
        mSleep(2000);
        page_array["page_huiying"]:enter();
    end
    return true
end

--step1
function pingzidazhaohu_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function pingzidazhaohu_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_pingzidazhaohu() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function pingzidazhaohu_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_pingzidazhaohu();     
end

--step3  --最主要的工作都在这个里面
function pingzidazhaohu_page:action()
    return action_pingzidazhaohu();
end

page_array["page_pingzidazhaohu"] =  pingzidazhaohu_page:new() 


------------------end:  page\wx_piaoliuping_3.2\page_pingzidazhaohu.lua-------------------------------------




----------------------begin:  page\wx_piaoliuping_3.2\page_rengpingzi.lua---------------------------------

default_rengpingzi_page = {
    page_name = "rengpingzi_page",
    page_image_path = nil
}

rengpingzi_page = class_base_page:new(default_rengpingzi_page);

 --扔瓶子   3.3  /扔瓶子.bmp
local function check_page_rengpingzi( ... )   
   x, y = findMultiColorInRegionFuzzy({ 0xFAFAFA, 16, 16, 0x7F8389, 24, 3, 0xFAFAFA, 11, -1, 0xFAFAFA, 276, 9, 0xEBEBEB, 286, 15, 0x6A6A6A, 274, -13, 0xFBFBFB, 307, -5, 0x565656, 314, 12, 0xDCDCDC, 321, 1, 0x949494, 346, 10, 0xFBFBFB, 353, 8, 0xEBEBEB, 355, -5, 0xFBFBFB, 386, 14, 0x565656, 409, 10, 0xFBFBFB, 393, -11, 0xFBFBFB, 385, -3, 0xE9E9E9, 592, 9, 0xC3C5C8 }, 90, 27, 893, 619, 922);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
         log_info("----扔瓶子界面----");
        return true
    else
        return false
    end
end

local function action_rengpingzi()     --操作
    if gongneng == 3.22 or gongneng == 3.2 then   --漂流瓶
        cicky(  42,909,50);   --点击文字
        mSleep(2000);
        if text_renpingzi == nil then
            warning_info("请设置扔瓶子内容")
            return false
        end
        inputText(text_renpingzi[math.random(#text_renpingzi)]);   --内容
        mSleep(2000);
        cicky( 377,467,50);    --点击扔出去
        mSleep(5000);
        log_info("扔瓶子一次")
        ---没输入5个字.bmp
        x, y = findMultiColorInRegionFuzzy({ 0x60C65F, -16, 12, 0x1AAD19, 1, 22, 0x1AAD19, 2, 22, 0x1AAD19, 23, -11, 0x1AAD19, 38, 18, 0x1AAD19, 42, 18, 0x1AAD19, 42, 5, 0x1AAD19, 32, -2, 0x1AAD19 }, 90, 287, 398, 345, 431);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);
            mSleep(2500);
            inputText(text_renpingzi[math.random(#text_renpingzi)]);   --内容
            mSleep(2000);
            cicky( 377,467,50);    --点击扔出去
            mSleep(4000);
            log_info("扔瓶子一次")
        end
        if  page_array["page_jianpingzi"]:check_page() == true then
             ---瓶子扔完了
            cicky( 124,887,50);   --点击扔一个
            mSleep(1500);
            ddzc(0x1AAD19, 34, 0, 0x1AAD19, 76, 5, 0x1AAD19, 132, 5, 0x1AAD19, 90, 265, 413, 397, 418);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);
                mSleep(1500);
                warning_info("瓶子扔完了");
                return false 
            end
            --page_array["page_rengpingzi"]:enter()
        end
        return true
    else
        cicky(339,624,50);   --点击屏幕
        mSleep(1500);
        page_array["page_jianpingzi"]:enter();
    end
end

--step1
function rengpingzi_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
        return false
    end
end

--step2
function rengpingzi_page:check_page()  --检查是否是在当前页面--
    local try_time = 1
    while 3 > try_time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_rengpingzi() then 
            return true;
        else
            try_time = try_time + 1;
        end
    end
    return false;
end

function rengpingzi_page:quick_check_page()  --快速检查是否是在当前页面--
   return  check_page_rengpingzi();     
end

--step3  --最主要的工作都在这个里面
function rengpingzi_page:action()
    return action_rengpingzi();
end

page_array["page_rengpingzi"] =  rengpingzi_page:new() 


------------------end:  page\wx_piaoliuping_3.2\page_rengpingzi.lua-------------------------------------




----------------------begin:  page\wx_pengyouquan_2.4-3.3\page_ifile.lua---------------------------------

default_ifile_page = {
    page_name = "ifile_page",
    page_image_path = nil
}

ifile_page = class_base_page:new(default_ifile_page);

---ifile本地文件操作  主界面.bmp
local function check_page_ifile( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -17, 12, 0xF7F7F7, -9, 21, 0x007AFF, 0, 25, 0x007AFF, 28, 17, 0xF7F7F7, 55, 17, 0xF7F7F7, 52, 7, 0xF7F7F7, 26, 4, 0xF7F7F7, 238, 15, 0x000000, 305, 16, 0xF7F7F7, 347, 11, 0xF7F7F7, 230, 13, 0xF7F7F7, 287, 13, 0x000000, 339, 11, 0xF7F7F7, 553, 17, 0x007AFF, 586, 11, 0x1483FE, 565, 2, 0x007AFF, 553, 9, 0x98C6FA, 68, 845, 0xFFFFFF, 159, 837, 0x077EFF, 285, 849, 0xFFFFFF, 412, 849, 0x007AFF, 540, 846, 0xFFFFFF }, 90, 16, 69, 619, 918);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----ifile本地文件操作  主界面----");
        return true
    else
        return false
    end
end

local function action_ifile()     --执行这个页面的操作--
    if gongneng == 3.31 then
        --取消
        x, y = findMultiColorInRegionFuzzy({ 0x4DA2FF, 11, 13, 0xDAEBFF, 11, -5, 0xAAD2FF, 45, 14, 0x81BDFF, 53, -8, 0xFFFFFF, 43, 3, 0x007AFF, 47, 11, 0xFFFFFF }, 90, 562, 23, 615, 45);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);  --点击取消
            mSleep(2000);
        end
        cicky(  71,84,50);  --点击主界面
        mSleep(1500);
        shanghua();     --上滑
        shanghua();
        cicky( 254,165,50);   --点击搜索
        mSleep(4000);
        inputText("touchelf");
        mSleep(1500);
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -13, 27, 0xFFFFFF, 8, 35, 0xCCCCCC, 11, 33, 0xCCCCCC, 28, 30, 0xFFFFFF, 40, 34, 0xFFFFFF, 47, 8, 0xCCCCCC, 50, 36, 0xFFFFFF, 77, 5, 0xCCCCCC, 73, 25, 0xCFCFCF, 87, 30, 0xFFFFFF, 87, 9, 0xFFFFFF, 95, 28, 0xFFFFFF }, 90, 264, 246, 372, 282);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
           ifile_cuowu("进入touchelf文件夹错误");
        end
        cicky( 140,274,50);   --点击touchelf文件夹
        mSleep(2500);
        shanghua();
        cicky( 254,165,50);   --点击搜索
        mSleep(4000);
        inputText("photo");
        mSleep(1500);
         x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -13, 27, 0xFFFFFF, 8, 35, 0xCCCCCC, 11, 33, 0xCCCCCC, 28, 30, 0xFFFFFF, 40, 34, 0xFFFFFF, 47, 8, 0xCCCCCC, 50, 36, 0xFFFFFF, 77, 5, 0xCCCCCC, 73, 25, 0xCFCFCF, 87, 30, 0xFFFFFF, 87, 9, 0xFFFFFF, 95, 28, 0xFFFFFF }, 90, 264, 246, 372, 282);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
           ifile_cuowu("进入photo文件夹错误");
        end
        cicky( 140,274,50);   --点击photo文件夹
        mSleep(1500);
        page_array["page_ifile_photo"]:enter()
        return true
    else
        keyDown("HOME");
        mSleep(100);
        keyUp("HOME");
        mSleep(1500);
        page_array["page_main"]:enter()
    end
end

--step1
function ifile_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function ifile_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_ifile() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function ifile_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_ifile() ;
end

--step3  --最主要的工作都在这个里面
function ifile_page:action()     --执行这个页面的操作--
    return  action_ifile();
end

page_array["page_ifile"] = ifile_page:new()

------------------end:  page\wx_pengyouquan_2.4-3.3\page_ifile.lua-------------------------------------




----------------------begin:  page\wx_pengyouquan_2.4-3.3\page_ifile_photo.lua---------------------------------

default_ifile_photo_page = {
    page_name = "ifile_photo_page",
    page_image_path = nil
}

ifile_photo_page = class_base_page:new(default_ifile_photo_page);

---ifile_photo photo文件操作 保存照片到相册 
local function check_page_ifile_photo( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xF7F7F7, -13, 15, 0x4DA1FC, -11, 25, 0x007AFF, -9, 25, 0x007AFF, 31, 14, 0xF7F7F7, 43, 27, 0xE6EEF8, 95, 23, 0xF7F7F7, 119, 23, 0x007AFF, 78, 15, 0x007AFF, 96, 15, 0x007AFF, 138, 19, 0x007AFF, 192, 14, 0xF7F7F7, 242, 24, 0x111111, 302, 26, 0xF7F7F7, 330, 22, 0xF7F7F7, 311, 15, 0xF7F7F7, 318, 17, 0x0F0F0F, 324, 21, 0xF7F7F7, 532, 7, 0xC1DBF9, 578, 17, 0xF7F7F7, 578, 17, 0xF7F7F7, 539, 30, 0x007AFF, 556, 14, 0xF7F7F7, 581, 14, 0xF7F7F7, 574, 24, 0x007AFF, 568, 24, 0xF7F7F7 }, 90, 21, 64, 615, 94);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----ifile_photo界面----");
        return true
    else
        return false
    end
end

local function action_ifile_photo()     --执行这个页面的操作--
    if gongneng == 3.31 then
        shanghua()
        mSleep(500);
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 4, 28, 0xFFFFFF, 31, 29, 0xFFFFFF, 25, 3, 0xFFFFFF, 17, 8, 0x007AFF, 16, 26, 0x007AFF, 73, 12, 0xFFFFFF, 73, 20, 0xC7C7CC, 66, 22, 0xFFFFFF }, 90, 532, 292, 605, 321);
        if x>0 and y>0 then  -- 如果找到了
            mSleep(500)
            gongneng = 3.32   --保存照片去
            mSleep(500)
            page_array["page_ifile_photo"]:enter()
        else
            warning_info("没有图片,发不了朋友圈");
            return false
        end
    elseif gongneng == 3.32 then
        cicky( 550,309,50);   ---点击感叹号
        mSleep(1500);
        xiahua();           --下滑
        xiahua();
        cicky( 303,840,50);   --点击添加到相册
        mSleep(2000);
        ---访问你图片
        ddzc(0x007AFF, 0, 5, 0x007AFF, 17, 9, 0x007AFF, 17, 18, 0x007AFF, 90, 445, 528, 462, 546);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);   --点击好
            mSleep(2000);
        end
        mSleep(2000);
        cicky( 331,537,50);   --点击关闭
        mSleep(2000);
        cicky( 598,82,50);    --点击完成
        mSleep(2000);
        ---滑动删除
        rotateScreen(0);
        mSleep(1186);
        touchDown(2, 396, 312)
        mSleep(1);
        touchMove(2, 382, 314)
        mSleep(18);
        touchMove(2, 356, 314)
        mSleep(102);
        touchMove(2, 328, 314)
        mSleep(2);
        touchMove(2, 292, 312)
        mSleep(12);
        touchMove(2, 254, 312)
        mSleep(2);
        touchMove(2, 216, 312)
        mSleep(2);
        touchMove(2, 184, 312)
        mSleep(13);
        touchMove(2, 160, 312)
        mSleep(2);
        touchMove(2, 138, 314)
        mSleep(11);
        touchMove(2, 118, 314)
        mSleep(2);
        touchMove(2, 102, 314)
        mSleep(17);
        touchMove(2, 94, 310)
        mSleep(18);
        touchUp(2)

        mSleep(851);
        touchDown(9, 582, 302) --点击删除
        mSleep(103);
        touchUp(9)
        mSleep(2000);
         x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 4, 28, 0xFFFFFF, 31, 29, 0xFFFFFF, 25, 3, 0xFFFFFF, 17, 8, 0x007AFF, 16, 26, 0x007AFF, 73, 12, 0xFFFFFF, 73, 20, 0xC7C7CC, 66, 22, 0xFFFFFF }, 90, 532, 292, 605, 321);
        if x>0 and y>0 then  -- 如果找到了
            mSleep(500)
            gongneng = 3.32   --保存照片去
            mSleep(500)
            page_array["page_ifile_photo"]:enter()
        else
            warning_info("保存图片完毕 发朋友圈去");
            gongneng = 3.3   --发朋友圈去
            page_array["page_ifile_photo"]:enter()
            return false
        end
    else
        keyDown("HOME");
        mSleep(100);
        keyUp("HOME");
        mSleep(1500);
        page_array["page_main"]:enter()
    end
end

--step1
function ifile_photo_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function ifile_photo_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_ifile_photo() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function ifile_photo_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_ifile_photo() ;
end

--step3  --最主要的工作都在这个里面
function ifile_photo_page:action()     --执行这个页面的操作--
    return  action_ifile_photo();
end

page_array["page_ifile_photo"] = ifile_photo_page:new()

------------------end:  page\wx_pengyouquan_2.4-3.3\page_ifile_photo.lua-------------------------------------




----------------------begin:  page\wx_pengyouquan_2.4-3.3\page_pengyouquan.lua---------------------------------

default_pengyouquan_page = {
    page_name = "pengyouquan_page",
    page_image_path = nil
}

pengyouquan_page = class_base_page:new(default_pengyouquan_page);

---朋友圈  3.3
local function check_page_pengyouquan( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x0C0C0D, 5, -10, 0x0C0C0C, 21, -9, 0x0C0C0C, 33, 18, 0xFFFFFF, 44, 8, 0x0C0C0D, 6, 11, 0x9F9F9F, 6, 22, 0x979697, -23, 18, 0x0C0C0D, -5, 13, 0xFFFFFF, -232, -6, 0x0C0C0C, -215, 14, 0xCCCCCD, -215, 21, 0xFFFFFF, -226, 18, 0x2A2A2A, -261, -3, 0x0C0C0D, -248, 22, 0x4B4B4C, -248, 16, 0xE5E5E5, -302, -6, 0x0C0C0C, -279, 7, 0xCACACA, -291, 13, 0xFFFFFF, -306, 24, 0xF9F9F9, -267, 27, 0x131314, -294, 17, 0x0C0C0D, -295, 17, 0x19191A, -550, -1, 0x0C0C0C, -558, 8, 0x0C0C0D, -533, 26, 0x0D0C0D, -517, 2, 0x24221D, -504, 13, 0x131213, -482, 4, 0x0E0F12, -477, 20, 0xFFFFFF, -477, 20, 0xFFFFFF }, 90, 17, 62, 619, 99);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----发朋友圈界面----");
        return true
    else

        return false
    end
end

local function action_pengyouquan()     --执行这个页面的操作--
    if gongneng == 3.3 or gongneng == 2.41 then
        cicky( 592,87,50);   --点击摄像机
        mSleep(3000);
        --知道了.bmp
        ddzc(0x09BB07, 6, 10, 0x09BB07, 56, 23, 0x09BB07, 84, 22, 0x09BB07 , 90, 272, 660, 356, 683);
        if x>0 and y>0 then
            cicky(x,y,50);  --点击知道了
            mSleep(2000);
        end
        cicky( 320,814,50);   --点击从相册选择
        mSleep(5000);
        for i=1,10 do
            if page_array["page_zhaopian"]:quick_check_page() == true then
                page_array["page_zhaopian"]:enter()
                break
            elseif page_array["page_xiangji"]:quick_check_page() == true then
                page_array["page_xiangji"]:enter()
                break
            end
            if i == 10 then 
                pengyou_cuowu("选择相片界面错误,重新进入微信");
            end
            mSleep(1000)
        end
    elseif gongneng == 3.5 then   --提取电话号码
        rotateScreen(0);
        mSleep(1393);
        touchDown(4, 358, 810)
        mSleep(68);
        touchMove(4, 360, 802)
        mSleep(16);
        touchMove(4, 360, 794)
        mSleep(36);
        touchMove(4, 360, 784)
        mSleep(2);
        touchMove(4, 360, 772)
        mSleep(13);
        touchMove(4, 362, 758)
        mSleep(16);
        touchMove(4, 364, 746)
        mSleep(16);
        touchMove(4, 366, 730)
        mSleep(16);
        touchMove(4, 368, 716)
        mSleep(16);
        touchMove(4, 370, 702)
        mSleep(16);
        touchMove(4, 372, 690)
        mSleep(16);
        touchMove(4, 374, 678)
        mSleep(17);
        touchMove(4, 376, 666)
        mSleep(15);
        touchMove(4, 378, 656)
        mSleep(16);
        touchMove(4, 380, 646)
        mSleep(12);
        touchMove(4, 382, 638)
        mSleep(16);
        touchMove(4, 384, 630)
        mSleep(16);
        touchMove(4, 386, 620)
        mSleep(16);
        touchMove(4, 390, 610)
        mSleep(15);
        touchMove(4, 392, 600)
        mSleep(17);
        touchMove(4, 394, 590)
        mSleep(16);
        touchMove(4, 398, 578)
        mSleep(15);
        touchMove(4, 404, 568)
        mSleep(16);
        touchMove(4, 410, 556)
        mSleep(16);
        touchMove(4, 416, 544)
        mSleep(18);
        touchMove(4, 422, 532)
        mSleep(17);
        touchMove(4, 428, 520)
        mSleep(17);
        touchMove(4, 434, 510)
        mSleep(15);
        touchMove(4, 438, 502)
        mSleep(17);
        touchMove(4, 444, 492)
        mSleep(17);
        touchMove(4, 450, 484)
        mSleep(17);
        touchMove(4, 454, 478)
        mSleep(15);
        touchMove(4, 456, 472)
        mSleep(17);
        touchMove(4, 460, 468)
        mSleep(15);
        touchMove(4, 462, 466)
        mSleep(16);
        touchMove(4, 464, 464)
        mSleep(17);
        touchMove(4, 464, 464)
        mSleep(9);
        touchMove(4, 466, 464)
        mSleep(49);
        touchUp(4)

        mSleep(318);
        touchDown(7, 326, 776)
        mSleep(149);
        touchMove(7, 336, 752)
        mSleep(15);
        touchMove(7, 336, 746)
        mSleep(1);
        touchMove(7, 340, 740)
        mSleep(1);
        touchMove(7, 342, 730)
        mSleep(29);
        touchMove(7, 346, 720)
        mSleep(2);
        touchMove(7, 350, 712)
        mSleep(2);
        touchMove(7, 354, 704)
        mSleep(13);
        touchMove(7, 358, 696)
        mSleep(2);
        touchMove(7, 362, 688)
        mSleep(3);
        touchMove(7, 366, 680)
        mSleep(12);
        touchMove(7, 368, 674)
        mSleep(31);
        touchMove(7, 372, 666)
        mSleep(3);
        touchMove(7, 374, 660)
        mSleep(15);
        touchMove(7, 376, 654)
        mSleep(16);
        touchMove(7, 378, 648)
        mSleep(17);
        touchMove(7, 382, 640)
        mSleep(16);
        touchMove(7, 384, 634)
        mSleep(18);
        touchMove(7, 386, 628)
        mSleep(15);
        touchMove(7, 388, 622)
        mSleep(17);
        touchMove(7, 390, 616)
        mSleep(15);
        touchMove(7, 392, 608)
        mSleep(16);
        touchMove(7, 396, 600)
        mSleep(16);
        touchMove(7, 400, 594)
        mSleep(16);
        touchMove(7, 402, 586)
        mSleep(16);
        touchMove(7, 406, 580)
        mSleep(16);
        touchMove(7, 408, 576)
        mSleep(11);
        touchMove(7, 410, 570)
        mSleep(16);
        touchMove(7, 414, 566)
        mSleep(25);
        touchMove(7, 416, 562)
        mSleep(15);
        touchMove(7, 418, 560)
        mSleep(10);
        touchMove(7, 420, 556)
        mSleep(15);
        touchMove(7, 422, 554)
        mSleep(18);
        touchMove(7, 422, 552)
        mSleep(33);
        touchMove(7, 424, 550)
        mSleep(14);
        touchMove(7, 424, 548)
        mSleep(1);
        touchMove(7, 426, 546)
        mSleep(14);
        touchMove(7, 426, 544)
        mSleep(36);
        touchMove(7, 428, 542)
        mSleep(1);
        touchMove(7, 428, 540)
        mSleep(13);
        touchMove(7, 430, 538)
        mSleep(21);
        touchMove(7, 432, 538)
        mSleep(13);
        touchMove(7, 432, 536)
        mSleep(20);
        touchMove(7, 434, 534)
        mSleep(12);
        touchMove(7, 434, 532)
        mSleep(20);
        touchMove(7, 436, 532)
        mSleep(12);
        touchMove(7, 436, 530)
        mSleep(20);
        touchMove(7, 438, 528)
        mSleep(13);
        touchMove(7, 438, 526)
        mSleep(15);
        touchMove(7, 440, 524)
        mSleep(12);
        touchMove(7, 440, 522)
        mSleep(24);
        touchMove(7, 442, 520)
        mSleep(7);
        touchMove(7, 442, 518)
        mSleep(16);
        touchMove(7, 444, 516)
        mSleep(16);
        touchMove(7, 446, 512)
        mSleep(16);
        touchMove(7, 446, 510)
        mSleep(16);
        touchMove(7, 448, 508)
        mSleep(18);
        touchMove(7, 448, 506)
        mSleep(14);
        touchMove(7, 448, 506)
        mSleep(20);
        touchMove(7, 450, 504)
        mSleep(12);
        touchMove(7, 450, 504)
        mSleep(20);
        touchMove(7, 450, 502)
        mSleep(14);
        touchMove(7, 450, 500)
        mSleep(21);
        touchMove(7, 452, 498)
        mSleep(12);
        touchMove(7, 452, 496)
        mSleep(20);
        touchMove(7, 452, 494)
        mSleep(13);
        touchMove(7, 454, 494)
        mSleep(21);
        touchMove(7, 454, 492)
        mSleep(13);
        touchMove(7, 454, 490)
        mSleep(16);
        touchMove(7, 456, 488)
        mSleep(19);
        touchMove(7, 456, 486)
        mSleep(12);
        touchMove(7, 456, 486)
        mSleep(35);
        touchMove(7, 458, 484)
        mSleep(1);
        touchMove(7, 458, 482)
        mSleep(13);
        touchMove(7, 458, 482)
        mSleep(14);
        touchMove(7, 458, 482)
        mSleep(16);
        touchMove(7, 458, 480)
        mSleep(21);
        touchMove(7, 458, 480)
        mSleep(8);
        touchMove(7, 458, 478)
        mSleep(15);
        touchMove(7, 458, 476)
        mSleep(16);
        touchMove(7, 460, 476)
        mSleep(16);
        touchMove(7, 460, 474)
        mSleep(19);
        touchMove(7, 460, 474)
        mSleep(13);
        touchMove(7, 462, 472)
        mSleep(19);
        touchMove(7, 462, 472)
        mSleep(13);
        touchMove(7, 462, 470)
        mSleep(21);
        touchMove(7, 464, 470)
        mSleep(13);
        touchMove(7, 464, 468)
        mSleep(21);
        touchMove(7, 464, 468)
        mSleep(12);
        touchMove(7, 464, 466)
        mSleep(19);
        touchMove(7, 466, 466)
        mSleep(13);
        touchMove(7, 466, 466)
        mSleep(21);
        touchMove(7, 466, 464)
        mSleep(13);
        touchMove(7, 468, 464)
        mSleep(21);
        touchMove(7, 468, 462)
        mSleep(12);
        touchMove(7, 468, 462)
        mSleep(19);
        touchMove(7, 468, 460)
        mSleep(24);
        touchMove(7, 470, 460)
        mSleep(24);
        touchMove(7, 470, 458)
        mSleep(28);
        touchMove(7, 470, 458)
        mSleep(11);
        touchMove(7, 470, 456)
        mSleep(97);
        touchMove(7, 472, 456)
        mSleep(150);
        touchUp(7)
        mSleep(1000);
        gongneng = 3.51
        page_array["page_pengyouquan"]:enter()
    elseif gongneng == 3.51 then
        while true do
            --返回
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -14, -1, 0xFFFFFF, -14, -15, 0xFFFFFF, 0, -15, 0xFFFFFF, 7, -10, 0xFFFFFF, -26, -9, 0xFFFFFF, -37, -9, 0xFFFFFF, -46, -6, 0xFFFFFF, -76, -3, 0xFFFFFF, -68, 8, 0xFFFFFF, -61, 13, 0xFFFFFF, -43, 6, 0xFFFFFF, -26, -16, 0xFFFFFF }, 90, 25, 70, 108, 99);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(80,80,50);
                mSleep(1500)
                xiahua()
            end
            --取消
            x, y = findMultiColorInRegionFuzzy({ 0x000000, -52, 14, 0x000000, -48, 14, 0x000000, -62, -12, 0x000000, -44, -10, 0x000000, -9, -8, 0x000000, -9, -13, 0x000000 }, 90, 289, 896, 351, 923);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);  --点击取消
                mSleep(2000);
                xiahua()
            end
             --朋友圈
            x, y = findMultiColorInRegionFuzzy({ 0x0B0B0C, 45, 6, 0x404040, 46, 7, 0xFFFFFF, 95, 10, 0xFFFFFF, 105, 11, 0xFFFFFF, 34, 18, 0xBFBFBF, 75, 16, 0x0C0C0C, 109, 15, 0xB4B4B4, 96, 19, 0x7E7E7E, 70, 26, 0xFFFFFF, 97, 21, 0x0C0C0C, 111, 18, 0x3F3F3F, 111, 18, 0x3F3F3F }, 90, 23, 67, 134, 93);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(80,80,50);  --返回
                mSleep(2000);
                xiahua()
            end
            for i=0,22 do
                x,y=findColorInRegion(0x007AFF,1,80+40*i,639,120+40*i)
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    cicky(x,y,50);  --点击电话号码
                    mSleep(2000)
                    --朋友圈
                    x, y = findMultiColorInRegionFuzzy({ 0x0B0B0C, 45, 6, 0x404040, 46, 7, 0xFFFFFF, 95, 10, 0xFFFFFF, 105, 11, 0xFFFFFF, 34, 18, 0xBFBFBF, 75, 16, 0x0C0C0C, 109, 15, 0xB4B4B4, 96, 19, 0x7E7E7E, 70, 26, 0xFFFFFF, 97, 21, 0x0C0C0C, 111, 18, 0x3F3F3F, 111, 18, 0x3F3F3F }, 90, 23, 67, 134, 93);
                    if x ~= -1 and y ~= -1 then  -- 如果找到了
                        cicky(80,80,50);  --返回
                        mSleep(2000);
                        return false
                    end
                    ---复制
                    x, y = findMultiColorInRegionFuzzy({ 0x0A0A0A, 10, 10, 0x000000, 59, 12, 0x000000, 41, 4, 0x000000, 35, 1, 0x000000, 34, 24, 0x000000, 10, 25, 0x000000, -2, 22, 0x000000, 41, -2, 0x000000 }, 90, 290, 690, 351, 717);
                    if x ~= -1 and y ~= -1 then  -- 如果找到了
                        cicky(x,y,50);   --点击复制
                        mSleep(1000);
                        a =  clipText()  --剪切板内容
                        if file_exists("/var/touchelf/res/photo.txt") == false then
                            os.execute("touch ".."/var/touchelf/res/photo.txt");
                        end
                      --  notifyMessage(#a)
                      --  mSleep(1000)
                        b = getline("/var/touchelf/res/photo.txt")
                        if b ~= nil then
                            c = string.sub(b,1,-2);
                        end
                     --   notifyMessage(#c)
                      --  mSleep(1000)
                        if #a == 11 and a ~= c then
                            writeStrToFile(a,"/var/touchelf/res/photo.txt");
                            mSleep(2000);
                        end
                    else
                        x, y = findMultiColorInRegionFuzzy({ 0x000000, -52, 14, 0x000000, -48, 14, 0x000000, -62, -12, 0x000000, -44, -10, 0x000000, -9, -8, 0x000000, -9, -13, 0x000000 }, 90, 289, 896, 351, 923);
                        if x ~= -1 and y ~= -1 then  -- 如果找到了
                            cicky(x,y,50);  --点击取消
                            mSleep(2000);
                        end
                    end
                end
            end
            rotateScreen(0);
            mSleep(575);
            touchDown(6, 478, 710)
            mSleep(13);
            touchMove(6, 478, 692)
            mSleep(1);
            touchMove(6, 480, 674)
            mSleep(2);
            touchMove(6, 488, 648)
            mSleep(1);
            touchMove(6, 498, 620)
            mSleep(1);
            touchMove(6, 510, 578)
            mSleep(30);
            touchMove(6, 530, 500)
            mSleep(10);
            touchMove(6, 544, 458)
            mSleep(16);
            touchMove(6, 554, 424)
            mSleep(11);
            touchMove(6, 562, 396)
            mSleep(178);
            touchMove(6, 572, 376)
            mSleep(1);
            touchMove(6, 576, 362)
            mSleep(3);
            touchMove(6, 580, 348)
            mSleep(2);
            touchMove(6, 584, 338)
            mSleep(1);
            touchMove(6, 584, 330)
            mSleep(1);
            touchMove(6, 586, 326)
            mSleep(1);
            touchMove(6, 586, 322)
            mSleep(2);
            touchMove(6, 586, 320)
            mSleep(76);
            touchMove(6, 586, 316)
            mSleep(16);
            touchMove(6, 586, 312)
            mSleep(2);
            touchMove(6, 586, 306)
            mSleep(48);
            touchMove(6, 586, 300)
            mSleep(26);
            touchMove(6, 586, 292)
            mSleep(1);
            touchMove(6, 586, 286)
            mSleep(2);
            touchMove(6, 586, 280)
            mSleep(1);
            touchMove(6, 588, 276)
            mSleep(1);
            touchMove(6, 588, 272)
            mSleep(34);
            touchMove(6, 594, 270)
            mSleep(2);
            touchUp(6)

            mSleep(180);
            touchDown(5, 400, 788)
            mSleep(18);
            touchMove(5, 404, 772)
            mSleep(25);
            touchMove(5, 410, 752)
            mSleep(7);
            touchMove(5, 420, 724)
            mSleep(32);
            touchMove(5, 432, 696)
            mSleep(1);
            touchMove(5, 442, 664)
            mSleep(22);
            touchMove(5, 452, 636)
            mSleep(14);
            touchMove(5, 462, 598)
            mSleep(58);
            touchMove(5, 468, 570)
            mSleep(4);
            touchMove(5, 476, 548)
            mSleep(16);
            touchMove(5, 480, 530)
            mSleep(39);
            touchMove(5, 484, 520)
            mSleep(14);
            touchMove(5, 486, 508)
            mSleep(16);
            touchMove(5, 490, 500)
            mSleep(13);
            touchMove(5, 492, 492)
            mSleep(1);
            touchMove(5, 494, 484)
            mSleep(1);
            touchMove(5, 496, 474)
            mSleep(1);
            touchMove(5, 500, 466)
            mSleep(31);
            touchMove(5, 504, 448)
            mSleep(8);
            touchMove(5, 506, 440)
            mSleep(16);
            touchMove(5, 508, 430)
            mSleep(16);
            touchMove(5, 510, 422)
            mSleep(16);
            touchMove(5, 512, 414)
            mSleep(16);
            touchMove(5, 514, 406)
            mSleep(20);
            touchMove(5, 516, 402)
            mSleep(14);
            touchMove(5, 516, 396)
            mSleep(19);
            touchMove(5, 518, 394)
            mSleep(13);
            touchMove(5, 518, 390)
            mSleep(20);
            touchMove(5, 520, 388)
            mSleep(12);
            touchMove(5, 520, 386)
            mSleep(21);
            touchMove(5, 520, 384)
            mSleep(13);
            touchMove(5, 520, 380)
            mSleep(20);
            touchMove(5, 520, 378)
            mSleep(14);
            touchMove(5, 520, 374)
            mSleep(20);
            touchMove(5, 520, 372)
            mSleep(12);
            touchMove(5, 520, 370)
            mSleep(20);
            touchMove(5, 520, 368)
            mSleep(16);
            touchMove(5, 520, 366)
            mSleep(13);
            touchMove(5, 520, 364)
            mSleep(26);
            touchMove(5, 520, 362)
            mSleep(52);
            touchMove(5, 520, 362)
            mSleep(53);
            touchMove(5, 520, 360)
            mSleep(25);
            touchMove(5, 520, 360)
            mSleep(14);
            touchMove(5, 520, 358)
            mSleep(35);
            touchMove(5, 520, 358)
            mSleep(67);
            touchUp(5)
            mSleep(math.random(2200,4444))
      --  page_array["page_pengyouquan"]:enter()
       end
    elseif gongneng == 3.6 then    --发文字说说
        cicky( 592,87,2500);   --长按摄像机
        mSleep(2000);
        ---知道了
        x, y = findMultiColorInRegionFuzzy({ 0x2B9433, 79, 15, 0x5FA463, 134, 17, 0x1E8B27, 116, 35, 0x14841C, 33, 28, 0xFFFFFF, 24, 16, 0x78A57B, 49, 11, 0xD4E1D4, 113, 14, 0x218D2A, 68, 6, 0x317F39, -39, 0, 0x2B9433, 0, 31, 0x16851F, 102, 37, 0x13841C, 127, 24, 0x1A8823, 134, 18, 0x1E8B27, 79, 5, 0x289130 }, 90, 214, 840, 387, 877);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);   --点击知道了
            mSleep(2000)
        end
        if page_array["page_fawenziss"]:check_page() == true then
            page_array["page_fawenziss"]:enter()
        else
            cicky( 602,808,5000);   --删除
            mSleep(2000)
            page_array["page_fawenziss"]:enter()
        end
    elseif gongneng == 3.7 then    --浏览朋友圈
        mSleep(math.random(2000,4000))
        m = math.random(15,30);
        for i=1,m do
            n = math.random(200,400)
            o = math.random(140,500)
            p = math.random(550,950)
            mSleep(math.random(2000,5000))
            move(n,p, n,o,5) --随机滑动
            mSleep(500)
        end
        cicky(  80,83,50);   --返回发现
        mSleep(2000);
        warning_info("浏览朋友圈一次")
        return true
    else
        cicky(  65,83,50);   --返回发现
        mSleep(1500);
        page_array["page_faxian"]:enter();
    end
end

--step1
function pengyouquan_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function pengyouquan_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_pengyouquan() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function pengyouquan_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_pengyouquan() ;
end

--step3  --最主要的工作都在这个里面
function pengyouquan_page:action()     --执行这个页面的操作--
    return  action_pengyouquan();
end

page_array["page_pengyouquan"] = pengyouquan_page:new()

------------------end:  page\wx_pengyouquan_2.4-3.3\page_pengyouquan.lua-------------------------------------




----------------------begin:  page\wx_pengyouquan_2.4-3.3\page_zhaopian.lua---------------------------------

default_zhaopian_page = {
    page_name = "zhaopian_page",
    page_image_path = nil
}

zhaopian_page = class_base_page:new(default_zhaopian_page);

---照片  3.3  /照片.bmp
local function check_page_zhaopian( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 46, 9, 0x39393A, 53, 22, 0xFFFFFF, 265, 9, 0x121213, -158, 105, 0x000000, -110, 106, 0xFFFFFF, -77, 107, 0x000000, -41, 125, 0xCECECE }, 90, 135, 71, 558, 196);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----发说说选择照片界面----");
        return true
    else
        return false
    end
end

local function action_zhaopian()     --执行这个页面的操作--
    if gongneng == 3.3 or gongneng == 2.41 then
        x, y = findMultiColorInRegionFuzzy({ 0xF4F6F9, 65, 8, 0xF2F5F8, 54, 39, 0xCAD1DB, 13, 60, 0xC2C8D4, -4, 82, 0xE2E8EE, 88, 94, 0xE0E7ED, 120, 36, 0x000000, 156, 37, 0x000000, 225, 47, 0x000000 }, 90, 16, 140, 245, 234);
        if x>0 and y>0 then
            warning_info("没有照片发布不了朋友圈");
            return false
        end
        cicky( 245,210,50);  --点击相机胶卷
        mSleep(1500);
        page_array["page_xiangji"]:enter();
    else
        cicky(  597,88,50);   --点击取消
        mSleep(1500);
        page_array["page_pengyouquan"]:enter();
    end
    return true 
end

--step1
function zhaopian_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function zhaopian_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_zhaopian() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function zhaopian_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_zhaopian() ;
end

--step3  --最主要的工作都在这个里面
function zhaopian_page:action()     --执行这个页面的操作--
    return  action_zhaopian();
end

page_array["page_zhaopian"] = zhaopian_page:new()

------------------end:  page\wx_pengyouquan_2.4-3.3\page_zhaopian.lua-------------------------------------




----------------------begin:  page\wx_pengyouquan_2.4-3.3\page_xiangji.lua---------------------------------

default_xiangji_page = {
    page_name = "xiangji_page",
    page_image_path = nil
}

xiangji_page = class_base_page:new(default_xiangji_page);

---相机  3.3  /相机.bmp
local function check_page_xiangji( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x201F21, -42, 2, 0x9A9A9B, -75, 2, 0xE9E9E9, -74, 24, 0x232323, 157, 5, 0xC0C0C0, 203, 12, 0xE9E9E9, 240, 3, 0x383839, 263, 14, 0x212122, 474, -3, 0x1F1F20, 508, 13, 0x737373, 493, 10, 0x212122 }, 90, 31, 73, 614, 100);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----发说说选择相薄界面----");
        return true
    else
        return false
    end
end

local function action_xiangji()     --执行这个页面的操作--
    if gongneng == 3.3 or gongneng == 2.41 then
        --默认点击9张
        cicky( 137,161  );   --点击第一张
        mSleep(1000);  
        x, y = findMultiColorInRegionFuzzy({ 0xBEE5C2, 15, 6, 0xFAFAFA, 17, -14, 0xFAFAFA, 13, 1, 0xC0E6C4, 38, 5, 0xD7EEDA, 60, 2, 0xFAFAFA, 52, -16, 0xFAFAFA, 41, -3, 0xFAFAFA, 41, -1, 0xFAFAFA }, 90, 558, 900, 618, 922);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            warning_info("没有照片发不了朋友圈");
            return false
        end
        cicky( 284,158   );    ----2
        mSleep(500);
        cicky( 443,163   );     ----3
        mSleep(500);
        cicky( 607,160 );       ----4
        mSleep(500);
        cicky( 133,320 );          ---5
        mSleep(500);
        cicky( 283,328   );       --6
        mSleep(500);
        cicky( 439,325  );       --7
        mSleep(500);
        cicky( 600,322  );      --8
        mSleep(500);
        cicky( 125,484  );       --9
        mSleep(1000);
        cicky(590,912,50);       --点击完成
        mSleep(5000);
        for i=1,10 do
            if page_array["page_shuoshuo"]:quick_check_page() == true then
                page_array["page_shuoshuo"]:enter();
                break
            end
            mSleep(1000)
        end
        return true
    else
        cicky(  597,88,50);   --点击取消
        mSleep(1500);
        page_array["page_pengyouquan"]:enter();
    end
    return true 
end

--step1
function xiangji_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function xiangji_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xiangji() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function xiangji_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_xiangji() ;
end

--step3  --最主要的工作都在这个里面
function xiangji_page:action()     --执行这个页面的操作--
    return  action_xiangji();
end

page_array["page_xiangji"] = xiangji_page:new()

------------------end:  page\wx_pengyouquan_2.4-3.3\page_xiangji.lua-------------------------------------




----------------------begin:  page\wx_pengyouquan_2.4-3.3\page_shuoshuo.lua---------------------------------

default_shuoshuo_page = {
    page_name = "shuoshuo_page",
    page_image_path = nil
}

shuoshuo_page = class_base_page:new(default_shuoshuo_page);

---说说  3.3  /说说.bmp
local function check_page_shuoshuo( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x121112, 3, 17, 0x186618, 5, 4, 0x1B9C1A, 13, 19, 0x1FD21E, 42, 3, 0x121212, 45, 31, 0x131314, 26, 1, 0x121212, 53, 6, 0x121212, -539, 0, 0x121112, -534, 14, 0x858586, -522, 5, 0x121212, -506, 8, 0x121212, -489, 20, 0xFFFFFF, -484, 2, 0x4F4F4F, -504, 2, 0x121212, -528, 23, 0x252525, -492, 21, 0x606060, -493, 19, 0x2D2D2D, -507, 4, 0x303030, -498, 6, 0xFFFFFF, -323, 9, 0x121212, -282, 12, 0x121213, -248, 13, 0x121213, -139, 12, 0x121213, -88, 12, 0x121213, -68, 12, 0x121213, -44, 13, 0x121213, -375, 16, 0x121213, -91, 21, 0x131313 }, 90, 26, 68, 618, 99);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----发说说界面----");
        return true
    else
        return false
    end
end

local function action_shuoshuo()     --执行这个页面的操作--
    if gongneng == 3.3 then  --发朋友圈  
        cicky(  96,169,50);   --点击输入框
        mSleep(1500);
        if text_pengyouquan == nil and text_pengyouquan[1] == nil then 
            warning_info("请设置发朋友圈内容")
            return false
        end
        inputText(text_pengyouquan[math.random(#text_pengyouquan)]);   
        mSleep(math.random(2888,4888))
        cicky( 598,91,50);   --点击发送
        mSleep(5000);
        gongneng = 5.1  --删除照片
        log_info("发朋友圈完成 删除照片去")
        page_array["page_pengyouquan"]:enter();
    elseif gongneng == 2.41 then  --转发朋友圈
        cicky(  96,169,50);   --点击输入框
        mSleep(1000);
        text = clipText()
        mSleep(1000);
        inputText(text);
        mSleep(math.random(2888,4888))
        cicky( 598,91,50);   --点击发送
        mSleep(5000);
        ---文章正在加载.bmp
        x, y = findMultiColorInRegionFuzzy({ 0x0B0B0C, -15, 15, 0x0C0C0C, 6, 29, 0x868686, 3, 14, 0x0C0C0C, 23, 10, 0x5B5B5B, 46, 22, 0x0C0C0C, 39, 5, 0x0C0B0C, 46, 5, 0x0C0B0C, 61, 26, 0x0C0C0C, 68, 12, 0xB1B1B1, 69, 5, 0x0C0B0C, 56, 1, 0x747475, 539, 12, 0xFFFFFF, 559, 12, 0x464646, 571, 12, 0xFFFFFF, 552, 6, 0x0C0C0C, 552, 24, 0x0C0C0C, 542, 15, 0xFFFFFF, 571, 15, 0xFFFFFF, 584, 9, 0x0C0C0C, 592, 20, 0x0C0C0C }, 90, 20, 69, 627, 98);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(61,81);  --点击返回
            mSleep(1500);
            log_info("转发朋友圈文章一次或者是转发公众号文章一次")
            return true
         -- page_array["page_noshuoshuo"]:enter()  --不是图片说说
        end
        gongneng = 5.1 --删除照片 
        log_info("转发朋友圈图片说说一次 删除照片去")
        if page_array["page_pengyouquan"]:check_page() == true then
            page_array["page_pengyouquan"]:enter();   --朋友圈
        end
    else
        cicky( 80,88,50);   --点击取消
        mSleep(1500);
         ---文章正在加载.bmp
         zs2(427,634 ,0x007AFF,471,624 ,0x007AFF);  ---退出
         mSleep(2000);
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 15, 1, 0xFFFFFF, 33, -2, 0x222125, -549, -4, 0x212024, -552, 13, 0x27272A, -525, 24, 0x2C2C2F, -455, -12, 0x1F1E23, -455, -12, 0x1F1E23, -504, 4, 0xFBFBFB, -477, -1, 0x222125, -485, 8, 0x252428, -471, 8, 0x242428 }, 90, 23, 68, 608, 104);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(61,81);  --点击返回
            mSleep(1500);
            page_array["page_noshuoshuo"]:enter()  --不是图片说说
        end
        if page_array["page_pengyouquan"]:quick_check_page() == true then
            page_array["page_pengyouquan"]:enter() 
        end
        return true
    end
end

--step1
function shuoshuo_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function shuoshuo_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_shuoshuo() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function shuoshuo_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_shuoshuo() ;
end

--step3  --最主要的工作都在这个里面
function shuoshuo_page:action()     --执行这个页面的操作--
    return  action_shuoshuo();
end

page_array["page_shuoshuo"] = shuoshuo_page:new()

------------------end:  page\wx_pengyouquan_2.4-3.3\page_shuoshuo.lua-------------------------------------




----------------------begin:  page\wx_pengyouquan_2.4-3.3\page_fawenziss.lua---------------------------------

default_fawenziss_page = {
    page_name = "fawenziss_page",
    page_image_path = nil
}

fawenziss_page = class_base_page:new(default_fawenziss_page);

---发表文字说说
local function check_page_fawenziss( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x121112, 48, 5, 0x121212, 51, 6, 0x333333, 34, 32, 0x131314, 9, 33, 0x131314, -1, 24, 0x131313, 39, 6, 0xBEBEBE, 29, 20, 0x131313, 21, 12, 0x121213, 241, 2, 0x2E2E2E, 314, 2, 0x121212, 353, 0, 0x121112, 355, 4, 0xFFFFFF, 347, 23, 0xFFFFFF, 329, 37, 0x141414, 273, 35, 0x131314, 226, 25, 0x1A1A1A, 263, 9, 0xFFFFFF, 299, 12, 0x121213, 327, 16, 0x121213, 349, 17, 0xF9F8F9, 351, 14, 0xFFFFFF, 297, 9, 0x121212, 263, 10, 0xFFFFFF, 569, 4, 0x121212, 586, 5, 0x142014, 585, 12, 0x152C15, 556, 23, 0x131313, 525, 15, 0x121213, 554, 3, 0x121212, 567, 10, 0x142513, 574, 19, 0x131313 }, 90, 26, 68, 613, 105);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----发表文字说说界面----");
        return true
    else

        return false
    end
end

local function action_fawenziss()     --执行这个页面的操作--
    if gongneng == 3.6 then 
        if text_wenziss ~= nil then
            inputText(text_wenziss[math.random(#text_wenziss)])
            mSleep(2000)
            cicky( 599,89 ,50);   --发送
            mSleep(2000)
        else
            warning_info("请设置发送说说内容")
            return false
        end
        -- page_array["page_pengyouquan"]:enter()
    else
        cicky(  65,83,50);   --返回发现
        mSleep(1500);
        page_array["page_faxian"]:enter();
    end
    return true
end

--step1
function fawenziss_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function fawenziss_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_fawenziss() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function fawenziss_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_fawenziss() ;
end

--step3  --最主要的工作都在这个里面
function fawenziss_page:action()     --执行这个页面的操作--
    return  action_fawenziss();
end

page_array["page_fawenziss"] = fawenziss_page:new()

------------------end:  page\wx_pengyouquan_2.4-3.3\page_fawenziss.lua-------------------------------------




----------------------begin:  page\wx_xiugai_4.1\page_gerenxinxi.lua---------------------------------

default_gerenxinxi_page = {
    page_name = "gerenxinxi_page",
    page_image_path = nil
}

gerenxinxi_page = class_base_page:new(default_gerenxinxi_page);

 --个人信息 4.1
local function check_page_gerenxinxi( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x111112, -5, 6, 0x888889, 0, 27, 0xFFFFFF, -5, 19, 0xFFFFFF, 24, 3, 0xEDEDED, 24, 13, 0xCCCCCC, 24, 27, 0x131213, 40, 24, 0xBABABB, 33, 8, 0xFCFCFC, 32, -1, 0x4C4C4D, 230, 7, 0x121112, 228, 8, 0x121112, 215, 8, 0x121112, 228, 21, 0xFFFFFF, 228, 25, 0xFFFFFF, 263, 2, 0x969697, 252, 20, 0x121213, 273, 20, 0x121213, 291, 9, 0xFFFFFF, 294, 25, 0x121213, 306, -4, 0x111112, 309, 4, 0xFFFFFF, 309, 9, 0xFFFFFF, 300, 20, 0xFFFFFF, 313, 26, 0xE8E8E8, 313, 22, 0x828283, 330, -1, 0x111112, 328, 14, 0xFFFFFF, 356, 17, 0x121213, 342, 11, 0x4C4C4C, 336, 7, 0xFFFFFF, 332, 24, 0xFFFFFF, 347, 23, 0x121213, 359, 22, 0x121213 }, 90, 30, 65, 394, 96);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----个人信息界面----")
        return true
    else
        return false
    end
end

local function action_gerenxinxi()     --执行这个页面的操作--
    if gongneng == 4.1 then
        cicky( 126,368 ,50);   --点击名字
        mSleep(1500);
        page_array["page_mingzi"]:enter();
    elseif gongneng == 4.12 then
        cicky( 123,908,50);   --点击个性签名
        mSleep(1500);
        page_array["page_qianming"]:enter()
    else
        cicky(  64,90,50);   --点击返回我
        mSleep(1500);
        page_array["page_wo"]:enter();
    end
    return true;
end

--step1
function gerenxinxi_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function gerenxinxi_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_gerenxinxi() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function gerenxinxi_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_gerenxinxi() ;
end

--step3  --最主要的工作都在这个里面
function gerenxinxi_page:action()     --执行这个页面的操作--
    return  action_gerenxinxi();
end

page_array["page_gerenxinxi"] = gerenxinxi_page:new()

------------------end:  page\wx_xiugai_4.1\page_gerenxinxi.lua-------------------------------------




----------------------begin:  page\wx_xiugai_4.1\page_mingzi.lua---------------------------------

default_mingzi_page = {
    page_name = "mingzi_page",
    page_image_path = nil
}

mingzi_page = class_base_page:new(default_mingzi_page);

 --修改名字 4.1
local function check_page_mingzi( ... )
   x, y = findMultiColorInRegionFuzzy({ 0x153715, -1, 3, 0x164D16, -2, 19, 0x121213, 17, 16, 0x164516, 37, -1, 0x111112, 46, 13, 0x174E16, 28, 15, 0x174A17, -265, -6, 0x111112, -253, 1, 0xFFFFFF, -272, 12, 0x121212, -256, 27, 0x131313, -264, 14, 0xFFFFFF, -237, 5, 0xF5F5F5, -224, -4, 0xD3D3D3, -209, 5, 0x121112, -227, 6, 0x121112, -223, 25, 0xF2F2F2, -238, 14, 0x121213, -213, 17, 0xFFFFFF, -540, -3, 0x111112, -531, 1, 0x767676, -511, 17, 0x121213, -520, 5, 0x121112, -536, 19, 0xD8D8D8, -505, 3, 0x111112, -480, 12, 0x121212, -487, 18, 0x5F5F60, -494, 1, 0x111112, -494, 0, 0x111112 }, 90, 23, 65, 609, 98);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----修改名字界面----")
        return true
    else
        return false
    end
end

local function action_mingzi()     --执行这个页面的操作--
    if gongneng == 4.1 then
        cicky( 594,202,50);    --点击叉叉
        mSleep(1500);
        inputText(text_mingzi[math.random(#text_mingzi)]);
        mSleep(1500)
        cicky( 430,915,50);  --点击空格
        mSleep(1500);
        cicky( 585,89,50);     --点击保存
        mSleep(3000);
        log_info("修改名字一次")
        gongneng = 4.12 ;    --修改签名
        if page_array["page_gerenxinxi"]:quick_check_page() == true then
            page_array["page_gerenxinxi"]:enter()
        elseif page_array["page_mingzi"]:quick_check_page() == true then
            cicky(  64,90,50);   --点击取消
            mSleep(1500);
            page_array["page_gerenxinxi"]:enter()
        end
    else
        cicky(  64,90,50);   --点击取消
        mSleep(1500);
        page_array["page_gerenxinxi"]:enter();
    end
    return true;
end

--step1
function mingzi_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function mingzi_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_mingzi() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function mingzi_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_mingzi() ;
end

--step3  --最主要的工作都在这个里面
function mingzi_page:action()     --执行这个页面的操作--
    return  action_mingzi();
end

page_array["page_mingzi"] = mingzi_page:new()

------------------end:  page\wx_xiugai_4.1\page_mingzi.lua-------------------------------------




----------------------begin:  page\wx_xiugai_4.1\page_qianming.lua---------------------------------

default_qianming_page = {
    page_name = "qianming_page",
    page_image_path = nil
}

qianming_page = class_base_page:new(default_qianming_page);

 --修改个性签名 4.1
local function check_page_qianming( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x121213, -8, -20, 0x111112, -46, -20, 0x20D81F, -36, 3, 0x121213, -236, -2, 0x121213, -223, -4, 0xFFFFFF, -269, -24, 0x111112, -280, -13, 0x121212, -280, 3, 0x121213, -321, -14, 0x121112, -320, 4, 0xB2B2B2, -485, -9, 0x121212, -428, -9, 0x121212, -439, -11, 0xFFFFFF, -516, -11, 0x121212, -540, -11, 0x121212, -578, -18, 0x888889, -578, 6, 0x131313 }, 90, 31, 68, 609, 98);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----修改个性签名界面----")
        return true
    else
        return false
    end
end

local function action_qianming()     --执行这个页面的操作--
    if gongneng == 4.1 or gongneng == 4.12 then
        if text_qianming == nil then
            warning_info("请设置修改签名内容")
            return false
        end
        --没签名
        x, y = findMultiColorInRegionFuzzy({ 0xB2B2B2, 4, -1, 0xB2B2B2, 4, -1, 0xB2B2B2, 7, 4, 0xFFFFFF, 6, 7, 0xD4D4D4, 15, 14, 0xE7E7E7, 15, 16, 0xFEFEFE, 2, 18, 0xFFFFFF, -4, 13, 0xFFFFFF, 18, 0, 0xB2B2B2, 17, 13, 0xB2B2B2, 21, 21, 0xB2B2B2, 28, 16, 0xB2B2B2, 28, 14, 0xB9B9B9, 30, 0, 0xFFFFFF, 24, -5, 0xFFFFFF, 24, -5, 0xFFFFFF }, 90, 570, 273, 604, 299);
        if x>0 and y>0 then
            mSleep(500);
            inputText(text_qianming[math.random(#text_qianming)]);
            mSleep(1500);
            cicky( 573,81,50);   --点击完成
            mSleep(3000);
            log_info("修改签名一次")
         --   page_array["page_gerenxinxi"]:enter();
        else  --有签名
            ddzc( 0xBCBFC3,53,40,0xB4B7BA, 67, 29, 0x000000, 85, 56, 0xBCBFC3, 90, 526, 601, 611, 657); 
            if x>0 then
                cicky(x,y,5000);  --点击叉叉1
            end
            mSleep(1000);
            ddzc( 0xB3B3B5, -14, 11, 0xFFFFFF, -6, 2,0xFFFFFF,4,13,0xFFFFFF,90,594, 799, 612, 812);
            if x>0 then
                cicky(x,y,5000);  --叉叉2
            end
            inputText(text_qianming[math.random(#text_qianming)]);
            mSleep(1500);
            cicky( 573,81,50);   --点击完成
            mSleep(3000);
            log_info("修改签名一次")
        --    gongneng = "touxiang";
        --  page_array["page_gerenxinxi"]:enter();
        end
    else
        cicky(  64,90,50);   --点击返回个人信息
        mSleep(1500);
        page_array["page_gerenxinxi"]:enter();
    end
    return true;
end

--step1
function qianming_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function qianming_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_qianming() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function qianming_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_qianming() ;
end

--step3  --最主要的工作都在这个里面
function qianming_page:action()     --执行这个页面的操作--
    return  action_qianming();
end

page_array["page_qianming"] = qianming_page:new()

------------------end:  page\wx_xiugai_4.1\page_qianming.lua-------------------------------------




----------------------begin:  page\wx_shezhi_4.2-4.3\page_shezhi.lua---------------------------------

default_shezhi_page = {
    page_name = "shezhi_page",
    page_image_path = nil
}

shezhi_page = class_base_page:new(default_shezhi_page);

 --设置 4.2-4.3
local function check_page_shezhi( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 306, 10, 0x121212, 278, 14, 0x121213, 35, 26, 0x919191, 18, 14, 0xFFFFFF, 37, 12, 0xFFFFFF, 36, -6, 0x111112, 12, -4, 0x111112, 15, 20, 0x121213, -275, -2, 0xFFFFFF, -275, 21, 0xFFFFFF, -286, 7, 0x121212, -240, -2, 0x111112, -236, 17, 0x121213, -252, 16, 0x121213, -253, -4, 0x111112, -238, 2, 0x111112 }, 90, 24, 67, 616, 99);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----设置界面----");
        return true
    else
        return false
    end
end

local function action_shezhi()     --执行这个页面的操作--
    if gongneng == 4.2 or gongneng == 4.3 or gongneng == 3.21 then
        cicky(  82,505,50);  --点击通用
        mSleep(1500);
        page_array["page_tongyong"]:enter();
    else
        cicky(  63,82,50);  --返回
        mSleep(1500);
        page_array["page_wo"]:enter();
    end
    return true;
end

--step1
function shezhi_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function shezhi_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_shezhi() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function shezhi_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_shezhi() ;
end

--step3  --最主要的工作都在这个里面
function shezhi_page:action()     --执行这个页面的操作--
    return  action_shezhi();
end

page_array["page_shezhi"] = shezhi_page:new()

------------------end:  page\wx_shezhi_4.2-4.3\page_shezhi.lua-------------------------------------




----------------------begin:  page\wx_shezhi_4.2-4.3\page_tongyong.lua---------------------------------

default_tongyong_page = {
    page_name = "tongyong_page",
    page_image_path = nil
}

tongyong_page = class_base_page:new(default_tongyong_page);

 --通用 4.2-4.3   
local function check_page_tongyong( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x1D1D1E, -6, 12, 0x121212, 0, 28, 0xFFFFFF, 21, 29, 0xF0F0F0, 2, 29, 0x161516, 13, -2, 0x111112, 17, 21, 0xFAFAFA, 17, 21, 0xFAFAFA, 41, 5, 0xFFFFFF, 55, 5, 0x111112, 58, 27, 0x121213, 44, 25, 0x121213, 67, 27, 0x121213, 326, 22, 0x121213, 301, 12, 0x121212, 317, 7, 0x111112, -218, 5, 0x111112, -221, 19, 0x262627, -229, 8, 0x121112, -202, 2, 0xE5E5E5, -173, 2, 0x111112, -188, 21, 0x585858, -195, 10, 0x757575, -252, 4, 0xFFFFFF, -259, 9, 0xFFFFFF, -256, 22, 0x898989 }, 90, 30, 66, 615, 97);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
         log_info("----通用界面----");
        return true
    else
        return false
    end
end

---清空缓存
local function action_tongyong()     --执行这个页面的操作--
    if gongneng == 4.2  then
        xiahua();   --下滑
        cicky( 338,870,50);   --点击清除聊天记录
        mSleep(2000);
        cicky( 325,799,50);   --确认清空
        mSleep(6000);
        log_info("清楚缓存一次")
        return true 
     --   page_array["page_tongyong"]:enter();
    elseif gongneng == 4.3 or gongneng == 3.21 then
        xiahua();
        cicky( 163,510,50);  --点击功能
        mSleep(1500);
        page_array["page_gongneng"]:enter();
    else
        cicky(  63,82,50);  --返回设置
        mSleep(1500);
        page_array["page_shezhi"]:enter();
    end
    return true;
end

--step1
function tongyong_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function tongyong_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_tongyong() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function tongyong_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_tongyong() ;
end

--step3  --最主要的工作都在这个里面
function tongyong_page:action()     --执行这个页面的操作--
    return  action_tongyong();
end

page_array["page_tongyong"] = tongyong_page:new()

------------------end:  page\wx_shezhi_4.2-4.3\page_tongyong.lua-------------------------------------




----------------------begin:  page\wx_shezhi_4.2-4.3\page_gongneng.lua---------------------------------

default_gongneng_page = {
    page_name = "gongneng_page",
    page_image_path = nil
}

gongneng_page = class_base_page:new(default_gongneng_page);

 --功能  4.3   
local function check_page_gongneng( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 2, 21, 0xFFFFFF, 36, 11, 0x121212, 38, 14, 0x181819, 64, 14, 0xABABAC, 69, 1, 0x111112, 67, 17, 0x121213, 261, 1, 0xCECECF, 265, 14, 0x121213, 282, 8, 0xFFFFFF, 269, 1, 0x696969, 309, 23, 0xA7A7A7, 306, 12, 0x686869, 309, -4, 0xFEFEFE, 294, 11, 0x121212, 296, 16, 0x121213, 289, 16, 0x121213, 548, 19, 0x121213, 537, 19, 0x121213 }, 90, 34, 69, 582, 96); 
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----功能界面----");
        return true
    else
        return false
    end
end

---清空缓存
local function action_gongneng()     --执行这个页面的操作--
   if gongneng == 4.3 then    ---开始群发
        ddzc(0x2BA245, 58, -22, 0xFFFFFF, 168, -7, 0xFFFFFF, 181, -30, 0xFFFFFF, 90, 66, 765, 247, 795);
        if x>0 and y>0 then
            cicky(x,y,50);   --点击群发助手
            mSleep(2000);
            cicky( 177,540,50);    --点击开始群发
            mSleep(1500);
            page_array["page_qunfazhushou"]:enter()
        else
            xiahua();  --下滑
            ddzc(0x2BA245, 96, 5, 0x4C4C4C, 143, 5, 0x878787, 219, 8, 0x040404, 90, 32, 136, 251, 144);
            if x>0 and y>0 then
                cicky(x,y,50);   --点击群发助手
                mSleep(2000);
                cicky( 177,540,50);    --点击开始群发
                mSleep(1500);
                page_array["page_qunfazhushou"]:enter()
            end
            ddzc( 0x2BA245, 42, -2, 0x2BA245, 109, -2, 0x121212,212, 2, 0x000000, 90, 39, 229, 251, 233)
            if x>0 and y>0 then
                cicky(x,y,50);   --点击群发助手
                mSleep(2000);
                cicky( 177,540,50);    --点击开始群发
                mSleep(1500);
                page_array["page_qunfazhushou"]:enter()
            end
            ddzc(0x2BA245, -5, -19, 0x2BA245,183,-16,0x212121,173,-30, 0x2C2C2C, 90, 60, 306, 248, 336);
            if x>0 and y>0 then
                cicky(x,y,50);   --点击群发助手
                mSleep(2000);
                cicky( 177,540,50);    --点击开始群发
                mSleep(1500);
                page_array["page_qunfazhushou"]:enter()
            end
        end
    elseif gongneng == 3.21 then   ---开启漂流瓶
            xiahua();  --下滑
            ddzc(0x93C0EB, 36, 15, 0x93C0EB, 96, 17, 0x040404, 175, 28, 0x030303 , 90, 41, 575, 216, 603);
            if x>0 and y>0 then
                cicky(x,y,50);
                mSleep(2000);
                cicky(324,580);   --点击启用漂流瓶
                mSleep(2000);
                cicky( 146,570,50);  --点击进入漂流瓶
                mSleep(1500);
                page_array["page_jianpingzi"]:enter();
            else
                ddzc(0x93C0EB, 25, 11, 0x93C0EB, 87, 14, 0x000000, 159, 19, 0x818181, 90, 53, 670, 212, 689);
                if x>0 and y>0 then
                    cicky(x,y,50);
                    mSleep(2000);
                    cicky(324,580);   --点击启用漂流瓶
                    mSleep(2000);
                    cicky( 146,570,50);  --点击进入漂流瓶
                    mSleep(1500);
                    page_array["page_jianpingzi"]:enter();
                end
            end       
    else
        cicky(  63,82,50);  --返回微信
        mSleep(1500);
        page_array["page_tongyong"]:enter();
    end
    return true;
end

--step1
function gongneng_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function gongneng_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_gongneng() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function gongneng_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_gongneng() ;
end

--step3  --最主要的工作都在这个里面
function gongneng_page:action()     --执行这个页面的操作--
    return  action_gongneng();
end

page_array["page_gongneng"] = gongneng_page:new()

------------------end:  page\wx_shezhi_4.2-4.3\page_gongneng.lua-------------------------------------




----------------------begin:  page\wx_shezhi_4.2-4.3\page_qunfazhushou.lua---------------------------------

default_qunfazhushou_page = {
    page_name = "qunfazhushou_page",
    page_image_path = nil
}

qunfazhushou_page = class_base_page:new(default_qunfazhushou_page);

 --群发助手  4.3   
local function check_page_qunfazhushou( ... )
    x, y = findMultiColorInRegionFuzzy({ 0x111112, -8, 22, 0x121213, 23, 11, 0x121212, 59, 15, 0x121213, 68, 17, 0xCCCCCC, 228, 4, 0xDDDDDE, 268, 19, 0xD0D0D0, 269, 12, 0xFFFFFF, 312, 20, 0x1A1A1B, 341, 17, 0x929293, 552, -3, 0x606061, 574, 16, 0xE7E7E7, 555, 13, 0x121212, 544, 18, 0xA4A4A4, 343, 10, 0xFFFFFF }, 90, 26, 67, 608, 92); 
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群发助手界面----");
        return true
    else
        return false
    end
end


local function action_qunfazhushou()     --执行这个页面的操作--
   if gongneng == 4.3 then
        cicky( 344,913,50);   --点击新建群发
        mSleep(1500);
        page_array["page_xuanzeren"]:enter()
    else
        cicky(  63,82,50);  --返回微信
        mSleep(1500);
        page_array["page_weixinzhu"]:enter();
    end
    return true;
end

--step1
function qunfazhushou_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function qunfazhushou_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_qunfazhushou() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function qunfazhushou_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_qunfazhushou() ;
end

--step3  --最主要的工作都在这个里面
function qunfazhushou_page:action()     --执行这个页面的操作--
    return  action_qunfazhushou();
end

page_array["page_qunfazhushou"] = qunfazhushou_page:new()

------------------end:  page\wx_shezhi_4.2-4.3\page_qunfazhushou.lua-------------------------------------




----------------------begin:  page\wx_shezhi_4.2-4.3\page_xuanzeren.lua---------------------------------

default_xuanzeren_page = {
    page_name = "xuanzeren_page",
    page_image_path = nil
}

xuanzeren_page = class_base_page:new(default_xuanzeren_page);

 --选择收信人 4.3   
local function check_page_xuanzeren( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -2, 14, 0xFFFFFF, 70, 6, 0xFFFFFF, 30, 1, 0x4E4E4E, 236, 12, 0x131313, 253, 12, 0x131313, 292, 11, 0xB9B9B9, 332, 4, 0x121213, 538, 8, 0x131213, 574, 11, 0x131313, 307, 92, 0xFFFFFF, 292, 92, 0xFFFFFF, 241, 92, 0xFFFFFF }, 90, 30, 77, 606, 169); 
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群发选择收信人界面----");
        return true
    else
        return false
    end
end

local function action_xuanzeren()     --执行这个页面的操作--
   if gongneng == 4.3 then
        cicky(579,81,50);     --点击全选
        mSleep(1500);
        cicky(330,909,50);   --点击下一步
        mSleep(1500);
        page_array["page_qunfa"]:enter()
    else
        cicky(  63,82,50);  --点击返回
        mSleep(1500);
        page_array["page_qunfazhushou"]:enter();
    end
    return true;
end

--step1
function xuanzeren_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function xuanzeren_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_xuanzeren() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function xuanzeren_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_xuanzeren() ;
end

--step3  --最主要的工作都在这个里面
function xuanzeren_page:action()     --执行这个页面的操作--
    return  action_xuanzeren();
end

page_array["page_xuanzeren"] = xuanzeren_page:new()

------------------end:  page\wx_shezhi_4.2-4.3\page_xuanzeren.lua-------------------------------------




----------------------begin:  page\wx_shezhi_4.2-4.3\page_qunfa.lua---------------------------------

default_qunfa_page = {
    page_name = "qunfa_page",
    page_image_path = nil
}

qunfa_page = class_base_page:new(default_qunfa_page);

 --群发 4.3   
local function check_page_qunfa( ... )
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 2, 10, 0xFFFFFF, -8, 4, 0x121212, 39, -1, 0xC4C4C4, 74, 6, 0xAFAFAF, 106, 6, 0xD8D8D8, 133, 6, 0xCECECE, 171, 5, 0x121212, 317, 9, 0x737373, 310, -2, 0x121112, 304, -9, 0x111112, 274, 4, 0x121212, 287, 8, 0x949494, 268, 11, 0x121213, 568, 7, 0x121212, 512, 0, 0x121212 }, 90, 21, 72, 597, 92);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群发界面----");
        return true
    else
        return false
    end
end

local function action_qunfa()     --执行这个页面的操作--
   if gongneng == 4.3 then
        cicky(306,895,50);    --点击输入框
        mSleep(1000);
        if text_qunfa == nil then
            warning_info("请设置群发内容")
            return false
        end
        inputText(text_qunfa[math.random(#text_qunfa)]);
        mSleep(1500);
        cicky(446,932,50);      --点击空格
        mSleep(1000);
        cicky(587,916,50);      --点击发送
        mSleep(2000);
        log_info("群发一次");
     --   page_array["page_qunfazhushou"]:enter()
    else
        cicky(  63,82,50);  --返回选择收信人
        mSleep(1500);
        page_array["page_xuanzeren"]:enter();
    end
    return true;
end

--step1
function qunfa_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();    --进入微信主界面错误
        return false
    end

end

--step2
function qunfa_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*try_time);   --休眠一会会
        if true ==  check_page_qunfa() then 
            return true;
        else  
            time = time + 1;
        end
    end
    return false;
end

function qunfa_page:quick_check_page()  --检查是否是在当前页面--
    return  check_page_qunfa() ;
end

--step3  --最主要的工作都在这个里面
function qunfa_page:action()     --执行这个页面的操作--
    return  action_qunfa();
end

page_array["page_qunfa"] = qunfa_page:new()

------------------end:  page\wx_shezhi_4.2-4.3\page_qunfa.lua-------------------------------------




----------------------begin:  func\weixinzong\WeChar_main.lua---------------------------------
--文件以"func_" 开头,说明是一个功能性的脚本
--此功能是： 微信修改头像 签名 名字


function  phone_weixin(f,num_txt)   --读取文本电话号或微信 读一行 删一行
    kong(f);
    shengcheng(f,num_txt) ;     --生成文件
    local t={};
    local file=io.open(f);
    for line in file:lines() do
    table.insert(t,line);
    end
    inputText(table.remove(t,1))
    local file=io.open(f,"w");
    for i,j in ipairs(t) do
    file:write(j,'\n');
    end
    file:close(); 
end                  
 
 --判断文件是不是空的
function  kong(file)
    if true == file_exists(file) then
        local t={};
        local file_path =io.open(file);
        for line in file_path:lines() do
        table.insert(t,line);
        end
        if table.remove(t,1) == nil then
            warning_info("电话号码已空,复位重新生成文件,");
            os.execute("rm -rf "..file);
            return reset_ms_server()  --复位一下
        end
    end
end

--生产文件
function  shengcheng(file,num_txt)
    index = get_var_item("var_ms_index")   --获取index
    if index * 1000 > #num_txt then
        warning_info("电话号码不足"..index*1000.."条,脚本停止运行")
        os.exit()
    end
    if false == file_exists(file) then
        os.execute("touch "..file);
        for i , v in pairs(num_txt) do
            -- print (v)
            if i > 1000 * (index - 1)  and i <= index * 1000 then  --获取index范围的号码
                local f = io.open(file, 'a');
                f:write(v .. "\r\n");
                f:close();
            end
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
    local  xx = pre_fix_phone_numb[math.random(#pre_fix_phone_numb)]
    xx = tostring(xx)
    local a = #xx - 7 
    local b = 10000
    if a < 0 then
        for i = a , -1 do
            b = b * 10   
        end 
    elseif a > 0 then
        for i = 1 , a do
            b = b * 0.1           
        end
    end
    x = math.random(b-1)
    x = (tonumber(xx) * b) + x
    x = string.match(x,"(%d+)")
    local  y = tostring(x)
    y = string.sub(y, -3, -1)
    local my_name = pre_fix_name[math.random(#pre_fix_name)] .. y
    x = tonumber(x)
    -- print(x)
    -- print(my_name)
    return my_name, x;
    -- body
end

--网络测试
function network_test( ... )
    local x = 1
    while x < 180 do
        time = getNetTime();
        if  time ~= -1 then
            mSleep(1000)
            return true
        else
            notifyMessage("网络已断开，等待网络恢复中")
            mSleep(1000)
            log_info("网络已断开，等待网络恢复中")
        end
        x = x + 1 
        mSleep(60000)
    end
    notifyMessage("网络恢复不了,重启手机")
    mSleep(1000)
    log_info("网络恢复不了,重启手机")
    os.execute("reboot");
end
 
--从服务器上下载数据
function tmp_download_file(local_path,sl_url) 
    local local_path_path = strip_file_name(local_path);
    if false == file_exists(local_path_path) then 
        os.execute("mkdir -p " .. local_path_path);
    end
    local time = 1
    while 2 >= time do
        os.execute("curl -o " .. local_path .." " .. sl_url);
        mSleep(1000*time);  --时间逐步加长
        if true == file_exists(local_path) then --只看是否下载下来
            if true == tmp_check_download_file(local_path) then    
                return true;
            else
                time = time + 1;
            end
        else
            time = time + 1;
        end
    end
    return false; 
end

--下载错误
function tmp_check_download_file(path)
    -- body
    --oss下载错误会有NoSuchKey， nginx下载错误会有"404"
    if false == isStringInFile("NoSuchKey", path)  and  false == isStringInFile("404 Not Found", path)  then
        return true;
    else
        return false;
    end
end


function weixin_main() --微信主函数
    w,h = getScreenResolution();                  -- 将屏幕宽度和高度分别保存在变量w、h中
   -- notifyMessage(string.format("%d,%d\n", w,h)); -- 将宽度和高度用提示框显示到屏幕上
    ---mSleep(10000);
    if gongneng == "暂停" then   ---等待
        mSleep(math.random(1000,8888))
        return true
    end
	logFileInit(sl_log_file);
    math.randomseed(tostring(os.time()):sub(5):reverse()); 
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
    weixin_main();



------------------end:  func\weixinzong\WeChar_main.lua-------------------------------------
