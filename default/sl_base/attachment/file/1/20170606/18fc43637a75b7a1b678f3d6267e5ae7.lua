------------sl_func_qq_ip5.lua------------
--                                      --
--                                      --
--170606  21:08:53    luoshui package 
--                                      --
--                                      --
--                                      --
------------------------------------------








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

error_time = 1;
function error_info(out_info)  ---错误处理函数   
    local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage("错误：" .. out_info);
    mSleep(1200);
    if nil ~= sl_error_time then
        error_time = error_time + 1;
        if error_time >= sl_error_time then
            error_info_exit("错误次数太多");
        else
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
end

--end lib_file_log.lua

--检查下载文件--
function check_download_file(path)
    -- body
    --oss下载错误会有NoSuchKey， nginx下载错误会有"404"
    if true == isStringInFile("isStringInFile", path) then
        return true;
    end

    if false == isStringInFile("NoSuchKey", path)  and  false == isStringInFile("404 Not Found", path)  then
        return true;
    else
        return false;
    end
end

--从服务器上下载文件
function download_remote_file(local_path,sl_url) 
    local local_path_path = strip_file_name(local_path);
    if false == file_exists(local_path_path) then  --创建自己的临时文件夹
        os.execute("mkdir -p " .. local_path_path);
    end

    local try_time = 1
    while 3 >= try_time do
        os.execute("curl -o " .. local_path .." " .. sl_url);
        mSleep(1000*try_time);  --时间逐步加长
        if true == file_exists(local_path) then --只看是否下载下来
            if true == check_download_file(local_path) then    
                return true;
            else
                try_time = try_time + 1;
            end
        else
            try_time = try_time + 1;
        end
    end
    return false; 
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
        qq_error_info(self:get_page_name());
        mSleep(3000)
        tongzhi()  --系统通知
        qq_tongzhi()   --qq通知
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
            qq_error_info(self:get_page_name());
            return false
        end
    end
end

------------------end:  class\class_base_page.lua-------------------------------------




----------------------begin:  class\class_app_base.lua---------------------------------
--class_app_base.lua begin--


--简要逻辑：
-- 设备从服务器上领取任务；
-- 设备将任务提交给app模块；
-- app模块计算出任务的参数2，返回给设备；
-- 设备执行完任务，将执行结果返回给app，app记录；

--this class is for app
--APP中用户信息
local_app_info_path         = "/private/var/touchelf/scripts/sl/" --配置文件,
local_app_info_prefix_name  = "_app_nv.txt"
app_nv_prefix_name          = "_app_nv"


default_app_user = {
    user_name       = "default_account",  -- 用户名称
    user_snap_info  = "12212121212121",   --用户特征信息
    user_data       = {},                 --用户在这个设备上的信息
};

--base APP信息
class_base_app = {
    app_name = "default_app",
    app_info = {  
                app_snap_info = {},  --app特征值
                app_image_path = "",

                current_user_index = 1,         --当前是那个用户;
                user_list = {default_app_user}, --用户列表
            }, 
    app_user_key_point = { point_x = 80, point_y = 80},           --用户标识的点
    app_ctrl_func_list = {"default_func"},   --control func list 功能列表
    app_nv = nil,
    app_nv_path = "",
    app_nv_name = "",
   -- app_snap_iamge = {} --截图数组，hash数组
} 

--新建app对象--
function class_base_app:new(o) 
    o = o or {} --如果参数中没有提供table，则创建一个空的。
    setmetatable(o,self)
    self.__index = self 

    --设置路径
    self.app_nv_path = local_app_info_path .. self.app_name .. local_app_info_prefix_name;
    self.app_nv_name = self.app_name .. app_nv_prefix_name;
    self.app_nv = class_nv:new(); --初始化
    self.app_nv.local_nv_path = self.app_nv_path;
    self.app_nv:init();
   
    local tmp_nv = self.app_nv:read_nv_item(self.app_nv_name); --初始化nv项目
    if nil ~= tmp_nv and type(tmp_nv) == 'table' then
        self.app_info = tmp_nv;
    end
    return o    --最后返回构造后的对象实例
end

--得到APP名称--
function class_base_app:get_app_name()      
    return self.app_name;
end



--用户相关--

--进入用户帐号界面--
function class_base_app:enter_account_page()
    -- body
end

--初始化用户--
function class_base_app:init_user()  
    --在用户中心界面，去读取用户名的特征值 
    local app_user_key_name = self.app_name .. "_user_index"
    local tmp_user_index = get_tmp_var_item(app_user_key_name);
    --判断系统中是否已经判断过用户，防止二次进入
    if nil ~= tmp_user_index and type(tmp_user_index) == "number" then
         self.app_info.current_user_index = tmp_user_index;
         return true;
    end

    self:enter_account_page();     
    local user_key_info = get_pic_key_info(self.app_user_key_point.point_x, self.app_user_key_point.point_y);
    local is_find_user = false;
    local my_index = 1;
    if nil ~= self.app_info and type(self.app_info.user_list) == 'table' then
        for k,v in pairs(self.app_info.user_list) do
            if user_key_info == v.user_snap_info then
                self.app_info.current_user_index = k;
                is_find_user = true;
            end
            my_index = k;
        end

        if(false == is_find_user) then
            self.app_info.current_user_index = (my_index + 1);
            self.app_info.user_list[self.app_info.current_user_index] = {};
            self.app_info.user_list[self.app_info.current_user_index].user_snap_info = user_key_info;
            self:update_to_nv(); --写入nv文件中
        end
    else
        self.app_info = {};
        self.app_info.current_user_index = 1;
        self.app_info.user_list = {};
        self.app_info.user_list[self.app_info.current_user_index] = {};
        self.app_info.user_list[self.app_info.current_user_index].user_snap_info = user_key_info;
        self:update_to_nv(); --写入nv文件中
    end

    --print("class_base_app:check_app");
    --print(self.app_name)
    --设置系统已经判断过用户
    set_tmp_var_item(app_user_key_name, self.app_info.current_user_index);
    return true;
end

--更新用户信息到nv--
function class_base_app:update_to_nv()  
    self.app_nv:write_nv_item(self.app_nv_name, self.app_info);
    --print("class_base_app:check_app");
    --print(self.app_name)
    return true;
end

--step1 执行某个操作之前调用
function class_base_app:do_func(func_name, in_para)  
    if type(func_name) ~= 'string' then
        return false;
    end

    for k,v in ipairs(self.app_ctrl_func_list) do
      if v == func_name then
         local func_name = 'func_' .. func_name;
         return self[func_name](self,in_para);
      end
    end
    return false; 
    --print(self.app_name);
end

--step2 当执行完某个操作完成之后调用
function class_base_app:finish_func(func_name, in_para) 
    if type(func_name) ~= 'string' then
        return false;
    end

    for k,v in ipairs(self.app_ctrl_func_list) do
      if v == func_name then
         local func_name = 'func_' .. func_name .. '_finish';
         local tmp_return = self[func_name](self,in_para);
         self:update_to_nv();
         return tmp_return;
      end
    end
    return false; 
    --print(self.app_name);
end

--错误处理
function class_base_app:error_handle()  
    -- body
    if self.app_error_code == 101 then    --默认错误处理，按返回键
        keyDown('HOME');    --HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      --HOME键抬起
        mSleep(3000);
        warning_info(self:get_app_name());
    end
end


--应用处理
function class_base_app:func_default_func() 
    print("func_default_func");
end
function class_base_app:func_default_func_finish() 
    print("func_default_func_finish");
end


-------------------------------------------------test case----------------------------------------
function test_class_app_base( ... )
    -- body
    my_app = class_base_app:new();
    my_app:init_user();

    my_app.app_info.current_user_index = 10;
    my_app:update_to_nv();

    my_app:do_func("default_func");
    my_app:finish_func("default_func");

end

-- function main( ... )
--     -- body
--     test_class_app_base();
-- end

--class_app_base.lua end--
------------------end:  class\class_app_base.lua-------------------------------------




----------------------begin:  class\app\class_app_qq.lua---------------------------------
--默认微信用户参数---
default_qq_app_user = {
    user_name = "default_qq_account",  -- 用户名称
    user_snap_info = "131313131313131313",            --用户特征信息
    user_data = {
        qq_group_add_friends_num = 0,              --qq群加好友次数 
        qq_change_login_num = 0                          --qq换号登录次数
        }
}
--默认微信app数据--
qq_app_data = {
    app_name = "qq",
    app_info = {  
                app_snap_info = {},  --app特征值
                app_image_path = "",
                current_user_index = 1,         --当前是那个用户;
                user_list = {default_qq_app_user}, --用户列表
            } ,
    app_user_key_point = {
                 point_x = 320,  --用户标识的点
                 point_y = 180
                },          
    app_ctrl_func_list = {
                    "default_func", --默认             
                    "qq_change_login",             --qq换号登录       
                    "qq_group_add_friends"      --qq群加好友
                },
    app_nv      = nil,
    app_nv_path = "",
    app_nv_name = "",
   -- app_snap_iamge = {} --截图数组，hash数组
} 

--新建
qq_app_class = class_base_app:new(qq_app_data);



function qq_app_class:enter_account_page( ... )
end

----------------
function qq_app_class:func_default_func()

end
function qq_app_class:func_default_func_finish( ... )
    
end

--qq群
function qq_app_class:func_qq_group_add_friends()
    local index = self.app_info.current_user_index
    ---qq群加好友次数
    local group_add_num = self.user_list[index].user_data.qq_group_add_friends_num
end

function qq_app_class:func_qq_group_add_friends_finish()
end

function qq_app_class:func_qq_change_login()
    local index = self.app_info.current_user_index
    --qq群加好友换号次数
    local change_num = self.app_info.user_list[index].user_data.qq_change_login_num
    if change_num > 7 and change_num == 0 then  
        return 1    --点击第一个账号
    else
        return change_num     --点击第change_num个账号
    end
end

function qq_app_class:func_qq_change_login_finish(num_login)
    local index = self.app_info.current_user_index
     --qq群加好友换号次数
    local change_num = self.app_info.user_list[index].user_data.qq_change_login_num
    if change_num >= 7  then  
        self.app_info.user_list[index].user_data.qq_change_login_num = 1  --初始化
    else
        if num_login == true then
            self.app_info.user_list[index].user_data.qq_change_login_num = change_num + 1
        else
            self.app_info.user_list[index].user_data.qq_change_login_num = 1  --初始化
        end
    end
end
-------------------------------------------test 部分-------------------------
function test_qq_app( ... )
    -- body
    my_qq_app = qq_app_class:new();
    my_qq_app:init_user();
    my_qq_app:do_func("qq_add_contact_by_phone_book_link");
    my_qq_app:finish_func("qq_add_contact_by_phone_book_link",  "huangyinke---");

end

-- function main( ... )
--     -- body
--     test_qq_app();
-- end
------------------end:  class\app\class_app_qq.lua-------------------------------------




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




----------------------begin:  func\qq_main\config_fengzhuang.lua---------------------------------
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

--4代
function  zs(x1,y1,a,x2,y2,b)--多点找色
    xx1=math.ceil(x1/640*w);
    yy1=math.ceil(y1/960*h);
    xx2=math.ceil(x2/640*w);
    yy2=math.ceil(y2/960*h);
    x = getColor(x1, y1);
    y = getColor(x2, y2);    
    if x==a and y==b then
        cicky(x1,y1,50);
        mSleep(300);          
    end
    mSleep(100);        
end

--5c
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

function  fanhui_main()
    mSleep(500);
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(2000);
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

---qq通知
function qq_tongzhi( ... )
    zs2(196,733 ,0x00A5E0,169,723 ,0x00A5E0);        --升级提示1  点击暂不升级
    zs2(448,655 ,0x007AFF,462,648 ,0x007AFF);        --访问照片  点击好
    zs2(441,735 ,0x007AFF,462,739 ,0x007AFF);        --访问位置  点击允许
    zs2(152,655 ,0x007AFF,185,665 ,0x007AFF);        --发送通知  点击不允许  --9系统
    zs2(165,677 ,0x007AFF,172,677 ,0x007AFF);        --是否开启通知  点击取消
    zs2(458,745 ,0x007AFF,445,738 ,0x007AFF);        --访问位置  点击好
    zs2(462,648 ,0x007AFF, 445,640,0x007AFF);        --访问照片  点击好
    zs2(447,676 ,0x007AFF,462,668 ,0x007AFF);        --访问通讯录  点击好
    zs2(168,767 ,0x00A5E0,143,767 ,0x00A5E0);        --暂不升级2  --7系统
    zs2( 189,683 ,0x007AFF,189,692 ,0x007AFF);       --通知不允许 --7系统
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
------------------end:  func\qq_main\config_fengzhuang.lua-------------------------------------




----------------------begin:  func\qq_main\qq_error_handling.lua---------------------------------
error_time1 = 0 ;
function qq_error_info(out_info)  ---错误处理函数   
    logFileInit(sl_log_file);
    local time = get_local_time(); 
    writeStrToFile("error:  " .. time .. out_info , sl_log_file); 
    notifyMessage("错误：" .. out_info);
    mSleep(1200);
    if nil ~= func_error_time then
        error_time1 = error_time1 + 1;
        if error_time1 >= func_error_time then
            error_info_exit("错误次数太多,重启设备");
        elseif error_time1 == 4 then
            warning_info("错误4次,继续下一个");
            if appRunning("com.tencent.mqq") then 
                appKill("com.tencent.mqq");
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

error_time2 = 0 ;
--输出警告信息到文件
function qq_warning_info(out_info)  ---错误处理函数   
    notifyMessage("警告：" .. out_info);
    mSleep(1200);
    local time = get_local_time(); 
    writeStrToFile("warning:  " .. time .. out_info , sl_log_file);    
    if nil ~= func_error_time then
        error_time2 = error_time2 +1 ;
        if error_time2 >= func_error_time then
            error_info_exit("警告次数太多,重启设备");
        elseif error_time2 == 4 then
            warning_info("警告4次,继续下一个");
            if appRunning("com.tencent.mqq") then 
                appKill("com.tencent.mqq");
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
------------------end:  func\qq_main\qq_error_handling.lua-------------------------------------




----------------------begin:  page\qq_main\page_heiping.lua---------------------------------

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
------------------end:  page\qq_main\page_heiping.lua-------------------------------------




----------------------begin:  page\qq_main\page_main.lua---------------------------------

default_main_page = {
    page_name = "main_page",
    page_image_path = nil
}

main_page = class_base_page:new(default_main_page);

---手机主界面 0
local function check_page_main()
    --下面3个图标
    x, y = findMultiColorInRegionFuzzy({ 0x6DF35D, -29, 65, 0x1DD925, -35, -18, 0x7EF96A, 1, 8, 0x63F057, 120, 34, 0xFFFFFF, 152, 50, 0xFFFFFF, 162, 9, 0xFFFFFF, 124, -7, 0x1D77F2, 274, 30, 0x1B9CF7, 292, 50, 0x1C82F4, 311, 17, 0x1BABF8, 282, 1, 0x1ABEFA, 293, 20, 0xFF1414, 302, 28, 0x1B9EF7 }, 90, 72, 985, 418, 1068);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----手机主界面7.0----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x64F97D, 51, -2, 0x64FA7E, 68, 3, 0x63F87C, 75, 64, 0x38CD51, 60, 96, 0x0AB827, 22, 91, 0x10BB2D, 10, 71, 0x2DC848, 9, 26, 0xFFFFFF, 39, 8, 0x61F47B, 34, 73, 0x2AC745, 15, 56, 0x43D35B, 20, 22, 0xFFFFFF, 46, 23, 0x5CEA74, 49, 30, 0x58E570 }, 90, 52, 983, 127, 1081);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----手机主界面9.0----");
            return true
        else
            return false
        end
    end
end

--锁屏界面
local  function check_page_suoping( ... )
    mSleep(500)
    x, y = findMultiColorInRegionFuzzy({ 0x5AC6E2, -1, 0, 0x5AC6E2, 6, -8, 0x51C4E4, -6, 1, 0x57C5DF, 22, -2, 0x53CBEA, 254, -10, 0x3BCCEB, 257, -5, 0x37C9EB, 276, -9, 0x45CEEB, 295, -9, 0x3FC9EB, 295, 1, 0x38C8EB, 289, 2, 0x3AC9EB }, 90, 318, 1103, 619, 1115);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---锁屏界面-7.0---")
        return true
    else 
        return false
    end
end

--打开qq
local function action_qq() --执行这个页面的操作--
    --判断qq是否运行
    if appRunning("com.tencent.mqq") then
        appRun("com.tencent.mqq");
        mSleep(2000)
    else
        appRun("com.tencent.mqq");
        mSleep(5000)
        --qq提示通知
        x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 7, 0, 0x007AFF, 22, -5, 0x007AFF, 22, 7, 0x007AFF, 16, 7, 0x007AFF, 18, 13, 0x007AFF }, 90, 309, 655, 331, 673);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50)  --点击好
            mSleep(2000)
        end
    end
    local current_page = get_current_page(); --得到当前的page
    if false ~= current_page then 
        page_array[current_page]:enter(); --直接进当前页面的处理
    else
        qq_warning_info("没找到这个界面,重新打开QQ");
        mSleep(1000);
        appKill("com.tencent.mqq");    ---关闭qq
        mSleep(4000);
        return page_array["page_main"]:enter()
    end
end


local  function action_suoping( ... )
        zuohua() ;   --右滑
        page_array["page_main"]:enter(); 
end

--step1 第一步
function main_page:enter()        --进入页面后的动作--
    tongzhi();    --系统通知
    qq_tongzhi();  --qq通知
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
    return action_qq();
end

page_array["page_main"] = main_page:new()
--end page_main.lua
------------------end:  page\qq_main\page_main.lua-------------------------------------




----------------------begin:  page\qq_main\page_xiaoxi.lua---------------------------------

default_xiaoxi_page = {
    page_name = "xiaoxi_page",
    page_image_path = nil
}

xiaoxi_page = class_base_page:new(default_xiaoxi_page);

---qq消息界面
local function check_page_xiaoxi()
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 26, 4, 0xFFFFFF, 39, 10, 0xFFFFFF, 42, 17, 0xFFFFFF, 10, 17, 0x8ADBFA, 8, 11, 0xFAFDFE, 20, 7, 0xC6EDFC, 110, 6, 0x12B7F5, 154, 4, 0x12B7F5, 165, 19, 0xFFFFFF, 127, 19, 0xEBF9FE, 144, 5, 0x12B7F5, 158, -1, 0x12B7F5, 183, 0, 0x12B7F5, 198, 21, 0x12B7F5, 181, 41, 0x12B7F5, 114, 37, 0x12B7F5, 104, 34, 0x12B7F5, 113, -3, 0x12B7F5, 154, -3, 0x12B7F5, 190, -3, 0x12B7F5, 218, -3, 0x12B7F5, 227, 2, 0x12B7F5, 218, 33, 0x12B7F5, 203, 39, 0x12B7F5, -10, 39, 0xFFFFFF, 108, 39, 0x12B7F5, 185, 34, 0x12B7F5, 193, 7, 0x12B7F5, 132, -5, 0x12B7F5, 109, -2, 0x12B7F5, 122, 8, 0x7DD7FA }, 90, 227, 61, 464, 107);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq消息界面1-7.0-8.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 22, -3, 0xFFFFFF, 38, 0, 0x3FC4F6, 44, 10, 0x87DAF9, 31, 18, 0xE0F5FD, -4, 17, 0xFFFFFF, -3, 5, 0xFFFFFF, 2, 2, 0x12B7F5, 102, -5, 0x6ED1F6, 139, -5, 0x6ED1F6, 149, 7, 0xFFFFFF, 149, 10, 0xFFFFFF, 187, 1, 0x6ED1F6, 159, 14, 0x6ED1F6, 141, 2, 0x6ED1F6, 180, -4, 0x6ED1F6, 197, -4, 0x6ED1F6, 200, 25, 0x6ED1F6, 171, 21, 0x6ED1F6, 189, -15, 0x6ED1F6, 210, -2, 0x6ED1F6, 218, 15, 0x6ED1F6, 218, 15, 0x6ED1F6, 251, -6, 0x6ED1F6, 220, 8, 0x6ED1F6, 237, 19, 0x6ED1F6, 37, 30, 0xFFFFFF, 62, 30, 0xFFFFFF, 114, 31, 0x6ED1F6, 168, 33, 0x6ED1F6, 195, 11, 0x6ED1F6, 121, -8, 0x6ED1F6, 71, -8, 0xFFFFFF, 52, -8, 0xFFFFFF }, 90, 232, 58, 487, 106);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----qq消息界面2-7.0---");
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0x34C0F5, 85, 9, 0xFFFFFF, 101, 14, 0xFFFFFF, 109, 23, 0xFFFFFF, 48, 30, 0x88DAF9, 47, 21, 0xFFFFFF, 161, 37, 0x34C0F5, 210, 32, 0xFFFFFF, 213, 21, 0x49C6F6, 148, 10, 0x34C0F5, 188, 25, 0x34C0F5, 235, 20, 0x34C0F5, 294, 20, 0x34C0F5, 394, 36, 0x34C0F5, 420, 22, 0x34C0F5, 382, 10, 0x34C0F5, 390, 31, 0x34C0F5, 410, 32, 0x34C0F5 }, 90, 194, 59, 614, 96);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("----qq消息界面-9.0----");
                return true
            else
                return false
            end
        end
    end
end

