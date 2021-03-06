sl_log_file       = "/private/var/touchelf/scripts/sl/sl_log.txt" --配置文件
sl_error_time     = 3 ;  --容错处理
try_time  =   1     --等待时间/s
strategy = {"1"}    ;     --策略 =1 -- 2  

--判断文件是否存在
function file_exists(path)
  local file = io.open(path, "rb")
  if file then file:close() end
  return file ~= nil
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

--写字串到到文件中--
function writeStrToFile(mystring, file)
    local f = io.open(file, 'a');
    f:write(mystring .. "\r\n");
    f:close();
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
    notifyMessage(out_info);
    local time = get_local_time(); 
    writeStrToFile("info:  " .. time .. out_info , sl_log_file);    
end

function time()
    mSleep(1500)
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    time1 = os.time()
    tt1 = os.date("*t", time1);
    mSleep(2000);
    while true do 
        mSleep(1000)
        time2 = os.time()
        tt2 = os.date("*t", time2);
        logFileInit(sl_log_file);
        log_info(tt2.hour.."点")
        mSleep(1000)
        if tt2.day ~= tt1.day and tt2.hour >= 8 then
            notifyMessage("复位,等待一下重新开始运行脚本")
            mSleep(math.random(1000,1500000));
            logFileInit(sl_log_file);
            log_info("复位，重新开始运行脚本")
            mSleep(1000);
            return reset_ms_server()   ---复位
        else
            notifyMessage("休眠到8点");
            mSleep(600000);
        end
    end
end

time()