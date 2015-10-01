<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class frined extends Backend_Controller {
    
    /**
     * 
     */
    public function index() {
       
    }
    
    public function addfriend(){
        $param  = $_REQUEST;
        if(isset($param['user_id'])){
            $id = $param['user_id'];
        }else{
            $user = $this->getUser();
            $id = $user['id'];
        }
        $frienIds = $param['friendids'];
        $frienIds = explode(',', $frienIds);
        $this->load->model('user_friends_m', 'friendModel');
        foreach($frienIds as $frienId){
            $this->friendModel->addFriend($id, $frienId);
        }
        echo json_encode(array('result'=>true));
        die();
    }
    
    
    public function getfriendsbyuserId(){
        if(isset($param['user_id'])){
            $id = $param['user_id'];
        }else{
            $user = $this->getUser();
            $id = $user['id'];
        }
        $this->load->model('user_friends_m', 'friendModel');
        $users = $this->friendModel->getFrinedIds($id, false);
        echo json_encode(array('result'=>true,'object'=>$users));
        die();
    }
}
