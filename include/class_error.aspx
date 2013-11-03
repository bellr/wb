<?

class Error {
	function Email($email) {
		if(!preg_match("/^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$/", $email)) return 1;
		else return 0;
	}
	function UserSurname($user_surname) {
		if(!preg_match("/^[a-zA-Zà-ÿÀ-ß]+$/", $user_surname)) return 1;
		else return 0;
	}
	function UserName($user_name) {
		if(!preg_match("/^[a-zA-Zà-ÿÀ-ß]+$/", $user_name)) return 1;
		else return 0;
	}
	function NameBank($name_bank) {
		if(!preg_match("/^[a-zA-Zà-ÿÀ-ß,\"\ ]+$/", $name_bank)) return 1;
		else return 0;
	}
	/*
	function N_card($number_card,$c) {
		if(!preg_match("/^([0-9]){".$c."}$/", $number_card)) return 1;
		else return 0;
	}
	function P_card($period) {
		if(!preg_match("/^([0-9]){4}$/", $period)) return 1;
		else return 0;
	}
	*/
	function Did($did) {
		if(!preg_match("/^([0-9]){10}$/", $did)) return 1;
		else return 0;
	}
	function WMID($wmid) {
		if(!preg_match("/^([0-9]){12}$/", $wmid)) return 1;
		else return 0;
	}
	function Inval($sum) {
		if(!preg_match("/^([0-9.])+$/", $sum)) return 1;
		else return 0;
	}
	function numeral($numeral) {
		if(!preg_match("/^([0-9])+$/", $numeral)) return 1;
		else return 0;
	}
	function checkN($numeral,$c) {
		if(!preg_match("/^([0-9]){".$c."}$/", $numeral)) return 1;
		else return 0;
	}
}
?>