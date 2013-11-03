<?php

require("customsql.inc.aspx");

$db = new CustomSQL($DBName);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>Интернет-банк NoxPay.su :: Кредитование, ивестирование, обмен электронных валют, оплата коммунальных платежей, мобильной связи</Title>
<Meta name="description" Content="">
<Meta name="keywords" Content="">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by noxpay.su">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
<script language='JavaScript'>
<!--
function Check() {

if (document.form_uslugi.oplata.value == "none") {
alert('Выберите способ оплаты');
document.form_uslugi.oplata.focus();
return false;
}

return true;
}
// -->
</script>
</head>

<body>
<?
include('include/top.aspx');
?>


	<tr>
	<td width="700" align="center" class="div_include"><br /><br />
	<form method="post" action="out_cash_demand.aspx" name="form_uslugi" id="form_uslugi"  onSubmit="return Check()">
	<table width="500" border="0" cellspacing="1" cellpadding="4" bgColor="#C0C0C0">
	<tr bgColor="#FFE4B5">
		<td width="35%" align="center" valign="top"><h1>Услуги</h1></td>
		<td width="65%" align="center" valign="top"><h1>Описание</h1></td>
	</tr>


<? $uslugi = $db_pay_desk->sel_uslugi();
$count = 1;
	foreach($uslugi as $arr) {
		$name = $arr['0'];
		$desc_val = $arr['1'];
		$desc_uslugi = $arr['2'];

	echo "<tr bgColor=\"#ffffff\">
		<td width=\"30%\" align=\"left\" valign=\"top\" class=\"text_log\"><input type=\"radio\" ";
		if ($count == "1") echo "checked=1";
		echo " name=\"usluga\" value=\"$name\">&nbsp;{$desc_val}</td>
		<td width=\"70%\" align=\"left\" valign=\"top\" class=\"text_log\">{$desc_uslugi}</td>
	</tr>";
	$count++;
	}
?>

	<tr bgColor="#ffffff">
		<td colspan="2" align="center" valign="top" class="text">
		<select name="oplata"  id="oplata" >
			<option value="none" selected="selected">Выберите способ оплаты</option>
			<option value="WMZ">WebMoney WMZ</option>
			<option value="WMR">WebMoney WMR</option>
			<option value="WME">WebMoney WME</option>
			<option value="WMU">WebMoney WMU</option>
			<option value="WMY">WebMoney WMY</option>
			<option value="WMB">WebMoney WMB</option>
		</select>
		</td>
	</tr>
	<tr bgColor="#f3f7ff">
		<td colspan="2" align="center" valign="top" class="text"><input type="submit" name="send_demand" value="Отправить" style="width:100px;
		    "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';"
		    id="cursor"/></td>
	</tr>
	</table>
	</form>
<br /><br />
</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
