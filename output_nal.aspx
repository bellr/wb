<?
//require("include/header.aspx");
require("customsql.inc.aspx");

$db = new CustomSQL($DBName);
$db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net :: ����� WebMoney, Z-Payment �� �������� ������������.</Title>
<Meta name="description" Content="���������� ����� (��������) ������������ �� WebMoney, EasyPay, Z-Payment">
<Meta name="keywords" Content="����������, �����, ��������, �����, �����������, WebMoney, EasyPay, Z-Payment, WMZ, WMR, WME, WMU">
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
function Check_output_nal() {

if (document.output_nal.card.value == "none") {
alert('�������� ����� ��� ����������');
document.output_nal.card.focus();
return false;
}
if (document.output_nal.oplata.value == "none") {
alert('�������� ������ ������');
document.output_nal.oplata.focus();
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
	<td width="700" class="div_include">
	<div class="top_title" align="right">
����� WebMoney, EasyPay, Z-Payment � �������� �� �������� (�����) ������������</div>
<div id="margin">
&nbsp;&nbsp;&nbsp;&nbsp;��� ������ ������������� ����� WebMoney WMZ, WMR, WME, WMU, EasyPay, Z-Payment �� �������� (�����) ������������. ��� ���������� ������ �������� ������ ����������� ������ � ����� ������������� ����.
</div><br />
<div id="report">
	<center><b>����� ���������!</b><br /></center>
&nbsp;&nbsp;&nbsp;&nbsp;� ����� � ���������� ������ ��� �������� ������� � ������ ������ ������ ����� ������� ���������. ����� �� ���������� ����� ����� �������������� ������ �� ����������� ����� �������� ����������. ��� �������� ����� ����� �������� ��������������� �����������.<br /><br />
<b>��� �������� ����� � ������� ���������� ����������:</b><br />
- ����� �������� �� ���� �����������;<br />
- <a href="https://passport.webmoney.ru/asp/aUserBankCards.asp" target="_blank">������� ��������� ���������� �����</a> (����� �����, ��� ����� � �������� �����);<br />
- <a href="https://passport.webmoney.ru/asp/Upload.asp?ref=CARD" target="_blank">��������� ������� ����</a> ��� ���������� ������� ������� ����� ���������� �����, � ����� <a href="https://passport.webmoney.ru/asp/Upload.asp?ref=CARD" target="_blank">���������</a> ������� ��������������� ����� ���� �������� ������� ������ �������� (���� ��� �� ���� ������� �����);<br />
- ��������� ��������� ��������, �������, ��� �������, �������� 1-2 ������� ���.<br />
����� �������� �������� ������� �������� ����������� �� ����������� � ���������� WM-�����.

</div>

<br />
<div id="padding" align="center">
 <form method="post" action="http://wm-rb.net/out_demand.aspx" name="output_nal" id="output_nal"  onSubmit="return Check_output_nal()">
 <div id="padding" class="black">
 �������� ����� ��� ����������<br /><br />
							<select name="card"  id="card" >
<? $card = $db_pay_desk->output_nal_card();
	foreach($card as $arr) {

			echo "<option value=\"{$arr['0']}\">{$arr['1']}</option>";
	}
?>
		</select>
			</div>
<div id="padding" class="black">
�������� ������ ��� ������<br /><br />
						<select name="oplata"  id="oplata" >
<? $currency = $db_exchange->konst_currency('st_out_nal');
	foreach($currency as $arr) {

			echo "<option value=\"{$arr['0']}\">{$arr['2']}</option>";
	}
?>
		</select>

		</div>
		<input type="hidden" name="type_usluga" value="output_NAL" readonly="readonly">
		<input type="hidden" name="usluga" value="NAL_output" readonly="readonly">
<input type="submit" name="oplata_nal_out" value="���������" style="width:100px;
		    "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';"
		    id="cursor"/>

 </form>
</div>
<br /><br />

</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
