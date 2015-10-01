<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class user extends Backend_Controller {

    /**
     * 
     */
    public function index() {
        
    }

    public function getuserlist() {
        $this->load->model('users_m', 'userModel');
        $users = $this->userModel->getUserList();
		
		$currentUser = $this->getUser();        
		if($currentUser){		
			$user_id = $currentUser['id'];
			$this->load->model('user_follows_m', 'folowModel');
			$followIds = $this->folowModel->getFollowIds($user_id, true);
			if(count($users) > 0){
				foreach($users as &$user){
					if(in_array($user['id'], $followIds)){
						$user['is_following'] = true;
					}else{
						$user['is_following'] = false;	
					}
				}
			}
		}
		
		
        echo json_encode(array('result' => true, 'object' => $users));
        die();
    }

    public function getvendorbyid() {
        $this->load->model('users_m', 'userModel');
        $id = $_REQUEST['user_id'];
        $user = $this->userModel->getUserById($id);
        if(count($user) == 0){
            $this->show400error("No Exist User");
        }else{
//            $this->load->model('user_follows_m', 'followModel');
//            $followUsers = $this->folowModel->getFollowIds($id, false);
//            $followingUsers = $this->folowModel->getFollowingIds($id, false);
//            $user['followers_count'] = count($followUsers);
//            $user['followings_count'] = count($followingUsers);
//            $this->load->model('streams_m', 'streamsModel');            
//            $user['streams'] = $this->streamsModel->getStreamsByUserId($id);			
			
            $currentUser = $this->getUser();        
            if($currentUser){		
		$user_id = $currentUser['id'];
		$this->load->model('user_follows_m', 'followModel');
		$followIds = $this->followModel->getFollowIds($user_id, true);
		if(in_array($user['id'], $followIds)){
                	$user['is_following'] = true;
		}else{
                        $user['is_following'] = false;
		}
            }
	    
            $this->load->model('posts_m', 'postModel');
            $foodresponse = $this->postModel->getFoodPostsByUserId($user['id']);
            if ($foodresponse == false) {
                $user['foodPhotos'] = '';
            } else {
                $user['foodPhotos'] = $foodresponse;
            }
            
            $this->load->model('user_menus_m', 'menuModel');
            $menuresponse = $this->menuModel->getMenuByVendorId($user['id']);
            if(count($menuresponse) > 0){                
                $user['menu'] = $menuresponse;
            } else {
                $user['menu'] = '';
            }
            
            $this->load->model('user_schedule_m', 'scheduleModel');
            $scheduleresponse = $this->scheduleModel->getScheduleByVendorId($user['id']);
            if(count($scheduleresponse) > 0){                
                $user['schedule'] = $scheduleresponse;
            } else {
                $user['schedule'] = '';
            }
            
            echo json_encode(array('result' => true, 'object' => $user));
            die();
        }        
    }

    public function updateuser() {
        $row =  $_REQUEST;
        if(isset($row['id'])){
            $id = $row['id'];
        }else{
            $user = $this->getUser();
            $id = $user['id'];
        }
        
        $user = array();
        
        if(isset($row['login_name'])){
            $user['login_name'] = $row['login_name'];
        }
        if(isset($row['first_name'])){
            $user['first_name'] = $row['first_name'];
        }
        if(isset($row['last_name'])){
            $user['last_name'] = $row['last_name'];
        }
        if(isset($row['email_addr'])){
            $user['email_addr'] = $row['email_addr'];
        }
        if(isset($row['photo_url'])){
            $user['photo_url'] = $row['photo_url'];
        }
        if(isset($row['passwd'])){
            $user['passwd'] = $row['passwd'];
        }
        if(isset($row['device_token'])){
            $user['device_token'] = $row['device_token'];
        }
        
        //update user
        $this->userModel->updateUser($id, $user);
        $user = $this->userModel->getUserById($id);
        echo json_encode(array('result'=>true,'object'=>$user));
        die();
    }

    public function deleteuser() {
        $row =  $_REQUEST;
        if(isset($row['id'])){
            $id = $row['id'];
        }else{
            $user = $this->getUser();
            $id = $user['id'];
        }
        $user = $this->userModel->getUserById($id);
        if(count($user) > 0){
            $this->userModel->deleteUser($id);
            echo json_encode(array('result'=>true));
            die();
        }else{
            $this->show400error("No Exist User Id");
        }        
    }    
}
