<?
//require($_SERVER['DOCUMENT_ROOT']."/online/online.php");
//require("../online/online.php");
$news_count = $db->count('content_reklama');
$random_news = rand (0, $news_count[0][stotal] - 1);
$ban_f = rand (0, 2);
$flash = array('600x90_bonus_ru','600x90_card_ru','600x90_pamm_ru');
$content_reklama = $db->content_reklama($random_news);
//$news = $db->news("1","1");
//$db_forum = new CustomSQL_forum($DBName_forum);
//$theam_1 = $db_forum->theam_1('2','3','4','5','6');
//$theam_7 = $db_forum->theam_7('8','9','10','11','12','13');
//$theam_14 = $db_forum->theam_14('15','16','17');
//$theam_18 = $db_forum->theam_18('19','20','21');
?>
<div class="substrate" id="substrate"></div>
<div id="notifyblock"><div id="notify"></div></div>
<div id="loadingblock"><div class="loadingDoc" id="sl"><img src="<?=Config::$base['STATIC_URL']?>/img/loader.gif" width="16" height="16" alt="" /><span class="textLoadDoc">���������, ���� �������� ������</span></div></div>

<DIV id=login
style="BORDER: white 0px solid; DISPLAY: none; LEFT: 10px; WIDTH: 160px; POSITION: absolute; TOP: 440px"
 align=center>
<FORM name="enter_pertner" id="enter_pertner"  action="http://wm-rb.net/partner/index.aspx" method="post" onSubmit="return Check_form()">
<TABLE
style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BACKGROUND: white; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid"
cellSpacing=0 cellPadding=10 width=160 align=center border=0>
  <TBODY>
  <TR>
    <TD vAlign=top colSpan=2>
      <TABLE cellSpacing=0 cellPadding=2 width="100%" border=0>
        <TBODY>
        <TR>
          <TD onselectstart="return false;" id="" colSpan=2><IMG title=�������
            style="LEFT: 132px; CURSOR: pointer; POSITION: absolute; TOP: 10px"
            onclick=hidelogin(); height=14 alt="" src="img/close.gif" width=16 border=0>
            <span class="black">���� � �������</span></TD>
        <TR>

          <TD><INPUT name=email size="15" maxlength="52" onclick="javascript:if(this.value=='��� E-mail')this.value='';" value="��� E-mail"></TD>
        <TR>

          <TD><input type="hidden" name="ses_id" value="<? echo session_id(); ?>" readonly="readonly">
		  <INPUT type=password name=passw size="15" maxlength="32" onclick="javascript:if(this.value=='������')this.value='';" value="������"></TD>
        <TR>
          <TD align="center"><INPUT class="button px70" name=login_index id=submitbox type=submit value=����� style="width:70px; "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';" id="cursor"></TD>
</TBODY></TABLE></TR></TBODY></TABLE></FORM></DIV>
<SCRIPT type="text/javascript">
<!--
function showlogin(){
    document.getElementById('login').style.display = 'block';
    return false;
}
function hidelogin(){
    document.getElementById('login').style.display = 'none';

    return false;
}

function Check_form() {
if (!document.enter_pertner.email.value.match('^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-Mail ������ �� �����');
document.enter_pertner.email.focus();
return false;
}
if (document.enter_pertner.passw.value.length == 0) {
alert('�� �� ����� ������');
document.enter_pertner.passw.focus();
return false;
}
if (document.enter_pertner.passw.value.length < 3) {
alert('����������� ����� ������: 3');
document.enter_pertner.passw.focus();
return false;
}
return true;
}

function Check_rest_pass() {
if (!document.rest_pass.email.value.match('^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-Mail ������ �� �����');
document.rest_pass.email.focus();
return false;
}
return true;
}

function show_hide(d){
var id=document.getElementById('d'+d);
if(id) id.style.display=id.style.display=='none'?'block':'none';
}
// -->


</SCRIPT>
<center>
<div class="border">
<table width="100%" border="0" cellspacing="10" cellpadding="0">
	<tr>
	<td width="10%" align="center" class="div_include" style="BACKGROUND-COLOR: #ffffff;"><center>
	<a href="http://wm-rb.net"><img src="http://wm-rb.net/img/logo.gif" alt="WebMoney � ���������� ��������" width="190" height="60"></a>
	</center>
	</td>
		<td width="90%" class="div_include" align="right" colspan="2">
<div style="float:left;" align="center"><noindex><br />
<!-- <span class="black">��� WMID</span> &nbsp;&nbsp;&nbsp;&nbsp;<a href="http://passport.webmoney.ru/asp/certview.asp?wmid=409306109446" target="_blank">409306109446</a> -->

</noindex>

