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
//форматирование данных
if (!empty($_GET['d'])) {
	$did = substr(trim(stripslashes(htmlspecialchars($_GET['d']))),0,10); $error_did = false;}
if (!empty($_POST['user_check_usluga']) || !empty($_POST['report_usluga'])) {
	$did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10); $error_did = false;}
//if (!empty($_POST['LMI_PAYMENT_NO'])) {
//	$sel_did = $db_admin->sel_did($_POST['LMI_PAYMENT_NO']);
//	$did = $sel_did[0]['did'];	$error_did = false;}

if (!empty($_POST['report_usluga'])) {
//проверка рефера
cheak_ref($_SERVER['HTTP_REFERER']);

//проверка наличия заявки
$empty_dem = $db_pay_desk->empty_dem($did);
if (!empty($empty_dem)) {
	$errormsg = "Заявка оправлена на рассмотрение";
	$errortag = true;
	$db_pay_desk->demand_edit('yn',$_POST['did']);

//отправка данных платежа на телефон через смс
require($home_dir."mailer/smtp-func.aspx");
	$mail = new PHPMailer();
	$mail->IsSMTP();
	$mail->Host = $mail_host;
	$mail->SMTPAuth = true;
	$mail->Username = $mail_user;
	$mail->Password = $mail_pass;
	$mail->From = 'support@wm-rb.net';
	$mail->FromName = "SERVICES";
	$mail->AddAddress('1176044@sms.velcom.by');
	$mail->WordWrap = 2024;
	$mail->IsHTML(false);
	$mail->Subject = "Notice";
	$mail->Body = $did;
	$mail->Send();
	}
	else {
	$errormsg = "Данное операция производиться в автоматическом режиме!";
	$errortag = true;
	}
}

//вывод инфы по завке
if (!$error_did) {
$demand_info = $db_pay_desk->demand_info($did);

	if (!empty($demand_info)) {
		$out_val = $demand_info[0]['out_val'];
$purse = $db_exchange->sel_purse($demand_info[0]['output']);
$us = $db_pay_desk->select_usluga($demand_info[0]['name_uslugi'],'uslugi');
$desc_pay = "Payment facilities: {$demand_info[0]['name_uslugi']}, ID:{$demand_info[0]['did']}";
$des_cat = $db_pay_desk->select_cat($demand_info[0]['name_uslugi']);
$cur_out_info = $db_exchange->cur_out_info($demand_info[0]['output']);
$edit_out_val = trim(sprintf("%8.0f",$demand_info[0]['out_val']));
$count = $count = $demand_info[0]['output'];
	}
	else {
		$errormsg = "Заявки с таким номером не существует";
		$errortag = true;
	}
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<meta name="description" Content="Автоматизированный обменник электронных валют WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, коммунальные платежи и услуги">
<meta name="keywords" Content="форум, wm, обмен валюты,обменный, оплата, пополнение, партнерская программа, пункт, услуг">
<title>WM-RB.net - Сервис электронных платежей :: Страница просмотра информации по заявкам</title>
<?= Vitalis::tmpl('Widgets')->load_tmpl_block('system.static_data'); ?>
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

if ($errortag || empty($_POST['user_check_usluga']) && empty($_GET['d'])){

echo "

<div style=\"display: none;\" id=\"d1\">
<br />
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"http://wm-rb.net/user_check_usluga.aspx\" onSubmit=\"return Check_report()\">
	№ заявки : <input type=\"text\" name=\"did\" size=\"10\" maxlength=\"10\" value=\"{$did}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report_usluga\" value=\"Сообщить\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div>
<br />
<a href=\"javascript:show_hide(1)\">Отправить сообщение об оплате</a><br /><br />
<form name=\"check_demand\" id=\"check_demand\" method=\"post\" action=\"http://wm-rb.net/user_check_usluga.aspx\" onSubmit=\"return Check_demand()\">
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
                    <input type=\"submit\" name=\"user_check_usluga\" value=\"Проверить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">
                    </form><br /><br />";
}

if (!empty($_POST['user_check_usluga']) && !$errortag || !empty($_GET['d'])) {
include ("include/check_demand_uslugi.aspx");
}
?>
	</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
