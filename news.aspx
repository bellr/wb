<?
require("include/header.aspx");
require("customsql.inc.aspx");

$db = new CustomSQL($DBName);

?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<head>
<Meta Http-equiv="Content-Type" Content="text/html; charset=Windows-1251">
<Title>WM-RB.net - ������ ����������� �������� :: ������� �������</Title>
<Meta name="description" Content="������������������ �������� ����������� ����� WebMoney (WMZ, WMB, WMR, WME, WMU, WMY), EasyPay, RBK Money, Yandex Money, ������������ ������� � ������">
<Meta name="keywords" Content="�����, wm, ����� ������,��������, ������, ����������, ����������� ���������, �����, �����">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<META NAME="RESOURCE-TYPE" CONTENT="DOCUMENT">
<META content="30 days" name="revisit-after">
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
<div class="top_title" align="right">������� �������</div>
	<? $result = $db->news($_GET['page'],'10');

		foreach ($result as $ar) {
	        $title = $ar["1"];
	        $contents = $ar["2"];
	        $data = $ar["3"];

		echo "<div align=left>
			<div class=\"blue2\" style=\"padding-bottom: 5px;\">$title</div>
			<div class=\"text_log\">$contents</div>
			<div class=\"text_log\" align=\"right\"><br /><b>���� ���������� : $data</b></div>
			<hr size=\"1\" color=\"BDB76B\" noshade />
		</div>";
		}
		?>
		<div>
		<?
	$number = $db->count('news');
	$posts = $number[0]["stotal"];
	$total = intval(($posts - 1) / $record) + 1;
	$page = $_GET['page'];
if ($total > 1)
{
   	$i = 0;
   	while(++$i <= $total)
   	{
	if ($i == $page+1) {
	echo "<span class=\"black\"><u>";
	echo $page+1;
	echo "</u></span>&nbsp;";
	continue;
	}
	$p = $i - 1;
     	echo "<a href=\"news.aspx?page=$p\"><span class=\"text_log\">" . $i . "</span></a>&nbsp;";
   	}
}
?>
</div>
		</td>
	</tr>
<?
include('include/bottom.aspx');
?>
</body>
</html>
