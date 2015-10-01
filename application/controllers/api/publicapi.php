<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class publicapi extends Backend_Controller {

    /**
     * 
     */
    public function index() {
        
    }
    /**
     * 
     */
    public function login() {
        $row = $_REQUEST;
        $this->load->model('users_m', 'userModel');
        $email = $row['email'];        
        $passwd = $row['password'];
        $user = $this->userModel->login($email, $passwd);
        if ($user == false) {
            echo json_encode(array('result' => false, 'message' => 'Does not exist'));
        } else {
            $this->userModel->updateUser($user['id'], array(
                'token' => generator_random_string(),
                'device_token' => $row['device_token']
            ));
            $row = $this->userModel->getUserById($user['id']);
            echo json_encode(array('result' => true, 'token' => $row['token'], 'object' => $row));
        }
        die();
    }
    
    /** 
     * @param facebookid
     * @param email
     * @param name
     * @param photo_url     
     * 
     */
    public function facebooklogin() { 
        $row = $_REQUEST;   
        $this->load->model('users_m', 'userModel');
        $facebookId = $row['facebookid'];
        $user = $this->userModel->facebooklogin($facebookId);
        
        if ($user == false) {            
            $user = array(
            'user_name' => $row['username'],
            'user_avatarpath' => $row['avatarPhotoUrl'],
            'email_addr' => $row['email'],           
            'facebook_id' => $row['facebookid'],         
            'device_token' => $row['deviceToken'],
            'user_type' => $row['userType'],
            'user_lat' => $row['userLatitude'],
            'user_long' => $row['userLongitude']              
        );
            //add user
            $newId = $this->userModel->insertUser($user);            
            $user['id'] = $newId;
            echo json_encode(array('result' => true, 'object' => $user));
            die();
        } else {
            $this->userModel->updateUser($user['id'], array(
                'token' => generator_random_string(),
                'device_token' => $row['deviceToken']
            ));
            $row = $this->userModel->getUserById($user['id']);
            echo json_encode(array('result' => true, 'token' => $row['token'], 'object' => $row));
        }
    }

    /**
     * 
     */
    public function register() {
        $row = $_REQUEST;
        $this->load->model('users_m', 'userModel');
        $deviceToken = '';
        
        $user = $this->userModel->getUserByVendorLoginName($row['username']);
        if (sizeof($user) > 0) {
            $this->show400error("Exist Vendor Name");
        }
        $user = $this->userModel->getUserByVendorEmail($row['email']);
        if (sizeof($user) > 0) {
            $this->show400error("Exist Vendor Email");
        }            
        if (isset($row['deviceToken']) == TRUE) {                
            $deviceToken = $row['deviceToken'];
        }
        $user = array(
            'user_name' => $row['username'],                
            'email_addr' => $row['email'],
            'passwd' => $row['password'],
            'user_type' => $row['usertype'],
            'facebook_id' => '',
            'user_lat' => $row['latitude'],
            'user_long' => $row['longitude'],                
            'token' => generator_random_string(),
            'device_token' => $deviceToken
        );
        //add user
        $newId = $this->userModel->insertUser($user);
        $user['id'] = $newId;
        echo json_encode(array('result' => true, 'object' => $user));        
        die();
    }
    /**
     *
     */
    public function forget_password() {
        $row = $_REQUEST;
        $this->load->model('users_m', 'userModel');
        $user = $this->userModel->getUserByEmailId($row['email_addr']);
        if (sizeof($user) == 0) {
            echo json_encode(array('result' => false, 'message' => 'No Exist Email Address'));
        } else {
            $this->userModel->updateUser($user['id'], array('reset_token' => generator_random_string()));
            /**
             * @todo
             * Send Email to User
             */
            echo json_encode(array('result' => true));
        }
        die();
    }

    /**
     * 
     */
    public function check_uniqueloginname() {
        $row = $_REQUEST;
        $this->load->model('users_m', 'userModel');
        $user = $this->userModel->getUserByLoginName($row['login_name']);
        if (!$row['login_name']) {
            $this->show400error("");
        }
        if (sizeof($user) > 0) {
            echo json_encode(array('result' => false, 'message' => 'Exist Login Name'));
        } else {
            echo json_encode(array('result' => true));
        }
        die();
    }

    /**
     * 
     */
    public function check_uniqueemail() {
        $row = $_REQUEST;
        $this->load->model('users_m', 'userModel');
        $user = $this->userModel->getUserByEmailId($row['email_addr']);
        if (!$row['email_addr']) {
            $this->show400error("");
        }
        if (sizeof($user) > 0) {
            echo json_encode(array('result' => false, 'message' => 'Exist Email Address'));
        } else {
            echo json_encode(array('result' => true));
        }
        die();
    }

    public function file_upload() {
        $config['upload_path'] = './assets/uploads/';
        $config['allowed_types'] = 'gif|jpg|png|jpeg|pdf|doc|xml';
        $config['max_size'] = '10000';
        $this->load->library('upload', $config);
        if (!$this->upload->do_upload()) {
            $error = array('error' => $this->upload->display_errors());
            echo json_encode(array('result' => true, 'object'=>$error));
//            $this->load->view('api/upload_form', $error);
        } else {
            $data = array('upload_data' => $this->upload->data());            
            $src = site_url().'/assets/uploads/'.$data['upload_data']['file_name'];
            echo json_encode(array('result' => true, 'object'=>array('file_url'=>$src)));
            //            $this->load->view('api/upload_success', $error);
        }
    }

}
