<?
require("customsql.inc.aspx");

$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$currency = $db_exchange->konst_currency('st_exch');
//print_r($currency);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - Сервис электронных платежей :: Список доступных валют для обмена с курсами WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money</Title>
<Meta name="description" Content="Автоматизированный обменник электронных валют WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, коммунальные платежи и услуги">
<Meta name="keywords" Content="easypay, money, yandex, валюты, форум, wm, обменный, оплата,пополнение, партнерская программа, обменный пункт, услуг">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META name="author" content="AtomLy">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
<?
include('include/display_kurs.aspx');

?>
<SCRIPT type="text/javascript">
<!--
function Check_direct() {
if (document.form_exch.output.value == "none") {
alert('Выберите валюту, которую хотите обменять');
document.form_exch.output.focus();
return false;
}
if (document.form_exch.input.value == "none") {
alert('Выберите валюту, которую хотите получить');
document.form_exch.input.focus();
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
	<td width="700" class="div_include">
	<div class="top_title" align="right">Выберите направление обмена</div><br><br/><br /><br />
<form name="form_exch" id="form_exch" method="post" action="http://wm-rb.net/auto_exchange.aspx" onSubmit="return Check_direct()">
<table width="350" cellspacing="1" cellpadding="5" align="center" bgColor="#ebebeb">
	<tr bgColor="#ffffff">
		<td align="center" class="text">
		<select name="output" id="output" onclick="get_kurs()" onSelect="get_kurs()" onFocus="get_kurs()" onSelect="get_kurs()" onKeyUp="get_kurs()"  onChange="show_out()">
		<option value="none" selected="selected">Отдаете</option>

<?// print_r($currency);
	foreach($currency as $arr) {
	//	echo $arr[name]."<br />";
		if($arr[name] == 'Z-Payment') {$arr[name] = 'Z-PAYMENT';}
	echo "<option value=\"{$arr[name]}\">{$arr['2']}</option>";
	}
?>
</select></td>
		<td align="center">
<span id="out_img"><img src="img/none.gif" width="88" height="31" alt="none" /></span>
</td>
	</tr>
	<tr bgColor="#ffffff">
		<td align="center" class="text">
		<select name="input" id="input" onclick="get_kurs()" onSelect="get_kurs()" onFocus="get_kurs()" onSelect="get_kurs()" onKeyUp="get_kurs()"  onChange="show_in()">
		<option value="none" selected="selected">Получаете</option>
<?
	foreach($currency as $arr) {
		if($arr[name] == 'Z-Payment') {$arr[name] = 'Z-PAYMENT';}
			echo "<option value=\"{$arr[name]}\">{$arr['2']}</option>";

	}
?>
</select></td>
		<td align="center">
<div id="in_img"><img src="img/none.gif" width="88" height="31" alt="none" /></div>
</td>
	</tr>
	<tr bgColor="#ffffff">
		<td colspan="2" id="margin">
			<div id="k" style="margin:7;"><span class="red">Курс : </span><span class="text" id="kurs"><b>Выберите вылюту</b></span></div>
			<div id="b" style="margin:7;"><span class="red">Резерв : </span><span class="text" id="balance"><b>Выберите вылюту</b></span></div>
	</td>
	</tr>
	<tr bgColor="#ffffff">
		<td colspan="2" id="margin">



<center><input id="ex_sel" type="submit" name="ex_sel" value="Далее ›››" style="width:100px; margin:10px; padding:2px;" onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';" id="cursor"/></center>
	</td>
	</tr>
</table>
</form>
	</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>