local  message_num = 20   --查看消息次数
local function action_xiaoxi() --执行这个页面的操作--
    if gongneng == "add_group" or gongneng == "add_friends" or gongneng == "pull_people_into_group" or gongneng == "hair_message_friends" or gongneng == "agree_friends_add_request" 
        or gongneng == "copy_qq_number" then
        cicky( 321,1067,50);  --点击联系人
        mSleep(1000)
        page_array["page_lianxiren"]:enter()
    elseif gongneng == "change_login" then
        cicky(  59,89,1500);  --长按切换账号
        mSleep(1500);
        local my_qq_app = qq_app_class:new();
        local num_login = my_qq_app:do_func("qq_change_login")  --读取登录次数  从1开始
        cicky( 183,258+92*(num_login-1),50)   --点击第num_login个账号
        mSleep(3000)
        log_info("切换账号");
        mSleep(1000)
        --没号了
        x, y = findMultiColorInRegionFuzzy({ 0xFEFFFF, 11, 1, 0xF0FAFE, 24, 3, 0x12B7F5, 64, 4, 0xFFFFFF, 87, 4, 0xFFFFFF, 134, 4, 0x56CCF8, 192, 4, 0x12B7F5, 221, 4, 0x95DFFB, 221, 4, 0x95DFFB, 226, 16, 0x12B7F5, 224, 24, 0x12B7F5, 212, 27, 0x12B7F5, 194, 27, 0x12B7F5, 152, 27, 0xC3EDFC, 105, 29, 0x12B7F5, 51, 29, 0x12B7F5, 21, 28, 0x12B7F5, 6, 21, 0xFFFFFF, 22, 16, 0x12B7F5, 76, 15, 0xCAEFFD, 140, 15, 0x12B7F5, 182, 16, 0x9CE1FB, 225, 11, 0xF8FDFF, 178, 2, 0x12B7F5, 127, 12, 0x12B7F5, 53, 17, 0x12B7F5, 25, 10, 0x12B7F5, 20, 6, 0xFFFFFF, 4, 2, 0x12B7F5, 10, 1, 0x9FE2FB, 125, 1, 0x12B7F5, 219, 1, 0xDBF4FD, 235, 1, 0x12B7F5 }, 90, 208, 71, 443, 100);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky( 598,77,50);  --点击取消
            mSleep(1500)
            qq_warning_info("该设备没有8个账号")
            return my_qq_app:finish_func("qq_change_login",false)  --初始化登录次数
        end
        my_qq_app:finish_func("qq_change_login",true)   --写入登录次数
        return true
    elseif gongneng == "group_message_add_friends" then
        --没有消息了
        x, y = findMultiColorInRegionFuzzy({ 0xDBDBDC, 43, -1, 0xE0E0E2, 135, -1, 0xA9A9A9, 216, -5, 0xF7F7F9, 222, -4, 0xF7F7F9, 189, 21, 0xF7F7F9, 144, 25, 0xF7F7F9, 83, 25, 0xF7F7F9, 36, 25, 0xF7F7F9, 8, 21, 0xF7F7F9, 11, 4, 0xB0B0B0, 35, 9, 0xF7F7F9, 99, 17, 0xC6C6C7, 197, 11, 0xCFCFD0, 198, 2, 0xF7F7F9, 91, 4, 0xF7F7F9, 89, 5, 0xF7F7F9, 20, -177, 0xADADAF, 14, -116, 0xF7F7F9, 17, -75, 0xF7F7F9, 70, -122, 0xD5D5D7, 155, -127, 0xF7F7F9, 158, -127, 0xF7F7F9, 60, -129, 0xF7F7F9, 88, -105, 0xF7F7F9, 107, -55, 0xF7F7F9, 155, -57, 0xF7F7F9 }, 90, 214, 488, 436, 690);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            qq_warning_info("没有消息可查看了")
            return false
        end
        move(245,math.random(500,800),245,math.random(200,400),5);  --随机滑动
        mSleep(1000);
        cicky( 313,216,50);   --点击第一条消息
        mSleep(1500)
        --自己的群
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -5, 5, 0xFFFFFF, -5, 11, 0xFFFFFF, -20, 11, 0xFFFFFF, -44, 8, 0xFFFFFF, 28, 4, 0xFFFFFF, 56, -7, 0xFFFFFF, 66, -1, 0xFFFFFF, 68, 6, 0xFFFFFF, 92, 11, 0xFFFFFF, 113, -1, 0xFFFFFF, 140, 2, 0xFFFFFF, 163, 0, 0xFFFFFF, 183, -1, 0xFFFFFF, 192, 10, 0xFFFFFF, 203, 10, 0xFFFFFF, 213, 10, 0xFFFFFF }, 90, 196, 77, 453, 95);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(60,80,50);   --点击返回
            mSleep(1500)
            move( 504,215, 100,215,8);   --滑动删除
            mSleep(1000)
            cicky(593,216,50);   --点击删除
            mSleep(1500)
            page_array["page_xiaoxi"]:enter()
        end
        if page_array["page_group_message"]:quick_check_page() == true then
            page_array["page_group_message"]:action()
        elseif page_array["page_tencent_news"]:quick_check_page() == true then
            page_array["page_tencent_news"]:action()
        else
            log_info("不能回复消息")
            mSleep(math.random(1500,3000))
            cicky(60,80,50);   --点击返回
            mSleep(1500)
            move( 504,215, 100,215,8);   --滑动删除
            mSleep(1000)
            cicky(593,216,50);   --点击删除
            mSleep(1500)
            page_array["page_xiaoxi"]:enter()
        end
    elseif gongneng == "del_message" then  --删除这条消息
        move( 504,215, 100,215,8);   --滑动删除
        mSleep(1000)
        cicky(593,216,50);   --点击删除
        mSleep(1500)
        return true
    elseif gongneng == "reply_friends_message"  then  --回复消息给好友
       if message_num <= 0 then
           qq_warning_info("消息回复满了，不在回复")
           return false
       end
        message_num = message_num - 1   --每次查看消息次数减一
        --没有消息了
        x, y = findMultiColorInRegionFuzzy({ 0xDBDBDC, 43, -1, 0xE0E0E2, 135, -1, 0xA9A9A9, 216, -5, 0xF7F7F9, 222, -4, 0xF7F7F9, 189, 21, 0xF7F7F9, 144, 25, 0xF7F7F9, 83, 25, 0xF7F7F9, 36, 25, 0xF7F7F9, 8, 21, 0xF7F7F9, 11, 4, 0xB0B0B0, 35, 9, 0xF7F7F9, 99, 17, 0xC6C6C7, 197, 11, 0xCFCFD0, 198, 2, 0xF7F7F9, 91, 4, 0xF7F7F9, 89, 5, 0xF7F7F9, 20, -177, 0xADADAF, 14, -116, 0xF7F7F9, 17, -75, 0xF7F7F9, 70, -122, 0xD5D5D7, 155, -127, 0xF7F7F9, 158, -127, 0xF7F7F9, 60, -129, 0xF7F7F9, 88, -105, 0xF7F7F9, 107, -55, 0xF7F7F9, 155, -57, 0xF7F7F9 }, 90, 214, 488, 436, 690);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            qq_warning_info("没有消息可查看了")
            return false
        end
        cicky( 313,216,50);   --点击第一条消息
        mSleep(1500)
         --好友聊天界面
        x, y = findMultiColorInRegionFuzzy({ 0xF0FAFE, 0, -7, 0xF0FAFE, -11, -12, 0xF0FAFE, -13, -18, 0xF0FAFE, -13, -39, 0xF0FAFE, -24, -39, 0xF0FAFE, -108, -38, 0xF0FAFE, -113, -42, 0xF0FAFE, -119, -32, 0xF0FAFE, -114, -18, 0xF0FAFE, -92, 0, 0xF0FAFE }, 90, 496, 62, 615, 104);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            page_array["page_friends_chat"]:action()
        elseif page_array["page_tencent_news"]:quick_check_page() == true then
            page_array["page_tencent_news"]:action()
        else
            log_info("不能回复消息")
            mSleep(math.random(1500,3000))
            cicky(60,80,50);   --点击返回
            mSleep(1500)
            move( 504,216, 100,216,8);   --滑动删除
            mSleep(1000)
            cicky(593,216,50);   --点击删除
            mSleep(1500)
            page_array["page_xiaoxi"]:enter()
        end
    elseif gongneng == "fashuoshuo" or gongneng == "comment_friends_shuoshuo" then
        cicky( 534,1078,50);    --点击动态
        mSleep(1000)
        page_array["page_dongtai"]:enter()
    end
end


--step1 第一步
function xiaoxi_page:enter()        --进入页面后的动作--
    if  true == check_page_suoping() then
        return action_suoping();
    elseif true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function xiaoxi_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_xiaoxi() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function xiaoxi_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_xiaoxi()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function xiaoxi_page:action()
    return action_xiaoxi()
end

page_array["page_xiaoxi"] = xiaoxi_page:new()
--end page_xiaoxi.lua
------------------end:  page\qq_main\page_xiaoxi.lua-------------------------------------




----------------------begin:  page\qq_main\page_lianxiren.lua---------------------------------

default_lianxiren_page = {
    page_name = "lianxiren_page",
    page_image_path = nil
}

lianxiren_page = class_base_page:new(default_lianxiren_page);

---qq联系人界面
local function check_page_lianxiren()
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 12, 2, 0x12B7F5, 30, 3, 0x45C7F7, 51, 3, 0x12B7F5, 62, 3, 0x12B7F5, 85, 3, 0x12B7F5, 101, 3, 0x12B7F5, 114, 4, 0x12B7F5, -24, 7, 0x12B7F5, 8, 8, 0x12B7F5, 54, 8, 0x12B7F5, 67, 8, 0x12B7F5, 75, 8, 0xFFFFFF, 109, 8, 0x12B7F5, 111, 8, 0x12B7F5, -16, 18, 0x12B7F5, 23, 18, 0x12B7F5, 48, 18, 0x90DDFA, 58, 18, 0x12B7F5, 80, 18, 0xFFFFFF, 115, 18, 0x12B7F5, 130, 18, 0x12B7F5, -9, -2, 0x12B7F5, 1, 13, 0xFFFFFF, 1, 13, 0xFFFFFF, 10, 3, 0x12B7F5, 18, 8, 0x12B7F5, 42, 5, 0x12B7F5, 44, 4, 0x12B7F5, 60, 20, 0x12B7F5, 69, 11, 0x12B7F5, 86, 10, 0x12B7F5, 97, 17, 0x12B7F5 }, 90, 255, 69, 409, 91);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq联系人界面1-7.0-8.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x6ED1F6, 68, 0, 0xA2E1F9, 106, -2, 0x6ED1F6, 41, 27, 0x6ED1F6, -52, 6, 0x6ED1F6, -88, -11, 0x6ED1F6, -33, 29, 0x6ED1F6, 104, -6, 0xD8F3FD, 28, -17, 0x6ED1F6, 121, 2, 0x6ED1F6, 265, 1, 0x6ED1F6, 199, -9, 0x6ED1F6, 307, -2, 0xFAFDFF, 297, 23, 0x6ED1F6, 370, -10, 0x6ED1F6, 352, 8, 0x6ED1F6, 290, -2, 0x6ED1F6, 351, -19, 0x6ED1F6 }, 90, 163, 59, 621, 107);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----qq联系人界面2-7.0---");
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 50, 13, 0x12B7F5, -37, 26, 0x12B7F5, -37, 20, 0x12B7F5, 14, 9, 0xA2E3FB, 69, 27, 0x12B7F5, 96, 35, 0x12B7F5, 328, 30, 0xFFFFFF, 342, 19, 0x12B7F5, 290, -2, 0x12B7F5, 288, 10, 0x12B7F5, 322, 29, 0xFFFFFF, 300, 21, 0x12B7F5, -83, 12, 0x12B7F5, 138, 16, 0x12B7F5, 184, 22, 0x12B7F5, 184, 22, 0x12B7F5 }, 90, 199, 63, 624, 100);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("----qq联系人界面1-9.0----");
                return true
            else
               x, y = findMultiColorInRegionFuzzy({ 0x34C0F5, 35, 3, 0xA2E2FA, -3, 26, 0x34C0F5, -14, -1, 0x34C0F5, -3, -4, 0x89DAF9, 19, -7, 0x34C0F5, 22, 15, 0xFFFFFF, 3, 16, 0x34C0F5, -15, 2, 0x34C0F5, -11, 2, 0x34C0F5, -27, -4, 0x34C0F5, -21, 11, 0x34C0F5, -307, -9, 0x34C0F5, -250, -5, 0x34C0F5, -230, -5, 0xD9F3FD, -220, 14, 0x34C0F5, -217, 25, 0x79D5F8, -268, 25, 0xFFFFFF, -308, 24, 0x33BFF4, -314, 11, 0x33BFF4, -269, 4, 0xF7FDFF, -225, 12, 0xFDFFFF, -220, 14, 0x34C0F5, -264, -2, 0xFFFFFF, -305, 4, 0xFFFFFF, -261, 22, 0x34BFF4, -234, 22, 0x34C0F5, -228, 19, 0x34C0F5, -97, 9, 0x34C0F5, -60, 25, 0x34C0F5 }, 90, 269, 64, 618, 99);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    log_info("----qq联系人界面2-9.0----");
                    return true
                else
                    return false
                end
            end
        end
    end
end

local function action_lianxiren() --执行这个页面的操作--
    if gongneng == "add_friends" or gongneng == "add_group" then
        cicky( 595,81,50);  --点击添加
        mSleep(1000)
        page_array["page_add_contacts"]:enter()
    elseif gongneng == "hair_message_friends" then
        cicky( 283,173,50);  --点击搜索
        mSleep(1500)
        if text_hair_friends ~= nil and text_hair_friends[1] ~= nil then
            inputText(text_hair_friends[math.random(#text_hair_friends)])   --输入搜索指定信息
        else
            qq_warning_info("没有发消息的好友信息")
            return false
        end
        mSleep(2000)
        cicky( 200,237,50);   --点击第一个
        mSleep(3000)
        --好友聊天界面
        x, y = findMultiColorInRegionFuzzy({ 0xF0FAFE, 0, -7, 0xF0FAFE, -11, -12, 0xF0FAFE, -13, -18, 0xF0FAFE, -13, -39, 0xF0FAFE, -24, -39, 0xF0FAFE, -108, -38, 0xF0FAFE, -113, -42, 0xF0FAFE, -119, -32, 0xF0FAFE, -114, -18, 0xF0FAFE, -92, 0, 0xF0FAFE }, 90, 496, 62, 615, 104);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            page_array["page_friends_chat"]:action()
        elseif page_array["page_application_jiahaoyou"]:check_page() == true then
            gongneng = "add_friends"   --加为好友
            mSleep(1000)
            page_array["page_application_jiahaoyou"]:action()
        else
            qq_warning_info("没有这个好友");
            cicky(60,80,50);  --点击返回
            mSleep(1500)
            cicky( 600,84 ,50);  --点击取消
            mSleep(1500)
            return false
        end
    elseif gongneng == "agree_friends_add_request" then   --同意添加请求
        cicky( 106,287,50);  --点击新的朋友
        mSleep(1000)
        page_array["page_new_friends_add"]:enter()
    elseif gongneng == "group_add_friends" or gongneng == "pull_people_into_group" 
    or gongneng == "copy_qq_number" then
        cicky( 310,279,50); --点击群聊
        mSleep(1000)
        page_array["page_group_chat"]:enter()  
    elseif gongneng == "fashuoshuo" or gongneng == "comment_friends_shuoshuo" then
        cicky( 534,1078,50);    --点击动态
        mSleep(1000)
        page_array["page_dongtai"]:enter()
    elseif gongneng == "group_message_add_friends" or gongneng == "change_login" or gongneng == "reply_friends_message" then
        cicky(97,1075,50);  --点击消息
        mSleep(1000)
        page_array["page_xiaoxi"]:enter()
    end     
end


--step1 第一步
function lianxiren_page:enter()        --进入页面后的动作--
    if  true == check_page_suoping() then
        return action_suoping();
    elseif true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function lianxiren_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_lianxiren() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function lianxiren_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_lianxiren()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function lianxiren_page:action()
    return action_lianxiren()
end

page_array["page_lianxiren"] = lianxiren_page:new()
--end page_lianxiren.lua
------------------end:  page\qq_main\page_lianxiren.lua-------------------------------------




----------------------begin:  page\qq_main\page_dongtai.lua---------------------------------

default_dongtai_page = {
    page_name = "dongtai_page",
    page_image_path = nil
}

dongtai_page = class_base_page:new(default_dongtai_page);

---qq动态界面
local function check_page_dongtai()
    x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 11, 4, 0x12B7F5, 39, 4, 0xF6FCFF, 58, 4, 0xFFFFFF, 59, 17, 0x15B8F5, 52, 29, 0x56CCF8, 14, 23, 0xFFFFFF, 6, 20, 0x12B7F5, 12, 6, 0x97DFFB, 30, 2, 0x12B7F5, 51, 5, 0xFFFFFF, 53, 12, 0xFFFFFF, 31, 23, 0x12B7F5, 10, 6, 0x62CFF8, 34, 6, 0xC6EEFD, 69, 23, 0x12B7F5, 88, -3, 0x12B7F5, 9, -11, 0x12B7F5, -19, -10, 0x12B7F5, -20, 28, 0x12B7F5, 73, 39, 0x12B7F5, 128, 9, 0x12B7F5, 130, 8, 0x12B7F5, 237, 989, 0x12B7F5, 230, 1012, 0x12B7F5, 222, 1020, 0xFFFFFF, 245, 1022, 0x12B7F5, 248, 1022, 0x12B7F5, 256, 1014, 0xFFFFFF, 254, 1007, 0x12B7F5, 245, 1007, 0x12B7F5, 230, 1005, 0x12B7F5, 225, 1003, 0x12B7F5, 224, 1004, 0x12B7F5, 241, 1014, 0x12B7F5, 242, 1014, 0x12B7F5, 125, 999, 0xFFFFFF, 326, 1007, 0xFFFFFF }, 90, 271, 58, 617, 1091);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq动态界面1-7.0-8.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, -12, 14, 0x12B7F5, 9, 4, 0x12B7F5, 19, 9, 0x12B7F5, -12, 18, 0x12B7F5, -21, 28, 0xFFFFFF, 17, 32, 0x19B9F5, 18, 55, 0xD7F1FA, -13, 58, 0xABE1F6, -16, 50, 0x7ED2F1, 0, 47, 0xC9ECF9, 8, 52, 0xACE2F6, 17, 34, 0x7AD6FA, -1, 13, 0x12B7F5, -20, 3, 0x4EC9F7, -228, 43, 0xFFFFFF, -185, 47, 0xFFFFFF, -204, 53, 0x939393, -224, 51, 0xFFFFFF, -413, 47, 0xEDEDED, -428, 49, 0xF4F4F4, -433, 49, 0xF0F0F0, -418, 49, 0x808080 }, 90, 95, 1067, 547, 1125);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----qq动态界面2-7.0---");
            return true
        else
            return false
        end
    end
end

local function action_dongtai() --执行这个页面的操作--
    if gongneng == "fashuoshuo" or gongneng == "comment_friends_shuoshuo" then
        cicky( 105,281,50)   --点击好友动态
        mSleep(1500)
        --好友动态界面
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 4, -23, 0xFFFFFF, -24, -19, 0xFFFFFF, -24, -4, 0xFFFFFF, 2, 4, 0xFFFFFF, -19, 9, 0xFFFFFF, -30, 4, 0xFFFFFF, -285, -11, 0xFFFFFF, -290, 1, 0xFFFFFF, -270, 1, 0xFFFFFF, -252, -7, 0xFFFFFF, -244, -7, 0xFFFFFF, -233, -8, 0xFFFFFF }, 90, 305, 68, 599, 100);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            for i=1,math.random(3,7) do
                move(300,math.random(900,1000),300,math.random(200,300),5)
                mSleep(math.random(1222,2222))
            end
            page_array["page_space_dynamic"]:action()
        else
            if page_array["page_space_dynamic"]:quick_check_page() == true then
                return page_array["page_space_dynamic"]:action()
            end
            qq_warning_info("进入好友动态失败");
            return false
        end
    elseif gongneng == "add_friends" or gongneng == "add_group"or gongneng == "group_add_friends" or gongneng == "pull_people_into_group" or gongneng == "hair_message_friends" or gongneng =="agree_friends_add_request" or gongneng == "copy_qq_number" then
        cicky( 321,1067,50);  --点击联系人
        mSleep(1000)
        page_array["page_lianxiren"]:enter()
    elseif gongneng == "group_message_add_friends" or gongneng == "change_login" or gongneng == "reply_friends_message"  then
        cicky(97,1075,50);  --点击消息
        mSleep(1000)
        page_array["page_xiaoxi"]:enter()
    end
end


--step1 第一步
function dongtai_page:enter()        --进入页面后的动作--
    if  true == check_page_suoping() then
        return action_suoping();
    elseif true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function dongtai_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_dongtai() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function dongtai_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_dongtai()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function dongtai_page:action()
    return action_dongtai()
end

page_array["page_dongtai"] = dongtai_page:new()
--end page_dongtai.lua
------------------end:  page\qq_main\page_dongtai.lua-------------------------------------




----------------------begin:  page\qq_main\page_tongxunlu.lua---------------------------------

default_tongxunlu_page = {
    page_name = "tongxunlu_page",
    page_image_path = nil
}

tongxunlu_page = class_base_page:new(default_tongxunlu_page);

