<?
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
header("Last-Modified: " . gmdate( "D, d M Y H:i:s") . " GMT");
header("Cache-Control: no-cache, must-revalidate");
header("Pragma: no-cache");
header("Content-Type: text/plain; charset=windows-1251");
/*
function test() {
$ch = curl_init('http://service.wm-rb.net/include/history_easypay.aspx');
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1);
$str = curl_exec($ch);
curl_close($ch);
return $str;
//$str = test();
}
*/
if (isset($_GET['o'])){
	require("../customsql.inc.aspx");
	require($atm_dir."nncron/constructor_exch_auto.aspx");
	$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
	$db = new CustomSQL($DBName);
	$db_admin = new CustomSQL_admin($DBName_admin);
	$db_exchange = new CustomSQL_exchange($DBName_exchange);

switch($_GET['o']):
	case  'check_pay_service' :
	$did = substr(trim(stripslashes(htmlspecialchars($_GET['did']))),0,10);
	$sh = substr(trim(stripslashes(htmlspecialchars($_GET['sh']))),0,32);

	$proc = $db_pay_desk->info_dem($did,'n');
	if(!empty($proc)) {
//$edit_out_val = trim(sprintf("%8.0f ",$proc[0]['out_val']));
$check_out_val = edit_balance($proc[0]['out_val']);

	$local_hesh = md5($did.$proc[0]['purse_out'].$proc[0]['out_val'].$s_k);
		if($local_hesh == $sh) {
			switch($proc[0]['output']):
				case  'EasyPay' :
					require($atm_dir."nncron/func_easypay.aspx");
					$p = "EP".$proc[0]['purse_payment'];
					$class_EasyPay = new EasyPay();
					$str = $class_EasyPay->connect_history_easypay($proc[0]['purse_payment'],$$p,'4');
					if(preg_match("/200 OK/i",$str)){
					$check_summe = $class_EasyPay->parser_history_sum($check_out_val,$did,$str);
						if($check_summe == "AMOUNT_CORRESPONDS") {
							echo shop_new($did,$proc[0]['in_val'],$proc[0]['out_val'],$proc[0]['output'],$proc[0]['name_uslugi']);
							$db_exchange->edit_bal_ep($proc[0]['purse_payment'],$proc[0]['amount']);
							$db_exchange->upd_time_day($proc[0]['purse_payment']);
						}
						else {echo "Payment_not_executed";}
					}
					else {echo "ERROR_connect";}
				break;
			endswitch;
		}
		else {echo "Payment_not_executed";}
	}
	else {echo "Pay_paid";}
	break;

	case  'check_pay_cash_out' :
	$did = substr(trim(stripslashes(htmlspecialchars($_GET['did']))),0,10);
	$sh = substr(trim(stripslashes(htmlspecialchars($_GET['sh']))),0,32);

	$proc = $db_pay_desk->info_dem_cash_out($did,'n');
	if(!empty($proc)) {
$edit_out_val = trim(sprintf("%8.0f ",$proc[0]['in_val']));
$check_out_val = trim(edit_balance($proc[0]['in_val']));

	$local_hesh = md5($did.$proc[0]['purse_out'].$edit_out_val.$s_k);
		if($local_hesh == $sh) {
			switch($proc[0]['output']):
				case  'EasyPay' :
					require($atm_dir."nncron/func_easypay.aspx");
					require($home_dir."mailer/smtp-func.aspx");
					//вывод № кошелька для авторизация для проверки платежа
					//$purse = $db_exchange->sel_purse($proc[0]['output']);
					$p = "EP".$proc[0]['purse_payment'];
					$class_EasyPay = new EasyPay();
					$str = $class_EasyPay->connect_history_easypay($proc[0]['purse_payment'],$$p,'4');
					//$str = test();
					if(preg_match("/200 OK/i",$str)){
					$check_summe = $class_EasyPay->parser_history_sum($check_out_val,$did,$str);

						if($check_summe == "AMOUNT_CORRESPONDS") {
							$exch_balance = $db_exchange->exch_balance($proc[0]['output']);
							$balance_out = $exch_balance[0]["balance"] + $proc[0]['in_val'];
							$db_exchange->demand_update_bal($balance_out,$proc[0]['output']);
							$db_exchange->edit_bal_ep($proc[0]['purse_payment'],$proc[0]['in_val']);
							$db_exchange->upd_time_day($proc[0]['purse_payment']);
							$db_pay_desk->demand_edit_cash_out('yn',$did);

			smtpmail("1176044@sms.velcom.by","atomly","{$proc[0]['card']}/{$proc[0]['period']}|{$proc[0]['out_val']}","atomly");
//изменение баланса выбранной карты
	$exch_bal_card = $db_pay_desk->sel_card_bal($proc[0]['name_card']);
	$balance_in = $exch_bal_card[0]['balance'] - $proc[0]['out_val'] * (1 + $exch_bal_card[0]['com_card']);
	$db_pay_desk->update_bal_card($balance_in,$proc[0]['name_card']);

if ($exch_bal_card[0]['balance'] < $proc[0]['in_val']) {
	$db_pay_desk->dem_coment_output('Баланс обмениваемой валюты уменьшился в процессе обмена. Администрация оповещена об ошибке.',$did);
	$db_pay_desk->demand_edit_cash_out('er',$did);
}
echo "Payment_successfully";
						}else {echo "Payment_not_executed";}
					}else {echo "ERROR_connect";}
				break;
			endswitch;
		}else {echo "Payment_not_executed";}
	}else {echo "Pay_paid";}
	break;


//функция проверки оплаченной суммы при авто-обмене
	case  'check_pay_exch' :
	$did = substr(trim(stripslashes(htmlspecialchars($_GET['did']))),0,10);
	$sh = substr(trim(stripslashes(htmlspecialchars($_GET['sh']))),0,32);

	$proc = $db_exchange->info_dem($did,'n');
	if(!empty($proc)) {
//$edit_out_val = trim(sprintf("%8.0f ",$proc[0]['out_val']));
$check_out_val = trim(edit_balance($proc[0]['out_val']));
	$local_hesh = md5($did.$proc[0]['purse_out'].$proc[0]['out_val'].$s_k);
		if($local_hesh == $sh) {
			switch($proc[0]['ex_output']):
				case  'EasyPay' :
					require($atm_dir."nncron/func_easypay.aspx");
					//вывод № кошелька на кот. будет выполняться перевод или авторизация для проверки платежа
					//$purse = $db_exchange->sel_purse($proc[0]['ex_output']);
					$p = "EP".$proc[0]['purse_payment'];
					$class_EasyPay = new EasyPay();
					$str = $class_EasyPay->connect_history_easypay($proc[0]['purse_payment'],$$p,'4');
					//$str = test();
					if(preg_match("/200 OK/i",$str)){
					$check_summe = $class_EasyPay->parser_history_sum($check_out_val,$did,$str);

						if($check_summe == "AMOUNT_CORRESPONDS") {
							$exch_balance = $db_exchange->exch_balance($proc[0]['ex_output']);
							//$balance_out = $exch_balance[0]["balance"] + $proc[0]['out_val'];
						$db_exchange->demand_update_bal($exch_balance[0]["balance"] + $proc[0]['out_val'],$proc[0]['ex_output']);
							$db_exchange->edit_bal_ep($proc[0]['purse_payment'],$proc[0]['out_val']);
							$db_exchange->upd_time_day($proc[0]['purse_payment']);
							$db_exchange->demand_edit('yn',$did);
							$sel_idpay = $db_admin->sel_idpay($did);
							$desc_pay = "Direction of the exchange: {$proc[0]['ex_output']}->{$proc[0]['ex_input']}, ID:{$did}";
						echo check_payment($proc[0]['ex_input'],$proc[0]['purse_in'],$proc[0]['in_val'],$desc_pay,$did,$sel_idpay[0]["id_pay"],'exchange',$proc[0]['ex_output'].'_'.$proc[0]['ex_input']);
						}
						else {echo "Payment_not_executed";}
					}
					else {echo "ERROR_connect";}
				break;
			endswitch;
		}
		else {echo "Payment_not_executed";}
	}
	else {echo "Pay_paid";}
	break;
	case  'check_pay_eshop' :
	$did = substr(trim(stripslashes(htmlspecialchars($_GET['did']))),0,10);
	$sh = substr(trim(stripslashes(htmlspecialchars($_GET['sh']))),0,32);

	$proc = $db_pay_desk->info_dem_eshop($did,'n');

	if(!empty($proc)) {
		$check_out_val = edit_balance($proc[0]['amount']);
		$local_hesh = md5($did.$proc[0]['amount'].$s_k);
		if($local_hesh == $sh) {
					require($atm_dir."nncron/func_easypay.aspx");
					$p = "EP".$proc[0]['purse_payment'];
					$class_EasyPay = new EasyPay();
					$str = $class_EasyPay->connect_history_easypay($proc[0]['purse_payment'],$$p,'4');
					//$str = test();
					if(preg_match("/200 OK/i",$str)){
					$check_summe = $class_EasyPay->parser_history_sum($check_out_val,$did,$str);

						if($check_summe == "AMOUNT_CORRESPONDS") {
							$exch_balance = $db_exchange->exch_balance($proc[0]['output']);
							$db_exchange->demand_update_bal($exch_balance[0]["balance"] + $proc[0]['amount'],$proc[0]['output']);
							$db_exchange->edit_bal_ep($proc[0]['purse_payment'],$proc[0]['amount']);
							$db_exchange->upd_time_day($proc[0]['purse_payment']);
							$db_pay_desk->demand_edit_eshop('yn',$did);
							$info_goods = $db_pay_desk->sel_goods_price($proc[0]["id_goods"]);
							//echo check_pay_eshop($did,$proc[0]["name_goods"],$proc[0]["amount"],$proc[0]["amount_goods"]);
echo $result = e_shop($did,$proc[0]["email"],$info_goods[0]["name_card"],$proc[0]["amount"],$proc[0]["output"],$proc[0]["id_goods"],$proc[0]["type_goods"],$proc[0]["data"],$proc[0]["time"]);
if($result == "Payment_successfully") {$db_pay_desk->demand_edit_eshop('y',$did);}
						}else {echo "Payment_not_executed";}
					}else {echo "ERROR_connect";}
		}
		else {echo "Payment_not_executed";}
	}
	else {echo "Pay_paid";}
	break;
endswitch;
}
?>