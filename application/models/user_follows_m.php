<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class user_follows_m extends CI_Model {

    const T_NAME = 'user_follows';

    public function getFollowIds($userId, $onlyKeys = true) {
        if ($onlyKeys == true) {
            $sql = sprintf(
                    "SELECT * FROM %s WHERE user_id=%s ORDER BY `created_date` DESC", self::T_NAME, $userId
            );
            $rows = $this->db->query($sql)->result_array();
            $followIds = array();
            if (count($rows) > 0) {
                foreach ($rows as $row) {
                    $followIds[] = $row['follow_id'];
                }
            }
            return $followIds;
        } else {
            $sql = sprintf(
                    "SELECT t1.created_date as follow_date, t2.* FROM `user_follows` as t1 Join users as t2 on t1.follow_id = t2.id WHERE t1.user_id='%d' ORDER BY `follow_date` DESC", $userId
            );            
            $rows = $this->db->query($sql)->result_array();
            return $rows;
        }
    }

    public function getFollowingIds($userId, $onlyKeys = true) {
        if ($onlyKeys == true) {
            $sql = sprintf(
                    "SELECT * FROM %s WHERE follow_id=%s ORDER BY `created_date` DESC", self::T_NAME, $userId
            );
            $rows = $this->db->query($sql)->result_array();
            $followIds = array();
            if (count($rows) > 0) {
                foreach ($rows as $row) {
                    $followIds[] = $row['user_id'];
                }
            }
            return $followIds;
        } else {
             $sql = sprintf(
                    "SELECT t1.created_date as follow_date, t2.* FROM `user_follows` as t1 Join users as t2 on t1.user_id = t2.id WHERE t1.follow_id='%d' ORDER BY `follow_date` DESC", $userId
            );
             
            $rows = $this->db->query($sql)->result_array();
            return $rows;
        }
    }

    public function follow($userId, $followId) {        
        $followIds = $this->getFollowIds($userId);
        if (in_array($followId, $followIds) == false) {
            $this->db->insert(self::T_NAME, array('user_id' => $userId, 'follow_id' => $followId, 'created_date' => date("Y-m-d H:i:s")));
            
            $newId = $this->db->insert_id();
            /**
             *  Add Notification
             */
            $this->load->model('users_m', 'userModel');
            $user = $this->userModel->getUserById($userId);            
            $text = sprintf(
                    "%s %s followed you", $user['first_name'], $user['last_name']
            );
            $notifcation = array('user_id' => $followId, 'content'=>$text, 'data'=>$user['id'], 'alert_type'=>'Follow');           
           
            
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
	public function unfollow($userId, $followId) {
        $followIds = $this->getFollowIds($userId);
        if (in_array($followId, $followIds) == true) {
            return $this->db->delete(self::T_NAME, array('user_id' => $userId,'follow_id' => $followId));            
        } else {
            return false;
        }
    }

}
