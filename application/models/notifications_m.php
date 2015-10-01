<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class notifications_m extends CI_Model {

    const T_NAME = 'notifications';

    /**
     * 
     * @param type $userData
     */
    public function insertNotification($row) {
        $row['created_date'] = date('Y-m-d H:i:s');
        $this->db->insert(self::T_NAME, $row);
        return $this->db->insert_id();
    }

    public function confirmNotification($id) {
        $row['confirm'] = 1;
        $row['confirm_time'] = date('Y-m-d H:i:s');
        $this->db->update(self::T_NAME, $row, array('id' => $id));
        return true;
    }

    public function deleteNotification($id) {
        return $this->db->delete(self::T_NAME, array('id' => $id));
    }

    public function getNotificationByUserId($userId, $only_unread) {
        if ($only_unread) {
            $sql = sprintf(
                    "SELECT * FROM %s WHERE user_id=%d AND confirm=0 ORDER BY `created_date` DESC", self::T_NAME, $userId
            );
        } else {
            $sql = sprintf(
                    "SELECT * FROM %s WHERE user_id=%d ORDER BY `created_date` DESC", self::T_NAME, $userId
            );
        }
        return $this->db->query($sql)->result_array();
    }

}