---qq通讯录界面
local function check_page_tongxunlu()
    x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 12, 0, 0xFFFFFF, 72, -3, 0x12B7F5, 78, -3, 0x12B7F5, 82, -1, 0xC7EEFD, 124, 11, 0x12B7F5, 27, 9, 0xE8F8FE, 49, 9, 0xDAF4FD, 78, 10, 0xFFFFFF, 84, 10, 0xFFFFFF, 104, 10, 0x12B7F5, 24, 22, 0x12B7F5, 58, 22, 0x12B7F5, 74, 22, 0x68D1F9, 96, 21, 0x12B7F5, 111, 13, 0x12B7F5, 111, 8, 0x12B7F5, 90, -8, 0x12B7F5, 28, -16, 0x12B7F5, -16, -11, 0x12B7F5, -22, 13, 0x12B7F5, 52, 39, 0x12B7F5, 102, 32, 0x12B7F5, -254, -1, 0x12B7F5, -234, 3, 0x12B7F5, -241, 26, 0x12B7F5, -260, 22, 0x12B7F5, -248, 3, 0x12B7F5, -201, 1, 0x12B7F5, -217, 30, 0x12B7F5, -238, 11, 0x12B7F5 }, 90, 18, 55, 402, 110);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---qq通讯录界面-7.0---")
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 11, 0, 0x12B7F5, 33, 3, 0xFFFFFF, 65, 5, 0x12B7F5, 89, 5, 0x12B7F5, 112, 4, 0xD5F2FD, 130, 2, 0x12B7F5, 167, 2, 0xDCF4FE, 184, 4, 0x12B7F5, 186, 7, 0x12B7F5, 168, 20, 0xFFFFFF, 140, 17, 0x74D5F9, 83, 12, 0x12B7F5, 45, 9, 0xFFFFFF, 14, 5, 0x7FD8FA, -1, 5, 0x12B7F5, -5, 17, 0xA5E4FB, 26, 19, 0x12B7F5, 68, 19, 0x12B7F5, 109, 21, 0xFFFFFF, 161, 21, 0x12B7F5, 200, 20, 0x12B7F5, 208, 9, 0x12B7F5, 205, -6, 0x12B7F5, 131, -8, 0x12B7F5, 56, -11, 0x12B7F5, 13, -13, 0x12B7F5, -11, -10, 0x12B7F5, -11, 6, 0x12B7F5, 87, 14, 0x9FE2FB, 171, 14, 0x12B7F5 }, 90, 215, 58, 434, 92);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("---qq绑定手机号界面7.0---")
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0x66B400, -5, 114, 0xFFFFFF, -39, 123, 0x17BCCF, -64, 78, 0x17BCCF, 39, 96, 0x17BCCF, 48, 157, 0x17BCCF, -107, 167, 0xFFFFFF, 92, 209, 0xFFAF01, 61, 225, 0xFFFFFF, -7, 240, 0x66B400, -97, 220, 0x66B400, -125, 139, 0x66B400, -119, 91, 0x66B400, -31, 28, 0x66B400, 17, 20, 0x66B400, 115, 85, 0x66B400, 136, 149, 0x66B400, 84, 177, 0xFFAF01, -24, 130, 0xFFFFFF, 8, 85, 0x17BCCF, 79, 114, 0x17BCCF, 28, 131, 0x17BCCF }, 90, 199, 315, 460, 555);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("---设备锁界面---")
                return true
            else
                x, y = findMultiColorInRegionFuzzy({ 0xB1E7FC, 37, 0, 0xA3E3FB, 53, 0, 0x12B7F5, 65, 1, 0x12B7F5, 92, 2, 0x12B7F5, 154, 2, 0xFFFFFF, 216, 2, 0xFFFFFF, 223, 9, 0xFFFFFF, 227, 24, 0x12B7F5, 222, 29, 0xEBF9FE, 194, 30, 0x12B7F5, 155, 22, 0x12B7F5, 103, 20, 0xFFFFFF, 23, 20, 0xC1ECFC, -1, 16, 0x12B7F5, 13, 8, 0xFFFFFF, 42, 13, 0x12B7F5, 105, 17, 0xDEF5FE, 159, 17, 0xA7E4FB, 200, 14, 0x71D4F9, 237, 4, 0x12B7F5, 255, -4, 0x12B7F5, 146, -12, 0x12B7F5, 80, -5, 0x12B7F5, 8, -3, 0x12B7F5, -32, 1, 0x12B7F5, 2, 23, 0x12B7F5, 118, 25, 0xFFFFFF, 212, 25, 0x12B7F5, 258, 18, 0x12B7F5, 258, 12, 0x12B7F5, 248, 9, 0x12B7F5 }, 90, 174, 57, 464, 99);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    log_info("---登陆注册账号界面---")
                    return true
                else
                    return false
                end
            end
        end
    end
end

local function action_tongxunlu() --执行这个页面的操作--
    cicky( 591,84,50)  --点击关闭/取消
    mSleep(1500)
    if page_array["page_xiaoxi"]:quick_check_page() == true then
        return page_array["page_xiaoxi"]:enter()
    end
    cicky(57,81,50);   --点击关闭
    mSleep(1500)
    x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 32, -5, 0x007AFF, 43, -5, 0x007AFF, 47, -5, 0x007AFF, 47, 2, 0x007AFF, 47, 11, 0x007AFF }, 90, 437, 665, 484, 681);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        cicky(x,y,50);   --点击关闭
        mSleep(1500)
    end
    return page_array["page_xiaoxi"]:enter()
end


--step1 第一步
function tongxunlu_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
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
    return check_page_tongxunlu()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function tongxunlu_page:action()
    return action_tongxunlu()
end

page_array["page_tongxunlu"] = tongxunlu_page:new()
--end page_tongxunlu.lua
------------------end:  page\qq_main\page_tongxunlu.lua-------------------------------------




----------------------begin:  page\qq_main\page_tencent_news.lua---------------------------------

default_tencent_news_page = {
    page_name = "tencent_news_page",
    page_image_path = nil
}

tencent_news_page = class_base_page:new(default_tencent_news_page);

---qq腾讯新闻界面
local function check_page_tencent_news()
    x, y = findMultiColorInRegionFuzzy({ 0xABADBB, 52, 4, 0xFFFFFF, 33, 25, 0xABADBB, 6, 14, 0xABADBB, 15, 2, 0xABADBB, -6, 6, 0xABADBB, 9, 27, 0xABADBB, 28, 22, 0xABADBB, 26, 12, 0xABADBB, 13, 34, 0xABADBB, 274, 4, 0xEAEAEA, 284, 17, 0x434343, 289, 17, 0x8F8F8F, 358, 17, 0x767676, 394, 14, 0x767676, 401, 19, 0x1A1A1A, 358, 12, 0xAAAAAA, 412, -3, 0xFFFFFF, 391, 15, 0x848484, 286, 12, 0xDCDCDC, 204, 3, 0xFFFFFF, 131, -12, 0xFFFFFF, 93, -23, 0xFFFFFF, 23, -10, 0xFFFFFF, 4, 14, 0xABADBB, 170, 28, 0xFFFFFF, 221, -3, 0xFFFFFF, 388, -1, 0xFFFFFF, 472, 0, 0xFFFFFF, 559, 4, 0xFFFFFF, 547, 35, 0xFFFFFF, 440, 28, 0xFFFFFF, 463, 3, 0xFFFFFF }, 90, 29, 1057, 594, 1115);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----腾讯新闻界面1-7.0---");
        return true
    else
        return false
    end
end

local function action_tencent_news() --执行这个页面的操作--
    if gongneng == "group_message_add_friends" or gongneng == "reply_friends_message" then
        move(300,math.random(200,450),300,math.random(600,900),5)
        mSleep(1000)
        local yy = math.random(150,1000)
        cicky( 324,yy,50);
        mSleep(4000)
        local num_hua = math.random(3)
        for i=1,num_hua do
            xiahua()
            mSleep(math.random(999,2222))
        end
        for i=1,num_hua do
            shanghua()
            mSleep(math.random(999,2222))
        end
        cicky(52,86,50)  --返回
        mSleep(1500)
        if page_array["page_tencent_news"]:quick_check_page() == true then
            mSleep(500)
            cicky(60,80,50);   --点击返回
        elseif page_array["page_xiaoxi"]:quick_check_page() == true then
            mSleep(100)
        else
            return page_array["page_main"]:enter()
        end
        mSleep(1500)
        move( 504,222, 100,222,8);   --滑动删除
        mSleep(1000)
        cicky(593,216,50);   --点击删除
        mSleep(1500)
        return page_array["page_xiaoxi"]:enter()
    else
        cicky(52,86,50)
        mSleep(1500)
        page_array["page_xiaoxi"]:enter()
    end
end


--step1 第一步
function tencent_news_page:enter()        --进入页面后的动作--
    if  true == check_page_suoping() then
        return action_suoping();
    elseif true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function tencent_news_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_tencent_news() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function tencent_news_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_tencent_news()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function tencent_news_page:action()
    return action_tencent_news()
end

page_array["page_tencent_news"] = tencent_news_page:new()
--end page_tencent_news.lua
------------------end:  page\qq_main\page_tencent_news.lua-------------------------------------




----------------------begin:  page\page_search_add\page_add_contacts.lua---------------------------------

default_add_contacts_page = {
    page_name = "add_contacts_page",
    page_image_path = nil
}

add_contacts_page = class_base_page:new(default_add_contacts_page);

---添加联系人界面
local function check_page_add_contacts()
   x, y = findMultiColorInRegionFuzzy({ 0x26BDF6, 10, 0, 0xB8EAFC, 47, 0, 0x12B7F5, 61, 0, 0x12B7F5, 62, 14, 0x12B7F5, 62, 19, 0x12B7F5, 8, 26, 0x12B7F5, 33, 22, 0x12B7F5, 44, 21, 0xD9F3FD, 57, 21, 0xFFFFFF, 58, 14, 0x6AD2F9, 64, 14, 0x12B7F5, -5, 4, 0x12B7F5, -5, 23, 0x12B7F5, 33, 5, 0x95DFFB, 50, 5, 0x70D4F9, 57, 7, 0x12B7F5, -276, 1, 0x12B7F5, -277, 12, 0x12B7F5, -261, -7, 0x12B7F5, -262, 15, 0x12B7F5, -262, 22, 0xE7F8FE, -262, 30, 0x12B7F5, 301, 4, 0x12B7F5, 313, 2, 0x12B7F5, 330, 13, 0x12B7F5, 306, 26, 0x12B7F5, 289, -9, 0x12B7F5, 107, 13, 0x12B7F5, 80, 18, 0x12B7F5, -18, 11, 0x12B7F5, -21, 3, 0x12B7F5 }, 90, 13, 63, 620, 102);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---搜索添加1界面-7.0-8.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x6ED1F6, -5, 17, 0x6ED1F6, 29, 33, 0x6ED1F6, 82, 22, 0x6ED1F6, 112, 14, 0x6ED1F6, 111, -8, 0x6ED1F6, 14, -16, 0x6ED1F6, 78, 8, 0xFCFEFF, 114, 8, 0x6ED1F6, 74, 12, 0x70D2F6, 12, -14, 0x6ED1F6, 96, -3, 0x6ED1F6, 108, 16, 0x77D4F7, 273, 7, 0x6ED1F6, 285, 27, 0x6ED1F6, 289, -8, 0x6ED1F6, 331, 3, 0x6ED1F6, 296, 11, 0x6ED1F6, 57, 98, 0xFFFFFF, 105, 99, 0xFFFFFF, 62, 71, 0xFFFFFF, 92, 109, 0x00A5E0, 331, 86, 0xFFFFFF, 292, 93, 0xB2B2B2, 289, 94, 0xFEFEFE, 289, 94, 0xFEFEFE, 523, 15, 0x6ED1F6, 532, 4, 0x6ED1F6, 542, 4, 0x6ED1F6 }, 90, 17, 54, 564, 179);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("---搜索添加2界面-7.0---");
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, -4, 14, 0x58CCF8, 11, 27, 0xE7F8FE, 40, 25, 0x64D0F8, 46, 0, 0xFFFFFF, 28, -10, 0x12B7F5, 18, 9, 0x12B7F5, 39, 22, 0x12B7F5, 48, 3, 0x68D1F9, 45, 15, 0x12B7F5, 74, 19, 0x12B7F5, 75, -2, 0xAAE5FB, 65, 9, 0x12B7F5, 104, -3, 0x12B7F5, 112, 24, 0x12B7F5, 126, 9, 0x12B7F5, 108, -10, 0x12B7F5, 109, 3, 0x86DAFA, 299, -6, 0x12B7F5, 341, -8, 0x12B7F5, 326, 23, 0xFFFFFF, 278, 21, 0x12B7F5, 321, 7, 0x12B7F5, 275, 21, 0xFFFFFF, 291, -1, 0xFFFFFF, 319, 11, 0xFFFFFF, 321, 13, 0x12B7F5, 355, 13, 0x12B7F5, 569, -6, 0x12B7F5, 565, 10, 0x12B7F5, 580, 8, 0x12B7F5, 574, -16, 0x12B7F5, 558, 15, 0x12B7F5, 581, 10, 0x12B7F5, 573, 0, 0x12B7F5 }, 90, 18, 56, 603, 99);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("---搜索添加界面1-9.0---")
                return true
            else
                x, y = findMultiColorInRegionFuzzy({ 0x34C0F5, 7, 21, 0x34C0F5, 41, 33, 0x34C0F5, 88, 32, 0x34C0F5, 119, 24, 0x34C0F5, 128, 20, 0x54CAF7, 93, -9, 0x34C0F5, 32, -11, 0x34C0F5, 23, -2, 0xE6F7FE, 91, 9, 0x7FD7F9, 112, 9, 0x34C0F5, 281, 15, 0xB9E9FC, 332, 25, 0xE8F8FE, 323, -2, 0x34C0F5, 277, -2, 0xADE6FB, 351, 12, 0x34C0F5, 575, 10, 0x34C0F5, 613, 15, 0x34C0F5, 537, 30, 0x34C0F5, 533, 5, 0x34C0F5, 593, -4, 0x34C0F5, 608, 29, 0x34C0F5, 557, 17, 0x34C0F5, 571, 9, 0x34C0F5 }, 90, 14, 60, 627, 104);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    log_info("---搜索添加界面2-9.0---")
                    return true
                else
                    return false
                end
            end
        end
    end
end

local function action_add_contacts() --执行这个页面的操作--
    if gongneng == "add_friends" or gongneng == "add_group" then
        cicky(108,303,50);  --点击搜索
        mSleep(1000)
        page_array["page_input_search"]:enter()
    else
        cicky(60,80,50);
        mSleep(1000)
        page_array["page_lianxiren"]:enter()
    end
end


--step1 第一步
function add_contacts_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function add_contacts_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_add_contacts() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function add_contacts_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_add_contacts()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function add_contacts_page:action()
    return action_add_contacts()
end

page_array["page_add_contacts"] = add_contacts_page:new()
--end page_add_contacts.lua
------------------end:  page\page_search_add\page_add_contacts.lua-------------------------------------




----------------------begin:  page\page_search_add\page_input_search.lua---------------------------------

default_input_search_page = {
    page_name = "input_search_page",
    page_image_path = nil
}

input_search_page = class_base_page:new(default_input_search_page);

---搜索输入界面
local function check_page_input_search()
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 34, 1, 0xF7F7F7, 63, 5, 0xFFFFFF, 50, 32, 0xFFFFFF, 26, 37, 0xFFFFFF, 2, 16, 0x7F7F7F, 24, 9, 0x7F7F7F, 38, 9, 0xFFFFFF, 20, 19, 0x858585, 29, 9, 0xFFFFFF, 51, 9, 0x7F7F7F, -45, 1, 0xEEEFF3, -34, 26, 0xEEEFF3, -67, 7, 0xEEEFF3, -111, 5, 0xEEEFF3, -161, 5, 0xEEEFF3, -204, 7, 0xA6A6A6, -218, 18, 0xEEEFF3, -238, 4, 0xEEEFF3, -218, 31, 0xEEEFF3, -206, 16, 0xBDBDBE, -255, 9, 0xEEEFF3, -282, 19, 0xA6A6A6, -274, 13, 0xEEEFF3, -311, 25, 0xD6D6D9, -300, 14, 0xEEEFF3, -349, 12, 0xEEEFF3, -339, 10, 0xEEEFF3, -381, 10, 0xEEEFF3, -392, 25, 0xDEDFE2, -370, 15, 0xDEDFE2, -418, 8, 0xEEEFF3, -431, 10, 0xEEEFF3, -441, 20, 0xEEEFF3, -436, 9, 0xEEEFF3, -420, 9, 0xEEEFF3 }, 90, 119, 66, 623, 103);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----搜索输入界面-7.0----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0xA6A6A6, 27, 0, 0xEEEFF3, 64, 1, 0xEEEFF3, 83, 1, 0xEEEFF3, 136, 1, 0xD2D2D5, 208, 1, 0xEEEFF3, 246, 2, 0xEEEFF3, 254, 2, 0xB7B7B8, 255, 17, 0xEEEFF3, 255, 17, 0xEEEFF3, 236, 20, 0xEEEFF3, 140, 18, 0xEEEFF3, 89, 17, 0xEEEFF3, 13, 17, 0xEEEFF3, -10, 17, 0xEDEEF2, -19, 11, 0xEEEFF3, -22, 7, 0xEEEFF3, -12, 7, 0xA6A6A6, 23, 8, 0xBBBBBC, 57, 8, 0xEEEFF3, 112, 8, 0xA6A6A6, 181, 8, 0xA6A6A6, 228, 8, 0xEEEFF3, 255, 7, 0xB9B9BA, 485, -1, 0xFFFFFF, 507, 0, 0x7F7F7F, 494, 19, 0x888888, 463, 9, 0xFFFFFF, 514, 2, 0xFFFFFF, 507, 14, 0xBFBFBF, 484, 14, 0xFFFFFF }, 90, 87, 74, 623, 95);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----搜索输入界面-8.0----");
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0xB5B5B6, 47, 0, 0xEEEFF3, 152, 0, 0xB0B0B0, 221, 1, 0xEEEFF3, 263, 4, 0xBCBCBD, 266, 15, 0xADADAE, 219, 21, 0xE8E9ED, 185, 21, 0xEEEFF3, 114, 21, 0xEEEFF3, 47, 21, 0xEEEFF3, 16, 14, 0xE4E5E9, 10, 11, 0xEEEFF3, 127, 6, 0xEEEFF3, 182, 13, 0xEEEFF3, 240, 13, 0xEEEFF3, 481, -3, 0xFFFFFF, 505, 2, 0xCCCCCC, 495, 20, 0xC7C7C7, 452, 12, 0x7F7F7F, 451, 4, 0x7F7F7F }, 90, 110, 72, 615, 96);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("----搜索输入界面-9.0----");
                return true
            else
                return false
            end
        end
    end
