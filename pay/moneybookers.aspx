<?php
include('../const.inc.aspx');
require($atm_dir."nncron/customsql.inc.aspx");
require($atm_dir."nncron/constructor_exch_auto.aspx");
//$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_admin = new CustomSQL_admin($DBName_admin);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);

if($_POST['pay_to_email'] == "bellr@mail.ru") {

$sel_idpay_did = $db_admin->sel_idpay_did($_POST['transaction_id']);
//вывод инфы по заявке
	$demand_info = $db_pay_desk->demand_check_eshop($sel_idpay_did[0]['did']);
	$purse = $db_exchange->sel_purse_shop($demand_info[0]["output"]);
	$hesh = md5("keyok16201Dbnfkbq1987x986dbnfkbq19864-_=&^%$#@".$_POST['transaction_id'].$_POST['amount'].$purse[0]['purse'].$demand_info[0]["output"]."keyok16201Dbnfkbq1987x986dbnfkbq19864-_=&^%$#@");
if($hesh == $_POST['hesh']) {
$info_goods = $db_pay_desk->sel_goods_price($demand_info[0]["id_goods"]);
$s = e_shop($sel_idpay_did[0]["did"],$demand_info[0]["email"],$info_goods[0]["name_card"],$demand_info[0]["amount"],$demand_info[0]["output"],$demand_info[0]["id_goods"],$demand_info[0]["type_goods"],$demand_info[0]["data"],$demand_info[0]["time"]);
	if($s == "ERROR_SELGOODS") {$db_pay_desk->add_coment_eshop('Не выбран товар из базы данных. Администрация оповещена об ошибке.',$sel_idpay_did[0]['did']);	$db_pay_desk->demand_edit_eshop('er',$sel_idpay_did[0]['did']);}
	else {$db_pay_desk->demand_edit_eshop('y',$sel_idpay_did[0]['did']);
		if(!empty($demand_info[0]["diskont_id"])) {
			$sel_diskont = $db_pay_desk->search_diskont($demand_info[0]["diskont_id"]);	$db_pay_desk->upd_diskont($demand_info[0]["diskont_id"],$info_goods[0]["price"]-$info_goods[0]["price"]*$sel_diskont[0]['procent']/100);
		}
	}
}
else {$db_pay_desk->add_coment_eshop('Неверная подпись. Администрация оповещена об ошибке.',$sel_idpay_did[0]['did']);	$db_pay_desk->demand_edit_eshop('er',$sel_idpay_did[0]['did']);}

}

foreach($_POST as $key => $value) {
$str .= $key." = ".$value."\n";
}
$str .= $hesh." - ".$_POST['hesh'];
		$fd = fopen("123.log","w+");
		fputs($fd, $str);
                fflush($fd);
		fclose($fd);

?>