<?
require("include/header.aspx");
require("customsql.inc.aspx");
$db = new CustomSQL($DBName);
$db_admin = new CustomSQL_admin($DBName_admin);
//echo $_POST['server'];
/*
if($_GET['stat'] == "ok") {
if($_POST['server'] == 'www.megashare.by') {header("Location: http://www.megashare.by/regok.php?op=ok"); exit;}}
if($_GET['stat'] == "no") {
if($_POST['server'] == 'www.megashare.by') {header("Location: http://www.megashare.by"); exit;}}
*/



if(!empty($_POST['ex_wm'])) {$sel_did = $db_admin->sel_did($_POST['LMI_PAYMENT_NO']);
	header("Location: http://wm-rb.net/user_check_demand.aspx?d=".$sel_did[0]['did']); exit;}
if(!empty($_POST['usluga_wm'])) {$sel_did = $db_admin->sel_did($_POST['LMI_PAYMENT_NO']);
	header("Location: http://wm-rb.net/user_check_usluga.aspx?d=".$sel_did[0]['did']); exit;}
elseif (!empty($_POST['NAL']) || !empty($_POST['output_NAL'])) {$sel_did = $db_admin->sel_did($_POST['LMI_PAYMENT_NO']);
	header("Location: http://wm-rb.net/user_check_cash.aspx?d=".$sel_did[0]['did']); exit;}
elseif (!empty($_POST['pay_eshop'])) {$sel_did = $db_admin->sel_did($_POST['LMI_PAYMENT_NO']);
	header("Location: http://wm-rb.net/user_check_eshop.aspx?d=".$sel_did[0]['did']); exit;}
elseif (!empty($_POST['shop_pay'])) {$sel_did = $db_admin->sel_did($_POST['LMI_PAYMENT_NO']);
	header("Location: http://shop.wm-rb.net/check_pay.aspx?d=".$sel_did[0]['did']); exit;}

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
</head>

<body>
<?
include('include/top.aspx');
?>


	<tr>
	<td width="700" align="center" class="div_include">
<?
if($_GET['stat'] == "ok") {

echo "<br /><br /><div class=\"div_operok\" style=\"padding: 20\">
ВАШ ПЛАТЕЖ СОВЕРШЕН УСПЕШНО
</div><br />
<div class=\"\">
<br /><br />
</div>
<div class=\"text\" align=\"left\" id=\"margin\">Если у Вас возникли какие-либо вопросы по работе сервиса, Вы можете обратиться в <a href=\"http://wm-rb.net/support.aspx\">службу поддержки</a> или разместить вопрос на <a href=\"http://forum.wm-rb.net/\">форуме</a> для обсуждения.</div>";
	}

if($_GET['stat'] == "no") {
echo "<br /><br /><div class=\"div_operok\" style=\"padding: 20\">
ВАШ ПЛАТЕЖ СОВЕРШЕН НЕ УДАЧНО
</div><br />
<div class=\"\">
<br /><br />
</div>
<div class=\"text\" align=\"left\" id=\"margin\">Если у Вас возникли какие-либо вопросы по работе сервиса, Вы можете обратиться в <a href=\"http://wm-rb.net/support.aspx\">службу поддержки</a> или разместить вопрос на <a href=\"http://wm-rb.net/forum/\">форуме</a> для обсуждения.</div>";

}
?>
</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
