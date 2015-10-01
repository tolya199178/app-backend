<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class follow extends Backend_Controller {
    /**
     * 
     */
    public function index() {
       
    }
    
    
    public function followuser(){
        $param =  $_REQUEST;
        if(isset($param['user_id'])){
            $user_id = $param['user_id'];
        }else{
            $user = $this->getUser();
            $user_id = $user['id'];
        }
        $followId = $param['follow_id'];        
        $this->folowModel->follow($user_id, $followId);
        
        echo json_encode(array('result' => true));
    }	
	
    public function unfollowuser(){
		$param =  $_REQUEST;
        if(isset($param['user_id'])){
            $user_id = $param['user_id'];
        }else{
            $user = $this->getUser();
            $user_id = $user['id'];
        }
        $followIds = $param['follow_ids'];
        $followIds = explode(',', $followIds);        
        $this->load->model('user_follows_m', 'folowModel');
        foreach($followIds as $followId){
            $this->folowModel->unfollow($user_id, $followId);
        }
        echo json_encode(array('result' => true));
	}
    
    
    public function getfollowuser(){
        $param =  $_REQUEST;
        if(isset($param['user_id'])){
            $user_id = $param['user_id'];
        }else{
            $user = $this->getUser();
            $user_id = $user['id'];
        }
         $this->load->model('user_follows_m', 'folowModel');
        $users = $this->folowModel->getFollowIds($user_id, false);
        echo json_encode(array('result' => true,'object'=>$users));        
    }
    
    public function getfollowinguser(){
         $param =  $_REQUEST;
        if(isset($param['user_id'])){
            $user_id = $param['user_id'];
        }else{
            $user = $this->getUser();
            $user_id = $user['id'];
        }
        $this->load->model('user_follows_m', 'folowModel');
        $users = $this->folowModel->getFollowingIds($user_id, false);
        echo json_encode(array('result' => true,'object'=>$users));  
    }
}
