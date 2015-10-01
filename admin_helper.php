<?php

function get_supper_admin_loginid() {
    return "admin";
}

function get_admin_roles() {
    return array('investors', 'financing', 'reporting');
}

function get_supper_admin_rolename() {
    return "superadmin";
}

function get_allinclude_rolename() {
    return "all";
}

function identical_values($arrayA, $arrayB) {
    sort($arrayA);
    sort($arrayB);
    return $arrayA == $arrayB;
}

function get_email_config() {
    return array('protocol' => 'smtp',
        'smtp_host' => 'ssl://smtp.googlemail.com',
        'smtp_port' => 465,
        'smtp_user' => 'jinpung78@gmail.com', // change it to yours
        'smtp_pass' => 'Riseofnations', // change it to yours
        'mailtype' => 'text',
        'charset' => 'iso-8859-1',
        'wordwrap' => TRUE
    );
//    return array('mailtype' => 'text');
}

function get_server_emailaddr() {
    return "jinpung78@gmail.com";
}

function is_unchekpage($controllerName, $actionName) {
    $str = strtolower($controllerName . '.' . $actionName);
    return in_array($str, array('login.index', 'login.logout'));
}

function get_role_acesspage($roleName) {
    $rule = array(
        'basicuser' => array('login.index',
            'login.logout'),
        'investors' => array('investordashboard.*'),
        'financing' => array(),
        'reporting' => array(),
    );
    return $rule[$roleName];
}

function is_action($pages, $controllerName, $actionName) {
    foreach ($pages as $page) {
        list($controller, $action) = explode('.', $page);
        if ($controller == $controllerName && ($action == "*" || $action == $actionName))
            return true;
    }
    return false;
}

function is_accesspage($roles, $controllerName, $actionName) {
    $controllerName = strtolower($controllerName);
    $actionName = strtolower($actionName);
    $roles[] = 'basicuser';
    foreach ($roles as $role) {
        $accesspage = get_role_acesspage($role);
        if (is_array($accesspage) == true && sizeof($accesspage) > 0 && is_action($accesspage, $controllerName, $actionName) == true)
            return true;
    }
    return false;
}

function is_useraccesspage() {
    $CI = & get_instance();
    if ($CI->session->userdata('is_super') == 1) {
        return true;
    }
   
    if (is_accesspage($CI->session->userdata('roles'), $controllerName, $actionName) == false) {
        return false;
    }
    return true;
}
