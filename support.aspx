<?
session_start();
require("include/header.aspx");
require("customsql.inc.aspx");

$db = new CustomSQL($DBName);
$db_admin = new CustomSQL_admin($DBName_admin);

	$mess = false;
	$showtable = true;
if (!empty($_POST['send_mess'])){
if (session_id() == $_POST['session_id'])
{
//�������� ������
cheak_ref($_SERVER['HTTP_REFERER']);

	$errortag = false;

	$email = trim(stripslashes(htmlspecialchars(substr($_POST['email'],0,52))));
	$mess =  trim(stripslashes(htmlspecialchars(substr($_POST['mess'],0,750))));

	if(!preg_match("/^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$/", $email))
	{
	$errortag = true;
	}
	if (empty($mess))
	{
	$errortag = true;
	}
	if (!$errortag){
	$db_admin->support_mess($_SERVER['REMOTE_ADDR'],$email,$mess,$date_pay,$time_pay);
	$mess = true;
	}
}
else {$showtable = false;}
}


?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - ������ ����������� �������� :: ������ ���������</Title>
<Meta name="description" Content="������������������ �������� ����������� ����� WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, ������������ ������� � ������">
<Meta name="keywords" Content="�����, wm, ����� ������,��������, ������, ����������, ����������� ���������, �����, �����">
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

if (!document.check_support.email.value.match('^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-Mail ������ �� �����');
document.check_support.email.focus();
return false;
}
if (document.check_support.mess.value <= 0) {
alert('�� �� ����� ����� ���������');
document.check_support.mess.focus();
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
������ ���������
</div>
<div align="center">
<?
if ($showtable) {
if ($mess)
{
echo "<br /><br /><div class=\"red\" align=\"center\">���� ��������� ������� ���������� � ������ ���������<br>����� ����� � ������� 24 �����</div><br><br>";
}
?>
</div>
	<form  name="check_support" id="check_support" action="support.aspx" method="post" onSubmit="return Check()">
	<table width="100%" align="center">
	<tr>
		<td width="20%" align="right"><div class="text">E-mail : </div></td>
		<td width="80%" id="padding"><input type="text" name="email" id="email" maxlength="52" style="width:190;" /></td>
	</tr>
	<tr>
		<td><div class="text" align="right">���� ��������� : </div></td>
		<td id="padding"><textarea cols="50" rows="12"  maxlength="250" name="mess"></textarea>
		<div class="text_log">������������ ���������� �������� : 250</div></td>
	</tr>
	<tr>
	<td></td>
	<td id="padding">
	<input type="hidden" name="session_id" value="<? echo session_id(); ?>" readonly="readonly">
	<input type="submit" name="send_mess" value="���������"  style="width:130px; "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';" id="cursor">

	</td>
	</tr>
	</table>
		</form>
<br><br><div class="red">* ��� ���� ����������� ��� ����������</div><br>
<?
	}
	else {
echo "<br /><br /><div class=\"red\" align=\"center\">���� ������ ��������!!!</div><br /><br />
��������� ����� � ���������� ��� ���.<br /><br /><br />
<CENTER><FORM><INPUT TYPE=\"BUTTON\" VALUE=\" ����� \" ONCLICK=\"history.back(-1)\" style=\"width:130px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\"></FORM>
";
	}
	?>
</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
