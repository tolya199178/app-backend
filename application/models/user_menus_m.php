<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');
class user_menus_m extends CI_Model {  
	const T_NAME = 'vendor_menu';
	
	public function getMenuByVendorId ($vendorId) {
		$sql = sprintf(
                "SELECT * FROM %s WHERE vendor_id='%d'", self::T_NAME, $vendorId
        );	
		return $this->db->query($sql)->row_array();		
	}
}
?>