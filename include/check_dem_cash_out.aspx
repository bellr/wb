<?
echo "
<div style=\"display: none;\" id=\"d1\"><br />
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"user_check_cash.aspx\" onSubmit=\"return Check_report()\">
	� ������ : <input type=\"text\" name=\"did\" size=\"12\" maxlength=\"10\" value=\"{$demand_info[0]['did']}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report_cash\"  value=\"��������\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div><br />
<div id=\"report\" align=\"left\">
<div class=\"text\" id=padding>
<div class=\"red\">���������� � ������ :</div><br />
						&bull; <u>������������ ������ ������������� � ������� <b>12 �����</b></u><br />
						&bull; ���� ������ �� ����� ��������� � ������� 12 �����, �� ����� ���� ��������, ���������� ����� ����� ���������� ������� �� ��� ���� �� ����������� �������� ��������� �������.</u><br />
						&bull; ����� ������ ������ ��������� ��� �� E-Mail<br />";
$Constructor->InstructService($demand_info[0]['status'],$demand_info[0]['output'],$edit_out_val,$demand_info[0]['in_val'],$demand_info[0]["did"],'demand_nal_out');

						/*if ($demand_info[0]['status'] == "n") {

						if ($demand_info[0]['output'] == "EasyPay") {
							$EP_purse = $db_exchange->EP_purse_input($edit_out_val);
							$db_pay_desk->edit_purse_input($demand_info[0]["did"],$EP_purse[0]['acount'],'demand_nal_out');
						echo "<br /><div class='red'>��������!!! �������������� �������� ������!</div><br />
							<center><b>��������, ����������� ����, �����������.</b></center><br />
						&bull; ����������� <b>".$edit_out_val."</b> �� ���� <b>EasyPay {$EP_purse[0]['acount']}</b>, � ���������� � ������� ����������� ������� <u>������</u> ����� ������ <b>{$demand_info[0]['did']}</b>.<br /><br />
						<b>��������!!!</b> ������ ������ ������������� ������ �� ����� <b>{$demand_info[0]['purse_out']}</b>.<br />
						����� �������� �� ����� �������������.<br /><br />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��� ���������� �������� ��������� �� ��� �������� � ����������� ������, ����� �� ������ \"<b>��������� ������</b>\".<br />";
						}

						if ($demand_info[0]['output'] == "YaDengi") {
						echo "&bull; ����������� ��������� ����� �� ���� <b>Yandex.Money {$purse[0]['purse']}</b>, � ���������� � ������� ����������� ������� ����� ������, ����� ������ �������� ����� <a href=\"javascript:show_hide(1)\"><b>�����</b></a> ��� �� �������� \"<a href=\"http://wm-rb.net/user_check_demand.aspx\"><b>�������� ������</b></a>\"<br />";
						}
						if ($demand_info[0]['output'] == "RBK Money"){
						echo "&bull; ����������� ��������� ����� �� ���� <b>RBK Money {$purse[0]['purse']}</b>, � ���������� � ������� ����������� ������� ����� ������, ����� ������ �������� ����� <a href=\"javascript:show_hide(1)\"><b>�����</b></a> ��� �� �������� \"<a href=\"http://wm-rb.net/user_check_demand.aspx\"><b>�������� ������</b></a>\"<br />";
						}
						}*/
						echo "</div>
</div>
<br /><br />
                   <table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"10\" bgColor=\"#ebebeb\" class=\"form_bord\">
                      <tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"center\" class=\"text\"><font color=\"#2d496e\"><b>������  � {$demand_info[0]['did']}</b></font></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>������ :</b>&nbsp;</td>
                        <td align=\"left\">";
switch ($demand_info[0]['status']) :

	case ("n") :
echo "<font color=\"#FF0000\"><b>�� ��������</b></font>";
	break;
	case ("yn") :
echo "<font color=\"#0000FF\"><b>��������</b></font>";
	break;
	case ("y") :
echo "<font color=\"#008000\"><b>���������</b></font>";
	break;
	case ("er") :
echo "<font color=\"#CC0000\"><b>������</b></font>";
	break;
	default:
endswitch;

						echo "</td>
                      </tr>";
                      if (!empty($demand_info[0]['coment']) && $demand_info[0]['status'] != 'y') { echo "<tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"left\" class=\"text\"><font color=\"red\"><b>����������� : </b></font><span class=\"text_log\">{$demand_info[0]['coment']}</span></td>
                      </tr>";
					  }
                      echo "
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>����������� :</b>&nbsp;</td>
                        <td align=\"left\">
						{$demand_info[0]['in_val']} {$cur_in_info_out[0]['desc_val']}
                        </td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\"><b>��������� :</b>&nbsp;</td>
                        <td align=\"left\" height=\"4\">{$demand_info[0]['out_val']} BYR
                        </td>";
if(empty($demand_info[0]['period'])) {
					  echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>����� ����-����� :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]['card']}
                        </td>
						</tr>";
} else {
					  echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>����� ����� :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]['card']}
                        </td>
						</tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>���� �������� :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]['period']}
                        </td>
						</tr>";
}
					  echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>E-Mail :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]['email']}
                        </td>
						</tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>���� ������� :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]['data']} {$demand_info[0]['time']}
                        </td>
						</tr>
						<tr class=\"text\" bgColor=\"#ffffff\">
						<tr class=\"text\" bgColor=\"#ffffff\">
						<td colspan=\"2\" align=\"center\">";

//$Constructor->Payment_cash_out($demand_info[0]['output'],$purse[0]['purse'],$demand_info[0]['out_val'],$demand_info[0]['in_val'],$sel_idpay[0]["id_pay"],$desc_pay);


				if ($demand_info[0]['status'] == "n") {
					$sel_idpay = $db_admin->sel_idpay($demand_info[0]['did']);
				if($demand_info[0]['output'] == "EasyPay") {
$Constructor->Payment_cash_out($demand_info[0]['output'],$demand_info[0]['purse_out'],$demand_info[0]['out_val'],$demand_info[0]['in_val'],$sel_idpay[0]["id_pay"],$desc_pay,$demand_info[0]['did']);
				}
				else {
$Constructor->Payment_cash_out($demand_info[0]['output'],$purse[0]['purse'],$demand_info[0]['out_val'],$demand_info[0]['in_val'],$sel_idpay[0]["id_pay"],$desc_pay,$demand_info[0]['did']);}
				}


			echo "<br />
			</td>
                      </tr>
                   </table><br />";
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
?>
