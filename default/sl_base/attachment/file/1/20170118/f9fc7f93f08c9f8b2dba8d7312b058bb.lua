local lua_value = "空闲时间： "
--local my_time = 8000;
lua_value = lua_value .. tostring(sl_idle_time)
notifyMessage(lua_value);
mSleep(sl_idle_time);