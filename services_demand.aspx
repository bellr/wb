<?
require("include/header.aspx");
require("customsql.inc.aspx");
cheak_ref($_SERVER['HTTP_REFERER']);
require("include/constructor_exch.aspx");
require("include/class_nal_usl.aspx");
$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
$Constructor = new Constructor();
$Cons_uslugi = new Cons_uslugi();
$errortag = true;
$reqID = wm_ReqID();
if (!empty($_POST['oplata_usluga']) && !empty($_POST['oplata_nal']) && !empty($_POST['oplata_nal_out'])) {
	header("Location: index.aspx");
	exit;
}
	session_start();
	$_SESSION['id'] = md5('1620'.session_id());
$type_usluga = stripslashes(htmlspecialchars(substr($_POST['type_usluga'],0,25)));
$reqID = wm_ReqID();
switch ($type_usluga) :
	case ("uslugi") :
	$usluga = stripslashes(htmlspecialchars(substr($_POST['usluga'],0,25)));
	$oplata = stripslashes(htmlspecialchars(substr($_POST['oplata'],0,25)));
	$currency = $Cons_uslugi->output($type_usluga,$oplata);
	if(empty($usluga) || empty($oplata)) {header("Location: output_nal.aspx"); exit();}
	$us = $db_pay_desk->select_usluga($usluga,'uslugi');
	$u = $db_exchange->get_kurs($Cons_uslugi->kurs_n($type_usluga,$oplata));
	$userinfo = $db_exchange->exch_balance($Cons_uslugi->bal($type_usluga,$oplata));
	$com_seti = $userinfo[0]["com_seti"];
	$info_card = $db_pay_desk->exch_balance('prior');
	$balance = $info_card[0]['balance'] - $info_card[0]['balance'] * $info_card[0]['com_card'];
	break;

	case ("NAL") :
	$oplata = stripslashes(htmlspecialchars(substr($_POST['oplata'],0,25)));
	$usluga = stripslashes(htmlspecialchars(substr($_POST['card'],0,25)));
	if(empty($usluga) || empty($oplata)) {header("Location: output_nal.aspx"); exit();}
	$us = $db_pay_desk->select_usluga($usluga,'uslugi');
	if($usluga == "VISA") $u = $db_exchange->get_kurs("VISA_".$oplata);
	else $u = $db_exchange->get_kurs($Cons_uslugi->kurs_n($type_usluga,$oplata));
	if($usluga == "VISA") $currency = "USD";
	else $currency = $Cons_uslugi->output($type_usluga,$oplata);
	$info_card = $db_pay_desk->exch_balance($usluga);
	$com_seti = $info_card[0]['com_card'];
	$userinfo = $db_exchange->exch_balance($Cons_uslugi->bal($type_usluga,$oplata));
	$balance = $userinfo[0]["balance"] - $userinfo[0]["balance"] * $userinfo[0]["com_seti"];
	break;
endswitch;
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
<? include('include/js_services.aspx'); ?>
</head>

<body>
<?
include('include/top.aspx');
?>


	<tr>
	<td width="700" align="center" class="div_include">
<br /><br />
<?
if($type_usluga == 'output_NAL' && $currency == 'WMZ') echo "<div align=\"left\" class=\"black\">
При обмене свыше 100 WMZ действует скидка 0.3%</div><br /><br />";
	include ("include/form_demand_sevices.aspx");
?>
<br /><br />

</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
