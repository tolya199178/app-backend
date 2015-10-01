<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class MY_Controller extends CI_Controller {
    
}

class Clent_Controller extends MY_Controller {    

}
class Admin_Controller extends MY_Controller {    

}

class Backend_Controller extends MY_Controller {
    
    private $_user = null;
    
    public function __construct() {
        parent::__construct();        
        $this->load->helper('backend');
        if($this->_checkAcess() == false){
            $this->show403error();
        }
    }
    
    private function _checkAcess(){
        $controllerName = $this->uri->rsegments[1];
        $actionName = $this->uri->rsegments[2];
        if(is_unchekpage($controllerName, $actionName) == true){
            return true;
        }
        $this->load->model('users_m', 'userModel');
        $user = $this->userModel->getUserByToken($_REQUEST['authorization_token']);
        if (sizeof($user) == 0) {
            return false;
        }else{
            $this->setUser($user);
            return true;
        }        
    }
    
    public function show403error(){
        http_response_code(403);
        echo json_encode([
            'result' => false,
            'type' => 'Unauthorized'
        ]);
        die();
    }
    
    public function show400error($msg=""){
        http_response_code(400);
        echo json_encode([
            'result' => false,
            'type' => 'InvalidParameter',
            'message' => $msg
        ]);
        die();
    }
    
    public function setUser($user){
        $this->_user = $user;
    }
    
    public function getUser(){
        return $this->_user;
    }
}
