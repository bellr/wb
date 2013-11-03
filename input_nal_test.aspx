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
<Title>WM-RB.net - Сервис электронных платежей :: Пополнить WMZ, WMB, WMR, WMG, WME, WMU, WMY, EasyPay, Yandex Money за наличные или купить за EasyPay</Title>
<Meta name="description" Content="Автоматизированный обменник электронных валют WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, Yandex Money, коммунальные платежи и услуги">
<Meta name="keywords" Content="форум, wm, WMZ, WMB, WMR, WMG, WME, WMU, WMY, Yandex Money, обмен, валюты,обменный, оплата, пополнение, партнерская программа, пункт, услуг, пополнить, купить, EasyPay">
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
<div class="top_title" align="right">Порядок действий при пополнении счета наличными</div>
<DL id="margin" title="Порядок действий при пополнении счета наличными">
 <DD>Администрация СЕРВИСА предлагает <b>сначала создать заявку</b>, а потом уже ее оплачивать, это может ускорить процесс перевода. Заявка действительна в течении 24 часов.</dd>
<br />
<dd class="black">В почтовых отделениях</dd><br />
 <DD>Пополнить НАШ счет в EasyPay <b><? echo $purse[0]['purse']; ?> </b>(пункты пополнения EasyPay описаны <a href="http://easypay.by/page4.htm#1">на странице сайта EasyPay.by</a>).</dd>
 <br />
<dd class="black">С помощью пластиковых карт</dd>
 <br />
<dd>Оплачиваете указанную сумму на нашу банковскую карточку, реквизиты вы получите после создания заявки.</dd><br />
 <DD>Об оплате сообщить на странице <a href="user_check_cash.aspx">проверка заявки</a>.</dd>
 <dd>Ваш платеж будет обработан в ближайшее время.</dd>
 <dd>Валюты которые Вы можете купить за EasyPay и по пластиковой карточке через наш сервис: WMZ, WMB, WMR, WMG, WME, WMU, WMY, Z-PAYMENT, Yandex Money.</dd>
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
<option value="bpsb">БПС-Банк</option>
<option value="belbank">БеларусБанк</option>
<option value="pochta">Почтовое отделение</option>
<option value="VISA">Карта Visa/MasterCard</option>
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
</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