</div>
<?
if(IN_PAGE=='INDEX') {echo "<a href=\"http://www.planeta-dobra.by\" target=\"_blank\"><img src=\"../img/ban/468x60-2.gif\" width=\"468\" height=\"60\" alt=\"����������������� ���� \"������� �����\"\" /></a>";}
else {
?>
<!-- Mestkom code BEGIN -->
<script type="text/javascript" src="http://dynamic.exaccess.ru/asp/dynamic_script.asp?id_d=780805"></script>
<!-- Mestkom code END -->
<?}?>
</td>
	</tr>
<tr>
<td colspan="3" id="report" style="font-size:13px;" align="center"><b><? echo $content_reklama[0]['contents']?></b></td>
</tr>

	<tr>
		<td ROWSPAN="3" class="menu" valign="top">
		<div class="menu_line_top" align="center"><b>������� ����</b></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="�������� ������ �������" href="http://wm-rb.net/rules.aspx"><b>����������� � ������</b></a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="�������� ���� �������� �������" href="http://wm-rb.net/news.aspx">������� �������</a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="����� �������" href="http://forum.wm-rb.net/" target="_blank">�����</a></div>
		<div class="menu_linex" align="left">�������</div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="������ �������" href="http://shop.wm-rb.net/">� ������ �������</a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="�������� ���������� �� ������" href="http://wm-rb.net/user_check_eshop.aspx"><u>�������� ������</u></a></div>
		<div class="menu_linex" align="left">�������� �����</div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="������� ��� ������ ������ ��� ������" href="http://wm-rb.net/exchange.aspx">����� ������</a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="�������� ���������� �� ������" href="http://wm-rb.net/user_check_demand.aspx"><u>�������� ������</u></a></div>
		<div class="menu_linex" align="left">������ �����</div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="������ ��������������� �����" href="http://service.wm-rb.net/">������ �����</a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="�������� ���������� �� ������" href="http://service.wm-rb.net/user_check_usluga.aspx"><u>�������� ������</u></a></div>
		<div class="menu_linex" align="left">�����, ���������</div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="������ �������� � ������������ �����" href="http://wm-rb.net/input_nal.aspx">��������� ���� ���������</a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="������ �������� � ������������ �����" href="http://wm-rb.net/output_nal.aspx">����� �� ����� ���������</a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="�������� ������ �� ���������� ����� ���������" href="http://wm-rb.net/user_check_cash.aspx"><u>�������� ������</u></a></div>
		<div class="menu_linex" align="left">��������</div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="� �������" href="http://wm-rb.net/info.aspx">� ������� </a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="��������� ����������" href="http://wm-rb.net/contact.aspx">��������� ���������� </a></div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="�������� ��������� � ������ ���������" href="http://wm-rb.net/support.aspx">������ ���������</a></div>
		<div class="menu_linex" align="left">����������� ���������</div>
		<div class="menu_line" align="left"><b>� </b><a class="menu_gl" title="����������� � ����������� ���������" href="http://wm-rb.net/registration.aspx">�����������</a></div>
		<div class="menu_line" align="left"><b>� </b><A hideFocus
      href="http://wm-rb.net/" onclick="return showlogin();">�����</A></div>
	  		<div class="menu_line" align="left"><b>� </b><A href="javascript:show_hide(10)">������ ������?</A></div>
			<div class="menu_line" style="display: none; margin: 5px;" id="d10">
			<form name="rest_pass" id="rest_pass" method="post" action="http://wm-rb.net/registration.aspx" onSubmit="return Check_rest_pass()">
	<INPUT name=email size="15" maxlength="52" onclick="javascript:if(this.value=='������� E-mail')this.value='';" value="������� E-mail">
<INPUT name=mess_pass type=submit value=��������� style="width:80px; "onmouseover="this.style.backgroundColor='#E8E8FF';" onmouseout="this.style.backgroundColor='#f3f7ff';" id="cursor">

			</form></div>
<hr />
		<div align="center">
<!-- <a href="http://www.planeta-dobra.by" target="_blank"><img style="margin-bottom:5px;" src="../img/ban/planeta-dobra.png" width="210" height="82" alt='����������������� ���� "������� �����"' /></a>
<br /> -->
<a href="http://aforex.ru//intro-company?utm_campaign=524&utm_term=Advantage&utm_medium=banner&utm_source=http://www.wm-rb.net&utm_content=all"><img src="../img/ban/200-300.gif" alt="��������� ������"></a>
<hr />
<div align="center" style="margin-bottom:5px;">
<!-- Mestkom code BEGIN -->
<script type="text/javascript" src="http://dynamic.exaccess.ru/asp/dynamic_script.asp?id_d=780806"></script>
<!-- Mestkom code END -->
</div>

		<noindex>
		<hr />

		<a href="http://www.webmoney.ru" target="_blank">