end
local function action_input_search() --执行这个页面的操作--
    if gongneng == "add_friends" then  --添加朋友
        if text_frirnds_info ~= nil and text_frirnds_info[1] ~= nil then
            inputText(text_frirnds_info[math.random(#text_frirnds_info)])     --输入人信息搜索
        else
            qq_warning_info("没有添加好友信息，搜索不了")
            return false
        end
        mSleep(1500)
        cicky( 123,161,50);    --点击找人
        mSleep(4000)
        if page_array["page_application_jiahaoyou"]:check_page() == true then
            return page_array["page_application_jiahaoyou"]:action()
        else
            ---搜索人结果
            x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 21, 1, 0xFFFFFF, 41, 1, 0xFFFFFF, 55, 12, 0x7F7F7F, 42, 41, 0xFFFFFF, 12, 27, 0xF6F6F6, 32, 10, 0xFEFEFE, 53, 11, 0x7F7F7F, 54, 14, 0xD9D9D9, -514, -2, 0xFFFFFF, -534, 14, 0xFFFFFF, -510, 26, 0xFFFFFF, -511, 19, 0xFFFFFF, -525, 4, 0xFFFFFF, -525, 4, 0xFFFFFF, -512, 22, 0xFFFFFF, -516, 21, 0xFDFDFD, -526, 1, 0xFFFFFF }, 90, 29, 65, 618, 108);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
               cicky( 169,242,50);   --点击第一个
               mSleep(1000)
               return page_array["page_application_jiahaoyou"]:enter()
            end
            qq_warning_info("搜索好友没结果或者网卡了")
            mSleep(1000)
            cicky( 595,78,50);   --点击取消
            mSleep(1000)
            return false
        end
    elseif gongneng == "add_group"  then  --添加群
        --输入群信息搜索
        if text_appoint_group_info ~= nil and text_appoint_group_info[1] ~= nil 
            and gong_neng == "appoint_group" then
            inputText(text_appoint_group_info[math.random(#text_appoint_group_info)])  
        elseif text_group_info ~= nil and text_group_info[1] ~= nil then
            inputText(text_group_info[math.random(#text_group_info)])   
        else
            qq_warning_info("没有添加群信息，搜索不了")
            return false
        end  
        mSleep(1500)
        cicky( 143,269,50);   --点击找群
        mSleep(2000)
        for i=1,8 do
            if page_array["page_sq_result"]:quick_check_page() == true then
                return page_array["page_sq_result"]:action()
            elseif page_array["page_application_jiaqun"]:quick_check_page() == true then
                return page_array["page_application_jiaqun"]:action()
            end
            mSleep(1000)
        end
        qq_warning_info("搜索群没结果或者网卡了")
        mSleep(1000)
        cicky(60,80,50)  --点击返回
        mSleep(1000);
        cicky( 595,78,50);   --点击取消
        mSleep(1000)
        return false
    else
        cicky( 595,78,50);   --点击取消
        mSleep(1000)
        page_array["page_lianxiren"]:enter()
    end
end


--step1 第一步
function input_search_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function input_search_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_input_search() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function input_search_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_input_search()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function input_search_page:action()
    return action_input_search()
end

page_array["page_input_search"] = input_search_page:new()
--end page_input_search.lua
------------------end:  page\page_search_add\page_input_search.lua-------------------------------------




----------------------begin:  page\page_add_friends\page_application_jiahaoyou.lua---------------------------------

default_application_jiahaoyou_page = {
    page_name = "application_jiahaoyou_page",
    page_image_path = nil
}

application_jiahaoyou_page = class_base_page:new(default_application_jiahaoyou_page);

---搜到人界面
local function check_page_application_jiahaoyou()
    x, y = findMultiColorInRegionFuzzy({ 0x1EB9F2, 73, 9, 0x1EB9F2, 79, 20, 0xF1FBFE, 8, 28, 0x1EB9F2, 1, 12, 0x1EB9F2, 38, 10, 0x28BCF3, 279, 7, 0x1EB9F2, 209, 29, 0x1EB9F2, -62, 2, 0x1EB9F2, -134, -19, 0x1EB9F2, -147, 12, 0x1EB9F2, 26, 14, 0x1EB9F2, 23, 1, 0x1EB9F2, 7, -2, 0x1EB9F2, 51, 18, 0x1EB9F2 }, 90, 132, 1042, 558, 1090);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---- 搜索到加好友界面7.0----");
        return true
    else
        return false
    end
end


local function action_application_jiahaoyou() --执行这个页面的操作--
    if gongneng == "add_friends" then  --加好友
        cicky( 329,1080,50)   --点击加好友
        mSleep(1500);
        page_array["page_shy_add_verification"]:enter()
    else
        cicky(60,80,50);  --返回
        mSleep(1500)
        --多个选择
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 21, 1, 0xFFFFFF, 41, 1, 0xFFFFFF, 55, 12, 0x7F7F7F, 42, 41, 0xFFFFFF, 12, 27, 0xF6F6F6, 32, 10, 0xFEFEFE, 53, 11, 0x7F7F7F, 54, 14, 0xD9D9D9, -514, -2, 0xFFFFFF, -534, 14, 0xFFFFFF, -510, 26, 0xFFFFFF, -511, 19, 0xFFFFFF, -525, 4, 0xFFFFFF, -525, 4, 0xFFFFFF, -512, 22, 0xFFFFFF, -516, 21, 0xFDFDFD, -526, 1, 0xFFFFFF }, 90, 29, 65, 618, 108);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(597,84,50);   --点击取消
            mSleep(1000)
            return page_array["page_add_contacts"]:enter()
        end
        cicky(597,84,50);   --点击取消
        mSleep(1000)
        page_array["page_add_contacts"]:enter()
    end
end


--step1 第一步
function application_jiahaoyou_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function application_jiahaoyou_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_application_jiahaoyou() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function application_jiahaoyou_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_application_jiahaoyou()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function application_jiahaoyou_page:action()
    return action_application_jiahaoyou()
end

page_array["page_application_jiahaoyou"] = application_jiahaoyou_page:new()
--end page_application_jiahaoyou.lua
------------------end:  page\page_add_friends\page_application_jiahaoyou.lua-------------------------------------




----------------------begin:  page\page_add_friends\page_shy_add_verification.lua---------------------------------

default_shy_add_verification_page = {
    page_name = "shy_add_verification_page",
    page_image_path = nil
}

shy_add_verification_page = class_base_page:new(default_shy_add_verification_page);

---搜加好友验证界面
local function check_page_shy_add_verification()
    x, y = findMultiColorInRegionFuzzy({ 0x6ED1F6, 8, 11, 0xF0FAFE, 30, 24, 0x6ED1F6, 69, 19, 0x6ED1F6, 100, 7, 0x6ED1F6, 98, -1, 0xB3E7FA, 53, -4, 0x6ED1F6, 42, -1, 0x6ED1F6, 57, 10, 0xFFFFFF, 88, 19, 0x6ED1F6, 66, 2, 0x6ED1F6, 19, 3, 0x6ED1F6, 244, -3, 0x80D7F7, 341, -3, 0x6ED1F6, 348, -1, 0xFFFFFF, 366, 15, 0xE0F5FD, 300, 27, 0x6ED1F6, 253, 16, 0x6ED1F6, 258, 6, 0x6ED1F6, 331, -2, 0xFFFFFF, 351, 5, 0xF5FCFE, 531, 1, 0x72D2F6, 564, 21, 0x6ED1F6, 606, 10, 0x85D8F7, 596, -4, 0xFFFFFF, 548, -10, 0x6ED1F6, 526, -4, 0x90DCF8, 577, 1, 0x6ED1F6, 606, 9, 0xECF9FE, 600, 12, 0x6FD1F6 }, 90, 13, 66, 619, 103);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---- 搜索加好友验证界面1-7.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 8, 3, 0xFFFFFF, 12, 3, 0x12B7F5, 20, 3, 0xFEFFFF, 30, 3, 0x12B7F5, 50, 4, 0xD6F3FD, 81, 4, 0xDDF5FE, 119, 7, 0x75D5F9, 136, 8, 0x12B7F5, 137, 10, 0x12B7F5, 119, 16, 0x7AD7F9, 108, 16, 0x80D8FA, 57, 16, 0x12B7F5, 17, 14, 0x30C0F6, 2, 11, 0xFFFFFF, -4, 9, 0x12B7F5, -24, 15, 0x12B7F5, 38, 30, 0x12B7F5, 79, 28, 0xFFFFFF, 116, 26, 0x12B7F5, 130, 26, 0x57CCF8, 135, 13, 0x12B7F5, 135, 8, 0x12B7F5, 78, 3, 0x15B8F5, 27, 4, 0x12B7F5, -33, 1, 0x12B7F5, 9, 23, 0xFDFEFF, 73, 36, 0x12B7F5, 137, 2, 0x12B7F5, 63, -10, 0x12B7F5, -15, -8, 0x12B7F5, 24, 7, 0xFFFFFF, 102, 21, 0x12B7F5, 139, 26, 0x12B7F5, 139, 26, 0x12B7F5 }, 90, 222, 59, 394, 105);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("---- 搜索加好友验证界面2-7.0-8.0---");
            return true
        else
            return false
        end
    end 
end


local function action_shy_add_verification() --执行这个页面的操作--
    if gongneng == "add_friends" then  --加好友
        if text_shy_verification ~= nil and text_shy_verification[1] ~= nil then
            cicky(598,971,2000)   --点击叉叉删除
            mSleep(500);
            inputText(text_shy_verification[math.random(#text_shy_verification)]);  --输入验证消息内容
        else
            qq_warning_info("没有验证内容")
        end
        mSleep(1000)
        cicky( 558,82,50);  --点击下一步
        mSleep(1500)
        page_array["page_shy_send_verification"]:enter()
    else
        cicky(60,80,50);
        mSleep(1000)
        page_array["page_application_jiahaoyou"]:enter()
    end
end


--step1 第一步
function shy_add_verification_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function shy_add_verification_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_shy_add_verification() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function shy_add_verification_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_shy_add_verification()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function shy_add_verification_page:action()
    return action_shy_add_verification()
end

page_array["page_shy_add_verification"] = shy_add_verification_page:new()
--end page_shy_add_verification.lua
------------------end:  page\page_add_friends\page_shy_add_verification.lua-------------------------------------




----------------------begin:  page\page_add_friends\page_shy_send_verification.lua---------------------------------

default_shy_send_verification_page = {
    page_name = "shy_send_verification_page",
    page_image_path = nil
}

shy_send_verification_page = class_base_page:new(default_shy_send_verification_page);

---搜加好友验证界面
local function check_page_shy_send_verification()
    x, y = findMultiColorInRegionFuzzy({ 0x6FD1F6, 16, 0, 0x6ED1F6, 25, 1, 0x6ED1F6, 34, 3, 0x6ED1F6, 70, 7, 0xAFE6FA, 90, 7, 0xFFFFFF, 137, 7, 0x6ED1F6, 121, 9, 0x6ED1F6, 17, 12, 0x6ED1F6, 75, 12, 0x6ED1F6, 92, 10, 0x6ED1F6, 108, 9, 0x6ED1F6, 126, 9, 0x6ED1F6, 134, 9, 0x6ED1F6, -4, 19, 0x6ED1F6, 36, 19, 0x6ED1F6, 66, 19, 0x6ED1F6, 92, 19, 0x6ED1F6, 125, 19, 0x6ED1F6, 135, 23, 0x6ED1F6, 95, 34, 0x6ED1F6, 61, 34, 0x6ED1F6, 23, 32, 0x6ED1F6, -7, 26, 0x6ED1F6, -17, 7, 0x6ED1F6, -9, 0, 0x6ED1F6, 87, -3, 0x6ED1F6, 137, -1, 0x6ED1F6, 162, 22, 0x6ED1F6, 127, 52, 0x6ED1F6, 5, 52, 0x6CCFF5, -15, 48, 0x6DD0F5, -21, 29, 0x6ED1F6, 33, -15, 0x6ED1F6, 157, -15, 0x6ED1F6 }, 90, 235, 53, 418, 120);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---- 加好友发送验证界面1-7.0----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 11, -3, 0x12B7F5, 36, 1, 0x12B7F5, 79, 2, 0x12B7F5, 114, 4, 0xFFFFFF, 131, 4, 0xD2F1FD, 148, 4, 0x12B7F5, 28, 14, 0xABE6FB, 52, 14, 0x70D4F9, 75, 13, 0x12B7F5, 101, 13, 0x12B7F5, 115, 12, 0xFFFFFF, 139, 10, 0x12B7F5, 37, 24, 0xD1F1FD, 92, 24, 0x12B7F5, 113, 23, 0x12B7F5, 130, 23, 0x12B7F5, 146, 18, 0x12B7F5, 143, -4, 0x12B7F5, -12, -11, 0x12B7F5, -17, 12, 0x12B7F5, 41, 39, 0x12B7F5, 108, 39, 0x12B7F5, 148, 26, 0x12B7F5, 158, 12, 0x12B7F5, 121, -2, 0x12B7F5, 51, -10, 0x12B7F5, 24, -10, 0x12B7F5, 47, 21, 0xFFFFFF, 112, 22, 0x12B7F5, 139, 13, 0x12B7F5 }, 90, 237, 58, 412, 108);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("---- 加好友发送验证界面2-7.0-8.0---");
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0x34C0F5, -2, 20, 0x34C0F5, 34, 29, 0x34C0F5, 140, 13, 0x34C0F5, 154, 1, 0xFFFFFF, 126, -7, 0x34C0F5, 65, -7, 0x34C0F5, 51, -1, 0x34C0F5, 37, 5, 0x34C0F5, 111, 14, 0xFFFFFF, 138, 6, 0xFFFFFF, 266, -8, 0x34C0F5, 331, -8, 0x34C0F5, 350, 0, 0xBBEAFC, 349, 20, 0xFFFFFF, 296, 29, 0x34C0F5, 220, 12, 0x34C0F5, 276, 1, 0xFFFFFF, 320, 1, 0x34C0F5, 355, -1, 0xFFFFFF, 374, 12, 0x34C0F5, 553, 4, 0x34C0F5, 597, 15, 0xDFF5FD, 596, -1, 0xFFFFFF, 574, -7, 0x34C0F5, 546, 5, 0x34C0F5, 571, 17, 0x34C0F5, 467, 11, 0x34C0F5, 493, -8, 0x34C0F5 }, 90, 17, 67, 616, 104);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("---- 加好友发送验证界面9.0----");
                return true
            else
                return false
            end
        end
    end
end

local function action_shy_send_verification() --执行这个页面的操作--
    if gongneng == "add_friends" then  --加好友
        cicky( 577,84,50);   --点击发送
        mSleep(5000)
         ---搜索添加人结果
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 21, 1, 0xFFFFFF, 41, 1, 0xFFFFFF, 55, 12, 0x7F7F7F, 42, 41, 0xFFFFFF, 12, 27, 0xF6F6F6, 32, 10, 0xFEFEFE, 53, 11, 0x7F7F7F, 54, 14, 0xD9D9D9, -514, -2, 0xFFFFFF, -534, 14, 0xFFFFFF, -510, 26, 0xFFFFFF, -511, 19, 0xFFFFFF, -525, 4, 0xFFFFFF, -525, 4, 0xFFFFFF, -512, 22, 0xFFFFFF, -516, 21, 0xFDFDFD, -526, 1, 0xFFFFFF }, 90, 29, 65, 618, 108);
         if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky( 583,87,50);  --点击取消
            mSleep(1000)
            return true
        end
        --发消息搜索人结果
        x, y = findMultiColorInRegionFuzzy({ 0xABABAB, 39, 1, 0xFFFFFF, 41, 1, 0xDDDDDD, 53, 4, 0xFFFFFF, -5, 8, 0xFFFFFF, 27, 8, 0x7F7F7F, 48, 9, 0xFFFFFF, 49, 11, 0xB7B7B7, -2, 17, 0xFFFFFF, 32, 17, 0xFFFFFF, 41, 19, 0xFAFAFA, -5, 23, 0xFFFFFF, 25, 21, 0xFFFFFF, 35, 21, 0x7F7F7F }, 90, 564, 70, 622, 93);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);  --点击取消
            mSleep(1000)
            return true
        end
    elseif gongneng =="group_add_friends" or gongneng == "group_message_add_friends" then
        cicky(577,84,50);   --点击发送
        mSleep(5000)
        if page_array["page_group_member_data"]:check_page() == true then
            cicky(60,80,50);  --点击返回
            mSleep(1500)
            if page_array["page_group_message"]:quick_check_page() == true then
                gongneng = "del_message"  --删除消息
                return page_array["page_group_message"]:action()
            end
            return false
        end
        return false
    else
        cicky(60,80,50);
        mSleep(1500)
        if page_array["page_shy_add_verification"]:quick_check_page() == true then
            page_array["page_shy_add_verification"]:action()
        elseif page_array["page_qhy_add_verification"]:quick_check_page() == true then
            page_array["page_qhy_add_verification"]:action()
        end
    end
end


--step1 第一步
function shy_send_verification_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function shy_send_verification_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_shy_send_verification() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function shy_send_verification_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_shy_send_verification()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function shy_send_verification_page:action()
    return action_shy_send_verification()
end

page_array["page_shy_send_verification"] = shy_send_verification_page:new()
--end page_shy_send_verification.lua
------------------end:  page\page_add_friends\page_shy_send_verification.lua-------------------------------------




----------------------begin:  page\page_hair_message_frineds\page_friends_chat.lua---------------------------------

default_friends_chat_page = {
    page_name = "friends_chat_page",
    page_image_path = nil
}

friends_chat_page = class_base_page:new(default_friends_chat_page);

---qq好友聊天界面
local function check_page_friends_chat()
    x, y = findMultiColorInRegionFuzzy({ 0xF0FAFE, 10, 14, 0x6ACDF2, 5, 26, 0x6ACDF2, -8, 26, 0x79D2F3, -9, 35, 0x6ACDF2, 22, 39, 0xF0FAFE, 26, 21, 0x6ACDF2, 13, 5, 0x6ACDF2, -5, 1, 0x6ACDF2, -14, 18, 0x6ACDF2, 32, 30, 0x6ACDF2, 22, 22, 0x6ACDF2, -566, 3, 0x6ACDF2, -572, 19, 0xECF9FD, -553, 33, 0xF0FAFE, -544, 34, 0x6ACDF2, -523, 4, 0xFFFFFF, -492, 3, 0xEFFAFE, -486, 7, 0x6ACDF2, -515, 24, 0xF0FAFE, -534, 20, 0xFFFFFF, -531, 10, 0x6ACDF2, -502, 14, 0xC8EDFA, -498, 16, 0x6ACDF2, -88, 7, 0x6ACDF2, -63, 24, 0xF0FAFE, -53, 31, 0xEFFAFE, -56, 30, 0xA1DFF7, -70, 5, 0x6ACDF2, -20, 7, 0x6ACDF2, 1, 17, 0xE9F8FD, 1, 24, 0xF0FAFE }, 90, 18, 66, 622, 105);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq好友聊天界面1-7.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 4, 24, 0xE8F8FE, 20, 32, 0xE8F8FE, 31, 38, 0x12B7F5, 39, 41, 0x5ECEF8, 79, 29, 0x12B7F5, 95, 9, 0x12B7F5, 110, 17, 0xE8F8FE, 115, 40, 0x12B7F5, 93, 42, 0x2BBFF6, 89, 17, 0xE8F8FE, 113, 8, 0x12B7F5, 124, 16, 0x12B7F5, 110, 48, 0x12B7F5, 78, 23, 0x12B7F5, 52, 17, 0x12B7F5, 22, 6, 0x12B7F5, 7, 5, 0x98E0FB, 12, 32, 0x45C7F7, 51, 39, 0x12B7F5, 56, 29, 0x12B7F5, 20, 4, 0x12B7F5, 47, 2, 0x12B7F5, 101, 2, 0xD3F2FD, 117, 1, 0x12B7F5, 126, 6, 0x12B7F5, 125, 38, 0x12B7F5, 83, 49, 0x12B7F5, 46, 34, 0x12B7F5, 10, 15, 0x34C1F6, 9, 14, 0x12B7F5, 6, 7, 0x12B7F5, 4, 2, 0xE8F8FE, 10, 26, 0x12B7F5, 49, 36, 0x12B7F5 }, 90, 497, 60, 623, 109);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----qq好友聊天界面2-7.0---");
            return true
        else
            return false
        end
    end
end

local function action_friends_chat() --执行这个页面的操作--
    if gongneng == "hair_message_friends" or gongneng == "reply_friends_message" then
        move(300,150,300,350,7)  --滑动一下
        mSleep(1500)
        cicky( 145,1003,50);   --点击输入框  发送消息
        mSleep(math.random(1500,3500))
        for i=1,math.random(2) do
            if text_message_info ~= nil and text_message_info[1] ~= nil then
                inputText(text_message_info[math.random(#text_message_info)])
            end
            mSleep(1500);
            cicky( 589,1080,50);   --点击发送
            mSleep(math.random(2888,5555))
        end
        cicky(  52,655,50);  --点击语言
        mSleep(1000)
        for i=1,math.random(2) do
            cicky( 292,880,math.random(2000,8000))  --长按语音
            mSleep(math.random(2888,5555))
        end
        cicky(60,80,50);  --点击返回
        mSleep(1500)
        if gongneng == "reply_friends_message" then
            move( 504,222, 100,222,8);   --滑动删除
            mSleep(1000)
            cicky(593,216,50);   --点击删除
            mSleep(1500)
            return page_array["page_xiaoxi"]:enter()
        end
    else
        cicky(60,80,50);  --点击返回
        mSleep(1500)
        if page_array["page_lianxiren"]:quick_check_page() == true then
            return page_array["page_lianxiren"]:action()
        end
        cicky( 595,83,50) --点击取消
        mSleep(1000)
        page_array["page_lianxiren"]:enter()
    end
end


--step1 第一步
function friends_chat_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function friends_chat_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_friends_chat() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function friends_chat_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_friends_chat()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function friends_chat_page:action()
    return action_friends_chat()
end

page_array["page_friends_chat"] = friends_chat_page:new()
--end page_friends_chat.lua
------------------end:  page\page_hair_message_frineds\page_friends_chat.lua-------------------------------------




----------------------begin:  page\page_add_group\page_application_jiaqun.lua---------------------------------

default_application_jiaqun_page = {
    page_name = "application_jiaqun_page",
    page_image_path = nil
}

application_jiaqun_page = class_base_page:new(default_application_jiaqun_page);

---搜到群添加界面
local function check_page_application_jiaqun()
    x, y = findMultiColorInRegionFuzzy({ 0x1EB9F2, 139, 0, 0x1EB9F2, 160, 4, 0x1EB9F2, 93, 25, 0x1EB9F2, 2, 8, 0x1EB9F2, 101, -8, 0x1EB9F2, 125, 0, 0x69D0F6, 105, 6, 0xFFFFFF, 57, 3, 0xFFFFFF, -133, 7, 0x1EB9F2, -2, 19, 0x1EB9F2, 203, 12, 0x1EB9F2, 281, -4, 0x1EB9F2, 316, 8, 0x1EB9F2, 253, 23, 0x1EB9F2, 172, 10, 0x1EB9F2, -28, 3, 0x1EB9F2, -179, 4, 0x1EB9F2 }, 90, 73, 1063, 568, 1096);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----搜到群添加界面-7.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x1EB9F2, 41, 5, 0x1EB9F2, 85, 7, 0x1EB9F2, 111, 7, 0xFFFFFF, 119, 16, 0x1EB9F2, 120, 33, 0x1EB9F2, 55, 36, 0x1EB9F2, 8, 30, 0x1EB9F2, -6, 24, 0x1EB9F2, 54, 12, 0xFFFFFF, 97, 27, 0xFFFFFF, 128, 20, 0xFFFFFF, 134, 16, 0x1EB9F2, 260, 12, 0x1EB9F2, 307, 27, 0x1EB9F2, 143, 21, 0x1EB9F2, 163, 11, 0x1EB9F2, -112, 33, 0x1EB9F2, -45, 17, 0x1EB9F2, -188, 0, 0x1EB9F2, -191, 0, 0x1EB9F2, -124, 11, 0x1EB9F2 }, 90, 61, 1059, 559, 1095);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----搜到群添加界面-9.0---");
            return true
        else
            return false
        end
    end
end


local function action_application_jiaqun() --执行这个页面的操作--
    if gongneng == "add_group" then  --添加群
        cicky( 352,1078,50);   --点击申请入群
        mSleep(2000)
        if page_array["page_sq_send_verification"]:check_page() == true then
            page_array["page_sq_send_verification"]:action()
        elseif page_array["page_group_message"]:check_page() == true then --不需要验证
            cicky(60,80,50);  --返回
            mSleep(1000)
            return true
        else
            cicky(60,80,50);  --返回
            mSleep(1500)
            cicky( 593,83,50);  --点击取消
            mSleep(1000)
            return true
        end
    else
        cicky(68,82,50);   --点击返回
        mSleep(1500)
        if page_array["page_sq_result"]:quick_check_page() == true then
            return page_array["page_sq_result"]:action()
        end
        cicky( 593,83,50);  --点击取消
        mSleep(1000)
        page_array["page_add_contacts"]:enter()
    end
end

--step1 第一步
function application_jiaqun_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function application_jiaqun_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_application_jiaqun() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function application_jiaqun_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_application_jiaqun()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function application_jiaqun_page:action()
    return action_application_jiaqun()
end

page_array["page_application_jiaqun"] = application_jiaqun_page:new()
--end page_application_jiaqun.lua
------------------end:  page\page_add_group\page_application_jiaqun.lua-------------------------------------




----------------------begin:  page\page_add_group\page_sq_result.lua---------------------------------

default_sq_result_page = {
    page_name = "sq_result_page",
    page_image_path = nil
}

sq_result_page = class_base_page:new(default_sq_result_page);

---搜群结果界面
local function check_page_sq_result()
   x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 9, 0, 0xE3F6FD, 12, 0, 0xFFFFFF, 20, 0, 0xEBF9FE, 51, 0, 0x6ED1F6, 87, 1, 0xE7F7FE, 107, 1, 0x6FD1F6, 120, 2, 0x6ED1F6, 122, 3, 0x6ED1F6, 113, 12, 0x73D2F6, 59, 16, 0x6ED1F6, 32, 16, 0xF9FDFF, 12, 11, 0xFFFFFF, -8, 2, 0x6ED1F6, -20, -4, 0x6ED1F6, -41, -5, 0x6ED1F6, -47, 12, 0x6ED1F6, 41, 22, 0x6ED1F6, 66, 21, 0x6ED1F6, 107, 21, 0xFFFFFF, 138, 10, 0x6ED1F6, 138, -1, 0x6ED1F6, 67, -7, 0x6ED1F6, -30, -7, 0x6ED1F6, -35, 16, 0x6ED1F6, 160, 20, 0x6ED1F6, 216, 17, 0x6ED1F6, 352, 0, 0x6ED1F6, 338, 20, 0x6ED1F6, 305, -3, 0x6ED1F6, 359, 9, 0x6ED1F6, 304, 11, 0x6ED1F6, 350, 4, 0x6ED1F6, 348, 5, 0x6ED1F6 }, 90, 209, 65, 615, 94);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----搜群结果界面2-7.0----");
        return true
    else
       x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 13, 3, 0x12B7F5, 34, 3, 0x12B7F5, 57, 3, 0x12B7F5, 78, 2, 0x12B7F5, 113, 1, 0x12B7F5, 138, 1, 0x12B7F5, 138, 1, 0x12B7F5, 122, 6, 0xFFFFFF, -16, 15, 0x12B7F5, 4, 11, 0x12B7F5, 42, 11, 0xFFFFFF, 79, 11, 0xD7F3FD, 111, 11, 0xBEEBFC, 136, 14, 0x12B7F5, 12, 18, 0xFFFFFF, -3, 16, 0x12B7F5, 25, 20, 0xFFFFFF, 100, 20, 0x12B7F5, 136, 20, 0x12B7F5, 138, 22, 0x12B7F5, 77, 29, 0xFFFFFF, 27, 26, 0x12B7F5, -9, 23, 0x12B7F5, -24, 0, 0x12B7F5, 58, -1, 0x12B7F5, 299, 9, 0x12B7F5, 347, 9, 0x12B7F5, 359, 16, 0x12B7F5, 323, 27, 0x12B7F5, 362, 16, 0x12B7F5, 356, 36, 0x12B7F5, 315, 5, 0x12B7F5, 150, 18, 0x12B7F5 }, 90, 228, 64, 614, 101);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----搜群结果界面1-7.0----");
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, -2, 19, 0xD1F1FD, 58, 33, 0x12B7F5, 103, 12, 0x12B7F5, 69, -5, 0x12B7F5, 45, 0, 0x26BDF6, 38, 9, 0x21BCF6, 95, 16, 0x12B7F5, 245, 1, 0xFFFFFF, 350, -2, 0xFFFFFF, 362, 4, 0x12B7F5, 332, 24, 0xFFFFFF, 258, 23, 0x12B7F5, 276, 9, 0x12B7F5, 341, 11, 0x15B8F5, 346, 8, 0xEBF9FE, 245, -4, 0x12B7F5, 315, 18, 0x12B7F5, 592, 0, 0x12B7F5, 590, 12, 0x12B7F5, 544, 12, 0x12B7F5, 553, 3, 0x12B7F5, 563, 19, 0x12B7F5 }, 90, 24, 67, 618, 105);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("----搜群结果界面-9.0----");
                return true
            else
                return false
            end
        end
    end
