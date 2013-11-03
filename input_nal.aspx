<?
require("include/header.aspx");
require("customsql.inc.aspx");

$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$purse = $db_exchange->sel_purse('EasyPay');
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net :: Пополнить WebMoney, Z-PAYMENT, Moneybookers за наличные.</Title>
<Meta name="description" Content="Пополнить или купить WebMoney (WMZ, WMR, WME, WMU), Z-PAYMENT, Moneybookers за наличные через почтовые отделения и кассы Белгазпромбанка.">
<Meta name="keywords" Content="автоматическое пополнение, WebMoney, WMZ, WMR, WME, WMU, Z-PAYMENT, Moneybookers, наличные, почтовое отделение, касса, Белгазпромбанк, купить,">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by WM-RB.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
</head>

<body>
<?
include('include/top.aspx');
?>


	<tr>
	<td width="700" align="center" class="div_include">
<div class="top_title" align="right">Автоматическое пополнение счета WebMoney (WMZ, WMR, WME, WMU), Moneybookers, Z-Payment наличными</div>
<DL id="margin" title="Автоматическое пополнение счета наличными">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Сервис электронных платежей предлагает уникальную возможность автоматически пополнить счет или электронный кошелек WebMoney (WMZ, WMR, WME, WMU), Moneybookers, Z-Payment наличными через почтовое отделение и кассы Белгазпромбанка.<br /><br />
<b>Правила по автоматическому пополнению :</b><br /><br />
 <DD>- в форме, которая расположена ниже выбираете валюту пополнения и способ пополнения;</dd>
 <DD>- далее вводите сумму пополнения свои реквизиты для ввода;</dd>
<dd>- сервис скоректирует сумму пополнения с учетом уже существующих заявок и укажет счет для оплаты;</dd>
<dd>- пополнить НАШ счет в системе EasyPay через валютные кассы и банкоматы Белгазпромбанка или в любом почтовом отделении Белпочта;</dd>
<dd>- после пополнения нашего счета на этой <a href="http://wm-rb.net/user_check_cash.aspx" target="_blank">странице</a> нужно подтвердить оплату, нажав ссылку "Отправить сообщение об оплате" и ввести номер заявки;</dd>
<br />
Обработка заявок производиться ТОЛЬКО после подтверждения на <a href="http://wm-rb.net/user_check_cash.aspx" target="_blank">странице</a>, зачисление денежных средств происходить в течении 2-4 часов с момента подтверждения оплаты.<br />
<br />
<b>Посмотреть список почтовых отделений, где можно произвести пополнение счета расположен на этой <a href="https://ssl.easypay.by/input/post_office/" target="_blank">странице</a></b>.
<br /><br />
 </DL>
 <br />
 <div class="black">Выберете валюту для пополнения</div>
 <br />

 <form method="post" action="http://wm-rb.net/services_demand.aspx" name="form_uslugi" id="form_uslugi"  onSubmit="return Check()">
			<select name="oplata"  id="oplata" >
			<? $currency = $db_exchange->konst_currency('st_cash');
	foreach($currency as $arr) {

			echo "<option value=\"{$arr['0']}\">{$arr['2']}</option>";
	}
?>
		</select>
		<br /><br />
<div id="padding" class="black">Выберете способ пополнения<br /><br />
							<select name="card"  id="card" >
<option value="pochta">Наличными</option>
		</select>
			</div>
		<br />
		<br />
		<input type="hidden" name="type_usluga" value="NAL" readonly="readonly">
		<input type="hidden" name="usluga" value="NAL_input" readonly="readonly">
<input type="submit" name="oplata_nal" value="Отправить" style="width:100px;
		    "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';"
		    id="cursor"/>

 </form>
 <br /><br />
 <center><b>Наш сервис также осуществляем пополнение счетов электронных валют посредством перевода <font color="#FF0000">на карту "АСБ Беларусбанк"</font>.</b><br />
 <b>За подробной информацией обращаться по контактам, которые указаны на <a href="http://wm-rb.net/contact.aspx">странице</a>.</b></center>
</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
