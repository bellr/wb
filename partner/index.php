<?

define('PROJECT','HOME');
define('PROJECT_ROOT',dirname(dirname(__FILE__)));
define('VS_DEBUG',true);

require_once(dirname(PROJECT_ROOT)."/core/vs.php");

session_start();
require("include/header.aspx");

$showtable = true;
$errortag = false;
$error_did = true;

if($_GET['action'] == 'logout') session_unset();

if(!empty($_POST['login_index'])) {
    $email = trim(stripslashes(htmlspecialchars($_POST['email'])));
    $pass = trim(stripslashes(htmlspecialchars($_POST['passw'])));
    if(!preg_match("/^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$/", $email) && empty($pass)) {
        header("location: http://wm-rb.net");
        exit;
    }

    $ses_start = dataBase::DBmain()->select('partner','id, password, status',"where email='{$email}' and password='".sUser::createPassword(Model::Partner(),$pass)."'");

    if (empty($ses_start)) {

        $errortag = true;
        $errormsg = "Неправильно введено имя или пароль";

    } elseif($ses_status['status'] == '0') {

        $errortag = true;
        $errormsg = "Ваш аккаунт заблокирован";

    } else {
        $showtable = false;
        $_SESSION['id'] = $ses_start[0]["id"];
        $_SESSION['pass'] = $pass;
        $_SESSION['email'] = $email;
    }
}

if(!empty($_SESSION['id']) && !$errortag) {

    $ses_start = dataBase::DBmain()->select('partner','id, password, status',"where email='".$_SESSION['email']."' and password='".sUser::createPassword(Model::Partner(),$_SESSION['pass'])."'");

    if (empty($ses_start)) {

        $errortag = true;
        $errormsg = "Неправильно введено имя или пароль.";
    }
    else {

        $info_akk = Model::Partner()->get(array(
            'id' => $_SESSION['id']
        ));

        $PP = (array)Extension::Payments()->getParam('payments');
        $showtable = false;

        $exch_balance = Model::Balance()->get(array(
            'name' => 'WMZ'
        ));

        $balance_in = $exch_balance["balance"] - $exch_balance["balance"] * $PP['com_WMT'] / 100;

        if(!empty($_POST['op_output'])) {
            if($info_akk['refer'] > 100 && $info_akk['count_oper'] > 10) {

                if ($balance_in >= $_POST['summa'] && $_POST['summa'] >= 5 && $_POST['summa'] <= $info_akk['balance']) {
                    if(preg_match("/^[Z,z]{1}+[0-9]{12}+$/", $_POST['purse'])) {

                        $sel_idpay = Model::Id_payment()->add($did);

                        $r = Extension::Payments()->Webmoney()->x2(array(
                            'id_pay'        => $sel_idpay,
                            'purse_in'      => $_POST['purse'],
                            'purse_type'    => 'WMZ',
                            'amount'        => floatval($_POST['summa']),
                            'desc'          => 'Партнерские выплаты ID'.$_SESSION['id']
                        ),'primary_wmid');

                        if($r->retval == '0') {
                            $bal_in = $_POST['summa'] * (1 + $PP['com_WMT'] / 100) ;

                            Model::Balance()->updateBalance('WMZ','-'.$bal_in);
                            Model::Partner()->updateBalance($_SESSION['id'],'-'.$_POST['summa']);

                            header("Location: index.php");
                            exit;
                        }
                    }
                }
            }
            else {
                $errortag = true;
                $errormsg = "Ваш аккаунт используется в ограниченном режиме.<br />Обратитесь в Службу поддержки для разъяснений.";
            }
        }

    }
}
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
    <Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
    <Title>WM-RB.net - Сервис электронных платежей :: Партнерская программа</Title>
    <Meta name="description" Content="Автоматизированный обменник электронных валют WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, коммунальные платежи и услуги">
    <Meta name="keywords" Content="обменный пункт, автоматизированный обменник, exchange, электронные деньги, wmb, wmz, wmr, wme, easypay, rbk money, yandex money, автоматизированный обмен, автоматизированный автомат, обмен цифровых денег, обмен wm, электронные денеги в Беларуси, пополнение ввод вывод WebMoney в Минске, обменять webmoney, курсы, обмен валют, обменник, Минск, Беларусь, заработок, ВебМани, интернет-деньги, БелГазПром банк, online change, баланс телефона, пополнение, оплата, коммунальные платежи и услуги, свет, газ, мобильной связи, мобильный, партнерская программа">
    <META HTTP-EQUIV="EXPIRES" CONTENT="0">
    <META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
    <META content="30 days" name="revisit-after">
    <META content="index,follow,all" name="robots">
    <META name="author" content="AtomLy">
    <META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
    <link rel="stylesheet" href="http://wm-rb.net/static/src/css/style.css" type="text/css">
    <link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">

    <script language="JavaScript">
        <!--
        <?
        echo "