end

local function action_sq_result() --执行这个页面的操作--
    if gongneng == "add_group" then  --添加群
        mSleep(1500)
        cicky(323,232,50);   --点击第一个群
        mSleep(2000)
        page_array["page_application_jiaqun"]:enter()
    else
        cicky(68,82,50);   --点击返回
        mSleep(1500)
        cicky( 593,83,50);
        mSleep(1000)
        page_array["page_add_contacts"]:enter()
    end
end


--step1 第一步
function sq_result_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function sq_result_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_sq_result() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function sq_result_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_sq_result()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function sq_result_page:action()
    return action_sq_result()
end

page_array["page_sq_result"] = sq_result_page:new()
--end page_sq_result.lua
------------------end:  page\page_add_group\page_sq_result.lua-------------------------------------




----------------------begin:  page\page_add_group\page_sq_send_verification.lua---------------------------------

default_sq_send_verification_page = {
    page_name = "sq_send_verification_page",
    page_image_path = nil
}

sq_send_verification_page = class_base_page:new(default_sq_send_verification_page);

---加群验证界面
local function check_page_sq_send_verification()
    x, y = findMultiColorInRegionFuzzy({ 0xF0FAFE, 37, 18, 0x6ED1F6, 125, -2, 0x6ED1F6, 55, -20, 0x6ED1F6, 22, -10, 0x6ED1F6, 116, -5, 0x6ED1F6, 301, -17, 0x6ED1F6, 347, -12, 0xFFFFFF, 354, 0, 0x6ED1F6, 247, 7, 0xD4F1FC, 234, -6, 0x9FE1F9, 303, -6, 0xA3E2F9, 359, 13, 0x6ED1F6, 569, 11, 0x6ED1F6, 609, -11, 0x6ED1F6, 541, -20, 0x6ED1F6, 576, 2, 0xFFFFFF, 587, 2, 0xFAFDFF }, 90, 21, 64, 630, 102);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----加群验证界面1-7.0---");
        return true
    else   
        x, y = findMultiColorInRegionFuzzy({ 0x42C4F6, 1, 19, 0xAFE6FB, 18, 37, 0x34C0F5, 87, 27, 0x34C0F5, 100, 11, 0xA1E2FA, 69, -2, 0xFFFFFF, 33, -2, 0x90DCFA, 31, 9, 0x34C0F5, 27, 10, 0xFFFFFF, 100, 15, 0xFFFFFF, 115, 23, 0xFFFFFF, 113, 3, 0x34C0F5, 121, 0, 0x34C0F5, 240, 2, 0x34C0F5, 347, 8, 0x34C0F5, 360, 15, 0x34C0F5, 283, 26, 0xFFFFFF, 251, 6, 0xFFFFFF, 360, -5, 0x34C0F5, 240, -3, 0x34C0F5, 258, 19, 0x34C0F5, 557, 1, 0x34C0F5, 596, 3, 0x34C0F5, 564, 24, 0x34C0F5, 543, 8, 0x34C0F5, 581, -3, 0x34C0F5, 564, 19, 0x34C0F5, 528, 7, 0x34C0F5 }, 90, 28, 66, 624, 108);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----加群验证界面2-9.0---");
            return true
        else
            return false
        end
    end
end

local function action_sq_send_verification() --执行这个页面的操作--
    if gongneng == "add_group" then  --添加群
        inputText("加群");   --有的需要验证
        mSleep(1000)
        cicky( 591,85,50);  --点击发送
        mSleep(4000)
        for i=1,10 do
            --验证发送成功-7.0
            x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 230, 3, 0x12B7F5, 263, 6, 0xFFFFFF, 254, 30, 0x12B7F5, 122, 12, 0x12B7F5, 146, -2, 0x12B7F5, 273, 22, 0xD9F3FD, 281, 29, 0x12B7F5, 468, 19, 0x12B7F5, 507, 12, 0xE3F7FE, 491, -11, 0x12B7F5, 453, 2, 0x12B7F5, 491, 11, 0x12B7F5, -57, 32, 0x12B7F5, -17, 15, 0x12B7F5, -63, -6, 0x12B7F5 }, 90, 48, 59, 618, 102);
            --验证发送成功-9.0
            x2, y2 = findMultiColorInRegionFuzzy({ 0xC1ECFC, 105, 4, 0x24BCF6, 140, 10, 0x12B7F5, 88, 31, 0x12B7F5, 14, 27, 0x2FC0F6, -9, 7, 0xCFF0FD, 62, 5, 0xF4FCFF, 105, 24, 0xFFFFFF, 108, 24, 0x12B7F5, 310, -1, 0x12B7F5, 347, 2, 0xFFFFFF, 333, 37, 0x12B7F5, 292, 16, 0xFFFFFF, 325, 8, 0xA9E5FB, 284, 14, 0x12B7F5, -113, 3, 0x12B7F5, -145, 19, 0x12B7F5, 162, 8, 0x12B7F5, 214, 5, 0x12B7F5, 227, 6, 0x12B7F5 }, 90, 123, 67, 615, 105);
            if x ~= -1 or x ~= -1 then  -- 如果找到了
                cicky( 590,77,50);   --关闭
                mSleep(1500)
                cicky(60,80,50);  --点击返回
                mSleep(2000)
                cicky( 590,77,50);   --关闭
                mSleep(1500)
                return true
            end
            mSleep(1000)
        end
        gongneng = "home"  --返回微信首界面
        return page_array["page_sq_send_verification"]:enter()
    else
        cicky(60,80,50);  --点击返回
        mSleep(1000)
        page_array["page_application_jiaqun"]:enter()
    end
end


--step1 第一步
function sq_send_verification_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function sq_send_verification_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_sq_send_verification() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function sq_send_verification_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_sq_send_verification()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function sq_send_verification_page:action()
    return action_sq_send_verification()
end

page_array["page_sq_send_verification"] = sq_send_verification_page:new()
--end page_sq_send_verification.lua
------------------end:  page\page_add_group\page_sq_send_verification.lua-------------------------------------




----------------------begin:  page\page_agree_add_friends\page_new_friends_add.lua---------------------------------

default_new_friends_add_page = {
    page_name = "new_friends_add_page",
    page_image_path = nil
}

new_friends_add_page = class_base_page:new(default_new_friends_add_page);

---新的朋友界面
local function check_page_new_friends_add()
    x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 46, 1, 0x12B7F5, 71, 1, 0x12B7F5, 84, 2, 0x12B7F5, 104, 2, 0x12B7F5, -2, 14, 0x12B7F5, 28, 14, 0x51CAF8, 64, 14, 0x12B7F5, 100, 14, 0x12B7F5, 101, 14, 0x12B7F5, 6, 18, 0x83D9FA, 77, 23, 0x12B7F5, 95, 14, 0x12B7F5, 57, -1, 0x12B7F5, 3, -4, 0x12B7F5, -18, -3, 0x12B7F5, -13, 18, 0x12B7F5, 57, 20, 0x12B7F5, 96, 20, 0x12B7F5, 103, 1, 0x12B7F5, 47, -8, 0x12B7F5, -10, -8, 0x12B7F5, -12, -4, 0x12B7F5, 45, 12, 0xFFFFFF, 67, 13, 0x12B7F5, 118, 16, 0x12B7F5, 117, 16, 0x12B7F5, 13, 9, 0xD5F2FD, -1, -3, 0x12B7F5, 47, 5, 0x12B7F5, 49, 5, 0x37C2F7, 37, 19, 0xFFFFFF, 19, 15, 0xFEFFFF, 9, 13, 0xD7F3FD, 121, 38, 0x12B7F5, 121, 38, 0x12B7F5 }, 90, 254, 57, 393, 103);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----新的朋友界面1-7.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0xCBEEFC, 23, 1, 0x6ED1F6, 39, 1, 0xF0FAFE, 82, -1, 0x6ED1F6, 91, -1, 0x6ED1F6, 90, 12, 0x6ED1F6, 62, 16, 0x6ED1F6, 28, 15, 0x6ED1F6, 6, 7, 0x77D4F7, 42, 7, 0x6ED1F6, 80, 9, 0xFFFFFF, 5, -5, 0x6ED1F6, -9, 2, 0x6ED1F6, 21, 19, 0x6ED1F6, 96, 15, 0x6ED1F6, 85, 18, 0x6ED1F6, 50, 25, 0x88D9F8, -15, 12, 0x6ED1F6, -30, -1, 0x6ED1F6, -43, 5, 0x6ED1F6, 73, 32, 0x6ED1F6, 114, 21, 0x6ED1F6, 122, -1, 0x6ED1F6, 90, -3, 0x6ED1F6, 98, 22, 0x6ED1F6, 98, 22, 0x6ED1F6, 46, -1, 0xFFFFFF, -2, -3, 0x6ED1F6, -21, 6, 0x6ED1F6, 9, 16, 0x79D5F7, 64, 12, 0x6ED1F6, 125, 17, 0x6ED1F6, 79, 3, 0xFFFFFF, 26, 0, 0x6ED1F6 }, 90, 234, 67, 402, 104);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
             log_info("----新的朋友界面2-7.0---");
            return true
        else
            return false
        end
    end
end


local function action_new_friends_add() --执行这个页面的操作--
    if gongneng == "agree_friends_add_request" then  --添加群
        --没有消息1
        x1, y1 = findMultiColorInRegionFuzzy({ 0xAEAEAE, 10, 1, 0xF1F1F3, 135, 1, 0xF7F7F9, 167, 3, 0xEAEAEC, 193, 3, 0xD6D6D7, 201, 14, 0xBFBFC0, 135, 18, 0xA9A9A9, 68, 12, 0xF7F7F9, 16, 17, 0xE4E4E5, -2, 16, 0xF1F1F2, 31, 7, 0xA7A7A7, 97, 12, 0xDEDEDF, 181, 9, 0xD8D8D9, 188, 7, 0xE0E0E2, 173, -29, 0xF7F7F9, 142, -82, 0xAEAEB0, 142, -84, 0xD6D6D8, 142, -91, 0xD8D8DA, 142, -100, 0xD8D8DA, 142, -100, 0xD8D8DA }, 90, 225, 680, 428, 798);
         --没有消息2
        x2, y2 = findMultiColorInRegionFuzzy({ 0xAAAAAB, 38, 3, 0xF7F7F9, 119, 10, 0xF7F7F9, 169, 5, 0xDDDDDF, 207, 0, 0xB9B9BA, 221, 6, 0xF7F7F9, 214, 17, 0xA8A8A8, 171, 18, 0xC7C7C8, 72, 12, 0xF6F6F8, 17, 16, 0xB9B9BA, 12, 13, 0xE0E0E2, 57, 0, 0xF7F7F9, 97, 6, 0xF7F7F9, 187, 15, 0xF7F7F9, 210, 10, 0xF2F2F3, 157, -95, 0xB4B4B6, 154, -73, 0xF5F5F7, 154, -62, 0xF5F5F7, 146, -83, 0xF7F7F9, 159, -79, 0xF2F2F4, 189, -77, 0xF7F7F9 }, 90, 211, 680, 432, 793);
        --添加更多朋友
        x3, y3 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 14, 2, 0xBDBDBD, 46, 2, 0xFFFFFF, 67, 2, 0xB2B2B2, 107, 2, 0xFFFFFF, 144, 2, 0xCECECE, 158, 2, 0xFFFFFF, 153, 9, 0x838383, 126, 13, 0xADADAD, 64, 11, 0xFFFFFF, 32, 7, 0xFFFFFF, 8, 4, 0xABABAB, 0, 6, 0xA9A9A9, 46, 18, 0xFFFFFF, 79, 17, 0xFFFFFF, 125, 16, 0xFFFFFF, 143, 14, 0xC2C2C2, 143, 14, 0xC2C2C2 }, 90, 234, 500, 392, 518);
        if x1 ~= -1 or x2 ~= -1 or x3 ~= -1 then  -- 如果找到了
            mSleep(500)
            qq_warning_info("新的朋友没有消息")
            mSleep(500)
            cicky(60,80,50);  --返回联系人
            mSleep(1000)
            return false
        end
        --同意添加1
        x1, y1 = findMultiColorInRegionFuzzy({ 0x1EB9F2, 57, -1, 0x1EB9F2, 69, 1, 0x1EB9F2, 89, 3, 0x1EB9F2, 91, 5, 0x1EB9F2, 3, 11, 0x1EB9F2, 52, 16, 0x1EB9F2, 81, 17, 0x1EB9F2, 85, 15, 0x1EB9F2, 35, 22, 0x5ECDF6, 56, 23, 0x1EB9F2, 75, 24, 0x1EB9F2, 79, 25, 0x1EB9F2 }, 90, 506, 479, 597, 505);
        --同意添加2
        x2, y2 = findMultiColorInRegionFuzzy({ 0x1EB9F2, 34, 5, 0x3DC3F4, 50, 11, 0x1EB9F2, 5, 20, 0x4EC8F5, 7, 11, 0x1EB9F2, 27, 6, 0x1EB9F2, 40, 6, 0x1EB9F2, 52, 10, 0x1EB9F2, 65, 14, 0x1EB9F2, 41, 24, 0x67D0F6, -9, 18, 0x1EB9F2, -8, 10, 0x1EB9F2 }, 90, 524, 258, 598, 282);
        if x1 ~= -1 or x2 ~= -1 then  -- 如果找到了
            if x1 > 1 then
                cicky(x1,y1,50);   --点击同意
            else
                cicky(x2,y2,50);   --点击同意
            end
            mSleep(3000)
            for i=1,10 do
                --好友设置
                x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -16, 0, 0xFFFFFF, -16, -4, 0xFFFFFF, -31, -2, 0xFFFFFF, -32, -8, 0xFFFFFF, -41, -8, 0xFFFFFF, -63, -10, 0xFDFEFF }, 90, 279, 73, 342, 83);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    cicky( 595,90,50);   --点击完成
                    mSleep(2000)
                    break
                end
                mSleep(1000)
            end
        end
        mSleep(1000)
        if page_array["page_new_friends_add"]:check_page() == true then
            --好友通知
            x1, y1 = findMultiColorInRegionFuzzy({ 0x9E9E9F, 13, -1, 0xBEBEBE, 29, -1, 0xB4B4B5, 73, 1, 0xF6F6F7, 88, 1, 0xF7F7F8, 107, 1, 0xF7F7F8, 108, 3, 0xF7F7F8, 73, 16, 0xB3B3B4, 43, 10, 0xF7F7F8, 18, 5, 0xA8A8A8, 6, 5, 0xABABAB, 15, 2, 0xF7F7F8, 82, 2, 0xF7F7F8, 93, 3, 0x898989, 75, 13, 0xF7F7F8, 4, 18, 0xF7F7F8, 4, 18, 0xF7F7F8, 68, 17, 0x8E8E8F, 81, 16, 0x797979 }, 90, 32, 151, 140, 170);
            x2, y2 = findMultiColorInRegionFuzzy({ 0xF7F7F8, 29, 2, 0xF7F7F8, 52, 2, 0x969696, 72, 2, 0xF2F2F3, 100, 7, 0xB0B0B1, 86, 14, 0xF0F0F0, 39, 11, 0xB8B8B8, 21, 9, 0x787878, 5, 9, 0xB0B0B1, 23, 15, 0xF7F7F8, 68, 18, 0xF7F7F8, 86, 17, 0xF7F7F8, 105, 11, 0x949494, 58, 4, 0xECECED, 47, 12, 0x898989, 78, 10, 0xD4D4D5, 83, 8, 0xF7F7F8 }, 90, 23, 148, 128, 166);
            if x1 ~= -1 or y2 ~= -1 then  -- 如果找到了
                move( 500,270, 250,270,7);  --滑动删除
                mSleep(1500)
                cicky( 594,266,50);  --点击删除
                mSleep(1500)
                return page_array["page_new_friends_add"]:action()
            else
                move( 472,500, 166,500,7);  --滑动删除
                mSleep(1500)
                cicky( 583,504,50);  --点击删除
                mSleep(1500)
                return page_array["page_new_friends_add"]:action()
            end
        end
    else
        cicky(68,82,50);   --点击返回
        mSleep(1500)
        page_array["page_lianxiren"]:enter()
    end
end

--step1 第一步
function new_friends_add_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function new_friends_add_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_new_friends_add() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function new_friends_add_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_new_friends_add()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function new_friends_add_page:action()
    return action_new_friends_add()
end

page_array["page_new_friends_add"] = new_friends_add_page:new()
--end page_new_friends_add.lua
------------------end:  page\page_agree_add_friends\page_new_friends_add.lua-------------------------------------




----------------------begin:  page\page_group_add_friends\page_group_chat.lua---------------------------------

default_group_chat_page = {
    page_name = "group_chat_page",
    page_image_path = nil
}

group_chat_page = class_base_page:new(default_group_chat_page);

---qq联系人界面
local function check_page_group_chat()
    x, y = findMultiColorInRegionFuzzy({ 0x22BCF6, -15, 22, 0x59CCF8, 50, 40, 0x12B7F5, 115, 33, 0x12B7F5, 81, 9, 0x12B7F5, 4, 9, 0x12B7F5, 31, 29, 0xFFFFFF, 88, 21, 0x12B7F5, 88, 16, 0x12B7F5, 273, 26, 0x82D9FA, 318, 18, 0x12B7F5, 273, -3, 0x12B7F5, 218, 20, 0x12B7F5, 546, 25, 0x12B7F5, 573, 20, 0xE1F6FE, 571, 10, 0x12B7F5, 527, 4, 0x12B7F5, 544, 9, 0x12B7F5 }, 90, 19, 62, 607, 105);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq群聊界面1-7.0---");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x82D7F7, 49, 1, 0xF1FBFE, 49, 1, 0xF1FBFE, 42, 9, 0xFFFFFF, 8, 8, 0x6ED1F6, -4, 6, 0xF1FAFE, -18, 21, 0x6ED1F6, 30, 19, 0x6ED1F6, 48, 17, 0x6ED1F6, 55, 14, 0x6ED1F6, -1, 3, 0x6ED1F6, -55, -1, 0x6ED1F6, 2, 31, 0x6ED1F6, 106, 5, 0x6ED1F6, 114, 7, 0x6ED1F6, 124, 12, 0x6ED1F6, 303, 7, 0x6ED1F6, 293, 27, 0xECF9FE, 306, 1, 0x6ED1F6, 276, 10, 0x6ED1F6, -280, 10, 0x78D4F7, -242, 36, 0x6ED1F6, -152, 27, 0x6ED1F6, -170, 4, 0x6ED1F6, -228, -3, 0x6ED1F6, -184, 17, 0x6ED1F6, -162, 9, 0x6ED1F6 }, 90, 19, 67, 605, 106);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----qq群聊界面2-7.0---");
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 12, 28, 0x56CCF8, 104, 32, 0x12B7F5, 117, 24, 0x12B7F5, 50, 5, 0xA5E4FB, 62, -2, 0x12B7F5, 89, -7, 0x12B7F5, 281, 2, 0x96DFFB, 330, 4, 0x12B7F5, 290, 3, 0xB1E7FC, 340, -3, 0x12B7F5, 568, 20, 0x12B7F5, 583, 10, 0xFFFFFF, 571, -9, 0xEBF9FE, 564, -9, 0x12B7F5, 551, -5, 0x12B7F5 }, 90, 22, 65, 605, 106);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                 log_info("----qq群聊界面2-9.0----");
                return true
            else
                return false
            end
        end
    end