<img src="img/logo_wm.gif" width="88" height="31" alt="��������� WebMoney" border="0"></a>
<!-- begin WebMoney Transfer : attestation label -->
<a href="https://passport.webmoney.ru/asp/certview.asp?wmid=<? echo $wmid;?>" target="_blank"><img src="img/blue_rus.gif" alt="����� ��������� �������� ������ WM �������������� <? echo $wmid;?>" border="0" /></a>
<!-- end WebMoney Transfer : attestation label -->
<div align="center">
		<!--WebMoney TOP--><script language="JavaScript"><!--
document.write('<a href="http://top.owebmoney.ru" target=_blank>'+'<img src="http://top.owebmoney.ru/counter.php?site_id=1068&from='+escape(document.referrer)+'&host='+location.hostname+'&rand='+Math.random()+'" alt="WebMoney TOP" '+'border=0 width=88 height=31></a>')//--></script>
<noscript><a href="http://top.owebmoney.ru" target=_blank>
<img src="http://top.owebmoney.ru/counter.php?site_id=1068"
width=88 height=31 alt="WebMoney TOP" border=0></a></noscript>
<!--/WebMoney TOP-->
<a href="http://www.easypay.by" target=_blank><IMG SRC="img/logo_easypay.gif" alt="��������� EasyPay" width="88" height="31" border="0"></a>
</div>

</noindex>
<div class="menu_line_top" align="center"><b>������ �������</b></div>
<div class="menu_line" align="center"><a class="menu_gl" href="http://topreliz.ru/" target="_blank"><b>TopReliz.ru</b></a></div>
</div>
<hr />
<!--
		<td align="center" height="30" class="div_include" style="BACKGROUND-COLOR: #FFFACD;"><div class="red"><b>�� ����������� �������� ������ ������� ���������� �� 12:00.<br />�������� ��������� �� ����������� ����������.</b></div></td>
	</tr>
-->

		<td  style="BACKGROUND-COLOR: #fff;	border: #C0C0C0 1px solid;padding: 5px;" colspan="3" align="center">
<?

echo "<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0\" width=\"600\" height=\"90\"><param name=\"movie\" value=\"http://wm-rb.net/img/ban/{$flash[$ban_f]}.swf\" /><param name=\"flashvars\" value=\"url_name=http://instaforex.com/ru/?x=BLIR\"><param name=\"quality\" value=\"high\" /><param name=\"wmode\" value=\"opaque\"/><embed src=\"http://wm-rb.net/img/ban/{$flash[$ban_f]}.swf\" wmode=\"opaque\" quality=\"high\" flashvars=\"url_name=http://instaforex.com/ru/?x=BLIR\" wmode=\"opaque\" pluginspage=\"http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash\" type=\"application/x-shockwave-flash\" width=\"600\" height=\"90\"></embed></object>";
?>
<!-- <table width="100%" class="div_include">
	<tr>
		<td width="323" class="oper_ok"> -->

<?
/*
if(!empty($theam_1)) {

	foreach($theam_1 as $arr) {
							echo "�&nbsp;<a href=\"http://forum.wm-rb.net/showthread.php?t={$arr['0']}\" target=_blank>{$arr['1']}</a><br />";
	}
}
if(!empty($theam_7)) {
	foreach($theam_7 as $arr) {
							echo "�&nbsp;<a href=\"http://forum.wm-rb.net/showthread.php?t={$arr['0']}\" target=_blank>{$arr['1']}</a><br />";
	}
}
*/
?>
<!-- </td>
		<td width="323" class="oper_ok"> -->
<?
/*
if(!empty($theam_14)) {
	foreach($theam_14 as $arr) {
							echo "�&nbsp;<a href=\"http://forum.wm-rb.net/showthread.php?t={$arr['0']}\" target=_blank>{$arr['1']}</a><br />";
	}
}
if(!empty($theam_18)) {
	foreach($theam_18 as $arr) {
							echo "�&nbsp;<a href=\"http://forum.wm-rb.net/showthread.php?t={$arr['0']}\" target=_blank>{$arr['1']}</a><br />";
	}
}
*/
?>
<!-- </td>
	</tr>
</table> -->
<a href="#instaforex"><b>���������� ���������</b> ������ ���������� ��������� �� ����� �����. <b>�������� 0%</b></a><br /><br />
<a href="http://instaforex.com/ru/?x=BLIR" target="_blank"><b>��������������� ������ � ����!</b> �������, ��� ������� ������� ������� �� ������ � �������� ������ ����� ��� ������, ����� ����������� �� 2% � ����� ����������. </a><br /><a href="http://wm-rb.net/support.aspx">�� ����������� ���������� � ������ ���������</a>

</td>
	</tr>