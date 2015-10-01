<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class user_friends_m extends CI_Model {

    const T_NAME = 'user_friends';

    public function getFrinedIds($userId, $onlyKeys = true) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE user_id=%s ORDER BY `created_date` ASC", self::T_NAME, $userId
        );
        $rows = $this->db->query($sql)->result_array();
        $friendIds = array();
        if (count($rows) > 0) {
            foreach ($rows as $row) {
                $friendIds[] = $row['frined_id'];
            }
        }
        if ($onlyKeys == true) {
            return $friendIds;
        } else {
            $this->load->model('users_m', 'userModel');
            $users = $this->userModel->getUsersByIds($friendIds);
            return $users;
        }
    }

    public function addFriend($userId, $friendId) {
        $friendIds = $this->getFrinedIds($userId);
        if (in_array($friendId, $friendIds) == false) {
            $this->db->insert(self::T_NAME, array('user_id'=>$userId, 'frined_id'=>$friendId, 'created_date'=>date("Y-m-d H:i:s")));           
            $newId = $this->db->insert_id();
            /**
             *  Add Notification
             */
            $this->load->model('users_m', 'userModel');
            $user = $this->userModel->getUserById($userId);            
            $text = sprintf(
                    "%s %s added you as a frined", $user['first_name'], $user['last_name']
            );
            $notifcation = array('user_id' => $friendId, 'content'=>$text, 'data'=>$user['id'], 'alert_type'=>'Add friend');
            
            $this->load->model('notifications_m', 'notificationModel');
            $this->notificationModel->insertNotification($notifcation);
            
            /**
             * @todo APNS
             */
            
            
            return $newId;
        } else {
            return false;
        }
    }
}