end

local function action_group_chat() --执行这个页面的操作--
    if gongneng == "group_add_friends" or gongneng == "copy_qq_number" then   --群加好友
        move(  324,230,324,120,4)    --滑动一下
        mSleep(800)
        if file_exists("/var/touchelf/scripts/qq_group.txt") == false then
            os.execute("touch ".."/var/touchelf/scripts/qq_group.txt")
            writeStrToFile(1, "/var/touchelf/scripts/qq_group.txt");
            writeStrToFile(1, "/var/touchelf/scripts/qq_group.txt");
        end
        mSleep(1000)
        local group_num = tonumber(getline_1("/var/touchelf/scripts/qq_group.txt"));     --加到第几个群
        cicky(150,300+112*(group_num-1),50);          --默认点击第一个群
        mSleep(2000)
        --群消息
        x, y = findMultiColorInRegionFuzzy({ 0xF0FAFE, 0, -5, 0xF0FAFE, 0, -17, 0xF0FAFE, -32, 7, 0xF0FAFE, -32, 12, 0xF0FAFE, -27, 14, 0xF0FAFE, -14, 3, 0xF0FAFE, 91, 5, 0xF0FAFE, 70, 3, 0xF0FAFE }, 90, 494, 69, 617, 100);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            page_array["page_group_message"]:action()
        else
            qq_warning_info("没有更多的群")
            return false
        end
    elseif gongneng == "pull_people_into_group" then   --拉人进群
        cicky( 311,257,50);   --点击搜索
        mSleep(1000)
        if text_into_group_number ~= nil and text_into_group_number[1] ~= nil then
            inputText(text_into_group_number[math.random(#text_into_group_number)])    --输入群号搜索
        else
            qq_warning_info("没有搜索的群信息,请配置好信息");
            return false
        end
        mSleep(2000)
        --搜索没结果
        x, y = findMultiColorInRegionFuzzy({ 0xD3D3D3, 49, 1, 0xF7F7F9, 92, 1, 0xCCCCCC, 102, 1, 0xCCCCCC, 104, 22, 0xF7F7F9, 96, 32, 0xF7F7F9, 76, 32, 0xF7F7F9, 32, 28, 0xF7F7F9, 4, 24, 0xD3D3D3, -2, 6, 0xF7F7F9, 19, 4, 0xF7F7F9, 53, 13, 0xCCCCCC, 82, 14, 0xCCCCCC, 91, 4, 0xF2F2F4, 40, -1, 0xF7F7F9, 73, 17, 0xF7F7F9, 93, 10, 0xCCCCCC }, 90, 265, 331, 371, 364);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            qq_warning_info("没有这个群，请先添加进群") 
            cicky( 601,77,50);   --点击取消
            mSleep(1000)
            return false
        else
            cicky( 269,166,50);   --点击第一个群
            mSleep(1000)
            return page_array["page_group_message"]:enter()
        end
    else
        cicky(  95,84,50);  --返回联系人
        mSleep(1000)
        page_array["page_lianxiren"]:enter()
    end
end


--step1 第一步
function group_chat_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function group_chat_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_group_chat() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function group_chat_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_group_chat()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function group_chat_page:action()
    return action_group_chat()
end

page_array["page_group_chat"] = group_chat_page:new()
--end page_group_chat.lua
------------------end:  page\page_group_add_friends\page_group_chat.lua-------------------------------------




----------------------begin:  page\page_group_add_friends\page_group_message.lua---------------------------------

default_group_message_page = {
    page_name = "group_message_page",
    page_image_path = nil
}

group_message_page = class_base_page:new(default_group_message_page);

---群发消息界面
local function check_page_group_message()
    x, y = findMultiColorInRegionFuzzy({ 0x77D6F9, 16, 8, 0x12B7F5, 14, 27, 0x12B7F5, 3, 25, 0x12B7F5, -6, 14, 0x12B7F5, -27, 13, 0x12B7F5, -91, 5, 0x12B7F5, -66, 7, 0x12B7F5, -63, 24, 0x12B7F5, -100, 22, 0x12B7F5, -106, 6, 0x29BEF6, -98, 26, 0x12B7F5, -47, 34, 0x12B7F5, -6, 34, 0x12B7F5, 7, 34, 0x12B7F5, 18, 34, 0xE8F8FE, -17, 34, 0x12B7F5, -576, -2, 0x12B7F5, -581, 16, 0xA1E2FB, -540, 29, 0x12B7F5, -513, 10, 0x12B7F5, -518, 18, 0x12B7F5, -494, 21, 0x68D1F9, -511, 22, 0x12B7F5, -497, -1, 0x12B7F5, -493, 26, 0x7CD7F9, -502, 15, 0xFFFFFF, -69, 12, 0xBCEBFC, -118, 14, 0x12B7F5, -97, 8, 0x12B7F5, -33, 6, 0x12B7F5, -4, 8, 0x12B7F5, -8, 30, 0x12B7F5, 19, 19, 0x12B7F5, -577, 11, 0x23BCF6, -506, 26, 0xFFFFFF, -495, 7, 0x12B7F5, -530, 2, 0xB3E8FC }, 90, 18, 64, 618, 100);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq群:发消息界面1-9.0----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 40, 0, 0xE8F8FE, 60, 3, 0x12B7F5, 63, 23, 0xE8F8FE, 31, 32, 0xE0F6FE, -17, 26, 0x12B7F5, -43, 8, 0x7ED8FA, -49, 7, 0xAFE7FC, 21, 31, 0x12B7F5, 42, 18, 0x27BDF6, 46, 4, 0x12B7F5, -28, -7, 0x12B7F5, -44, -2, 0x12B7F5, 54, 6, 0xCFF0FD, 69, 12, 0x12B7F5, 68, 28, 0x12B7F5 }, 90, 497, 60, 615, 99);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----qq群:发消息界面2-7.0---");
            return true
        else
            x, y = findMultiColorInRegionFuzzy({ 0x6ACDF2, 3, 24, 0xC3EBFA, -25, 20, 0xF0FAFE, -29, 4, 0x6ACDF2, -4, -11, 0x9CDEF6, -2, 17, 0x6ACDF2, -25, 22, 0x6ACDF2, -104, 0, 0xC6ECFA, -75, 14, 0x6ACDF2, -75, -8, 0xF0FAFE, -101, -4, 0x6ACDF2, -101, 21, 0x6ACDF2, -45, 18, 0x6ACDF2, -37, 3, 0x6ACDF2, -13, 15, 0xF0FAFE, -13, 15, 0xF0FAFE }, 90, 505, 64, 612, 99);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                log_info("----qq群:发消息界面3-7.0---");
                return true
            else
                x, y = findMultiColorInRegionFuzzy({ 0x8CDBF9, 78, -2, 0x33BFF4, 102, 4, 0xEBF9FE, 109, 28, 0xEBF9FE, 70, 39, 0x33BFF4, 2, 31, 0xEBF9FE, -3, 30, 0xEBF9FE, 39, 9, 0xB7E8FB, 98, 8, 0x33BFF4, 107, -4, 0x33BFF4, 12, -16, 0x33BFF4, -4, -2, 0xEBF9FE, 33, 21, 0x33BFF4, 86, 21, 0x4FC8F6, 98, 17, 0xEBF9FE, 101, 16, 0xEBF9FE }, 90, 495, 54, 608, 109);
                if x ~= -1 and y ~= -1 then  -- 如果找到了
                    log_info("----qq群:发消息界面5-9.0----");
                    return true
                else
                    return false
                end
            end
        end
    end
end

--群资料
local function page_group_data()
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -6, 0, 0xFFFFFF, -6, -12, 0xFFFFFF, -5, -17, 0xFFFFFF, -17, -17, 0xFFFFFF, -16, -12, 0xFFFFFF, -16, -6, 0xFFFFFF, -18, 10, 0xFFFFFF, 1, 10, 0xFFFFFF }, 90, 556, 70, 575, 97);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq群资料界面9.0----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -5, 0, 0xFFFFFF, -5, -6, 0xFFFFFF, -5, -10, 0xFFFFFF, -16, -10, 0xFFFFFF, -15, -3, 0xFFFFFF, -15, 5, 0xFFFFFF, -15, 16, 0xFFFFFF }, 90, 558, 69, 574, 95);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----qq群资料界面7.0----");
            return true
        else
           return false
        end
    end
end

--群消息  变化的
local function group_message()
    x, y = findMultiColorInRegionFuzzy({ 0xF0FAFE, -6, -4, 0xF0FAFE, -10, -4, 0xF0FAFE, -16, -1, 0xF0FAFE, -18, 10, 0xF0FAFE, -18, 23, 0xF0FAFE, -24, 35, 0xF0FAFE, -61, 21, 0xF0FAFE, -61, 12, 0xF0FAFE, -61, 1, 0xF0FAFE, -65, -3, 0xF0FAFE }, 90, 536, 67, 601, 106);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq群消息界面变化的7.0----");
        return true
    else
        return false
    end
end

local function action_group_message() --执行这个页面的操作--
    --弹框
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 20, -2, 0x1EB9F2, 29, -2, 0xFFFFFF, 52, -2, 0x1EB9F2, 70, -2, 0xE8F8FE, 97, -2, 0x1EB9F2, 105, -2, 0x1EB9F2, 108, 12, 0x1EB9F2, 105, 27, 0xA9E4FA, 94, 30, 0x1EB9F2, -4, 25, 0xFFFFFF, 50, 25, 0x46C5F4, 78, 25, 0xC4EDFC, 98, 25, 0x1EB9F2, 32, 12, 0xFFFFFF, 65, 12, 0x1EB9F2, 105, 12, 0xDDF5FD, 120, 9, 0x1EB9F2, 47, 6, 0x1EB9F2, 86, 6, 0x1EB9F2, 109, 5, 0x8ADAF8 }, 90, 261, 940, 385, 972);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        cicky(x,y,50);     --点击我知道了
        mSleep(1000)
    end
    if gongneng == "group_message_add_friends" then
        mSleep(1000)
        local num_hua = math.random(5)
        if num_hua > 1 then
            for i=1,num_hua do
                move( 601,500, 601,800,5);  --滑动一下
                mSleep(1000)
            end
        end
        local yy = 910
        while true do
            if yy <= 110 then
                mSleep(1000)
                cicky(52,86,50)  --返回
                mSleep(1500)
                move( 504,215, 100,215,8);   --滑动删除
                mSleep(1500)
                cicky(593,216,50);   --点击删除
                mSleep(1500)
                return page_array["page_xiaoxi"]:enter()
            end
            cicky( 49,yy,50);    --点击头像
            mSleep(1000)
            if group_message() == false then 
                mSleep(1000)
                if page_array["page_group_member_data"]:quick_check_page() == true then
                   return page_array["page_group_member_data"]:action()
                else
                    cicky(60,80,50);  --返回
                    mSleep(1200)
                end
            end
            yy = yy - 100
        end
        -- move( 305,934, 327,131,4);   --滑一页
    elseif gongneng == "group_add_friends" or gongneng == "pull_people_into_group" 
    or gongneng == "copy_qq_number" then   
        cicky( 601,77,50);  --点击右上角
        mSleep(2000)
        if page_group_data() == true then
            --群成员1-7.0
            x1, y1 = findMultiColorInRegionFuzzy({ 0xF1F7F2, 76, 0, 0xF1F7F2, 93, 0, 0xF2F7F2, 85, 34, 0x313231, 44, 35, 0xF1F7F2, 5, 24, 0x181818, 22, 11, 0xC6CAC6, 56, 16, 0xF1F7F2, 87, 22, 0x818481, 68, 12, 0x000000 }, 90, 33, 940, 126, 975);
            x2, y2 = findMultiColorInRegionFuzzy({ 0xFEFEFE, 41, 0, 0xECECEB, 52, 0, 0xEFEFEE, 55, 2, 0x959595, -18, 13, 0xFEFEFE, 38, 8, 0xFEFEFE, 67, 7, 0xFEFEFE, 2, 21, 0x0A0A0A, 38, 21, 0xF5F5F5, 48, 21, 0xFEFEFE }, 90, 43, 1021, 128, 1042);
            --群成员1-9.0
            x3, y3 = findMultiColorInRegionFuzzy({ 0xFEFEFE, 18, 2, 0xFEFEFE, 102, -3, 0x8A8A8A, 142, -3, 0xFEFEFD, 145, 5, 0xFEFEFD, 105, 16, 0xFEFEFE, 68, 18, 0xFEFEFE, 11, 7, 0xFCFCFC, -12, -7, 0xFEFEFE, -1, -5, 0xFBFBFB, 94, 17, 0xFEFEFE, 149, 7, 0xFEFEFD, 98, -14, 0xFEFEFE, 32, -13, 0xFEFEFE, 12, -11, 0xFEFEFE }, 90, 30, 851, 191, 883);
            if x1 ~= -1 or x3 ~= -1 then  -- 如果找到了
                if gongneng == "group_add_friends" or gongneng == "copy_qq_number" then
                    cicky( 278,1025,50);  --点击群成员
                    mSleep(2000)
                    return page_array["page_group_member"]:enter()
                else
                    cicky( 570,1034,50);  --点击+ 邀人进群
                    mSleep(2000)
                    return page_array["page_invitation_member_into_group"]:enter()
                end
            elseif x2 ~= -1 then
                if gongneng == "group_add_friends" or gongneng == "copy_qq_number" then
                    cicky( 319,1092,50);  --点击群成员
                    mSleep(2000)
                    return page_array["page_group_member"]:enter()
                else
                    cicky( 568,1102,50);  --点击+ 邀人进群
                    mSleep(2000)
                    return page_array["page_invitation_member_into_group"]:enter()
                end
            else
                qq_warning_info("群成员进入错误");
                return false
            end
            --群成员2-9.0
            x, y = findMultiColorInRegionFuzzy({ 0xEFF1EF, 73, 10, 0x101010, 92, 9, 0xEFF1EF, 93, 9, 0xEFF1EF, 55, 32, 0xA6A7A6, 18, 31, 0xEFF1EF, 7, 27, 0xEFF1EF, 0, 15, 0x9B9C9B, 69, 14, 0x8F918F, 86, 14, 0x8F918F, 36, 4, 0xEFF1EF, 13, 5, 0x888988 }, 90, 33, 1014, 126, 1046);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                if gongneng == "group_add_friends" or gongneng == "copy_qq_number" then
                    cicky( 308,1075,50);
                    mSleep(2000)
                    return page_array["page_group_member"]:enter()
                else
                    cicky( 566,1102,50);  --点击+ 邀人进群
                    mSleep(2000)
                    return page_array["page_invitation_member_into_group"]:enter()
                end
            else
                qq_warning_info("群成员进入错误");
                return false
            end
        else
            qq_warning_info("群资料进入错误");
            return false
        end
    else
        cicky(  95,84,50);  --返回qq消息界面
        mSleep(1000)
        page_array["page_xiaoxi"]:enter()
    end
end


local function group_data_check( ... )
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  page_group_data() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false
end

--step1 第一步
function group_message_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function group_message_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_group_message() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function group_message_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_group_message()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function group_message_page:action()
    return action_group_message()
end

page_array["page_group_message"] = group_message_page:new()
--end page_group_message.lua
------------------end:  page\page_group_add_friends\page_group_message.lua-------------------------------------




----------------------begin:  page\page_group_add_friends\page_group_member.lua---------------------------------

default_group_member_page = {
    page_name = "group_member_page",
    page_image_path = nil
}

group_member_page = class_base_page:new(default_group_member_page);

---群成员界面
local function check_page_group_member()
    x, y = findMultiColorInRegionFuzzy({ 0x78D3F6, 11, 1, 0x9FDFF7, 35, 1, 0xB7E5F7, 55, 1, 0xA4DEF5, 74, 1, 0x69CCF1, 86, 1, 0x6CCFF4, 91, 2, 0x6CCFF5, 12, 8, 0x6BCEF4, 48, 8, 0xFFFFFF, 73, 5, 0xFFFFFF, 89, 5, 0xFFFFFF, 93, 13, 0x6DD0F6, 82, 19, 0x6DD0F6, 41, 20, 0xFFFFFF, 14, 19, 0x6DD0F5, 11, 18, 0xCDEFFC, 20, 7, 0xFFFFFF, 66, 6, 0x69CCF2, 85, 6, 0x9ADEF7, 49, -11, 0x60C3E8, -6, 0, 0x6CCFF5, 144, 0, 0x6ED1F6, 167, 7, 0x6ED1F6, 123, 12, 0x6ED1F6, 176, 6, 0x6ED1F6, 215, 11, 0x6ED1F6, 243, 0, 0x6ED1F6, 163, -12, 0x6ED1F6, -125, 3, 0x6ED1F6, -11, 13, 0x6DD0F6, -27, -7, 0x6ED1F6, -89, -3, 0x6ED1F6, -15, 16, 0x6ED1F6, -3, 3, 0xD4F1FC, 3, -3, 0x7FD5F5, 63, 2, 0x67CAF0, 81, 13, 0xD0F0FB, 40, 24, 0x6DD0F5, 41, 24, 0x6DD0F5, 80, 24, 0x6DD0F6 }, 90, 149, 61, 517, 97);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq群成员界面7.0----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x34C0F5, 27, 22, 0x34C0F5, 92, 21, 0xD3F1FD, 101, 8, 0x34C0F5, 43, -4, 0x34C0F5, 39, 18, 0xFFFFFF, 98, 14, 0x34C0F5, 96, 6, 0x34C0F5, 281, 25, 0x33BFF4, 344, 19, 0x33BFF4, 351, -7, 0x33BFF4, 305, 14, 0x33BFF4, 343, 7, 0xFFFFFF, 346, 2, 0xC7EDFC, 602, 18, 0x34C0F5, 583, -16, 0x34C0F5, 545, 0, 0x34C0F5, 571, 10, 0x36C0F5, 577, 8, 0xEBF9FE, 585, 8, 0x34C0F5 }, 90, 17, 58, 619, 99);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----qq群成员界面9.0----");
            return true
        else
            return false
        end
    end
end

----群成员界面2  变化的
function  group_member_jiemian()
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, -1, -4, 0xFFFFFF, -1, -11, 0xFFFFFF, 8, -11, 0xFFFFFF, 5, -16, 0xFFFFFF, -12, -12, 0xFFFFFF, -30, -10, 0xFFFFFF, -43, -10, 0xFFFFFF, -47, -6, 0xFFFFFF, -47, 6, 0xFFFFFF, 30, 4, 0xFFFFFF }, 90, 276, 71, 353, 93);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---群成员界面---")
        return true
    else
        return false
    end
end

local function action_group_member() --执行这个页面的操作--
    if gongneng == "group_add_friends" or gongneng == "copy_qq_number" then   --群加好友
        if gong_neng == "copy_next" then  --复制下个qq号
            copy_no_several_people =  copy_no_several_people + 1  --复制qq号位置 + 1 
            if copy_no_several_people > 9 then  --一页有9个成员
                mSleep(300)
                m = getColor(  59,316 )
                n = getColor(  54,439 )
                z = getColor(  64,524 )
                o = getColor(  64,623 )
                move( 325,1100,325,180,4)  --滑一页
                mSleep(700)
                m2 = getColor(  59,316 )
                n2 = getColor(  54,439 )
                z2 = getColor(  64,524 )
                o2 = getColor(  64,623 )
                mSleep(300)
                if z2 == z and n2 == n and m2 == m and o2 == o  then
                    qq_warning_info("当前群成员qq复制完，继续复制下个群")
                    if file_exists("/var/touchelf/scripts/qq_group.txt") == true then
                        local group_num = tonumber(getline_1("/var/touchelf/scripts/qq_group.txt")) + 1;     --加到第几个群
                        local file = io.open("/var/touchelf/scripts/qq_group.txt","w+");  --更新文件
                        file:write(group_num .. "\r\n");
                        file:write(1 .. "\r\n");
                        file:close();
                    end
                    appKill("com.tencent.mqq");    ---关闭qq
                    mSleep(4000);
                    return page_array["page_main"]:enter()
                end
                copy_no_several_people = 1 --初始化
            end
            cicky(260,130+100*copy_no_several_people)   --点击群成员
            mSleep(1000)
        else
            cicky( 596,85,50);    --点击点
            mSleep(1500)
             --按加群时间排序 系统7.0 
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 10, 0, 0x007AFF, 22, 0, 0x007AFF, 43, -2, 0x007AFF, 62, -2, 0x007AFF, 79, -8, 0x007AFF, 93, -8, 0x007AFF, 113, 2, 0x007AFF, 134, 2, 0x007AFF }, 90, 241, 698, 375, 708);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);  --点击按时间
                mSleep(1000)
            end
             --按加群时间排序 系统7.0 管理员
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 7, 0, 0x007AFF, 17, 0, 0x007AFF, 29, 0, 0x007AFF, 54, 1, 0x007AFF, 68, 1, 0x007AFF, 78, 1, 0x007AFF, 96, 1, 0x077DFF, 112, 1, 0x007AFF }, 90, 234, 624, 346, 625);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);  --点击按时间
                mSleep(1000)
            end
            --按加群时间排序 系统9.0 
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, 6, 0, 0x007AFF, 17, 0, 0x007AFF, 32, 1, 0x007AFF, 50, 1, 0x007AFF, 72, 0, 0x007AFF, 93, 0, 0x007AFF, 107, 0, 0x007AFF, 115, 0, 0x007AFF }, 90, 238, 584, 353, 585);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);  --点击按时间
                mSleep(1000)
            end
            --按加群时间排序 管理员 系统9.0 
            x, y = findMultiColorInRegionFuzzy({ 0x007AFF, -16, 0, 0x007AFF, -33, 0, 0x007AFF, 13, -1, 0x007AFF, 34, -1, 0x007AFF, 41, -1, 0x007AFF, 52, -1, 0x007AFF, 74, -1, 0x007AFF, 83, 2, 0x007AFF }, 90, 238, 463, 354, 466);
            if x ~= -1 and y ~= -1 then  -- 如果找到了
                cicky(x,y,50);  --点击按时间
                mSleep(1000)
            end
            mSleep(4000)
            move(  324,230,324,120,4)    --滑动一下
            mSleep(1000)
            if file_exists("/var/touchelf/scripts/qq_group.txt") == true then
                 total_number = tonumber(getline("/var/touchelf/scripts/qq_group.txt")) ;  --加到第几人 
            else
                qq_warning_info("从群依次提取qq号")
                appKill("com.tencent.mqq");    ---关闭qq
                mSleep(4000);
                return page_array["page_main"]:enter()
            end
            if total_number > 9 then
                local  few_pages = math.floor(total_number / 9)  --滑动几页
                local  copy_no_several_people =  total_number % 9    --复制第几个人的qq号
                for i=1, few_pages do
                    mSleep(300)
                    m = getColor(  59,316 )
                    n = getColor(  54,439 )
                    z = getColor(  64,524 )
                    o = getColor(  64,623 )
                    move( 325,1100,325,180,4)  --滑一页
                    mSleep(700)
                    m2 = getColor(  59,316 )
                    n2 = getColor(  54,439 )
                    z2 = getColor(  64,524 )
                    o2 = getColor(  64,623 )
                    mSleep(300)
                    if z2 == z and n2 == n and m2 == m and o2 == o  then
                        break
                    end
                end
            else
                copy_no_several_people = total_number
            end
            cicky( 280,130+100*copy_no_several_people,50);   --点击第一个成员
            mSleep(1500)
        end
        if page_array["page_group_member"]:quick_check_page() == true then
            page_array["page_group_member"]:action()
        else
            page_array["page_group_member_data"]:action()  
        end
    else
        cicky(  95,84,50);  --返回群资料
        mSleep(1000)
        page_array["page_group_message"]:enter()
    end
