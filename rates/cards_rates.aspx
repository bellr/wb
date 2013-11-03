<?php
require("../customsql.inc.aspx");
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);

$rate = $db_exchange->get_kurs('WMZ_NAL');
$b_belbank = $db_pay_desk->exch_balance('belbank');
$b_bpsb = $db_pay_desk->exch_balance('bpsb');

echo "bb: ".$b_belbank[0]['balance']." BYR | ".$rate[0]['konvers']*$b_belbank[0]['bonus']." BYR;";
echo "bpsb: ".$b_bpsb[0]['balance']." BYR | ".$rate[0]['konvers']*$b_bpsb[0]['bonus']." BYR";
?>
