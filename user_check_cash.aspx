<?
//require("include/header.aspx");
require("customsql.inc.aspx");
require("include/constructor_exch.aspx");

$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
$db_admin = new CustomSQL_admin($DBName_admin);
$Constructor = new Constructor();

$errortag = false;
$error_did = true;
$error_did_cash = true;



//форматирование данных
if (!empty($_GET['d'])) {$did = substr(trim(stripslashes(htmlspecialchars($_GET['d']))),0,10); $error_did = false;}
if (!empty($_GET['d_cash'])) {$did = substr(trim(stripslashes(htmlspecialchars($_GET['d_cash']))),0,10); $error_did_cash = false;}
if (!empty($_POST['user_check_cash']) || !empty($_POST['report_cash'])) {
	$did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10); $error_did = false;}
//if (!empty($_POST['LMI_PAYMENT_NO'])) {
//	$sel_did = $db_admin->sel_did($_POST['LMI_PAYMENT_NO']);
//	$did = $sel_did[0]['did'];	$error_did = false;}

//ПОДТВЕРЖДЕНИЕ ОПЛАТЫ
if (!empty($_POST['report_cash'])) {
//проверка рефера
//cheak_ref($_SERVER['HTTP_REFERER']);

//проверка наличия заявки
$empty_dem = $db_pay_desk->empty_dem_nal($did);
$empty_dem_out = $db_pay_desk->empty_dem_out($did);

if (!empty($empty_dem) || !empty($empty_dem_out)) {
	$errormsg = "Заявка оправлена на рассмотрение";
	$errortag = true;
	if(!empty($empty_dem)) $db_pay_desk->demand_edit_nal('yn',$_POST['did'],'demand_cash');
	if(!empty($empty_dem_out)) $db_pay_desk->demand_edit_nal('yn',$_POST['did'],'demand_nal_out');
	}
	else {
	$errormsg = "Данная операция производиться в автоматическом режиме";
	$errortag = true;
	}
}

if(!$error_did || !$error_did_cash) {
	$demand_info = $db_pay_desk->demand_info_nal($did,'demand_nal_out');
	if(!empty($demand_info)) {
		$cur_in_info_out = $db_exchange->cur_out_info($demand_info[0]["output"]);
		$purse = $db_exchange->sel_purse($demand_info[0]['output']);
		$edit_out_val = trim(sprintf("%8.0f",$demand_info[0]['in_val']));
		$desc_pay = "Translation on card №{$demand_info[0]['card']}, ID:{$demand_info[0]['did']}";
	}
	else {
		$demand_info = $db_pay_desk->demand_info_nal($did,'demand_cash');
		$cur_in_info = $db_exchange->cur_out_info($demand_info[0]["input"]);
		$edit_out = truncation_amount($demand_info[0]['out_val']);
		$error_did_cash = false; $error_did = true;
	}
	if (empty($demand_info)) {
		$errormsg = "Заявки с таким номером не существует";
		$errortag = true;}
}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - Сервис электронных платежей :: Страница просмотра информации по заявкам</Title>
<Meta name="description" Content="Автоматизированный обменник электронных валют WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, коммунальные платежи и услуги">
<Meta name="keywords" Content="форум, wm, обмен валюты,обменный, оплата, пополнение, партнерская программа, пункт, услуг">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
<script src="http://wm-rb.net/include/ajax.js" type="text/javascript" language="JavaScript"></script>
<script language='JavaScript'>
<!--
function show_hide(d){
var id=document.getElementById('d'+d);
if(id) id.style.display=id.style.display=='none'?'block':'none';
}
function Check_report() {

if (!document.check_report.did.value.match('^[0-9]{10}$')) {
alert('Номер заявки указан не верно');
document.check_report.did.focus();
return false;
}
return true;
}

function Check_demand() {

if (!document.check_demand.did.value.match('^[0-9]{10}$')) {
alert('Номер заявки указан не верно');
document.check_demand.did.focus();
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
	<td width="700" align="center" class="div_include">
	<div class="top_title" align="right">
Страница просмотра информации по заявкам
</div>
<?

if ($errortag){
       echo "<br><div class=red>Внимание!!! </div>
<div class=black>";
echo $errormsg;
echo "</div>";
        }
if ($errortag || empty($_POST['user_check_cash']) && empty($_GET['d']) && empty($_GET['d_cash'])) {

echo "

<div style=\"display: none;\" id=\"d1\">
<br />
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"user_check_cash.aspx\" onSubmit=\"return Check_report()\">
	№ заявки : <input type=\"text\" name=\"did\" size=\"10\" maxlength=\"10\" value=\"{$did}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report_cash\" value=\"Сообщить\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div>
<br />
<a href=\"javascript:show_hide(1)\">Отправить сообщение об оплате</a><br /><br />
<form name=\"check_demand\" id=\"check_demand\" method=\"post\" action=\"user_check_cash.aspx\" onSubmit=\"return Check_demand()\">
                    <table width=\"350\" border=\"0\" cellspacing=\"1\" cellpadding=\"10\" bgColor=\"#ebebeb\">
  					    <tr bgColor=\"#f3f7ff\">
                        <td align=\"center\" class=\"text_log\"><b>Номер Вашей заявки :</b></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"center\">
                          <input type=\"text\" name=\"did\" id=\"did\" size=\"12\" maxlength=\"10\">
                        </td>
                      </tr>
                    </table>
					<br />
                    <input type=\"submit\" name=\"user_check_cash\" value=\"Проверить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">
                    </form>";
}
else {
	if (!$error_did_cash) {include ("include/check_demand_cash.aspx");}
	if (!$error_did) {include ("include/check_dem_cash_out.aspx");}

}
?>
	</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
