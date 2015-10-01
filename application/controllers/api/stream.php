<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class stream extends Backend_Controller {

    /**
     * 
     */
    public function index() {
        
    }

    public function addstream() {
        $param = $_REQUEST;
        if (isset($param['user_id'])) {
            $userId = $param['user_id'];
        } else {
            $user = $this->getUser();
            $userId = $user['id'];
        }
        $this->load->model('streams_m', 'streamModel');
        $stream = array(
            'title' => $param['title'],
            'content' => $param['content'],
            'image_url' => $param['image_url'],
            'user_id' => $userId
        );
        $newId = $this->streamModel->insertStream($stream);
        $stream = $this->streamModel->getStreamById($newId);
        echo json_encode(array('result' => true,'object'=>$stream));
        die();
    }

    public function updatestream() {
        $param = $_REQUEST;
        $id = $param['stream_id'];      
        $stream = array();        
        if(isset($param['title'])){
            $stream['title'] = $param['title'];
        }
        if(isset($param['content'])){
            $stream['content'] = $param['content'];
        }
        if(isset($param['image_url'])){
            $stream['image_url'] = $param['image_url'];
        }
        $this->load->model('streams_m', 'streamModel');
        $this->streamModel->updateStream($id, $stream);
        $stream = $this->streamModel->getStreamById($id);
        echo json_encode(array('result' => true,'object'=>$stream));
        die();
    }

    public function deletestream() {
        $param = $_REQUEST;
        $id = $param['stream_id'];
        $this->load->model('streams_m', 'streamModel');
        $this->streamModel->deleteStream($id);
        echo json_encode(array('result' => true));
    }

    public function getallstreams() {
       $this->load->model('streams_m', 'streamModel');
       $streams = $this->streamModel->getAllStream();
       echo json_encode(array('result' => true, 'object'=>$streams));
    }

    public function getstreambyid() {
        $param = $_REQUEST;
        $id = $param['stream_id'];
        $this->load->model('streams_m', 'streamModel');
        $stream =$this->streamModel->getStreamById($id);
        echo json_encode(array('result' => true, 'object'=>$stream));
    }

    public function getstreamsbyuser() {
        $param = $_REQUEST;
        if (isset($param['user_id'])) {
            $userId = $param['user_id'];
        } else {
            $user = $this->getUser();
            $userId = $user['id'];
        }
        $this->load->model('streams_m', 'streamModel');
        $streams =$this->streamModel->getStreamsByUserId($userId);
        echo json_encode(array('result' => true, 'object'=>$streams));
    }

    public function sharestream() {
        $param = $_REQUEST;
        $id = $param['stream_id'];
        if (isset($param['user_id'])) {
            $userId = $param['user_id'];
        } else {
            $user = $this->getUser();
            $userId = $user['id'];
        }
        echo json_encode(array('result' => true));
    }

    public function inviteusers() {
        $param = $_REQUEST;
        $id = $param['stream_id'];        
        $userIds = $param['user_ids'];
        $userIds = explode(',', $userIds);
        $this->load->model('stream_users_m', 'streamUserModel');
        foreach($userIds as $userId){
            $this->streamUserModel->assignUser($id, $userId);
        }
        echo json_encode(array('result' => true));
    }
    
    
    public function confirminvite(){
        $param = $_REQUEST;
        if (isset($param['user_id'])) {
            $userId = $param['user_id'];
        } else {
            $user = $this->getUser();
            $userId = $user['id'];
        }
        $stream_id = $param['stream_id'];
        $flag = $param['response'];
        $this->load->model('stream_users_m', 'streamUserModel');
        $this->streamUserModel->confirmInvite($userId, $stream_id, $flag);
        echo json_encode(array('result' => true));
    }
}
