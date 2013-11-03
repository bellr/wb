<?
require("customsql.inc.aspx");
require("include/constructor.aspx");
require("include/class_error.aspx");
$db = new CustomSQL($DBName);
$CheckError = new Error();
$url = $_SERVER['HTTP_HOST'];
//if(!empty($_POST['did'])) {
//	header("Location: http://{$url}/check_order.aspx?d=".$_POST['did']);
//	exit();}
if(!empty($_GET['d'])) {
	$did = substr(trim(stripslashes(htmlspecialchars($_GET['d']))),0,10);
	$ar_error .= $CheckError->Did($did);
	$demand_info = $db->demand_emoney($did);
	$id_pay = $db->sel_idpay($did);
$order = explode('|',$demand_info[0]['order_arr']);
$orders = explode(':',$order[0]);
$summa_com = $demand_info[0]['summa'] - $orders[0];
}

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>PinShop.by - Магазин пин-кодов -> Выписка счета</Title>
<Meta name="description" Content="">
<Meta name="keywords" Content="">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META name="author" content="AtomLy">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by PinShop.by">
<link rel="stylesheet" href="http://<?echo $url; ?>/include/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://<?echo $url; ?>/img/favicon.ico" TYPE="image/x-icon">

</head>

<body style="width: 1000px;  margin:10px auto; padding: 0 5px;">
<center>
<?
include('include/top.aspx');

?>


<div id="main">
<div class="mainrazd"><h1></h1></div>
	<div class="maincontainer">
<?

if(!$errortag) {
if($demand_info[0]["status"] == "n") {
echo "<div id=\"report\" align=\"left\" style=\"margin-top:10px;\" class=\"text_log\">
&bull; Неоплаченный заказ действителен в течении <b>1 часа</b><br />
&bull; Номер данного заказа и инструкции отправлены Вам на E-Mail
</div>";
}
echo "
<br />



<table width=\"400\" bgColor=\"#ffffff\" border=\"0\" cellspacing=\"0\" cellpadding=\"8\" style=\"BORDER: #ebebeb 1px solid; margin-bottom:15px;\" class=\"text\">
	<tr>
		<td colspan=\"2\" align=\"center\" bgColor=\"#F0F8FF\"><b>ЧЕК №</b> {$id_pay[0]['id_pay']}</td>
	</tr>
	<tr>
		<td colspan=\"2\" align=\"center\"><u>РАСПРОСТРАНЕНИЕ ЭЛЕКТРОННЫХ ДЕНЕГ</u></td>
	</tr>
	<tr>
		<td width=\"50%\" align=\"left\" class=\"text_log\">Интернет-магазин PinShop.by</td>
		<td class=\"text_log\"><b>ЗАКАЗ №</b> {$demand_info[0]['did']}, тел. для справок {$tel}</td>
	</tr>
	<tr>
		<td align=\"left\"><b>Банк-эмитент :</b></td>
		<td class=\"text_log\">ОАО \"Технобанк\" РБ г. Минск ул. Кропоткина 44, тел. для справок +375(17)237-43-94</td>
	</tr>";
	if (!empty($demand_info[0]['coment'])) {
	echo "<tr>
		<td align=\"left\"><b>Комментарий:</b></td>
		<td class=\"text_log\"><i>{$demand_info[0]['coment']}</i></td>
	</tr>";
	}
	echo "
	<tr>
		<td align=\"left\"><b>Сумма оплаты :</b></td>
		<td>{$demand_info[0]['summa']} BYR</td>
	</tr>
	<tr>
		<td align=\"left\"><b>Сумма эл. денег :</b></td>
		<td>{$orders[0]} WMB</td>
	</tr>
	<tr>
		<td align=\"left\"><b>Комиссия :</b></td>
		<td>{$summa_com} BYR</td>
	</tr>
	<tr>
		<td align=\"left\"><b>Дата :</b></td>
		<td> {$demand_info[0]['data_pay']} {$demand_info[0]['time_pay']}</td>
	</tr>
</table>
";
if ($demand_info[0]["status"] == "n" || $demand_info[0]["status"] == "p") {
	$sel_idpay = $db->sel_idpay($did);
	$c = explode("||",$demand_info[0]['company']);
	$company = explode("|",$c[0]);

	$purse = $db->RezervPusre($company[0],$WMB,$rezerv_WMB);
	$amount = $demand_info[0]['summa'];
	$desc_pay = "Оплата заказа №{$did} на сумму ".$demand_info[0]['summa']." рублей";
ParamertyPayment($did,$demand_info[0]['oplata'].'_e',$amount,$desc_pay,$sel_idpay[0]["id_pay"],$purse,$company[0]);
}


}
else {
       echo "<br><div id=\"report\"><b>Внимание!!!</b> ";
echo $errormsg;
echo "</div><br />";
}

?>
</div>
</div>




<?
include('include/bottom.aspx');
?>
</center>
</body>
</html>
