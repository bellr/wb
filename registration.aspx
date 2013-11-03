<?

header("Location: http://wm-rb.net/registration/?".$_SERVER['QUERY_STRING']);
exit;
require("include/header.aspx");
require("customsql.inc.aspx");
require($home_dir."mailer/smtp-func.aspx");
$db = new CustomSQL($DBName);
$errortag = false;

if(!empty($_GET['partner_id'])) {

	$sel_refer_ip = $db->sel_refer_ip($_GET['partner_id'],ip2long($_SERVER['REMOTE_ADDR']),ip2long($_SERVER['HTTP_X_FORWARDED_FOR']));

	if(empty($sel_refer_ip)) {
		$db->add_ip($_GET['partner_id'],ip2long($_SERVER['REMOTE_ADDR']),ip2long($_SERVER['HTTP_X_FORWARDED_FOR']));
		//setcookie("unique", $_GET['partner_id'], time() +90000, "/", "wm-rb.net");
		setcookie("partner_id", $_GET['partner_id'], time() +1209600, "/", "wm-rb.net");

	//$host = explode('/',$_SERVER['HTTP_REFERER']);
	//$sel_refer = $db->sel_refer($_GET['partner_id']);
	//if(!empty($sel_refer[0]["host"])) {

		$db->summ_refer($_GET['partner_id']);
	//}
	}
	//echo $_SERVER['SERVER_ADDR'];
	switch ($_GET['dir']) :
		case ("exchange") : header("location: http://wm-rb.net/".$_GET['dir'].".aspx"); exit(); break;
		case ("output_nal") : header("location: http://wm-rb.net/".$_GET['dir'].".aspx"); exit(); break;
		case ("services_list") : header("location: http://service.wm-rb.net/index.aspx"); exit(); break;
endswitch;
}

if(!empty($_POST['mess_pass'])) {
cheak_ref($_SERVER['HTTP_REFERER']);
	if(!preg_match("/^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$/", $_POST['email'])) {
	header("location: http://wm-rb.net");
	exit;
	}
	$dubl_email = $db->dubl_email($_POST['email']);
	if(!empty($dubl_email)) {
	$pass = substr(wm_ReqID(),4,10);
	$up_pass = $db->update_pass($_POST['email'],md5($pass));

		if(!empty($up_pass)) {
	$from_name = "Robot платежного сервиса WM-RB.net";
	$subject = "Восстановление пароля";
	$body = "
<center>Здравствуйте</center><br />
Вы сделали запрос на восстановление пароля.<br />
Ваш новый пароль : {$pass}
<br />
Мы будем благодарны Вам за любые предложения, высказанные по поводу того,
какой Вы хотите видеть сервис платежей WM-RB.net.<br /><br />

Благодарим Вас за использование нашего сервиса.<br />
Это письмо отправлено роботом, ответа не требует.<br />
<br />--<br />
С уважением,<br />
Администрация WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>Сервис платежей WebMoney в Республике Беларусь</a><br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq";
smtpmail($_POST['email'],$subject,$body,$from_name);
		}
	}
}

