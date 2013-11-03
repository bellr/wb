<?php
$arr = array(
"WMZ_WMR" => "WMZ -> WMR",
"WMZ_WME" => "WMZ -> WME",
"WMZ_WMG" => "WMZ -> WMG",
"WMZ_WMU" => "WMZ -> WMU",
"WMZ_WMY" => "WMZ -> WMY",
"WMZ_WMB" => "WMZ -> WMB",
"WMZ_EasyPay" => "WMZ -> EasyPay",
"WMR_WMZ" => "WMR -> WMZ",
"WMR_WME" => "WMR -> WME",
"WMR_WMG" => "WMR -> WMG",
"WMR_WMU" => "WMR -> WMU",
"WMR_WMY" => "WMR -> WMY",
"WMR_WMB" => "WMR -> WMB",
"WMR_EasyPay" => "WMR -> EasyPay",
"WME_WMZ"=> "WME -> WMZ",
"WME_WMR" => "WME -> WMR",
"WME_WMG" => "WME -> WMG",
"WME_WMU" => "WME -> WMU",
"WME_WMY" => "WME -> WMY",
"WME_WMB" => "WME -> WMB",
"WME_EasyPay" => "WME -> EasyPay",
"WMU_WMZ" => "WMU -> WMZ",
"WMU_WMR" => "WMU -> WMR",
"WMU_WME" => "WMU -> WME",
"WMU_WMG" => "WMU -> WMG",
"WMU_WMY" => "WMU -> WMY",
"WMU_WMB" => "WMU -> WMB",
"WMU_EasyPay" => "WMU -> EasyPay",
"EasyPay_WMY" => "EasyPay -> WMY",
"EasyPay_WMU" => "EasyPay -> WMU",
"EasyPay_WMG" => "EasyPay -> WMG",
"EasyPay_WME" => "EasyPay -> WME",
"EasyPay_WMR" => "EasyPay -> WMR",
"EasyPay_WMZ" => "EasyPay -> WMZ",
);
	//echo "<b>{$arr['WMR_RBK Money']}</b>";





require("customsql.inc.aspx");

$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$info_direct = $db_exchange->sel_rates();

foreach($info_direct as $kar) {
	$mass_valuta = explode("_",$kar[0]);
	$infoirates = $db_exchange->get_kurs($kar[0]);
	$infoireserv = $db_exchange->exch_balance($mass_valuta[1]);

	if(!empty($arr[$kar[0]])) {

		if($infoirates[0]['direct'] == "n") {
			echo "{$arr[$kar[0]]}: rate={$infoirates[0]['konvers']}, reserve={$infoireserv[0]['balance']}<br />";
		}
		else {
			$rates = 1/$infoirates[0]['konvers']+0.00001/100;
			echo "{$arr[$kar[0]]}: rate={$rates}, reserve={$infoireserv[0]['balance']}<br />";
		}
	}
}
?>