end

--step1 第一步
function group_member_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function group_member_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_group_member() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function group_member_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_group_member()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function group_member_page:action()
    return action_group_member()
end

page_array["page_group_member"] = group_member_page:new()
--end page_group_member.lua
------------------end:  page\page_group_add_friends\page_group_member.lua-------------------------------------




----------------------begin:  page\page_group_add_friends\page_group_member_data.lua---------------------------------

default_group_member_data_page = {
    page_name = "group_member_data_page",
    page_image_path = nil
}

group_member_data_page = class_base_page:new(default_group_member_data_page);

---群加好友界面
local function check_page_group_member_data()
    x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 83, 1, 0xFFFFFF, 90, 18, 0xFFFFFF, 66, 35, 0xFFFFFF, 13, 25, 0xFFFFFF, 41, 11, 0x000000, 98, 16, 0xFFFFFF, 101, 22, 0xFFFFFF, 285, 46, 0xFFFFFF, 344, 27, 0xFFFFFF, 278, 2, 0xFFFFFF, 225, 8, 0xFFFFFF, 298, 27, 0xC8C8C8, 295, 6, 0xFFFFFF, 271, 9, 0x383838, 459, 29, 0x55CAF5, 524, 16, 0x1EB9F2, 444, -2, 0x1EB9F2, 449, 11, 0xFFFFFF, 491, 11, 0x1EB9F2 }, 90, 53, 1059, 577, 1107);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---群成员资料界面-7.0---")
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0xFFFFFF, 44, 1, 0x000000, 75, 9, 0xFFFFFF, 45, 21, 0x575757, 7, 23, 0xFDFDFD, -22, -1, 0xFFFFFF, 25, -1, 0x000000, 37, 2, 0x000000, 200, 6, 0xFFFFFF, 272, 3, 0xFFFFFF, 268, 14, 0xFFFFFF, 191, 17, 0x000000, 225, -13, 0xFFFFFF, 384, 9, 0x1EB9F2, 468, 23, 0xFAFDFF, 467, 2, 0x1EB9F2, 394, -7, 0x1EB9F2, 455, 23, 0x1EB9F2, 466, 16, 0x1EB9F2 }, 90, 82, 1055, 572, 1091);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("---群成员资料界面-9.0---")
            return true
        else
            return false
        end
    end
end

--复制qq号操作
local function copy_qq_number_action()
   --账号信息1-7.0
    x1, y1 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 68, 5, 0xFFFFFF, 90, 7, 0xFFFFFF, 104, 7, 0x979797, 107, 24, 0xFFFFFF, 80, 36, 0xFFFFFF, 31, 36, 0xFFFFFF, 18, 30, 0x808080, 6, 22, 0x808080, 78, 15, 0xEEEEEE, 92, 26, 0xFFFFFF, 107, 16, 0x8A8A8A, -19, 4, 0xFFFFFF, -16, 4, 0xFFFFFF }, 90, 21, 524, 147, 560);
    --账号信息2-7.0
    x2, y2 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 56, 8, 0xFFFFFF, 81, 8, 0x808080, 109, 13, 0x808080, 91, 28, 0xFFFFFF, 34, 27, 0xFFFFFF, -3, 16, 0xFFFFFF, 67, 17, 0xA0A0A0, 111, 21, 0xFFFFFF, 92, 8, 0x808080, 33, 7, 0xFFFFFF }, 90, 38, 593, 152, 621);
  --账号信息4-7.0
    x3, y3 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 54, 0, 0xFFFFFF, 78, 0, 0xF8F8F8, 103, -1, 0x979797, 110, 0, 0x9A9A9A, 111, 6, 0x808080, 89, 9, 0xFFFFFF, 46, 7, 0xFFFFFF, 10, 5, 0xB4B4B4, 0, 5, 0xFFFFFF, 8, 17, 0xB2B2B2, 73, 21, 0x909090, 102, 21, 0xFFFFFF }, 90, 39, 475, 150, 497);
    x4, y4 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 34, -1, 0x808080, 71, -1, 0xFFFFFF, 99, -1, 0x8B8B8B, 105, 2, 0xFFFFFF, 85, 10, 0xFFFFFF, 31, 3, 0x808080, 5, 3, 0xFFFFFF, 59, 19, 0xFFFFFF, 79, 18, 0xFFFFFF, 89, 11, 0xFFFFFF, 96, 9, 0x8A8A8A, 107, 15, 0xFFFFFF, 107, 17, 0xFFFFFF }, 90, 39, 536, 146, 556);
    --账号信息1-9.0
    xx1, yy1 = findMultiColorInRegionFuzzy({ 0xB0B0B0, 71, -3, 0xEEEEEE, 101, -3, 0xB9B9B9, 105, -2, 0x919191, 106, 11, 0xECECEC, 85, 14, 0xFEFEFE, 32, 7, 0xA9A9A9, 8, 5, 0xA7A7A7, 81, 0, 0x848484, 102, 2, 0x969696, 105, 0, 0xFFFFFF }, 90, 38, 535, 144, 552);
    if x1 ~= -1  or x2 ~= -1 or x3 ~= -1 or x4 ~= -1 or xx1 ~= -1 then 
        if x1 ~= -1 or xx1 ~= -1 then  -- 如果找到了
           cicky( 299,545,1000);   --长按账号
           mSleep(500)
           cicky(288,428);         --点击复制
        elseif x2 ~= -1 and y2 ~= -1 then
            cicky( 309,611,1000);  --长按账号
            mSleep(500)
            cicky( 288,428,50);    --点击复制
        elseif x3 ~= -1 and y3 ~= -1 then
            cicky( 291,491,1000);  --长按账号
            mSleep(500)
            cicky( 295,374,50);    --点击复制
        elseif x4 ~= -1 and y4 ~= -1 then
            icky( 295,545,1000);  --长按账号
            mSleep(500)
            cicky( 289,490 ,50);     --点击复制
        end
        mSleep(2000)
        if file_exists("/var/touchelf/res/qq_number.txt") == false then
            os.execute("touch ".."/var/touchelf/res/qq_number.txt");
        end
        a = clipText()  --剪切板内容
        writeStrToFile(a,"/var/touchelf/res/qq_number.txt");
        mSleep(2000);
    else
        qq_warning_info("复制QQ号失败1")
        mSleep(1000)
    end
end

local function action_group_member_data() --执行这个页面的操作--
    if gongneng == "group_add_friends"  then   --群加好友
        cicky(  86,1078,50);    --点击加好友
        mSleep(2000)
        ---被加号被举报太多
        x, y = findMultiColorInRegionFuzzy({ 0xE7E6E9, 3, 1, 0x151515, 15, 6, 0xE8E7E9, 27, 8, 0xE8E7EA, 28, 8, 0xE8E7EA, 42, 10, 0x878789, 96, 10, 0xE8E8EA, 118, 10, 0x000000, 121, 11, 0x0F0F10, 88, 22, 0xE9E9EB, 59, 17, 0xE8E8EB, 23, 25, 0x000000, 1, 57, 0xEDEDED, 52, 60, 0x000000, 101, 60, 0xEDEDED, 114, 61, 0xEDEDED, 48, 94, 0xC4C4C4, 47, 92, 0x000000, 66, 106, 0x282828, 66, 106, 0x282828 }, 90, 259, 469, 380, 575);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky( 180,664,50)  --点击继续
            mSleep(1500)
        end
        if page_array["page_qhy_add_verification"]:check_page() == true then
            page_array["page_qhy_add_verification"]:action()
        else
            qq_warning_info("加群好友时网络太卡")
        end
    elseif gongneng == "copy_qq_number" then
         copy_qq_number_action()
         cicky(60,80,50)  --点击返回
         mSleep(2000)
         if group_member_jiemian() == true then
             gong_neng = "copy_next"  --复制下个qq号
             return page_array["page_group_member"]:action()
         end
    elseif  gongneng == "group_message_add_friends" then
        cicky(  86,1078,50);    --点击加好友
        mSleep(2000)
        ---被加号被举报太多
        x, y = findMultiColorInRegionFuzzy({ 0xE7E6E9, 3, 1, 0x151515, 15, 6, 0xE8E7E9, 27, 8, 0xE8E7EA, 28, 8, 0xE8E7EA, 42, 10, 0x878789, 96, 10, 0xE8E8EA, 118, 10, 0x000000, 121, 11, 0x0F0F10, 88, 22, 0xE9E9EB, 59, 17, 0xE8E8EB, 23, 25, 0x000000, 1, 57, 0xEDEDED, 52, 60, 0x000000, 101, 60, 0xEDEDED, 114, 61, 0xEDEDED, 48, 94, 0xC4C4C4, 47, 92, 0x000000, 66, 106, 0x282828, 66, 106, 0x282828 }, 90, 259, 469, 380, 575);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky( 180,664,50)  --点击继续
            mSleep(1500)
        end
        for i=1,8 do  
            if page_array["page_group_message_jiaren_verification"]:quick_check_page()== true then
                return page_array["page_group_message_jiaren_verification"]:action()
            elseif page_array["page_group_message_jiaren_send_verification"]:quick_check_page() == true then
                return page_array["page_group_message_jiaren_send_verification"]:action()
            end
            mSleep(1000)
        end
        qq_warning_info("加群里发言的人时网络卡了")
        return false
    else
        cicky(  95,84,50);  --返回群成员
        mSleep(1500)
        if group_member_jiemian() == true then   --是否是群成员界面
            page_array["page_group_member"]:action()
        elseif group_message()  == true then     --是否是群消息界面
            page_array["page_group_message"]:action()
        end
    end
end

local function group_data_check( ... )
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  page_group_data() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false
end

--step1 第一步
function group_member_data_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function group_member_data_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_group_member_data() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function group_member_data_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_group_member_data()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function group_member_data_page:action()
    return action_group_member_data()
end

page_array["page_group_member_data"] = group_member_data_page:new()
--end page_group_member_data.lua
------------------end:  page\page_group_add_friends\page_group_member_data.lua-------------------------------------




----------------------begin:  page\page_group_add_friends\page_qhy_add_verification.lua---------------------------------

default_qhy_add_verification_page = {
    page_name = "qhy_add_verification_page",
    page_image_path = nil
}

qhy_add_verification_page = class_base_page:new(default_qhy_add_verification_page);

---群加好友验证界面
local function check_page_qhy_add_verification()
    x, y = findMultiColorInRegionFuzzy({ 0x6ED1F6, -1, 18, 0x6ED1F6, 16, 10, 0x6ED1F6, 6, 2, 0x6ED1F6, 1, 2, 0x6ED1F6, 67, 2, 0xFFFFFF, 80, 7, 0x6ED1F6, 64, 28, 0xFFFFFF, 29, 24, 0x6ED1F6, 21, 7, 0x6ED1F6, 56, 9, 0x6ED1F6, 64, 21, 0x6ED1F6, -519, 7, 0x6ED1F6, -498, 26, 0x6ED1F6, -450, 31, 0x6ED1F6, -364, 16, 0xDFF5FD, -350, 7, 0x6ED1F6, -421, 3, 0xE6F7FD, -459, 3, 0x6ED1F6, -464, 3, 0x6ED1F6, -453, 13, 0xFFFFFF, -391, 17, 0x6ED1F6, -377, 10, 0x6ED1F6, -362, 6, 0x6ED1F6, -260, 1, 0x6ED1F6, -215, 1, 0x6ED1F6, -181, 2, 0x6ED1F6, -155, 14, 0x6ED1F6, -182, 26, 0xFFFFFF, -245, 26, 0xFFFFFF, -284, 26, 0xAEE5FA, -260, 11, 0xFFFFFF, -219, 11, 0x6ED1F6, -166, 11, 0xFFFFFF, -162, 11, 0xFFFFFF }, 90, 22, 66, 621, 97);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---群加好友验证界面-7.0---")
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x42C4F6, -21, 13, 0x34C0F5, -1, 39, 0xDEF5FD, 90, 37, 0x34C0F5, 134, 30, 0x34C0F5, 149, 14, 0x34C0F5, 123, 9, 0xFFFFFF, 89, 9, 0x3AC2F5, 39, 9, 0xEBF9FE, 20, 11, 0xFFFFFF, 77, 29, 0x34C0F5, 120, 27, 0x34C0F5, 129, 14, 0x34C0F5, 86, 9, 0x74D4F8, 250, 13, 0x34C0F5, 330, 13, 0xFFFFFF, 346, 22, 0x37C1F5, 231, 25, 0x39C1F5, 290, 11, 0xFFFFFF, 336, 14, 0xEDFAFE, 502, 17, 0xFFFFFF, 566, 28, 0x34C0F5, 581, 17, 0xFFFFFF, 524, -1, 0x34C0F5, 538, 15, 0x34C0F5, 571, 22, 0xFFFFFF }, 90, 15, 62, 617, 102);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("---群加好友验证界面-9.0---")
            return true
        else
            return false
        end
    end
end

local function action_qhy_add_verification() --执行这个页面的操作--
    if gongneng == "group_add_friends" then   --群加好友
        if text_shy_verification ~= nil and text_shy_verification[1] ~= nil then
            cicky( 598,980,2500);   --点击叉叉 删除
            mSleep(500)
            --随机输入验证消息
            inputText(text_shy_verification[math.random(#text_shy_verification)])
            mSleep(1000)
        end
        cicky( 580,81,50);  --点击下一步
        mSleep(1000)
        page_array["page_shy_send_verification"]:enter()
    else
        cicky(  95,84,50);  --返回群资料
        mSleep(1000)
        page_array["page_group_member_data"]:enter()
    end
end

local function group_data_check( ... )
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  page_group_data() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false
end

--step1 第一步
function qhy_add_verification_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function qhy_add_verification_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_qhy_add_verification() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function qhy_add_verification_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_qhy_add_verification()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function qhy_add_verification_page:action()
    return action_qhy_add_verification()
end

page_array["page_qhy_add_verification"] = qhy_add_verification_page:new()
--end page_qhy_add_verification.lua
------------------end:  page\page_group_add_friends\page_qhy_add_verification.lua-------------------------------------




----------------------begin:  page\page_group_add_friends\page_invitation_member_into_group.lua---------------------------------

default_invitation_member_into_group_page = {
    page_name = "invitation_member_into_group_page",
    page_image_path = nil
}

invitation_member_into_group_page = class_base_page:new(default_invitation_member_into_group_page);

---邀请新成员进群界面
local function check_page_invitation_member_into_group()
    x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 39, 0, 0x12B7F5, 58, 1, 0x12B7F5, 60, 10, 0xE5F7FE, 57, 23, 0x1ABAF5, 57, 26, 0x12B7F5, -1, 29, 0x12B7F5, 34, 29, 0xFEFFFF, 45, 29, 0x40C5F7, 35, 14, 0x12B7F5, 55, 14, 0x12B7F5, 232, 8, 0x79D6F9, 325, 8, 0xFFFFFF, 376, 6, 0x12B7F5, 381, 6, 0x12B7F5, 379, 21, 0x12B7F5, 354, 29, 0xFFFFFF, 280, 29, 0x12B7F5, 242, 29, 0x12B7F5, 222, 29, 0x12B7F5, 234, 16, 0x78D6F9, 289, 16, 0x75D5F9, 332, 16, 0xFFFFFF, 348, 16, 0xFFFFFF, 358, 10, 0x24BCF6, 329, 3, 0x12B7F5, 281, 4, 0x12B7F5, 280, 4, 0x12B7F5, 572, 3, 0x12B7F5, 576, 3, 0x12B7F5, 594, 6, 0x12B7F5, 580, 27, 0x12B7F5, 558, 28, 0x12B7F5, 543, 21, 0x12B7F5, 535, 14, 0x12B7F5, 562, 8, 0x12B7F5, 579, 14, 0x33C1F6, 554, 14, 0x12B7F5 }, 90, 29, 66, 624, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---邀请新成员进群界面-7.0---")
        return true
    else
        return false
    end
end

---选择人操作
local function pull_people_action() 
    while true do
        m = getColor( 117,381  )
        n = getColor( 125,464  )
        z = getColor( 123,555  )
        o = getColor(  128,644 )
        p = getColor(  121,742 )
        mSleep(500)
        for i=0,8 do   --点击9个好友
            cicky(282,380+i*90)
            mSleep(200)
        end
        mSleep(500)
        move( 136,1000, 136,150,4)   --滑一页
        mSleep(700)
        m2 = getColor( 117,381  )
        n2 = getColor( 125,464  )
        z2 = getColor( 123,555  )
        o2 = getColor(  128,644 )
        p2 = getColor(  121,742 )
        mSleep(200)
        if z2 == z and n2 == n and m2 == m and o2 == o and p2 == p then
            for i=0,8 do   --点击9个好友
                if getColor(44,352+i*90) == 0xFFFFFF then
                    cicky(282,380+i*90)
                    mSleep(200)
                end
                mSleep(200)
            end
            mSleep(1000)
            cicky( 592,82,50);   --点击完成
            mSleep(4000)
            warning_info("邀请全部好友完成")
            mSleep(1000)
            if page_group_data() == true then  --群资料
               cicky(60,80,50);  --点击返回
               mSleep(1000)
               return true
               -- page_array["page_invitation_member_into_group"]:enter()
            end
        end
    end
end

local function action_invitation_member_into_group() --执行这个页面的操作--
    if gongneng == "pull_people_into_group" then  --拉人进群
        mSleep(1100)
        --最近联系人7.0
        x, y = findMultiColorInRegionFuzzy({ 0xB3B3B3, 0, 5, 0xB3B3B3, 49, -6, 0xFFFFFF, 103, -5, 0xFFFFFF, 143, -7, 0x6A6A6A, 167, -7, 0xFFFFFF, 191, 10, 0xAFAFAF, 177, 17, 0xFFFFFF, 128, 20, 0xFFFFFF, 53, 7, 0x616161, 44, -7, 0x464646, 87, -1, 0xFFFFFF, 161, -4, 0xFFFFFF, 168, -7, 0xFFFFFF, 184, 2, 0x000000, 110, 21, 0xF9F9F9, 52, 16, 0xFCFCFC }, 90, 34, 434, 225, 462);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);
            mSleep(1000)
            cicky( 120,530,50);  --点击我的好友
            mSleep(1000)
            move(295,788,295,508,2)
            mSleep(1000)
        else
            move( 295,788,295,600,2)  -- 滑动一下
            mSleep(1000)
        end
        pull_people_action()
    else
        cicky(  95,84,50);  --取消
        mSleep(1500)
        cicky(  95,84,50);  --返回
        mSleep(1000)
        page_array["page_invitation_member_into_group"]:enter()
    end
end


local function group_data_check( ... )
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  page_group_data() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false
end

--step1 第一步
function invitation_member_into_group_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function invitation_member_into_group_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_invitation_member_into_group() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function invitation_member_into_group_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_invitation_member_into_group()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function invitation_member_into_group_page:action()
    return action_invitation_member_into_group()
end

page_array["page_invitation_member_into_group"] = invitation_member_into_group_page:new()
--end page_invitation_member_into_group.lua
------------------end:  page\page_group_add_friends\page_invitation_member_into_group.lua-------------------------------------




----------------------begin:  page\page_group_add_friends\page_group_message_jiaren_send_verification.lua---------------------------------

default_group_message_jiaren_send_verification_page = {
    page_name = "group_message_jiaren_send_verification_page",
    page_image_path = nil
}

group_message_jiaren_send_verification_page = class_base_page:new(default_group_message_jiaren_send_verification_page);

---群消息加人发送验证界面
local function check_page_group_message_jiaren_send_verification()
    x, y = findMultiColorInRegionFuzzy({ 0xC6EDFB, -15, 13, 0x6ED1F6, 2, 21, 0x6ED1F6, 12, 28, 0x6ED1F6, 31, -1, 0x6ED1F6, 80, -3, 0x6ED1F6, 131, -3, 0x6ED1F6, 153, 8, 0x6ED1F6, 144, 23, 0x6ED1F6, 96, 23, 0xE8F8FE, 23, 25, 0x6ED1F6, 17, 19, 0x6ED1F6, 34, 1, 0x6ED1F6, 60, 9, 0xF5FCFE, 121, 13, 0x6ED1F6, 129, -2, 0xFEFFFF, 62, 7, 0x6ED1F6, 115, 31, 0x6ED1F6, 230, 3, 0xFFFFFF, 344, 0, 0x6ED1F6, 381, 1, 0x6ED1F6, 361, 23, 0x6ED1F6, 326, 30, 0x6ED1F6, 231, 30, 0x6ED1F6, 227, 17, 0xF6FCFE, 274, 11, 0x6ED1F6, 338, 17, 0x81D7F7, 342, 5, 0xFFFFFF, 244, 14, 0x6ED1F6, 537, -8, 0x6ED1F6, 576, -7, 0x6ED1F6, 583, 11, 0xABE4FA, 572, 23, 0xFFFFFF, 532, 14, 0x6ED1F6, 549, -3, 0x71D2F6, 567, 8, 0xFFFFFF, 567, 12, 0xFFFFFF, 559, 8, 0x6ED1F6 }, 90, 15, 62, 613, 101);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("---- 群消息加人发送验证界面1-7.0----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 21, 1, 0x12B7F5, 37, 1, 0x12B7F5, 48, 1, 0x12B7F5, 86, 9, 0x12B7F5, 109, 9, 0xFFFFFF, 116, 9, 0xFFFFFF, 26, 14, 0x12B7F5, 77, 14, 0x6ED3F9, 115, 14, 0xFAFEFF, 8, 17, 0x12B7F5, 67, 17, 0xFFFFFF, 109, 17, 0x12B7F5, 123, 19, 0x12B7F5, 96, 31, 0x40C5F7, 38, 31, 0x12B7F5, 9, 31, 0x12B7F5, -1, 18, 0xFFFFFF, -244, 8, 0x12B7F5, -241, 26, 0x58CCF8, -176, 34, 0x12B7F5, -116, 32, 0x12B7F5, -86, 23, 0x12B7F5, -122, 5, 0xFFFFFF, -201, 2, 0x12B7F5, -221, 2, 0x12B7F5, -134, 12, 0xFEFFFF, -158, 19, 0x12B7F5, -90, 15, 0x40C5F7, -87, 15, 0x12B7F5, -25, 9, 0x12B7F5, 351, 5, 0x12B7F5, 354, 17, 0x12B7F5, 291, 13, 0x12B7F5, 330, 8, 0x12B7F5, 335, 12, 0x12B7F5 }, 90, 21, 66, 619, 100);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("---- 群消息加人发送验证界面2-7.0----");
            return true
        else
            return false
        end
    end
end


local function action_group_message_jiaren_send_verification() --执行这个页面的操作--
    if  gongneng == "group_message_add_friends" then
        cicky( 591,78,50);          --点击发送
        mSleep(5000)
        --添加频繁
        x, y = findMultiColorInRegionFuzzy({ 0xEAEAEA, 50, -1, 0xEAEAEA, 57, 3, 0x007AFF, 59, 13, 0xC3D6ED, 16, 8, 0xE7E8E9, 38, -7, 0xEBEBEB, 20, 16, 0x6EAEF4, 20, 1, 0x3091FB, 52, 3, 0xEAEAEA, 52, 3, 0xEAEAEA, 37, 7, 0xEAEAEA, 31, 7, 0x097EFE }, 90, 284, 617, 343, 640);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            cicky(x,y,50);  --点击确认
            mSleep(1000)
            qq_wanring_info("添加群好友过于频繁")
            return false
        end
        if page_array["page_group_member_data"]:check_page() == true then
            cicky(60,80,50);  --点击返回
            mSleep(1500)
            if page_array["page_group_message"]:quick_check_page() == true then
                gongneng = "del_message"  --删除消息
                return page_array["page_group_message"]:action()
            end
            return false
        end
        return false
    else
       cicky(60,80,50);  --返回
       mSleep(1000)
       page_array["page_group_message_data"]:enter()
    end
end


--step1 第一步
function group_message_jiaren_send_verification_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function group_message_jiaren_send_verification_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_group_message_jiaren_send_verification() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function group_message_jiaren_send_verification_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_group_message_jiaren_send_verification()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function group_message_jiaren_send_verification_page:action()
    return action_group_message_jiaren_send_verification()
end

page_array["page_group_message_jiaren_send_verification"] = group_message_jiaren_send_verification_page:new()
--end page_group_message_jiaren_send_verification.lua
------------------end:  page\page_group_add_friends\page_group_message_jiaren_send_verification.lua-------------------------------------




----------------------begin:  page\page_group_add_friends\page_group_message_jiaren_verification.lua---------------------------------

default_group_message_jiaren_verification_page = {
    page_name = "group_message_jiaren_verification_page",
    page_image_path = nil
}

group_message_jiaren_verification_page = class_base_page:new(default_group_message_jiaren_verification_page);

---群消息加人验证界面
local function check_page_group_message_jiaren_verification()
    x, y = findMultiColorInRegionFuzzy({ 0x9ADFF9, -9, 17, 0x6ED1F6, 2, 42, 0x6ED1F6, 17, 35, 0x6ED1F6, 18, -2, 0x6ED1F6, 42, 16, 0x6ED1F6, 23, -1, 0x6ED1F6, 64, -1, 0xF5FCFE, 87, 4, 0x7CD5F7, 131, 4, 0x6ED1F6, 136, 16, 0xFFFFFF, 61, 11, 0x6ED1F6, 104, -3, 0x6ED1F6, 126, 1, 0xFFFFFF, 131, 8, 0xDDF4FD, 226, 3, 0xFFFFFF, 270, 26, 0xFFFFFF, 326, 26, 0xA1E1F9, 349, 11, 0x6ED1F6, 344, 5, 0xCFF0FC, 258, -4, 0x6ED1F6, 235, -4, 0x6ED1F6, 268, 7, 0x6ED1F6, 313, 16, 0x6ED1F6, 331, 16, 0xFFFFFF, 495, 1, 0x87D9F8, 509, 17, 0x6ED1F6, 552, 17, 0x6ED1F6, 569, 11, 0x6ED1F6, 572, 7, 0xBCEAFB, 470, -19, 0x6ED1F6, 546, 1, 0x6ED1F6, 563, 10, 0x6ED1F6, 570, 20, 0xB6E8FA, 570, 22, 0xC6EDFB }, 90, 28, 51, 609, 112);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----群消息加人验证界面1-7.0----");
        return true
    else
        x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, -2, 11, 0x12B7F5, 9, 28, 0x59CCF8, 22, 34, 0xA5E4FB, 25, 34, 0x12B7F5, 38, -5, 0x12B7F5, 77, -3, 0x12B7F5, 141, -3, 0x12B7F5, 175, 1, 0x12B7F5, 167, 21, 0x12B7F5, 162, 32, 0x12B7F5, 109, 30, 0x12B7F5, 100, 20, 0x12B7F5, 141, 18, 0xF7FCFF, 155, 17, 0x12B7F5, 53, 10, 0x12B7F5, 136, 15, 0x12B7F5, 142, 17, 0x12B7F5, 238, 10, 0xFFFFFF, 271, 7, 0x12B7F5, 323, 8, 0xA1E2FB, 347, 11, 0xA7E4FB, 360, 14, 0xF0FAFE, 348, 45, 0x12B7F5, 262, 28, 0x91DEFA, 346, 28, 0xFFFFFF, 362, 28, 0x12B7F5, 245, 15, 0x86DAFA, 335, 15, 0x12B7F5, 355, 15, 0xFFFFFF, 361, 15, 0xFFFFFF, 528, 3, 0xFFFFFF, 570, 3, 0x12B7F5, 608, 3, 0x12B7F5, 599, 22, 0x12B7F5, 594, 28, 0x12B7F5, 559, 28, 0x12B7F5, 589, 26, 0xFFFFFF, 528, 7, 0x12B7F5, 595, 7, 0x12B7F5, 478, -1, 0x12B7F5, 506, 15, 0x12B7F5, 515, 21, 0x12B7F5 }, 90, 16, 62, 626, 112);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            log_info("----群消息加人验证界面2-7.0----");
            return true
        else
            return false
        end
    end