if(!empty($_POST['addpartner'])) {
cheak_ref($_SERVER['HTTP_REFERER']);
	$email = trim(stripslashes(htmlspecialchars($_POST['email'])));
	$pass = trim(stripslashes(htmlspecialchars($_POST['pass'])));
	$username = trim(stripslashes(htmlspecialchars($_POST['username'])));
	$host = trim(stripslashes(htmlspecialchars($_POST['host'])));

	$dubl_email = $db->dubl_email($email);
	$dubl_host = $db->dubl_host($host);
	if(!empty($dubl_email)) {
		$errortag = true;
		$errormsg = "Пользователь с таким почтовым адресом уже существует";
	}
	if(!empty($dubl_host)) {
		$errortag = true;
		$errormsg = "Такой сайт уже зарегистрирован в системе";
	}
	if(!preg_match("/^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$/", $email) &&
		!preg_match("/^[a-zA-Z0-9\.\-]+\.[a-zA-Z]+$/", $host) && empty($username) && empty($pass)) {
		header("location: http://wm-rb.net");
		exit;
	}
	if(!$errortag) {
		$info_n = $db->add_partner($email,md5($pass),$username,$host,$date_pay);
	$from_name = "Robot платежного сервиса WM-RB.net";
	$subject = "Регистрация партнерской программы";
	$body = "
<center>Здравствуйте, {$username}</center><br />
Регистрация в партнерской программе прошла успешно.<br /><br />
Ваши регистрационные данные.<br />
логин для входа : {$email}<br />
Ваш пароль : {$pass}<br />
регистрируемый сайт : {$host}<br />
<br />
Мы будем благодарны Вам за любые предложения, высказанные по поводу того,
какой Вы хотите видеть сервис платежей WM-RB.net.<br /><br />

Благодарим Вас за использование нашего сервиса.<br />
Это письмо отправлено роботом, ответа не требует.<br />
<br />--<br />
С уважением,<br />
Администрация WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>Сервис платежей WebMoney в Республике Беларусь</a><br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq";
smtpmail($email,$subject,$body,$from_name);
	}
}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - Сервис электронных платежей :: Партнерская программа</Title>
<Meta name="description" Content="Автоматизированный, обменник, обмен, электронных валют WebMoney (WMZ, WMR, WME, WMU, WMY, WMB, WMG), EasyPay, RBK Money, Yandex Money, коммунальные, платежи, услуги, пополнение, снятие, наличными, электронной, валюты, кредитование, инвестирование, пополнение балансов мобильных телефонов">
<Meta name="keywords" Content="форум, wm, обмен валюты,обменный, оплата, пополнение EasyPay, партнерская программа, пункт, услу, дополнительный доход, оплата за клики, оплата за переходы, автоматические выплаты, вознаграждения">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META name="author" content="AtomLy">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
<script language='JavaScript'>
<!--
function Check() {

if (!document.register.email.value.match('^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-Mail указан не верно');
document.register.email.focus();
return false;
}
if (document.register.pass.value.length == 0) {
alert('Вы не ввели пароль');
document.register.pass.focus();
return false;
}
if (document.register.pass.value.length < 3) {
alert('Минимальная длина пароля: 3');
document.register.pass.focus();
return false;
}
if (document.register.repass.value.length == 0) {
alert('Введите повторный пароль');
document.register.repass.focus();
return false;
}
if (document.register.repass.value.length < 3) {
alert('Минимальная длина пароля: 3');
document.register.repass.focus();
return false;
}
if (document.register.pass.value != document.register.repass.value) {
alert('Введенные пароли не совпадают');
document.register.pass.focus();
return false;
}
if (document.register.repass.value.length == 0) {
alert('Введите повторный пароль');
document.register.repass.focus();
return false;
}
if (!document.register.host.value.match('^[www]\.+[a-zA-Z0-9\.\-]+\.[a-zA-Z]+$')) {
alert('Вы не корректно ввели адрес сайта');
document.register.host.focus();
return false;
}
if (document.register.username.value.length == 0) {
alert('Введите свое имя');
document.register.username.focus();
return false;
}
if (document.register.host.value.length == 0) {
alert('Введите адрес своего сайта');
document.register.host.focus();
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
	<td width="700" align="center" class="div_include"><br />
<div class="top_title" align="right">
Партнерская программа
</div>
<?
if(!empty($up_pass)) echo "<div class=div_operok>НА ВАШ ПОЧТОВЫЙ ЯЩИК БЫЛО ОТПРАВЛЕНО ПИСЬМО С НОВЫМ КОДОМ</div>";

		if(!empty($info_n)) {
       echo "<div class=\"div_operok\">";
	   echo "Данные успешно отправлены<br />";
	echo "</div><br /><br />";
		}
?>

<div class="black">
Правила и условия партнерской программы
</div><br />
<div class="text" align="left">
	<span align="center" id="margin">Если Вы владелец сайта и Вам нужен дополнительный доход, то Вы пришли по адресу. </span><br />
От вас требуется только <a href="http://wm-rb.net/registration.aspx">зарегистрироваться</a> в партнерской программе, выбрать подходящий для Вашего сайта баннер, форму оплаты или разместить партнерскую ссылку со своим интерфейсом. За переход каждого уникального пользователя с Вашего сайта на сервис WM-RB.net Вам будет перечислено 0.01$, а при совершении операции 0.3% от поступившей суммы. Каждый пользователь перешедший по Вашей ссылке, будет запоминаться нашим сервисом, если он при первом своем посещении не совершит никаких платежей, Вы будете получать прибыль при следующих его посещениях, даже если он придет самостоятельно.<br /><br />
<span id="margin">Преимущества Нашей партнерской программы:</span>
<blockquote>
 - оплата за клики (переходы);<br />
 - сохранение cookies пришедшего по Вашей ссылке пользователя;<br />
 - автоматические выплаты вознаграждения;
</blockquote>

</div>
<div class="black" align="left">
			Запрещенные методы размещения партнерских материалов :</div>
<div class="text" align="left">
<blockquote>
- размещение ссылок на доменах ниже второго уровня;<br />
- размещение ссылок на сайтах автосерфинга, почтовых рассылок и других подобных сайтах;<br />
- размещать ссылки в всплывающих окнах;<br />
- использовать код, изменяющий видимость партнерской ссылки или баннера;<br />
- использовать код, автоматически открывающий и/или перезагружающий страницы сервиса «WM-RB.net» без взаимодействия с пользователем;<br />
 - размещать код ссылки на страницах, не несущих полезной информации (фреймы, дорвеи и т.п.).
</blockquote>
			</div>
<br />
<div class="black">
			Заполните данную форму для регистрации в партнерской программе
	</div><br /><br />
<?
	if ($errortag){
       echo "<div class=\"red\">Произошла ошибка! </div>
	<div class=\"black\">";
	echo $errormsg;
	echo "</div><br /><br />";
        }
?>
<form  name="register" id="register" action="http://wm-rb.net/registration.aspx" method="post" onSubmit="return Check()">
<table width="400"  border="0" cellspacing="1" cellpadding="10" bgColor="#ebebeb">
	<tr align="center" bgColor="#ffffff">
		<td class="text">Ваш E-mail :</td>
		<td id="padding"><input type="text" name="email" id="email" maxlength="52" style="width:140;" title="Ваше учетное имя в системе"></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
		<td class="text">Пароль :</td>
		<td id="padding"><input type="password" name="pass" id="pass" maxlength="52" style="width:140;"></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
		<td class="text">Повторите пароль :</td>
		<td id="padding"><input type="password" name="repass" id="repass" maxlength="52" style="width:140;"></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
		<td class="text">Ваше имя :</td>
		<td id="padding"><input type="text" name="username" id="username" maxlength="52" style="width:140;" title="Имя должно быть реальным. Пример : Виталий"></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
		<td class="text">Ваш сайт :</td>
		<td id="padding" height="50"><input type="text" name="host" id="host" maxlength="52" style="width:140;"><br />
		<span class="text_log">Пример: WWW.ваш_домен.ru</span></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
	<td colspan="2"><input type="submit" name="addpartner" value="Зарегистрироваться" style="width:160px;
		    "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';"
		    id="cursor"></td>
	</tr>
	<input type="hidden" name="ses_id" value="<? echo session_id(); ?>" readonly="readonly">
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

