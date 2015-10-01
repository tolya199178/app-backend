<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class posts_m extends CI_Model {   
    const T_NAME = 'posts';

    /**
     * 
     * @param type $userData
     */
    public function insertPost($postData) {
        $userData['created_date'] = date('Y-m-d H:i:s');
        $this->db->insert(self::T_NAME, $postData);
        return $this->db->insert_id();
    }

    public function updatePost($postId, $postData) {        
        $this->db->update(self::T_NAME, $postData, array('id' => $postId));
        return true;
    }

    public function deletePost($postId) {
        return $this->db->delete(self::T_NAME, array('id' => $postId));
    }

    public function getFoodPostsByUserId($userId) {
        $sql = sprintf(
                "SELECT * FROM %s WHERE user_id='%d'", self::T_NAME, $userId
        );
        $query = $this->db->query($sql);  
        $items = array();
        if ($query->num_rows() == 0) {
            return false;
        } else {
            return $this->db->query($sql)->result_array();
        }
    }
    
    public function getPostsByStreamId($streamId){
         $sql = sprintf(
                "SELECT * FROM %s WHERE stream_id=%d ORDER BY `created_date` ASC", self::T_NAME,$streamId
        );
        return $this->db->query($sql)->result_array();
    }
    
    public function getFoodPosts($page) {
        $from = (mysql_real_escape_string($page) - 1) * 20;
        $sql = sprintf(
                "SELECT * FROM %s ORDER BY id DESC LIMIT {$from}, 20", self::T_NAME
        );       
        $query = $this->db->query($sql);        
        $items = array();
        if ($query->num_rows() == 0) {
            return false;
        } else {
            return $this->db->query($sql)->result_array();
        }        
    }   
}
