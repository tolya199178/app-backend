<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class user_schedule_m extends CI_Model {  
	const T_NAME = 'user_schedule';
	
	public function getScheduleByVendorId ($vendorId) {
		$sql = sprintf(
                "SELECT * FROM %s WHERE vendor_id='%d'", self::T_NAME, $vendorId
        );	
		return $this->db->query($sql)->row_array();		
	}
}
?>