end


local function action_group_message_jiaren_verification() --执行这个页面的操作--
    if gongneng == "group_message_add_friends" then
        cicky(597,980,3000);  --点击删除
        mSleep(1000) 
        if text_shy_verification ~= nil and text_shy_verification[1] ~= nil then
            inputText(text_shy_verification[math.random(#text_shy_verification)])
        else
            inputText("你好")
        end
        mSleep(1000)
        cicky( 577,77,50);   --点击下一步
        mSleep(3000)
        if page_array["page_shy_send_verification"]:check_page() == true then
            page_array["page_shy_send_verification"]:action()
        else
            qq_warning_info("群里加人验证失败");
            mSleep(1000)
            gongneng = "del_message"   --删除这条消息
            return page_array["page_group_message_jiaren_verification"]:enter()
        end
    else
        cicky(60,80,50);  --返回
        mSleep(1000)
        page_array["page_group_message_data"]:enter()
    end
end


--step1 第一步
function group_message_jiaren_verification_page:enter()        --进入页面后的动作--
    if true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function group_message_jiaren_verification_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_group_message_jiaren_verification() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function group_message_jiaren_verification_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_group_message_jiaren_verification()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function group_message_jiaren_verification_page:action()
    return action_group_message_jiaren_verification()
end

page_array["page_group_message_jiaren_verification"] = group_message_jiaren_verification_page:new()
--end page_group_message_jiaren_verification.lua
------------------end:  page\page_group_add_friends\page_group_message_jiaren_verification.lua-------------------------------------




----------------------begin:  page\page_qq_space\page_space_dynamic.lua---------------------------------

default_space_dynamic_page = {
    page_name = "space_dynamic_page",
    page_image_path = nil
}

space_dynamic_page = class_base_page:new(default_space_dynamic_page);

--qq好友动态界面
local function check_page_space_dynamic()
    x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 15, 1, 0x12B7F5, 35, 3, 0x12B7F5, 55, 3, 0x12B7F5, 89, 3, 0x12B7F5, 119, 3, 0x12B7F5, 124, 3, 0x12B7F5, 129, 9, 0x12B7F5, 127, 17, 0xFFFFFF, 113, 17, 0x12B7F5, 65, 17, 0x12B7F5, 33, 17, 0x12B7F5, 15, 17, 0xFFFFFF, 4, 17, 0xFFFFFF, 1, 15, 0x12B7F5, -1, 13, 0x12B7F5, 42, 12, 0x12B7F5, 76, 12, 0x3DC4F7, 97, 12, 0x12B7F5, 126, 14, 0x99E0FB, 126, 24, 0xFFFFFF, 116, 29, 0x12B7F5, 101, 29, 0xD3F2FD, 59, 28, 0x12B7F5, 27, 28, 0x12B7F5, 10, 27, 0x12B7F5, 2, 23, 0xFFFFFF, 3, 22, 0xEAF9FE, 57, 20, 0x12B7F5, 97, 24, 0x12B7F5, 133, 24, 0x12B7F5, 153, 14, 0x12B7F5, 149, 0, 0x12B7F5, 130, 9, 0x12B7F5, 147, 26, 0x12B7F5, 181, 14, 0x12B7F5, 193, 8, 0x12B7F5, 218, 11, 0x12B7F5, 170, 27, 0x12B7F5, 209, 9, 0x12B7F5 }, 90, 257, 66, 476, 95);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----qq好友动态界面7.0-8.0----");
        return true
    else
        return false
    end
end

local num_huadong = 4  --滑动次数
local function action_space_dynamic() --执行这个页面的操作--
    if gongneng == "fashuoshuo" then
        cicky( 582,86,50);    --点击加
        mSleep(1200)
        cicky( 100,172,50);   --点击说说
        mSleep(1000)
        page_array["page_fashuoshuo"]:enter()
    elseif gongneng == "comment_friends_shuoshuo" then
        if num_huadong == 0 then
            qq_warning_info("网络卡或者没什么说说可评论")
            return false
        end
        num_huadong = num_huadong - 1    --次数限制
        move(300,math.random(900,1000),300,math.random(200,300),5)
        mSleep(math.random(1222,2222))
        cicky(math.random(100,300),math.random(200,900),50)   --点击一下
        mSleep(2000)
        if page_array["page_space_dynamic"]:quick_check_page() == true then
           move(300,math.random(900,1000),300,math.random(200,300),5)
           mSleep(1000)
           return page_array["page_space_dynamic"]:action()
        end
        --视频
        x, y = findMultiColorInRegionFuzzy({ 0x1F1F20, -3, -3, 0x1E1E20, -5, -5, 0x1E1E1F, 9, 9, 0x202022, 9, 8, 0x202022, 8, 9, 0x202022, 6, 11, 0x212123, 3, 14, 0x212123 }, 90, 586, 82, 600, 101);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
            -- notifyMessage(111)
            -- mSleep(1000)
            cicky(x,y,50);   --点击叉叉
            mSleep(1000)
            if page_array["page_space_dynamic"]:check_page() == true then
                move(300,math.random(900,1000),300,math.random(200,300),5)
                mSleep(1000)
                return page_array["page_space_dynamic"]:action()
            end
        end
        --文字评论 
        x1, y1 = findMultiColorInRegionFuzzy({ 0xFFFFFF, 32, -3, 0xFFFFFF, 44, 19, 0xFFFFFF, 21, 26, 0xFFFFFF, 7, 22, 0xFFFFFF, 0, 13, 0x999999, 27, 10, 0xFFFFFF, 43, 20, 0xFFFFFF, 13, 15, 0xFFFFFF, 39, 7, 0xA3A3A3, 39, 10, 0xFFFFFF, 541, 4, 0x8A8B8E, 542, 4, 0x8A8B8E, 545, 18, 0x8A8B8E, 533, 27, 0x8A8B8E, 527, 19, 0x8A8B8E, 527, 3, 0xD7D7D8, 531, -2, 0x8A8B8E, 543, 21, 0x8A8B8E, 524, 19, 0x8A8B8E, 260, 7, 0xFFFFFF, 225, 7, 0xFFFFFF, 70, -6, 0xFFFFFF, 10, 4, 0xF1F1F1, 38, 10, 0xFFFFFF, 33, 17, 0xB7B7B7, 120, 17, 0xFFFFFF, 392, 17, 0xFFFFFF, 463, 16, 0xFFFFFF, 504, 17, 0xFFFFFF, 483, 24, 0xFFFFFF, 541, 10, 0x8A8B8E, 547, 10, 0x8A8B8E, 539, 21, 0x8A8B8E, 532, 12, 0x8A8B8E, 532, 12, 0x8A8B8E }, 90, 39, 1072, 586, 1105);
        x2, y2 = findMultiColorInRegionFuzzy({ 0xBFBFBF, 0, -2, 0xBFBFBF, 17, -2, 0xBFBFBF, 17, 0, 0xBFBFBF, 16, 0, 0xBFBFBF, 31, 0, 0xBFBFBF, 32, -1, 0xBFBFBF, 33, -1, 0xBFBFBF, 34, -1, 0xBFBFBF, 34, 0, 0xBFBFBF, -68, -10, 0xBFBFBF, -72, -10, 0xBFBFBF, -78, -10, 0xBFBFBF, -82, -10, 0xBFBFBF, -87, -10, 0xBFBFBF, -87, 3, 0xBFBFBF, -87, 9, 0xBFBFBF, -76, 9, 0xBFBFBF, -80, 15, 0xBFBFBF, -66, 11, 0xBFBFBF, -59, 10, 0xBFBFBF, -60, 6, 0xBFBFBF, -61, 4, 0xBFBFBF, -61, -1, 0xBFBFBF, -63, -6, 0xBFBFBF }, 90, 487, 1077, 608, 1102);
        if x1 ~= -1 or x2 ~= -1 then  -- 如果找到了
            -- notifyMessage(222)
            -- mSleep(1000)
            cicky(68,1093,50);  --点击评论
            mSleep(1000)
            if text_comment_info ~= nil and text_comment_info[1] ~= nil then
                inputText(text_comment_info[math.random(#text_comment_info)])  --输入评论内容
            else
                qq_warning_info("请设置评论内容")
                return false
            end
            mSleep(1000)
            cicky( 579,1084,50);   --点击发送
            mSleep(3000)
            cicky(60,80,50);   --点击返回
            mSleep(1000)
            fanhui_main()   --返回桌面
            return true
        end
        --直接评论
        x, y = findMultiColorInRegionFuzzy({ 0xEBECEE, 9, 15, 0xEBECEE, -3, 37, 0x939494, -11, 26, 0xE6E7E9, -35, 10, 0xDFE0E2, -42, 15, 0xEBECEE, -25, 28, 0xEBECEE, -10, 33, 0xEBECEE, -2, 38, 0xC5C6C7, -24, 31, 0xEBECEE, -30, 11, 0xEBECEE, -18, 0, 0xEBECEE, 9, 0, 0xEBECEE, -4, 21, 0xEBECEE, 56, 3, 0xEBECEE, 49, 21, 0xEBECEE, 74, 26, 0xEBECEE, 72, 3, 0xEBECEE, 71, 3, 0xEBECEE, 77, 26, 0xEBECEE, 57, 35, 0xEBECEE, 53, 10, 0xEBECEE, 62, 3, 0xEBECEE, 75, 8, 0xEBECEE, 61, 33, 0xEBECEE, 38, 23, 0xEBECEE }, 90, 19, 553, 138, 591);
        if x ~= -1 and y ~= -1 then  -- 如果找到了
             if text_comment_info ~= nil and text_comment_info[1] ~= nil then
                inputText(text_comment_info[math.random(#text_comment_info)])  --输入评论内容
            else
                qq_warning_info("请设置评论内容")
                return false
            end
            mSleep(1000)
            cicky( 579,1084,50);   --点击发送
            mSleep(2000)
            fanhui_main()   --返回桌面
            return true
        end
        mSleep(1500)
        cicky(60,80,50);  --返回
        mSleep(1500)
        if page_array["page_space_dynamic"]:check_page() == true then
            move(300,math.random(900,1000),300,math.random(200,300),5)
            mSleep(1000)
            return page_array["page_space_dynamic"]:action()
        else
            qq_warning_info("网络卡或者没说说评论")
            mSleep(500)
            cicky(60,80,50);  --点击返回
            mSleep(1000)
            return false
        end
    else
        cicky(60,82,50);   --返回
        mSleep(1000)
        page_array["page_dongtai"]:enter()
    end
end


--step1 第一步
function space_dynamic_page:enter()        --进入页面后的动作--
    if  true == check_page_suoping() then
        return action_suoping();
    elseif true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function space_dynamic_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_space_dynamic() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function space_dynamic_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_space_dynamic()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function space_dynamic_page:action()
    return action_space_dynamic()
end

page_array["page_space_dynamic"] = space_dynamic_page:new()
--end page_space_dynamic.lua
------------------end:  page\page_qq_space\page_space_dynamic.lua-------------------------------------




----------------------begin:  page\page_qq_space\page_fashuoshuo.lua---------------------------------

default_fashuoshuo_page = {
    page_name = "fashuoshuo_page",
    page_image_path = nil
}

fashuoshuo_page = class_base_page:new(default_fashuoshuo_page);

---发说说界面
local function check_page_fashuoshuo()
    x, y = findMultiColorInRegionFuzzy({ 0x12B7F5, 43, -1, 0x12B7F5, 75, -1, 0x12B7F5, 47, 37, 0x12B7F5, 27, 33, 0x12B7F5, -5, 13, 0x12B7F5, 45, -3, 0x12B7F5, 60, 12, 0x42C6F7, 16, 12, 0x12B7F5, 13, 10, 0xFFFFFF, 35, 8, 0x1EBBF6, 256, 1, 0x20BBF6, 319, -3, 0x12B7F5, 338, 4, 0x12B7F5, 340, 19, 0x12B7F5, 283, 25, 0xFFFFFF, 248, 9, 0x12B7F5, 271, -7, 0x12B7F5, 335, 6, 0x42C6F7, 339, 10, 0x75D5F9, 259, 17, 0xFFFFFF, 259, 17, 0xFFFFFF, 301, 9, 0x1DBAF5, 338, 13, 0xFFFFFF, 540, -4, 0x12B7F5, 602, 4, 0x12B7F5, 603, 8, 0x12B7F5, 565, 21, 0x5CCEF8, 535, 12, 0x12B7F5, 537, 18, 0x71D4F9, 573, 9, 0x12B7F5, 553, -4, 0x12B7F5, 545, -1, 0x71D4F9 }, 90, 22, 62, 630, 106);
    if x ~= -1 and y ~= -1 then  -- 如果找到了
        log_info("----发说说界面----");
        return true
    else
        return false
    end
end


local function action_fashuoshuo() --执行这个页面的操作--
    if gongneng == "fashuoshuo" then
        if text_shuoshuo_info ~= nil and text_shuoshuo_info[1] ~= nil  then
            cicky(76,154,50);   --点击输入
            mSleep(1000)
            inputText(text_shuoshuo_info[math.random(#text_shuoshuo_info)])   --输入说说内容
            mSleep(1000)
            cicky( 591,78,50);   --点击发表
            mSleep(2000)
        else
            qq_warning_info("没有发说说说内容")
            mSleep(1000)
            cicky(60,80,50);   --点击取消
            mSleep(1000)
            return false
        end
    else
        cicky(60,80,50);   --点击取消
        mSleep(1000)
        page_array["page_space_dynamic"]:enter()
    end
end


--step1 第一步
function fashuoshuo_page:enter()        --进入页面后的动作--
    if  true == check_page_suoping() then
        return action_suoping();
    elseif true == self.check_page(self) then
        return self.action(self)
    else
        self:error_handling();
    end
end

--step2 第二步检查当前页面
function fashuoshuo_page:check_page()  --检查是否是在当前页面--
    local time = 1
    while 3 > time do
        mSleep(1000*time);   --休眠一会会
        if true ==  check_page_fashuoshuo() then 
            return true;
        else          
            time = time + 1;
        end
    end
    return false;
end

function fashuoshuo_page:quick_check_page()  --快速检查是否是在当前页面--
    return check_page_fashuoshuo()
end

--step3  第三步执行操作，最主要的工作都在这个里面
function fashuoshuo_page:action()
    return action_fashuoshuo()
end

page_array["page_fashuoshuo"] = fashuoshuo_page:new()
--end page_fashuoshuo.lua
------------------end:  page\page_qq_space\page_fashuoshuo.lua-------------------------------------




----------------------begin:  func\qq_main\qq_main.lua---------------------------------
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



------------------end:  func\qq_main\qq_main.lua-------------------------------------
