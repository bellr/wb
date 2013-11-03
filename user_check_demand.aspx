<?
//require("include/header.aspx");
require("customsql.inc.aspx");
require("include/constructor_exch.aspx");

$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$db_admin = new CustomSQL_admin($DBName_admin);
$Constructor = new Constructor();
$errortag = false;
$error_pay = true;
$error_did = true;
//форматирование данных
if (!empty($_GET['d'])) {
    $did = substr(trim(stripslashes(htmlspecialchars($_GET['d']))),0,10); $error_did = false;}
if (!empty($_POST['user_check_demand']) || !empty($_POST['report'])) {
    $did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10); $error_did = false;}
//if (!empty($_POST['LMI_PAYMENT_NO'])) {
//	$sel_did = $db_admin->sel_did($_POST['LMI_PAYMENT_NO']);
//	$did = $sel_did[0]['did'];	$error_did = false;}
//форматирование данных


if (!empty($_POST['report'])) {
    //проверка рефера
    cheak_ref($_SERVER['HTTP_REFERER']);

    //проверка наличия заявки
    $empty_dem = $db_exchange->empty_dem($did);
    if (!empty($empty_dem)) {
        //проверка заявки на обмен RBK, EP, YD
        $cheak_pay_ok = $db_exchange->cheak_pay_ok($did);
        if (!empty($cheak_pay_ok)) {
            $errormsg = "Заявка оправлена на рассмотрение";
            $errortag = true;
            $db_exchange->demand_edit('yn',$_POST['did']);
            //отправка данных платежа на телефон через смс
            require($home_dir."mailer/class.phpmailer.aspx");
            $mail = new PHPMailer();
            $mail->IsSMTP();
            $mail->Host = $mail_host;
            $mail->SMTPAuth = true;
            $mail->Username = $mail_user;
            $mail->Password = $mail_pass;
            $mail->From = 'support@wm-rb.net';
            $mail->FromName = "EXCHANGE";
            $mail->AddAddress('1176044@sms.velcom.by');
            $mail->WordWrap = 2024;
            $mail->IsHTML(false);
            $mail->Subject = "Notice";
            $mail->Body = $did;
            $mail->Send();
        }
    }
    else {
        $errormsg = "Данный обмен производиться в автоматическом режиме";
        $errortag = true;
    }
}

//вывод инфы по завке
if (!$error_did) {

	$demand_info = dataBase::DBexchange()->select('demand','*','where did='.$did);
    if (!empty($demand_info)) {
        $out_val = $demand_info[0]['out_val'];
        //вывод кошелька на кот. будет выполняться перевод
        $purse = $db_exchange->sel_purse($demand_info[0]['ex_output']);
        $desc_pay = "Direction of the exchange: {$demand_info[0]['ex_output']}->{$demand_info[0]['ex_input']}, ID:{$demand_info[0]['did']}";
        $cur_out_info = $db_exchange->cur_out_info($demand_info[0]["ex_output"]);
        $cur_in_info = $db_exchange->cur_out_info($demand_info[0]["ex_input"]);
        $edit_out_val = trim(sprintf("%8.0f",$demand_info[0]['out_val']));
        $count = $demand_info[0]["ex_output"];
		$demand_info[0]["coment"] = $value = iconv("UTF-8", "windows-1251", $demand_info[0]["coment"]);
    }
    else {
        $errormsg = "Заявки с таким номером не существует";
        $errortag = true;
    }
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
    <META name="author" content="AtomLy">
    <META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
    <link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
    <link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
	<? echo Vitalis::tmpl()->load_tmpl_block("inc.include_files"); ?>
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

        if ($errortag || empty($_POST['user_check_demand']) && empty($_GET['d'])) {

            echo "

<div style=\"display: none;\" id=\"d1\">
<br />
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"http://wm-rb.net/user_check_demand.aspx\" onSubmit=\"return Check_report()\">
	№ заявки : <input type=\"text\" name=\"did\" size=\"10\" maxlength=\"10\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report\" value=\"Сообщить\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div>
<br />
<a href=\"javascript:show_hide(1)\">Отправить сообщение об оплате</a><br /><br />
<form name=\"check_demand\" id=\"check_demand\" method=\"post\" action=\"http://wm-rb.net/user_check_demand.aspx\" onSubmit=\"return Check_demand()\">
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
                    <input type=\"submit\" name=\"user_check_demand\" value=\"Проверить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">
                    </form>";
        }
//if (!empty($_POST['LMI_PAYMENT_NO'])) {
//include ("include/form_check_demand.aspx");}
        if (!empty($_POST['user_check_demand']) && !$errortag || !empty($_GET['d'])) {
            include ("include/form_check_demand.aspx");
        }
        ?>
        <br /><br />
    </td>
</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
