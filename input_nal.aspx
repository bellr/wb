<?
require("include/header.aspx");
require("customsql.inc.aspx");

$db = new CustomSQL($DBName);
$db_exchange = new CustomSQL_exchange($DBName_exchange);
$purse = $db_exchange->sel_purse('EasyPay');
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net :: ��������� WebMoney, Z-PAYMENT, Moneybookers �� ��������.</Title>
<Meta name="description" Content="��������� ��� ������ WebMoney (WMZ, WMR, WME, WMU), Z-PAYMENT, Moneybookers �� �������� ����� �������� ��������� � ����� ���������������.">
<Meta name="keywords" Content="�������������� ����������, WebMoney, WMZ, WMR, WME, WMU, Z-PAYMENT, Moneybookers, ��������, �������� ���������, �����, ��������������, ������,">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by WM-RB.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
</head>

<body>
<?
include('include/top.aspx');
?>


	<tr>
	<td width="700" align="center" class="div_include">
<div class="top_title" align="right">�������������� ���������� ����� WebMoney (WMZ, WMR, WME, WMU), Moneybookers, Z-Payment ���������</div>
<DL id="margin" title="�������������� ���������� ����� ���������">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;������ ����������� �������� ���������� ���������� ����������� ������������� ��������� ���� ��� ����������� ������� WebMoney (WMZ, WMR, WME, WMU), Moneybookers, Z-Payment ��������� ����� �������� ��������� � ����� ���������������.<br /><br />
<b>������� �� ��������������� ���������� :</b><br /><br />
 <DD>- � �����, ������� ����������� ���� ��������� ������ ���������� � ������ ����������;</dd>
 <DD>- ����� ������� ����� ���������� ���� ��������� ��� �����;</dd>
<dd>- ������ ������������ ����� ���������� � ������ ��� ������������ ������ � ������ ���� ��� ������;</dd>
<dd>- ��������� ��� ���� � ������� EasyPay ����� �������� ����� � ��������� ��������������� ��� � ����� �������� ��������� ��������;</dd>
<dd>- ����� ���������� ������ ����� �� ���� <a href="http://wm-rb.net/user_check_cash.aspx" target="_blank">��������</a> ����� ����������� ������, ����� ������ "��������� ��������� �� ������" � ������ ����� ������;</dd>
<br />
��������� ������ ������������� ������ ����� ������������� �� <a href="http://wm-rb.net/user_check_cash.aspx" target="_blank">��������</a>, ���������� �������� ������� ����������� � ������� 2-4 ����� � ������� ������������� ������.<br />
<br />
<b>���������� ������ �������� ���������, ��� ����� ���������� ���������� ����� ���������� �� ���� <a href="https://ssl.easypay.by/input/post_office/" target="_blank">��������</a></b>.
<br /><br />
 </DL>
 <br />
 <div class="black">�������� ������ ��� ����������</div>
 <br />

 <form method="post" action="http://wm-rb.net/services_demand.aspx" name="form_uslugi" id="form_uslugi"  onSubmit="return Check()">
			<select name="oplata"  id="oplata" >
			<? $currency = $db_exchange->konst_currency('st_cash');
	foreach($currency as $arr) {

			echo "<option value=\"{$arr['0']}\">{$arr['2']}</option>";
	}
?>
		</select>
		<br /><br />
<div id="padding" class="black">�������� ������ ����������<br /><br />
							<select name="card"  id="card" >
<option value="pochta">���������</option>
		</select>
			</div>
		<br />
		<br />
		<input type="hidden" name="type_usluga" value="NAL" readonly="readonly">
		<input type="hidden" name="usluga" value="NAL_input" readonly="readonly">
<input type="submit" name="oplata_nal" value="���������" style="width:100px;
		    "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';"
		    id="cursor"/>

 </form>
 <br /><br />
 <center><b>��� ������ ����� ������������ ���������� ������ ����������� ����� ����������� �������� <font color="#FF0000">�� ����� "��� �����������"</font>.</b><br />
 <b>�� ��������� ����������� ���������� �� ���������, ������� ������� �� <a href="http://wm-rb.net/contact.aspx">��������</a>.</b></center>
</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