function Check_pay() {
if (document.output.purse.value.length == 0) {
alert('Вы не ввели кошелек');
document.output.purse.focus();
return false;
}
if (parseFloat(document.output.summa.value) > {$info_akk['balance']}) {
alert('Вы ввели сумму больше допустимой');
document.output.summa.focus();
return false;
}
if (parseFloat(document.output.summa.value) > {$balance_in}) {
alert('Введенная Вами сумма больше баланса');
document.output.summa.focus();
return false;
}
if (!document.output.purse.value.match('^[Z,z]{1}[0-9]{12}$')) {
alert('Z-кошелек указан не верно');
document.output.purse.focus();
return false;
}
if (parseFloat(document.output.summa.value) < 5) {
alert('Минимальная сумма вывода: 5$');
document.output.summa.focus();
return false;
}
return true;
}
"; ?>
        // -->
    </script>
</head>

<body>
<?
include('include/top.aspx');
?>
<tr>
    <td colspan="2" id="padding">

    </td>
</tr>
<tr>

<td colspan="2" align="center" class="div_include"><br />
<?
if ($errortag){
    echo "<div class=\"div_operok\">";
    echo $errormsg;
    echo "</div><br /><br />";
}
if($showtable) {
    ?>
<form name="login" id="login" action="index.php"  method="POST" onSubmit="return Check_login()">
    <div class="text">
        Для входа в защищенную зону Вы должны авторизироваться</div><br /><br />

    <div id="padding" class="div_include" style="margin-bottom: 10px; width: 300px;">
        Введите Ваш E-mail :
    </div>

    <div id="padding" class="div_include" style="background: #f3f7ff; margin-bottom: 10px; width: 300px;">
        <input type="text" size="15" maxlength="52" name="email" / style="background: #fcfcfc;">
    </div>

    <div id="padding" class="div_include" style="margin-bottom: 10px; width: 300px;">
        Введите пароль :
    </div>
    <div id="padding" class="div_include" style="background: #f3f7ff; margin-bottom: 10px; width: 300px;">
        <input type="password" size="15" maxlength="32" name="passw" /style="background: #fcfcfc;">
    </div>


    <input type="hidden" name="ses_id" value="<? echo session_id(); ?>" readonly="readonly">
    <input type="submit" name="login_index" value="Вход" style="width:100px; "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';" id="cursor" />

</form>
    <?
}
else {
    ?>
<div class="text" align="left">
<b>&nbsp;ВАШ АККАУНТ</b>
<hr color="#cococo"  size="1" /><br />
    <?	if ($kod_error == "0") {
    echo "<div class=\"div_operok\">";
    echo "Ваши средства переведены, спасибо за сотрудничество.";
    echo "</div><br /><br />";
} ?>
<br />
<div id="margin"><b>› Ваше учетное имя: </b><? echo $info_akk['email']; ?></div>
<div id="margin"><b>› Партнерский сайт: </b>http://<? echo $info_akk['host']; ?></div>
<div id="margin"><b>› Баланс: </b><? echo $info_akk['balance']; ?>$</div><br />
<div align="center"><u>Вывод осуществляется только на Z-кошелек WebMoney<br /></u><br />Доступно для вывода <? printf("%6.2f ",$balance_in); ?> WMZ<br /><br />
    <form  name="output" id="output" method="POST" onSubmit="return Check_pay()">
	<span class="text">Z-кошелек :&nbsp;
	<input type="text" size="13" maxlength="13" name="purse" />
	<span class="text">&nbsp;Сумма<span class="text_log">(min 5$)</span> :&nbsp;</span>
	<input type="text" size="15" maxlength="32" name="summa" value="<? echo $info_akk['balance']; ?>" />&nbsp;
	<input type="hidden" name="ses_id" value="<? echo session_id(); ?>" readonly="readonly">
	<input type="submit" name="op_output" value="Перечислить" style="width:100px; "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';" id="cursor" <? if($info_akk['balance'] < 5) echo "disabled=\"disabled\""; ?> />&nbsp;
    </form>
</div>
<br />
<b>&nbsp;СТАТИСТИКА</b>
<hr color="#cococo"  size="1" /><br />
<div id="margin"><b>› Количество переходов с сайта : </b><? echo $info_akk['refer']; ?></div>
<div id="margin"><b>› Количество завершенных операций : </b><? echo $info_akk['count_oper']; ?></div>
<div id="margin"><b>› Сумма поступивших средств через программу : </b><? echo $info_akk['summ_oper']; ?>$</div><br />
<div id="margin"><b>› Накопленные средства : </b><? echo $info_akk['summa_bal']; ?>$</div>
<br />
<b>&nbsp;РЕКЛАМНЫЕ МАТЕРИАЛЫ</b>
<hr color="#cococo"  size="1" /><br />
<div id="margin"><b>› Ваша партнерская ссылка : </b><a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>">http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?></a></div>
<div id="margin"><b>› Файл курсов для мониторингов : </b>http://wm-rb.net/out_rates_all.aspx</div>
<br />
<div><b>&nbsp;НАШИ БАННЕРЫ: </b></div><br />
<div align="center">
    <a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=exchange"><img src="http://wm-rb.net/img/ban/10_10.gif" width="100" height="100" alt="Сервис электронных платежей" /></a>
    <br /><br />
    <textarea rows="3" cols="100">
        <a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=exchange"><img src="http://wm-rb.net/img/ban/10_10.gif" width="100" height="100" alt="Сервис электронных платежей" /></a>
    </textarea>
</div>
<hr />
<div align="center">
    <a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=exchange"><img src="http://wm-rb.net/img/ban/46_6.gif" width="468" height="60" alt="Сервис электронных платежей" /></a>
    <br /><br />
    <textarea rows="3" cols="100">
        <a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=exchange"><img src="http://wm-rb.net/img/ban/46_6.gif" width="468" height="60" alt="Сервис электронных платежей" /></a>
    </textarea>
</div>
<hr />
<div style="margin-top:10px;" align="center">
    <div align="center" style="float:right; margin-right:50px;">
        <a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=output_nal"><img src="http://wm-rb.net/img/ban/b_88_31.gif" width="88" height="31" alt="Ввод, вывод на банковские карты" /></a>
        <br /><br />
        <textarea rows="5" cols="50">
            <a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=output_nal"><img src="http://wm-rb.net/img/ban/b_88_31.gif" width="88" height="31" alt="Ввод, вывод на банковские карты" /></a>
        </textarea>
    </div>
    <div align="center">
        <a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=exchange"><img src="http://wm-rb.net/img/ban/b_88_31e.gif" width="88" height="31" alt="Обмен электронных валют" /></a>
        <br /><br />
        <textarea rows="5" cols="50">
            <a href="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=exchange"><img src="http://wm-rb.net/img/ban/b_88_31e.gif" width="88" height="31" alt="Обмен электронных валют" /></a>
        </textarea>
    </div>
</div>
<br /><br />
<div><b>ФОРМЫ ДЛЯ ОПЛАТЫ: </b></div><br />
<table align="center" cellpadding="5" cellspacing="4" border="0" width="175" style="background-color: #f3f7ff; BORDER-LEFT: #C0C0C0 1px solid; BORDER-RIGHT: #C0C0C0 1px solid; BORDER-TOP: #C0C0C0 1px solid;	BORDER-BOTTOM: #C0C0C0 1px solid;">
    <form action="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=output_nal" method=post target=_blank>
        <tr>
            <td style="background-color: #ffffff; BORDER-LEFT: #C0C0C0 1px solid; BORDER-RIGHT: #C0C0C0 1px solid; BORDER-TOP: #C0C0C0 1px solid;	BORDER-BOTTOM: #C0C0C0 1px solid;"><a href="http://wm-rb.net"><img src="http://wm-rb.net/img/top_logo.gif" width="175" height="40" alt="Автоматический обмен электронных валют" /></a></td>
        </tr>
        <tr bgcolor="#fcfcfc">
            <td align="left" style="FONT-SIZE: 12px; FONT-FAMILY: verdana; color: #333333; line-height: 130%;"><u>Отдаете:</u></td>
        </tr>
        <tr bgcolor="#f3f7ff">
            <td id="margin">
                <select name="ex_out"  id="ex_out" style="MARGIN: 0px; background-color: #ffffff; color: #333333; font: normal 11px Verdana, sans-serif; border:1px solid;	border-color : #99ccff;">
                    <option value="WMZ" selected="selected">WMZ</option>
                    <option value="WMR">WMR</option>
                    <option value="WME">WME</option>
                    <option value="WMG">WMG</option>
                    <option value="WMU">WMU</option>
                    <option value="WMY">WMY</option>
                    <option value="WMB">WMB</option>
                    <option value="RBK Money">RUR RBK Money</option>
                    <option value="EasyPay">EasyPay</option>
                    <option value="YaDengi">Yandex.Money</option>
                </select>
            </td>
        </tr>
        <tr bgcolor="#fcfcfc">
            <td style="FONT-SIZE: 12px; FONT-FAMILY: verdana; color: #333333; line-height: 130%;"><u>Получаете:</u></td>
        </tr>
        <tr bgcolor="#f3f7ff">
            <td id="margin">
                <select name="ex_in"  id="ex_in" style="MARGIN: 0px; background-color: #ffffff; color: #333333; font: normal 11px Verdana, sans-serif; border:1px solid;	border-color : #99ccff;">
                    <option value="WMZ">WMZ</option>
                    <option value="WMR">WMR</option>
                    <option value="WME">WME</option>
                    <option value="WMG">WMG</option>
                    <option value="WMU">WMU</option>
                    <option value="WMY">WMY</option>
                    <option value="WMB">WMB</option>
                    <option value="RBK Money">RUR RBK Money</option>
                    <option value="EasyPay" selected="selected">EasyPay</option>
                    <option value="YaDengi">Yandex.Money</option>
                </select>
            </td>
        </tr>
        <tr bgcolor="#fcfcfc">
            <td align="center">
                <input type="submit" name="partner" value="Обменять" style="width:100px; background-color: #ffffff; MARGIN: 0px;	color : #333333; font: normal 11px Verdana, sans-serif; border:1px solid; border-color : #99ccff;"onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#ffffff';" id="cursor"  />
            </td>
        </tr>
    </form>
</table>
Код формы:<br />
<div align="center">
    <textarea rows="10" cols="100">
        <table align="center" cellpadding="5" cellspacing="4" border="0" width="175" style="background-color: #f3f7ff; BORDER-LEFT: #C0C0C0 1px solid; BORDER-RIGHT: #C0C0C0 1px solid; BORDER-TOP: #C0C0C0 1px solid;	BORDER-BOTTOM: #C0C0C0 1px solid;">
            <form action="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=output_nal" method=post target=_blank>
                <tr>
                    <td style="background-color: #ffffff; BORDER-LEFT: #C0C0C0 1px solid; BORDER-RIGHT: #C0C0C0 1px solid; BORDER-TOP: #C0C0C0 1px solid;	BORDER-BOTTOM: #C0C0C0 1px solid;"><a href="http://wm-rb.net"><img src="http://wm-rb.net/img/top_logo.gif" width="175" height="40" alt="Автоматический обмен электронных валют" /></a></td>
                </tr>
                <tr bgcolor="#fcfcfc">
                    <td align="left" style="FONT-SIZE: 12px; FONT-FAMILY: verdana; color: #333333; line-height: 130%;"><u>Отдаете:</u></td>
                </tr>
                <tr bgcolor="#f3f7ff">
                    <td id="margin">
                        <select name="ex_out"  id="ex_out" style="MARGIN: 0px; background-color: #ffffff; color: #333333; font: normal 11px Verdana, sans-serif; border:1px solid;	border-color : #99ccff;">
                            <option value="WMZ" selected="selected">WMZ</option>
                            <option value="WMR">WMR</option>
                            <option value="WME">WME</option>
                            <option value="WMG">WMG</option>
                            <option value="WMU">WMU</option>
                            <option value="WMY">WMY</option>
                            <option value="WMB">WMB</option>
                            <option value="RBK Money">RUR RBK Money</option>
                            <option value="EasyPay">EasyPay</option>
                            <option value="YaDengi">Yandex.Money</option>
                        </select>
                    </td>
                </tr>
                <tr bgcolor="#fcfcfc">
                    <td style="FONT-SIZE: 12px; FONT-FAMILY: verdana; color: #333333; line-height: 130%;"><u>Получаете:</u></td>
                </tr>
                <tr bgcolor="#f3f7ff">
                    <td id="margin">
                        <select name="ex_in"  id="ex_in" style="MARGIN: 0px; background-color: #ffffff; color: #333333; font: normal 11px Verdana, sans-serif; border:1px solid;	border-color : #99ccff;">
                            <option value="WMZ">WMZ</option>
                            <option value="WMR">WMR</option>
                            <option value="WME">WME</option>
                            <option value="WMG">WMG</option>
                            <option value="WMU">WMU</option>
                            <option value="WMY">WMY</option>
                            <option value="WMB">WMB</option>
                            <option value="RBK Money">RUR RBK Money</option>
                            <option value="EasyPay" selected="selected">EasyPay</option>
                            <option value="YaDengi">Yandex.Money</option>
                        </select>
                    </td>
                </tr>
                <tr bgcolor="#fcfcfc">
                    <td align="center">
                        <input type="submit" name="partner" value="Обменять" style="width:100px; background-color: #ffffff; MARGIN: 0px;	color : #333333; font: normal 11px Verdana, sans-serif; border:1px solid; border-color : #99ccff;"onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#ffffff';" id="cursor"  />
                    </td>
                </tr>
            </form>
        </table>
    </textarea>
</div>
<br />
<br />
<table align="center" cellpadding="5" cellspacing="4" border="0" width="175" style="background-color: #f3f7ff; BORDER-LEFT: #C0C0C0 1px solid; BORDER-RIGHT: #C0C0C0 1px solid; BORDER-TOP: #C0C0C0 1px solid;	BORDER-BOTTOM: #C0C0C0 1px solid;">
    <form action="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=services_list" method=post target=_blank>
        <tr>
            <td style="background-color: #ffffff; BORDER-LEFT: #C0C0C0 1px solid; BORDER-RIGHT: #C0C0C0 1px solid; BORDER-TOP: #C0C0C0 1px solid;	BORDER-BOTTOM: #C0C0C0 1px solid;"><a href="http://wm-rb.net"><img src="http://wm-rb.net/img/top_logo.gif" width="175" height="40" alt="Пополнение баланса мобильных операторов, оплата коммунальных платежей интернет-провадеров" /></a></td>
        </tr>
        <tr bgcolor="#fcfcfc">
            <td align="left" style="FONT-SIZE: 12px; FONT-FAMILY: verdana; color: #333333; line-height: 130%;"><u>Выберите валюту:</u></td>
        </tr>
        <tr bgcolor="#f3f7ff">
            <td id="margin">
                <select name="ex_out"  id="ex_out" style="MARGIN: 0px; background-color: #ffffff; color: #333333; font: normal 11px Verdana, sans-serif; border:1px solid;	border-color : #99ccff;">
                    <option value="WMZ" selected="selected">WMZ</option>
                    <option value="WMR">WMR</option>
                    <option value="WME">WME</option>
                    <option value="WMG">WMG</option>
                    <option value="WMU">WMU</option>
                    <option value="WMY">WMY</option>
                    <option value="WMB">WMB</option>
                    <option value="RBK Money">RUR RBK Money</option>
                    <option value="EasyPay">EasyPay</option>
                    <option value="YaDengi">Yandex.Money</option>
                </select>
            </td>
        </tr>
        <tr bgcolor="#fcfcfc">
            <td style="FONT-SIZE: 12px; FONT-FAMILY: verdana; color: #333333; line-height: 130%;"><u>Оплата услуги:</u></td>
        </tr>
        <tr bgcolor="#f3f7ff">
            <td id="margin">
                <select name="usluga"  id="usluga" style="MARGIN: 0px; background-color: #ffffff; color: #333333; font: normal 11px Verdana, sans-serif; border:1px solid;	border-color : #99ccff;">
                    <option value="" selected="selected">››› Интернет</option>
                    <option value="ByFlyBel">ByFly Белтелеком</option>
                    <option value="AtlantTelecom">Атлант Телеком</option>
                    <option value="BelInfoNet">BelInfoNet</option>
                    <option value="DL">Деловая сеть</option>
                    <option value="Solo">Solo</option>
                    <option value="NetSys">NetworkSystems</option>
                    <option value="TcmBY">Tcm.BY</option>
                    <option value="AchinaPlus">Айчына Плюс</option>
                    <option value="ShaparkiDamavik">Шпаркi Дамавiк</option>
                    <option value="IPTEL">АйПи ТелКом</option>
                    <option value="">››› Услуги связи</option>
                    <option value="Velcom">Velcom</option>
                    <option value="MTS">MTS</option>
                    <option value="life">life:)</option>
                    <option value="Dialog">Dialog</option>
                    <option value="Beltelecom">Белтелеком</option>
                    <option value="">››› Прочие услуги</option>
                    <option value="UJH_Minsk">УЖХ Минск</option>
                    <option value="UJH_Mogilev">УЖХ Могилев</option>
                    <option value="UJH_Mozir">УЖХ Мозырь</option>
                    <option value="UJH_Molodechno">УЖХ Молодечно</option>
                    <option value="UJH_Bobrujsk">УЖХ Бобруйск</option>
                </select>
            </td>
        </tr>
        <tr bgcolor="#fcfcfc">
            <td align="center">
                <input type="submit" name="partner" value="Оплатить" style="width:100px; background-color: #ffffff; MARGIN: 0px;	color : #333333; font: normal 11px Verdana, sans-serif; border:1px solid; border-color : #99ccff;"onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#ffffff';" id="cursor"  />
            </td>
        </tr>
    </form>
