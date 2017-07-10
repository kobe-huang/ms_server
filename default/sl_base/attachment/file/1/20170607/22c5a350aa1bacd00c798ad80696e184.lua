       
function function_name( ... )
        a = get_var_item("var_user_id")
        mSleep(1000)
       b = get_var_item("var_ms_index")
        mSleep(1000)
      notifyMessage(a)
      mSleep(1000)
      notifyMessage(b)
      mSleep(1000)
      return reset_ms_server()  --复位
end

function_name