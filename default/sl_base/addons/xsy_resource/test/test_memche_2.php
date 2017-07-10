<?php

header('Content-Type:text/html;charset=utf-8'); 
//require_once '../../../framework/bootstrap.inc.php';
//必须要打开，不然重新加载后，cache函数会报错
//default_server_addr = "http://120.76.215.162/sl_base/addons/xsy_resource/test/test_memche.php?task="
$get=$_GET;

$contact = array(                                             //定义外层数组
    //array(1,'huang' => '高某','A公司','北京市','(010)987654321','gm@Linux.com'),//子数组1
    //array(2,'洛某','B公司','上海市','(021)123456789','lm@apache.com'),//子数组2
    //array(3,'峰某','C公司','天津市','num' => '(022)24680246','fm@mysql.com'),  //子数组3
    array(4,'书某','D公司','重庆市','(023)13579135','sm@php.com'),     //子数组4
    array(5, 'huang', array('okbe', 'tttt', 'kkkk') )
    );

 function print_2_array($contact1)
 {
    //for($row=0; $row<count($contact1); $row++)
    foreach ($contact1 as $key1 => $value1) {   
        //error_log($key1);
        //使用内层循环遍历数组$contact1 中 子数组的每个元素,使用count()函数控制循环次数
        $out_string = "";
        //for($col=0; $col<count($contact1[$row]); $col++)
        foreach ( $contact1[$key1] as $key => $value ) {
             $out_string = $out_string . "  " . $contact1[$key1][$key];
            # code...
        }
        error_log($out_string);   
    }
}

function print_n_array($contact1)
{
    //for($row=0; $row<count($contact1); $row++)
    foreach ($contact1 as $key1 => $value1) {   
        //error_log($key1);
        //使用内层循环遍历数组$contact1 中 子数组的每个元素,使用count()函数控制循环次数
        if ( true == is_array($contact1[$key1]) )
        {
            print_n_array($contact1[$key1]);
        } else{
            error_log( $key1 . " => " . $contact1[$key1]);
        }
        
    }
}

error_log("-------");
print_n_array($_GET);
error_log("+++++++");
print_n_array($_GPC);
error_log("+++--+++");
error_log($_W['uniacid']);
$_W['uniacid'] = 21;
test_cache($contact);


 function test_cache($contact1){
 	print_n_array($contact1);
 	$my_key = "huangyinke";
 	error_log("step1");
 	cache_write($my_key, $contact1);
 	error_log("step2");
 	$my_value = cache_read($my_key);
 	print_n_array($contact1);

 }

//test_cache($contact);