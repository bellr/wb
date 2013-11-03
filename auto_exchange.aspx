<?
require("include/header.aspx");
require("customsql.inc.aspx");
cheak_ref($_SERVER['HTTP_REFERER']);
require("include/constructor_exch.aspx");
$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$Constructor = new Constructor();
$errortag = false;

$ex_sel = trim(stripslashes(htmlspecialchars(substr($_POST['ex_sel'],0,20))));
$ex_demand = trim(stripslashes(htmlspecialchars(substr($_POST['ex_demand'],0,20))));

//if (empty($ex_sel) && empty($_POST['ex_demand'])) {
	//if (empty($ex_sel)) {
	//header("Location: index.aspx");
//}
//else {
	session_start();
	$_SESSION['id'] = md5('1620'.session_id());
$output = trim(stripslashes(htmlspecialchars(substr($_POST['output'],0,20))));
$input = trim(stripslashes(htmlspecialchars(substr($_POST['input'],0,20))));

	$n = "{$output}_{$input}";
	$reqID = wm_ReqID();
	$u = $db_exchange->get_kurs($n);
	if(empty($u)) {header("Location: index.aspx"); exit;}
	$userinfo = $db_exchange->exch_balance($input);
	$output_info = $db_exchange->exch_balance($output);
	$com_seti = $output_info[0]['com_seti'];
	$balance = $userinfo[0]["balance"] - $userinfo[0]["balance"] * $userinfo[0]["com_seti"];
	$format_balance = edit_balance($balance);
	$cur_out_info = $db_exchange->cur_out_info($output);
	$cur_in_info = $db_exchange->cur_out_info($input);
	$sel_d = $db->sel_discount($input);
	$sd = 1;
//}
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
<? include('include/calc_check.aspx'); ?>
</head>
<body>
<?
include('include/top.aspx');
?>
	<tr>
	<td width="700" align="center" class="div_include">
	<div class="top_title" align="right">Заполните поля необходимые для обмена</div><br />
	<?
	include ("include/form_demand.aspx");
	?>
	<br />
	</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
