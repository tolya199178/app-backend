<?php
define('BASEPATH', dirname(__FILE__));
require_once(dirname(__FILE__) . '/application/config/database.php');

ini_set("user_agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");
ini_set("max_execution_time", 0);
error_reporting(E_ALL&~E_NOTICE);

$dbInfo = $db[$active_group];

function getDBConnection() {
    static $con;
    global $dbInfo;
    if (!isset($con)) {
        $con = mysql_pconnect($dbInfo['hostname'], $dbInfo['username'], $dbInfo['password']) or die('Failed to connect to database.');
        mysql_select_db($dbInfo['database'], $con) or die('Failed to select to database.');
        mysql_query('SET NAMES utf8', $con);
    }
    return $con;
}

function closeDBConnection($con) {
    mysql_close($con);
}

function execQuery($sql) {
    $con = getDBConnection();
    $rst = mysql_query($sql, $con) or die('<font color="red">Failed to execute query:</font><br/>' . $sql . '<br/>' . mysql_error());
    return $rst;
}

function fillPropertyLocations() {
    $sql = "SELECT property_id, city, state, zip, street_number, street, county FROM property_listings WHERE IFNULL(lat, 0)=0 OR IFNULL(lon, 0)=0 LIMIT 30";
    $result = execQuery($sql);
    while ($row = mysql_fetch_assoc($result)) {
        $address = $row['street_number'] . ' ' . $row['street'] . ',' . $row['city'] . ',' . $row['state'] . ' ' . $row['zip'];
        $json = file_get_contents('http://maps.googleapis.com/maps/api/geocode/json?address='.  urlencode($address).'&sensor=false');
        $info = json_decode($json, true);
        $info = $info['results'][0]['geometry']['location'];
		if($info){
			execQuery("UPDATE property_listings SET lat='{$info['lat']}', lon='{$info['lng']}' WHERE property_id='{$row['property_id']}'");
		}
    }
}

fillPropertyLocations();
