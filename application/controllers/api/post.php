<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class post extends Backend_Controller {

    /**
     * 
     */
    public function index() {
        
    }

    public function addpost() {
        $param = $_REQUEST;
        
        $post = array(            
            'user_id' => $param['userId'],            
            'content' => $param['photoContent'],
            'photo_url' => $param['photoUrl']            
        );
        $this->load->model('posts_m', 'postModel');
        $newId = $this->postModel->insertPost($post);
        $post = $this->postModel->getPostById($newId);
        echo json_encode(array('result' => true, 'object' => $post));
        die();
    }
    
    public function getfoodposts () {
        $param = $_REQUEST;
        $page = $param['page'];
        $this->load->model('posts_m', 'postModel');
        $response = $this->postModel->getFoodPosts($page);
        if ($response == false) {
            echo json_encode(array('result' => false, 'object' => ''));
        } else {
            echo json_encode(array('result' => true, 'object' => $response));
        }
    }
    
    public function addposts() {
        $param = $_REQUEST;
        if (isset($param['user_id'])) {
            $userId = $param['user_id'];
        } else {
            $user = $this->getUser();
            $userId = $user['id'];
        }
		$stream_idstr = $param['stream_ids'];
		$stream_ids = explode(',', $stream_idstr);
		$this->load->model('posts_m', 'postModel');
		$posts = array();
		foreach($stream_ids as $stream_id){
			if($stream_id){
				$post = array(
                                        'stream_id' => $stream_id,
					'user_id' => $param['user_id'],
					'title' => $param['title'],
					'content' => $param['content'],
					'image_url' => $param['image_url']?$param['image_url']:"",
					'movie_url' => $param['movie_url']
				);
				$newId = $this->postModel->insertPost($post);
				$posts[] = $this->postModel->getPostById($newId);
			}
		}        
        echo json_encode(array('result' => true, 'object' => $posts));
        die();
    }

    public function updatepost() {
        $param = $_REQUEST;
        $id = $param['id'];
        $stream = array();
        if (isset($param['stream_id'])) {
            $stream['stream_id'] = $param['stream_id'];
        }
        if (isset($param['user_id'])) {
            $stream['user_id'] = $param['user_id'];
        }
        if (isset($param['title'])) {
            $stream['title'] = $param['title'];
        }        
        if (isset($param['content'])) {
            $stream['content'] = $param['content'];
        }
        if (isset($param['img_url'])) {
            $stream['img_url'] = $param['img_url'];
        }
        if (isset($param['title'])) {
            $stream['title'] = $param['title'];
        }
        $this->load->model('posts_m', 'postModel');
        $this->postModel->updatePost($id, $stream);
        $stream = $this->postModel->getPostById($id);
        echo json_encode(array('result' => true, 'object' => $stream));
        die();
    }

    public function deletepost() {
        $param = $_REQUEST;
        $id = $param['id'];
        $this->load->model('posts_m', 'postModel');
        $this->postModel->deletePost($id);
        echo json_encode(array('result' => true));
    }
    
    public function getpostsbystreamid(){
        $param = $_REQUEST;
        $streamId = $param['stream_id'];        
    }

}
