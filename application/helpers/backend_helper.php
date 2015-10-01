<?php

function is_unchekpage($controllerName, $actionName) {    
    $str = strtolower($controllerName . '.' . $actionName);
    return in_array($str, array(
        'publicapi.index',
        'publicapi.login',
        'publicapi.facebooklogin',
        'publicapi.register',
	'posts.getfoodposts',
        'posts.getvendorposts',
        'user.getvendorbyid',
        'publicapi.forget_password',
        'publicapi.check_uniqueloginname',
        'publicapi.check_uniqueemail',
        'publicapi.file_upload',
    ));
}


    
 function generator_random_string(){
     return md5(uniqid(mt_rand(), true));
 }
