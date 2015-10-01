<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class stream_users_m extends CI_Model {

    const T_NAME = 'stream_users';

    public function getAssignedUsers($streamId, $onlyKeys = true) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE stream_id=%s ORDER BY `created_date` ASC", self::T_NAME, $streamId
        );
        $rows = $this->db->query($sql)->result_array();
        $userIds = array();
        if (count($rows) > 0) {
            foreach ($rows as $row) {
                $userIds[] = $row['user_id'];
            }
        }
        if ($onlyKeys == true) {
            return $userIds;
        } else {
			if(count($userIds) > 0){
				$this->load->model('users_m', 'userModel');
				$users = $this->userModel->getUsersByIds($userIds);
				return $users;
			}else{
				return array();
			}            
        }
    }

    public function assignUser($streamId, $userId) {
        $assignedUserIds = $this->getAssignedUsers($streamId);
        if (in_array($userId, $assignedUserIds) == false) {
            $this->db->insert(self::T_NAME, array('stream_id' => $streamId, 'user_id' => $userId, 'created_date' => date("Y-m-d H:i:s")));

            $newId = $this->db->insert_id();
            /**
             *  Add Notification
             */
            $this->load->model('streams_m', 'streamModel');
            $stream = $this->streamModel->getStreamById($streamId);

            $this->load->model('users_m', 'userModel');
            $user = $this->userModel->getUserById($stream['user_id']);


            $text = sprintf(
                    "%s %s invited you to their stream %s", $user['first_name'], $user['last_name'], $stream['title']
            );
            $notifcation = array('user_id' => $userId, 'content' => $text, 'data' => $streamId, 'alert_type' => 'Invite Stream');

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

    public function confirmInvite($userId, $streamId, $flag = 0, $comment = "") {
        $row = array(
            'response' => $flag,
            'comment' => $comment
        );
        $this->db->update(self::T_NAME, $row, array('stream_id' => $streamId, 'user_id' => $userId));
        /**
         *  Add Notification
         */
        $this->load->model('streams_m', 'streamModel');
        $stream = $this->streamModel->getStreamById($streamId);

        $this->load->model('users_m', 'userModel');
        $user = $this->userModel->getUserById($userId);

        if($flag == 1){
            $text = sprintf(
                "%s %s accepted your invite stream %s", $user['first_name'], $user['last_name'], $stream['title']
            );
            $notifcation = array('user_id' => $stream['user_id'], 'content' => $text, 'data' => $streamId, 'alert_type' => 'Accepted');
        }else{
            $text = sprintf(
                "%s %s decline your invite stream %s", $user['first_name'], $user['last_name'], $stream['title']
            );
            $notifcation = array('user_id' => $stream['user_id'], 'content' => $text, 'data' => $streamId, 'alert_type' => 'Decline');
        }
        

        $this->load->model('notifications_m', 'notificationModel');
        $this->notificationModel->insertNotification($notifcation);

        /**
         * @todo APNS
         */
        return true;
    }

}