</table>

Код формы:<br />
<div align="center">
    <textarea rows="10" cols="100">
        <table align="center" cellpadding="5" cellspacing="4" border="0" width="175" style="background-color: #f3f7ff; BORDER-LEFT: #C0C0C0 1px solid; BORDER-RIGHT: #C0C0C0 1px solid; BORDER-TOP: #C0C0C0 1px solid;	BORDER-BOTTOM: #C0C0C0 1px solid;">
            <form action="http://wm-rb.net/registration.aspx?partner_id=<? echo $info_akk['id']; ?>&dir=services_list" method=post target=_blank>
                <tr>
                    <td style="background-color: #ffffff; BORDER-LEFT: #C0C0C0 1px solid; BORDER-RIGHT: #C0C0C0 1px solid; BORDER-TOP: #C0C0C0 1px solid;	BORDER-BOTTOM: #C0C0C0 1px solid;"><a href="http://wm-rb.net"><img src="http://wm-rb.net/img/top_logo.gif" width="175" height="40" alt="Пополнение баланса мобильных операторов, оплата коммунальных платежей интернет-провадеров" /></a></td>
                </tr>
                <tr bgcolor="#fcfcfc">
                    <td align="left" style="FONT-SIZE: 12px; FONT-FAMILY: verdana; color: #333333; line-height: 130%;"><u>Выберите валюту:</u></td>
                </tr>
                <tr bgcolor="#f3f7ff">
                    <td id="margin">
                        <select name="ex_out"  id="ex_out" style="MARGIN: 0px; background-color: #ffffff; color: #333333; font: normal 11px Verdana, sans-serif; border:1px solid;	border-color : #99ccff;">
                            <option value="WMZ" selected="selected">WMZ</option>
                            <option value="WMR">WMR</option>
                            <option value="WME">WME</option>
                            <option value="WMG">WMG</option>
                            <option value="WMU">WMU</option>
                            <option value="WMY">WMY</option>
                            <option value="WMB">WMB</option>
                            <option value="RBK Money">RUR RBK Money</option>
                            <option value="EasyPay">EasyPay</option>
                            <option value="YaDengi">Yandex.Money</option>
                        </select>
                    </td>
                </tr>
                <tr bgcolor="#fcfcfc">
                    <td style="FONT-SIZE: 12px; FONT-FAMILY: verdana; color: #333333; line-height: 130%;"><u>Оплата услуги:</u></td>
                </tr>
                <tr bgcolor="#f3f7ff">
                    <td id="margin">
                        <select name="usluga"  id="usluga" style="MARGIN: 0px; background-color: #ffffff; color: #333333; font: normal 11px Verdana, sans-serif; border:1px solid;	border-color : #99ccff;">
                            <option value="" selected="selected">››› Интернет</option>
                            <option value="ByFlyBel">ByFly Белтелеком</option>
                            <option value="AtlantTelecom">Атлант Телеком</option>
                            <option value="BelInfoNet">BelInfoNet</option>
                            <option value="DL">Деловая сеть</option>
                            <option value="Solo">Solo</option>
                            <option value="NetSys">NetworkSystems</option>
                            <option value="TcmBY">Tcm.BY</option>
                            <option value="AchinaPlus">Айчына Плюс</option>
                            <option value="ShaparkiDamavik">Шпаркi Дамавiк</option>
                            <option value="IPTEL">АйПи ТелКом</option>
                            <option value="">››› Услуги связи</option>
                            <option value="Velcom">Velcom</option>
                            <option value="MTS">MTS</option>
                            <option value="life">life:)</option>
                            <option value="Dialog">Dialog</option>
                            <option value="Beltelecom">Белтелеком</option>
                            <option value="">››› Прочие услуги</option>
                            <option value="UJH_Minsk">УЖХ Минск</option>
                            <option value="UJH_Mogilev">УЖХ Могилев</option>
                            <option value="UJH_Mozir">УЖХ Мозырь</option>
                            <option value="UJH_Molodechno">УЖХ Молодечно</option>
                            <option value="UJH_Bobrujsk">УЖХ Бобруйск</option>
                        </select>
                    </td>
                </tr>
                <tr bgcolor="#fcfcfc">
                    <td align="center">
                        <input type="submit" name="partner" value="Оплатить" style="width:100px; background-color: #ffffff; MARGIN: 0px;	color : #333333; font: normal 11px Verdana, sans-serif; border:1px solid; border-color : #99ccff;"onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#ffffff';" id="cursor"  />
                    </td>
                </tr>
            </form>
        </table>
    </textarea>
</div>
</div>
<br /><br />
<div class="text" align="left"><b>ДОПОЛНИТЕЛЬНАЯ ИНФОРМАЦИЯ:</b></div>
<div id="margin">
    - дополнительную информацию Вы можете прочитать в разделе <a href="http://wm-rb.net/registration.aspx">регистрации</a> партнерской программы;<br />
    - для изменения Ваших персональных данных и другим вопросам обращайтесь в <a href="http://wm-rb.net/support.aspx">службу поддержки</a>;<br />
    - на рост партнерского вознаграждения влияет активность партнерской программы Вашего аккаунта;<br />
    - накрутка счетчика посещения наказывается удалением аккаунта, контроль ведется автоматически.<br />
</div>
    <?}
?>
<br />
</td>
</tr>

<?
include('include/bottom.aspx');
?>
</body>
</html>
