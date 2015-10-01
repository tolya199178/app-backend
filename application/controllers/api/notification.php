<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class notification extends Backend_Controller {
    /**
     * 
     */
    public function index() {
        
    }
    
    public function getallnotificationsbyuser(){
        $param =  $_REQUEST;
        if(isset($param['user_id'])){
            $user_id = $param['user_id'];
        }else{
            $user = $this->getUser();
            $user_id = $user['id'];
        }
        $only_unread = $param['only_unread'];
        $this->load->model('notifications_m', 'notificationModel');
        $rows = $this->notificationModel->getNotificationByUserId($user_id, $only_unread);
        echo json_encode(array('result' => true, 'object' => $rows));
    }
    
    public function confirmnotification(){
        $param =  $_REQUEST;
        $id = $param['id'];
        $this->load->model('notifications_m', 'notificationModel');
        $this->notificationModel->confirmNotification($id);
        echo json_encode(array('result' => true));
    }
    
    public function deletenototification(){
        $param =  $_REQUEST;
        $id = $param['id'];
        $this->load->model('notifications_m', 'notificationModel');
        $this->notificationModel->deleteNotification($id);
        echo json_encode(array('result' => true));
    }
}
