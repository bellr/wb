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
	$from_name = "Robot ���������� ������� WM-RB.net";
	$subject = "�������������� ������";
	$body = "
<center>������������</center><br />
�� ������� ������ �� �������������� ������.<br />
��� ����� ������ : {$pass}
<br />
�� ����� ���������� ��� �� ����� �����������, ����������� �� ������ ����,
����� �� ������ ������ ������ �������� WM-RB.net.<br /><br />

���������� ��� �� ������������� ������ �������.<br />
��� ������ ���������� �������, ������ �� �������.<br />
<br />--<br />
� ���������,<br />
������������� WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>������ �������� WebMoney � ���������� ��������</a><br />
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
		$errormsg = "������������ � ����� �������� ������� ��� ����������";
	}
	if(!empty($dubl_host)) {
		$errortag = true;
		$errormsg = "����� ���� ��� ��������������� � �������";
	}
	if(!preg_match("/^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$/", $email) &&
		!preg_match("/^[a-zA-Z0-9\.\-]+\.[a-zA-Z]+$/", $host) && empty($username) && empty($pass)) {
		header("location: http://wm-rb.net");
		exit;
	}
	if(!$errortag) {
		$info_n = $db->add_partner($email,md5($pass),$username,$host,$date_pay);
	$from_name = "Robot ���������� ������� WM-RB.net";
	$subject = "����������� ����������� ���������";
	$body = "
<center>������������, {$username}</center><br />
����������� � ����������� ��������� ������ �������.<br /><br />
���� ��������������� ������.<br />
����� ��� ����� : {$email}<br />
��� ������ : {$pass}<br />
�������������� ���� : {$host}<br />
<br />
�� ����� ���������� ��� �� ����� �����������, ����������� �� ������ ����,
����� �� ������ ������ ������ �������� WM-RB.net.<br /><br />

���������� ��� �� ������������� ������ �������.<br />
��� ������ ���������� �������, ������ �� �������.<br />
<br />--<br />
� ���������,<br />
������������� WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>������ �������� WebMoney � ���������� ��������</a><br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq";
smtpmail($email,$subject,$body,$from_name);
	}
}

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - ������ ����������� �������� :: ����������� ���������</Title>
<Meta name="description" Content="������������������, ��������, �����, ����������� ����� WebMoney (WMZ, WMR, WME, WMU, WMY, WMB, WMG), EasyPay, RBK Money, Yandex Money, ������������, �������, ������, ����������, ������, ���������, �����������, ������, ������������, ��������������, ���������� �������� ��������� ���������">
<Meta name="keywords" Content="�����, wm, ����� ������,��������, ������, ���������� EasyPay, ����������� ���������, �����, ����, �������������� �����, ������ �� �����, ������ �� ��������, �������������� �������, ��������������">
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
alert('E-Mail ������ �� �����');
document.register.email.focus();
return false;
}
if (document.register.pass.value.length == 0) {
alert('�� �� ����� ������');
document.register.pass.focus();
return false;
}
if (document.register.pass.value.length < 3) {
alert('����������� ����� ������: 3');
document.register.pass.focus();
return false;
}
if (document.register.repass.value.length == 0) {
alert('������� ��������� ������');
document.register.repass.focus();
return false;
}
if (document.register.repass.value.length < 3) {
alert('����������� ����� ������: 3');
document.register.repass.focus();
return false;
}
if (document.register.pass.value != document.register.repass.value) {
alert('��������� ������ �� ���������');
document.register.pass.focus();
return false;
}
if (document.register.repass.value.length == 0) {
alert('������� ��������� ������');
document.register.repass.focus();
return false;
}
if (!document.register.host.value.match('^[www]\.+[a-zA-Z0-9\.\-]+\.[a-zA-Z]+$')) {
alert('�� �� ��������� ����� ����� �����');
document.register.host.focus();
return false;
}
if (document.register.username.value.length == 0) {
alert('������� ���� ���');
document.register.username.focus();
return false;
}
if (document.register.host.value.length == 0) {
alert('������� ����� ������ �����');
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
����������� ���������
</div>
<?
if(!empty($up_pass)) echo "<div class=div_operok>�� ��� �������� ���� ���� ���������� ������ � ����� �����</div>";

		if(!empty($info_n)) {
       echo "<div class=\"div_operok\">";
	   echo "������ ������� ����������<br />";
	echo "</div><br /><br />";
		}
?>

<div class="black">
������� � ������� ����������� ���������
</div><br />
<div class="text" align="left">
	<span align="center" id="margin">���� �� �������� ����� � ��� ����� �������������� �����, �� �� ������ �� ������. </span><br />
�� ��� ��������� ������ <a href="http://wm-rb.net/registration.aspx">������������������</a> � ����������� ���������, ������� ���������� ��� ������ ����� ������, ����� ������ ��� ���������� ����������� ������ �� ����� �����������. �� ������� ������� ����������� ������������ � ������ ����� �� ������ WM-RB.net ��� ����� ����������� 0.01$, � ��� ���������� �������� 0.3% �� ����������� �����. ������ ������������ ���������� �� ����� ������, ����� ������������ ����� ��������, ���� �� ��� ������ ����� ��������� �� �������� ������� ��������, �� ������ �������� ������� ��� ��������� ��� ����������, ���� ���� �� ������ ��������������.<br /><br />
<span id="margin">������������ ����� ����������� ���������:</span>
<blockquote>
 - ������ �� ����� (��������);<br />
 - ���������� cookies ���������� �� ����� ������ ������������;<br />
 - �������������� ������� ��������������;
</blockquote>

</div>
<div class="black" align="left">
			����������� ������ ���������� ����������� ���������� :</div>
<div class="text" align="left">
<blockquote>
- ���������� ������ �� ������� ���� ������� ������;<br />
- ���������� ������ �� ������ ������������, �������� �������� � ������ �������� ������;<br />
- ��������� ������ � ����������� �����;<br />
- ������������ ���, ���������� ��������� ����������� ������ ��� �������;<br />
- ������������ ���, ������������� ����������� �/��� ��������������� �������� ������� �WM-RB.net� ��� �������������� � �������������;<br />
 - ��������� ��� ������ �� ���������, �� ������� �������� ���������� (������, ������ � �.�.).
</blockquote>
			</div>
<br />
<div class="black">
			��������� ������ ����� ��� ����������� � ����������� ���������
	</div><br /><br />
<?
	if ($errortag){
       echo "<div class=\"red\">��������� ������! </div>
	<div class=\"black\">";
	echo $errormsg;
	echo "</div><br /><br />";
        }
?>
<form  name="register" id="register" action="http://wm-rb.net/registration.aspx" method="post" onSubmit="return Check()">
<table width="400"  border="0" cellspacing="1" cellpadding="10" bgColor="#ebebeb">
	<tr align="center" bgColor="#ffffff">
		<td class="text">��� E-mail :</td>
		<td id="padding"><input type="text" name="email" id="email" maxlength="52" style="width:140;" title="���� ������� ��� � �������"></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
		<td class="text">������ :</td>
		<td id="padding"><input type="password" name="pass" id="pass" maxlength="52" style="width:140;"></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
		<td class="text">��������� ������ :</td>
		<td id="padding"><input type="password" name="repass" id="repass" maxlength="52" style="width:140;"></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
		<td class="text">���� ��� :</td>
		<td id="padding"><input type="text" name="username" id="username" maxlength="52" style="width:140;" title="��� ������ ���� ��������. ������ : �������"></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
		<td class="text">��� ���� :</td>
		<td id="padding" height="50"><input type="text" name="host" id="host" maxlength="52" style="width:140;"><br />
		<span class="text_log">������: WWW.���_�����.ru</span></td>
	</tr>
	<tr align="center" bgColor="#ffffff">
	<td colspan="2"><input type="submit" name="addpartner" value="������������������" style="width:160px;
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

