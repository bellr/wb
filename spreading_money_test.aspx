<?php
require("customsql.inc.aspx");
$url = $_SERVER['HTTP_HOST'];

$db = new CustomSQL($DBName);
if(!empty($_GET['m'])) {
$info_currency = $db->info_currency($_GET['m']);
}
if(!empty($_POST['buy_money'])) {
require($_SERVER['DOCUMENT_ROOT']."/include/smtp-func.aspx");
require("include/class_error.aspx");
	$oplata = substr(trim(stripslashes(htmlspecialchars($_POST['oplata']))),0,10);
	$email = substr(trim(stripslashes(htmlspecialchars($_POST['email']))),0,36);
	$summa_pay = substr(trim(stripslashes(htmlspecialchars($_POST['summa_pay']))),0,16);
	$count_wmb = substr(trim(stripslashes(htmlspecialchars($_POST['count_wmb']))),0,10);
	$purse = substr(trim(stripslashes(htmlspecialchars($_POST['purse']))),0,13);
	$type_money = substr(trim(stripslashes(htmlspecialchars($_POST['type_money']))),0,13);

	$CheckError = new Error();
$ar_error = $CheckError->Email($email);
$ar_error .= $CheckError->wmb_purse($purse);
$ar_error .= $CheckError->check_summ($count_wmb,$summa_pay,$oplata,$k_Webpay,$k_iPay,$k_input);

	if($ar_error > 0) {header("Location: http://{$url}"); exit();}

setcookie("email", $email, time() +31104000, "/", "{$url}");
setcookie("purse", $purse, time() +31104000, "/", "{$url}");
$reqID = wm_ReqID();
$order = $count_wmb.":".$type_money."|";
$db->add_order_money($reqID,$oplata,$purse,$summa_pay,$order,$email,$data_pay,$time_pay,$_COOKIE['rk_id'],'buy_emoney');
$db->add_id_pay($reqID,$_SERVER['REMOTE_ADDR'],$_SERVER['HTTP_X_FORWARDED_FOR']);
	$from_name = "Robot PinShop.by";
	$subject = "Заказ №{$reqID} успешно создана.";
	$body = "
<div style=\"FONT-SIZE: 12px; FONT-FAMILY: Verdana; COLOR: #676767; LINE-HEIGHT: 18px;\">
<center><b>Здравствуйте</b></center><br />
-------------------------------------------------<br />
<b>Номер Вашего заказа :</b> {$reqID}<br />
-------------------------------------------------<br />
<br />
Проверить статус, а так же реквизиты заказа Вы можете <a href='http://{$url}/' style=\"FONT-SIZE: 12px; FONT-FAMILY: Verdana; LINE-HEIGHT: 18px;\">здесь</a>, указав в правом разделе <b>\"Информация о заказе\"</b> номер вашего заказа.<br /><br />
<b>Получение товара :</b><br /><br />
- оплатить данный заказ;<br />
- после оплаты нужно зайти на сайт интернет-магазина <a href=\"http://{$url}/\">PinShop.by</a> и в меню с права ввести номер заказа;<br />
- после этого Вы перейдете на страницу, на которой будут размещены реквизиты вашего заказа.<br />
<br />
Сервис полностью автоматический, по-этому если вы не получили товар в течении 15 минут, сразу же обращайтесь в службу поддержки.<br />
<br />
Мы будем благодарны Вам за любые предложения, высказанные по поводу того,<br />
какой Вы хотите видеть интернет-магазин PinShop.by.<br /><br />

Благодарим Вас за использование нашего Сервиса.<br />
Это письмо отправлено роботом, ответа не требует.<br />
<br />
--<br />
С уважением,<br />
Администрация PinShop.by<br />
<br />
<a href='http://pinshop.by'>Интернет-магазин пин-кодов</a><br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq<br />
Тел. $tel</div>";
smtpmail($email,$subject,$body,$from_name);
	header("Location: http://{$url}/cheque_emoney_test.aspx?d={$reqID}");
	//header("Location: http://{$url}");
exit;
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>PinShop.by - Магазин по продаже пин-кодов -> Купить <?echo $info_currency[0]['desc_val'];?> пластиковой картой VISA, MasterCard, мобильным платежем iPay.</Title>
<Meta name="description" Content="Купить <?echo $info_currency[0]['desc_val'];?> пластиковой картой VISA, MasterCard, мобильным платежем iPay">
<Meta name="keywords" Content="Покупка, купить, продаже, wmb, webmoney, easypay, ">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META name="author" content="AtomLy">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by PinShop.by">
<link rel="stylesheet" href="http://<?echo $url; ?>/include/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://<?echo $url; ?>/img/favicon.ico" TYPE="image/x-icon">
<? include('include/js_calc.aspx');
if(!empty($_GET['m'])) {
?>
<SCRIPT type="text/javascript">
<!--
function CountMoney() {
	s=document.buy_cur.count_wmb.value;
	if(document.buy_cur.oplata.value == 'WebPay') {com_pay=<?echo $k_Webpay;?>;}
	if(document.buy_cur.oplata.value == 'iPay') {com_pay=<?echo $k_iPay;?>;}
	res = Math.floor(s*(1+com_pay+<?echo $k_input;?>));
	document.getElementById('s_pay').innerHTML = res;
	document.buy_cur.summa_pay.value= res;
}

function Check() {
if (document.buy_cur.count_wmb.value <= 0 && document.buy_cur.count_wmb.value <= '0') {
alert('Вы не указали количество титульных знаков');
document.buy_cur.count_wmb.focus();
return false;
}
if (document.buy_cur.count_wmb.value > <? echo $info_currency[0]['balance'];?>) {
alert('Вы превысили доступный резерв титульных знаков');
document.buy_cur.count_wmb.focus();
return false;
}
if(document.buy_cur.oplata.value == 'WebPay') {
if (document.buy_cur.summa_pay.value <= 30000 || document.buy_cur.summa_pay.value > 200000) {
alert('Сумма оплаты должна быть в пределах от 30 000 до 200 000 бел. рублей');
return false;
}
}
if(document.buy_cur.oplata.value == 'iPay') {
if (document.buy_cur.summa_pay.value <= 100 || document.buy_cur.summa_pay.value > 1050000) {
alert('Сумма оплаты должна быть в пределах от 100 до 1 050 000 бел. рублей');
return false;
}
}
if (!document.buy_cur.purse.value.match('^[B,b]{1}[0-9]{12}$')) {
alert('WMB кошелек указан не верно');
document.buy_cur.purse.focus();
return false;
}

if (!document.buy_cur.email.value.match('^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-Mail указан не верно');
document.buy_cur.email.focus();
return false;
}
return true;
}
// -->
</SCRIPT>
<?}?>
</head>

<body style="width: 1000px;  margin:10px auto; padding: 0 5px;">
<center>
<?
include('include/top.aspx');
?>


<div id="main">
<div class="mainrazd"><h1>Покупка <? echo $info_currency[0]['desc_val']; ?> </h1></div>
	<div class="maincontainer"><br />
<font size="" color="#FF0000"><b>СЕРВИС НАХОДИТЬСЯ В РЕЖИМЕ ТЕСТИРОВАНИЯ</b></font><br /><br />
	<div class="text" align="left" id="margin">&nbsp;&nbsp;&nbsp;&nbsp;<? echo $info_currency[0]['desc_m']; ?>
</div>
<div class="text" align="left">
<ol type="circle"><b>Дополнительно взимаемая комиссия в момент покупки :</b>
	<li>комиссия ОАО "Технобанк" - 3%(см. <a href="http://www.wmtransfer.by/tarrifs.asp" target="_blank">тарифы банка</a>); </li>
<!-- 	<li>при оплате пластиковой картой VISA/MasterCard - 4%;</li> -->
	<li>при оплате платежной системой iPay - 10%.</li>
</ol><br />
<ol type="circle"><b>Ограничения сумм платежей :</b>
<!-- 	<li>максимальная сумма при оплате пластиковой картой VISA/MasterCard - <u>200 000 бел. рублей</u>, минимальная сумма - <u>30 000 бел. рублей</u>; </li> -->
	<li>максимальная сумма при оплате платежной системой iPay - <u>1 050 000 бел. рублей</u>, минимальная сумма - <u>100 бел. рублей</u>.</li>
</ol><br />
</div>
<div class="input_form" style="margin-right:40px;">

<form name="buy_cur" id="buy_cur" method="post" action="http://<?echo $url; ?>/spreading_money.aspx" onSubmit="return Check()">
<div class="input_form"><b>Количество титульных знаков :</b> <input type="text" id="count_wmb" name="count_wmb" value="0" size="8" maxlength="7" onclick="javascript:if(this.value=='0')this.value='';" onkeyup="CountMoney()" /> &nbsp;&nbsp;<? echo $_GET['m']; ?><br />
<span class="text_log"><b>Доступно для пополнения :</b> <? echo $info_currency[0]['balance']; ?> <? echo $_GET['m']; ?></span></div>

<div class="input_form"><b>Способ оплаты :</b> <select name="oplata" id="oplata" onclick="CountMoney()" onSelect="CountMoney()" onFocus="CountMoney()" onSelect="CountMoney()" onKeyUp="CountMoney()" onChange="CountMoney()">
<!-- <option value="WebPay" selected="selected">Карта VISA/MasterCard</option> -->
	<option value="iPay">Мобильные платежи iPay</option>
</select></div>
<div class="input_form"><b>Сумма оплаты :</b> <span id="s_pay">0</span> бел. рублей</div>
<div class="input_form"><b>Ваш <? echo $_GET['m']; ?> кошелек : </b><input type="text" name="purse" id="purse" size="14" maxlength="13"  value="<?echo $_COOKIE['purse'];?>"  onmouseover="javascript:ShowHelp('showpurse');" onmouseout="javascript:HideHelp('showpurse');"><div id="showpurse" class="title" style="display:none; position:absolute; margin-top:5px; margin-left:5px;">На этот кощелек будет совершен перевод.</div></div>
<div class="input_form"><b>Ваш E-Mail : </b><input type="text" name="email" id="email" value="<?echo $_COOKIE['email'];?>" onmouseover="javascript:ShowHelp('showemail');" onmouseout="javascript:HideHelp('showemail');"><div id="showemail" class="title" style="display:none; position:absolute; margin-top:5px; margin-left:5px;">На этот адрес будет выслан номер заявки и дальнейшие инструкции.</div></div>
<input type="hidden" name="summa_pay" id="summa_pay" value="0" />
<input type="hidden" name="type_money" value="<?echo $_GET['m'];?>" />
<div class="input_form"><input type="submit" class="form_log_pass" id="cursor"  name="buy_money" onmouseout="this.style.backgroundColor='#f3f7ff';" onmouseover="this.style.backgroundColor='#E8E8FF';" style="width: 80px; margin-left: 50px; background-color: rgb(243, 247, 255);" value="Купить"></div>
</form>
</div>
<br />

</div>
</div>
<?
include('include/bottom.aspx');
?>
</center>
</body>
</html>
