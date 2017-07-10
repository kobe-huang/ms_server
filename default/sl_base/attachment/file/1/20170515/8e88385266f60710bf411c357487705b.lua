local time = os.time()
local tt = os.date("*t", time);
mSleep(1000)
if tt.hour >= 22 or tt.hour < 2  then
    gongneng = 3.4  --站街
else  
    mSleep(2000)
    keyDown('HOME');    -- HOME键按下
    mSleep(100);        --延时100毫秒
    keyUp('HOME');      -- HOME键抬起
    mSleep(2000);
    gongneng = "暂停"
    notifyMessage("返回手机主界面")
    mSleep(1000)
end


