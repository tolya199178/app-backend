<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class users_m extends CI_Model {

    const T_NAME = 'users';

    /**
     * 
     * @param type $userData
     */
    public function insertUser($userData) {
        if ($userData['passwd'])
            $userData['passwd'] = md5($userData['passwd']);
        $userData['created_date'] = date('Y-m-d H:i:s');
        $this->db->insert(self::T_NAME, $userData);
        return $this->db->insert_id();
    }

    public function updateUser($userId, $userData) {
        if ($userData['passwd'])
            $userData['passwd'] = md5($userData['passwd']);
        $this->db->update(self::T_NAME, $userData, array('id' => $userId));
        return true;
    }

    public function deleteUser($userId) {
        return $this->db->delete(self::T_NAME, array('id' => $userId));
    }

    /**
     * 
     * @param type $userId
     * @return type
     */
    public function getUserById($userId) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE 1 AND id='%d'", self::T_NAME, $userId
        );
        return $this->db->query($sql)->row_array();
    }

    /**
     * 
     * @param type $userId
     * @return type
     */
    public function getUserByLoginName($userName) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE 1 AND login_name='%s'", self::T_NAME, $userName
        );
        return $this->db->query($sql)->row_array();
    }

    public function getUserByVendorLoginName($userName) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE user_name='%s' AND user_type = '2'", self::T_NAME, $userName
        );
        return $this->db->query($sql)->row_array();
    }

    /**
     * 
     * @param type $userId
     * @return type
     */
    public function getUserByEmail($email) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE  email_addr = '%s'", self::T_NAME, $email
        );
        return $this->db->query($sql)->row_array();
    }

    //get used when register
    public function getUserByVendorEmail($email) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE  email_addr = '%s' AND user_type = '2'", self::T_NAME, $email
        );
        return $this->db->query($sql)->row_array();
    }

    public function getUserByToken($token) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE  token = '%s'", self::T_NAME, $token
        );
        return $this->db->query($sql)->row_array();
    }

    /**
     * get All Users
     * @return type
     */
    public function getUserList() {
        $sql = sprintf(
                "SELECT * FROM %s WHERE 1 ORDER BY `created_date` ASC", self::T_NAME
        );
        return $this->db->query($sql)->result_array();
    }

    public function getUsersByIds($ids) {
        if (count($ids) > 0) {
            $sql = sprintf(
                    "SELECT * FROM %s WHERE id IN (%s) ORDER BY `created_date` ASC", self::T_NAME, implode(',', $ids)
            );
            return $this->db->query($sql)->result_array();
        } else {
            return array();
        }
    }

    /**
     * @decription  
     * @param type $email
     * @param type $password
     * @return boolean
     */
    public function login($email, $password) {

        $sql = sprintf(
                "SELECT * FROM %s WHERE email_addr = '%s' AND passwd = '%s' AND user_type = '2'", self::T_NAME, mysql_real_escape_string($email), md5($password)
        );
        $query = $this->db->query($sql);
        if ($query->num_rows() == 0) {
            return false;
        }
        $resultAry = $query->row_array();
        return $resultAry;
    }

    public function facebooklogin($facebookId) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE facebook_id = '%s'", self::T_NAME, mysql_real_escape_string($facebookId)
        );
        $query = $this->db->query($sql);
        if ($query->num_rows() == 0) {
            return false;
        }
        $resultAry = $query->row_array();
        return $resultAry;
    }

    public function getVendorAddress($lat, $long) {
        $url = 'http://maps.googleapis.com/maps/api/geocode/json?latlng=' . trim($lat) . ',' . trim($long) . '&sensor=false';
        $json = @file_get_contents($url);
        echo $json;
        $data = json_decode($json);
        $status = $data->status;
        if ($status == "OK")
            return $data->results[0]->formatted_address;
        else
            return false;
    }

}
