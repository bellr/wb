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
<Title>WM-RB.net - ������ ����������� �������� :: ��������� WMZ, WMB, WMR, WMG, WME, WMU, WMY, EasyPay, Yandex Money �� �������� ��� ������ �� EasyPay</Title>
<Meta name="description" Content="������������������ �������� ����������� ����� WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, Yandex Money, ������������ ������� � ������">
<Meta name="keywords" Content="�����, wm, WMZ, WMB, WMR, WMG, WME, WMU, WMY, Yandex Money, �����, ������,��������, ������, ����������, ����������� ���������, �����, �����, ���������, ������, EasyPay">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
<META content="index,follow,all" name="robots">
<META name="author" content="AtomLy">
<META NAME="COPYRIGHT" CONTENT="Copyright (c) by Wm-Rb.net">
<link rel="stylesheet" href="http://wm-rb.net/style.css" type="text/css">
<link REL="shortcut icon" HREF="http://wm-rb.net/img/favicon.ico" TYPE="image/x-icon">
</head>

<body>
<?
include('include/top.aspx');
?>


	<tr>
	<td width="700" align="center" class="div_include">
<div class="top_title" align="right">������� �������� ��� ���������� ����� ���������</div>
<DL id="margin" title="������� �������� ��� ���������� ����� ���������">
 <DD>������������� ������� ���������� <b>������� ������� ������</b>, � ����� ��� �� ����������, ��� ����� �������� ������� ��������. ������ ������������� � ������� 24 �����.</dd>
<br />
<dd class="black">� �������� ����������</dd><br />
 <DD>��������� ��� ���� � EasyPay <b><? echo $purse[0]['purse']; ?> </b>(������ ���������� EasyPay ������� <a href="http://easypay.by/page4.htm#1">�� �������� ����� EasyPay.by</a>).</dd>
 <br />
<dd class="black">� ������� ����������� ����</dd>
 <br />
<dd>����������� ��������� ����� �� ���� ���������� ��������, ��������� �� �������� ����� �������� ������.</dd><br />
 <DD>�� ������ �������� �� �������� <a href="user_check_cash.aspx">�������� ������</a>.</dd>
 <dd>��� ������ ����� ��������� � ��������� �����.</dd>
 <dd>������ ������� �� ������ ������ �� EasyPay � �� ����������� �������� ����� ��� ������: WMZ, WMB, WMR, WMG, WME, WMU, WMY, Z-PAYMENT, Yandex Money.</dd>
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
<option value="bpsb">���-����</option>
<option value="belbank">�����������</option>
<option value="pochta">�������� ���������</option>
<option value="VISA">����� Visa/MasterCard</option>
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
</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
