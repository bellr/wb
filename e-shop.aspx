<?
session_start();
require("include/header.aspx");
require("customsql.inc.aspx");

$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
$goods = $db_pay_desk->sel_goods();
$reqID = wm_ReqID();
	$_SESSION['id'] = md5('1620'.session_id());
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - Сервис электронных платежей :: Список товаров, предлагаемый нашим магазином</Title>
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
<? include('include/displ_price_goods.aspx'); ?>
<script language='JavaScript'>
<!--
function Check() {
if (document.form_eshop.amount_goods.value <= 0 && document.form_eshop.amount_goods.value <= '0') {
alert('Вы не указали количество покупаемого товара');
document.form_eshop.amount_goods.focus();
return false;
}
if(!document.form_eshop.amount_goods.value.match('^[0-9]+$')) {
alert('Вы ввели не верные данные!!!');
document.form_eshop.amount_goods.value='0';
document.form_eshop.amount_goods.focus();
return false;
}
if (!document.form_eshop.akk.value.match('^[0-9]+$')) {
alert('Вы не верно указали аккаунт');
document.form_eshop.akk.focus();
return false;
}

if(document.getElementById('purse').style.display=='block') {
if (!document.form_eshop.purse.value.match('^[0-9]{8}$') && !document.form_eshop.purse.value.match('^[0-9]{13}$') && !document.form_eshop.purse.value.match('^[0-9]{14}$')) {
alert('Счет отправителя указан не верно');
document.form_eshop.purse.focus();
return false;
}
}
if (!document.form_eshop.email.value.match('^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-Mail указан не верно');
document.form_eshop.email.focus();
return false;
}
if (!document.form_eshop.rules.checked) {
alert('Вам необходимо ознакомиться и согласиться с правилами и условиями нашего сервиса');
document.form_eshop.rules.focus();
return false;
}
if (!document.form_eshop.exhibit.checked) {
alert('Установите приложение для передачи голосов на своей страничке');
document.form_eshop.exhibit.focus();
return false;
}
return true;
}


// -->
</SCRIPT>

</head>

<body>
<?
include('include/top.aspx');
?>


	<tr>
	<td width="700" align="center" class="div_include">
		<div class="top_title" align="right">Список товаров, предлагаемый нашим магазином</div><br>
	<!-- <b>ВНИМАНИЕ!!! Временно изменилось приложение для получения голосов.<br />
	Голоса будут переводиться в это <a href="http://vkontakte.ru/app712263" target="_blank">приложение</a>.</b><br /> -->
	<br />Предлагаем всем пользователям высказать мнение в <a href="http://forum.wm-rb.net/showthread.php?t=17" target="_blank">топике</a> на форуме о том какие товары вы хотели бы видеть в нашем магазине.
		<br/><br />
<form method="post" action="http://wm-rb.net/check_demand.aspx" name="form_eshop" id="form_eshop"  onSubmit="return Check()">

	<table width="98%" border="0" cellspacing="1" cellpadding="4" bgColor="#C0C0C0">
		<tr bgColor="#f3f7ff">
		<td width="60%" align="center" class="text">Описание товара</td>
		<td width="15%" align="center" class="text">В наличии</td>
		<td width="20%" align="center" class="text">Валюта</td>
		</tr>
<?
$sel_reserv = $db_pay_desk->reserv_eshop('vkontakte');
// $list_shop = $db_pay_desk->sel_shop();

		echo "<tr bgColor=\"#ffffff\">";

		echo "<td class=\"text_log\">{$sel_reserv[0]['desc_val']}</td>
		<td align=\"center\" class=\"text_log\">{$sel_reserv[0]['balance']}</td>
		<td align=\"center\" class=\"text_log\">
		<input type=\"hidden\" name=\"a_goods\" value=\"{$sel_reserv[0]['balance']}\" id=\"a_goods\">
		<input type=\"hidden\" name=\"did\" value=\"{$reqID}\">
		<input type=\"hidden\" name=\"did\" value=\"{$reqID}\">
		<input type=\"hidden\" name=\"hesh\" value=\""; echo md5($reqID.'1620'); echo "\" readonly=\"readonly\">
		<select name=\"oplata\" id=\"oplata\" onclick=\"ShowPrice()\" onSelect=\"ShowPrice()\" onFocus=\"ShowPrice()\" onSelect=\"ShowPrice()\" onKeyUp=\"ShowPrice()\" onChange=\"show_out()\">
			<option value=\"none\" selected=\"selected\">Выберите валюту</option>";
 $currency = $db_pay_desk->oplata('vkontakte');
	foreach($currency as $arr) {

			echo "<option value=\"{$arr['0']}\">{$arr['0']}</option>";
	}

		echo "</select></td>

	</tr>";
?>
	</table>
<div class="eshop_info" id="box_info" style="display:none; margin-top:10px; padding:10px;">
<font color="#FF0000"><b>Для получения голосов установите у себя на страничке это <a href="http://vkontakte.ru/app616100" target="_blank">приложение</a></font></b><br /><br />
<span class="text" id="price"></span><br /><br />
Купить <input type="text" name="amount_goods" id="amount_goods" onclick="javascript:if(this.value=='0')this.value='';" onblur=cheak_null() onkeyup=ShowPrice() onchange=ShowPrice() value="0" maxlength="4" style="width:50px; text-align: center;"> шт.<br /><br />
<input type="hidden" name="id_goods" value="" id="id_goods">
<b>Ваш аккаунт :</b> ID <input type="text" name="akk" id="akk" style="width:120px;" value="<? echo $_COOKIE['akk'];?>"><br /><br />
<div style="display: none; margin-bottom:10px;" id="purse">
<b>Счет отправителя :</b> <span id="form_purse"></span></div>

<b>E-Mail :</b> <input type="text" name="email" id="email" style="width:120px;" value="<? echo $_COOKIE['email'];?>"><br /><br />
<div class="text">C <a href="http://wm-rb.net/rules.aspx" target="_blank" title="Правила предоставления услуг">правилами</a> предоставления услуг согласен <input type="checkbox" name="rules"></div><br />
<div class="text"><a href="http://vkontakte.ru/app616100" target="_blank">ПРИЛОЖЕНИЕ</a> для передачи голосов установил <input type="checkbox" name="exhibit"></div><br />
<INPUT name="pay_eshop" id="pay_eshop" type="submit" value="Купить" style="width:90px;" onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';" id="cursor">
</div>
</form>

</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
