<?
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp

echo "<br />
<div style=\"display: none;\" id=\"d1\">
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"user_check_eshop.aspx\" onSubmit=\"return Check_report()\">
	� ������ : <input type=\"text\" name=\"did\" size=\"12\" maxlength=\"10\" value=\"{$demand_info[0]['did']}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report_eshop\"  value=\"��������\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div><br />
<div id=\"report\" align=\"left\">
<div class=\"text\" id=padding>
<div class=\"red\">���������� � ������ :</div><br />
						&bull; <u>������������ ������ ������������� � ������� <b>12 �����</b></u><br />
						&bull; ���� ������ �� ����� ��������� � ������� 12 �����, �� �����, ���� ��������, ���������� �����, ����� ���������� ������� �� ��� ���� �� ����������� �������� ��������� �������.</u><br />
						&bull; ����� ������ ������ ��������� ��� �� E-Mail<br />";
						if ($demand_info[0]['status'] == "n") {
						if ($demand_info[0]['output'] == "EasyPay") {
							$EP_purse = $db_exchange->EP_purse_input($edit_out_val);
							$db_pay_desk->edit_purse_input($demand_info[0]["did"],$EP_purse[0]['acount'],'demand_eshop');
						echo "<br /><div class='red'>��������!!! �������������� �������� ������!</div><br />
							<center><b>��������, ����������� ����, �����������.</b></center><br />
						&bull; ����������� <b>".$edit_out_val." BYR</b> �� ���� <b>EasyPay {$EP_purse[0]['acount']}</b>, � ���������� � ������� ����������� ������� <u>������</u> ����� ������ <b>{$demand_info[0]['did']}</b>.<br /><br />
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
						}

						echo "</div>
</div><br />
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
                      echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>����� :</b>&nbsp;</td>
                        <td align=\"left\">{$us[0]['desc_val']}
                        </td>
                      </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>���������� :</b>&nbsp;</td>
                        <td align=\"left\">{$demand_info[0]['amount_goods']}</td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\"><b>��� ������ :</b>&nbsp;</td>
                        <td align=\"left\" height=\"4\">{$demand_info[0]['amount']} {$cur_out_info[0]['desc_val']}
                        </td>
						<tr class=\"text\" bgColor=\"#ffffff\">
						<td align=\"right\"><b>";

					$Constructor->demand_sevices($demand_info[0]['name_goods']);
					  echo "</b><br>
					  </td>
							<td align=\"left\">{$demand_info[0]['pole1']}
						</td>
						</tr>";
						$Constructor->demand($demand_info[0]["output"],'',$demand_info[0]["purse_out"],'');
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
						<td colspan=\"2\" align=\"center\">";

				if ($demand_info[0]['status'] == "n") {
					$sel_idpay = $db_admin->sel_idpay($demand_info[0]['did']);
$Constructor->Payment_eshop($demand_info[0]['output'],$purse[0]['purse'],$demand_info[0]['amount'],$sel_idpay[0]["id_pay"],$desc_pay,$demand_info[0]['partner_id'],$demand_info[0]['did']);
				}
			echo "
			</td>
                      </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
					   <td colspan=\"2\"><b>����� ���������� �������� :</b><br />
<u>��-��</u> (12:00 - 22:00),
<u>��-��</u> (18:00 - 23:00)
                        </td>
						</tr>
                    </table>";
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
?>
