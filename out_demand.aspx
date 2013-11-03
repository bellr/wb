<?
require("include/header.aspx");
require("customsql.inc.aspx");
require("include/constructor_exch.aspx");
require("include/class_nal_usl.aspx");
$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
$Constructor = new Constructor();
$errortag = true;
$reqID = wm_ReqID();
	session_start();
	$_SESSION['id'] = md5('1620'.session_id());
$type_usluga = stripslashes(htmlspecialchars(substr($_POST['type_usluga'],0,25)));
$reqID = wm_ReqID();

	$card = stripslashes(htmlspecialchars(substr($_POST['card'],0,25)));
	$usluga = stripslashes(htmlspecialchars(substr($_POST['card'],0,25)));
	$oplata = stripslashes(htmlspecialchars(substr($_POST['oplata'],0,25)));
	if(empty($usluga) || empty($oplata) || empty($card)) {header("Location: output_nal.aspx"); exit();}
	$us = $db_pay_desk->info_card($card);
	$u = $db_exchange->get_kurs($oplata."_".$card);
	$userinfo = $db_exchange->exch_balance($oplata);
	$info_card = $db_pay_desk->exch_balance($card);
	$com_seti = $info_card[0]['com_card'];
	$balance = $info_card[0]['balance'] - $info_card[0]['balance'] * $info_card[0]['com_card'];

$format_balance = edit_balance($balance);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - Сервис электронных платежей :: Автоматизированный обмен электронных валют WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, коммунальные платежи и услуги</Title>
<Meta name="description" Content="Автоматизированный обменник электронных валют WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, коммунальные платежи и услуги">
<Meta name="keywords" Content="обменный пункт, автоматизированный обменник, exchange, электронные деньги, wmb, wmz, wmr, wme, easypay, rbk money, yandex money, автоматизированный обмен, автоматизированный автомат, обмен цифровых денег, обмен wm, электронные денеги в Беларуси, пополнение ввод вывод WebMoney в Минске, обменять webmoney, курсы, обмен валют, обменник, Минск, Беларусь, заработок, ВебМани, интернет-деньги, БелГазПром банк, online change, баланс телефона, пополнение, оплата, коммунальные платежи и услуги, свет, газ, мобильной связи, мобильный, партнерская программа">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META name="author" content="AtomLy">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
<script src="http://wm-rb.net/include/ajax.js" type="text/javascript" language="JavaScript"></script>
<? include('include/calk_output.aspx'); ?>
</head>

<body>
<?
include('include/top.aspx');
?>


	<tr>
	<td width="700" align="center" class="div_include">
<br /><br />
<?

	include ("include/form_demand_output.aspx");
?>
<br /><br />

</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
