sl_log_file       = "/private/var/touchelf/scripts/sl/sl_log.txt" --配置文件
sl_error_time     = 3 ;  --容错处理
try_time  =   1     --等待时间/s
strategy = {"1"}    ;     --策略 =1 -- 2 -- 3 

gong_neng ={"返回","返回","home","等待","home","home","返回","home","返回","home","返回","home"}

gong_neng = gong_neng[math.random(#gong_neng)]

function test( ... )
    log_info("返回or等待")
    if gong_neng == "等待" then
        mSleep(1000);
        gongneng = "暂停"
        notifyMessage("等待到这里")
        mSleep(1000)
    elseif gong_neng == "home" then  --返回手机主界面
        mSleep(2000)
        keyDown('HOME');    -- HOME键按下
        mSleep(100);        --延时100毫秒
        keyUp('HOME');      -- HOME键抬起
        mSleep(2000);
        gongneng = "暂停"
        notifyMessage("返回手机主界面")
        mSleep(1000)
    else
        gongneng = "返回"
        notifyMessage("返回微信首界面")
        mSleep(1000)
    end
end

test()