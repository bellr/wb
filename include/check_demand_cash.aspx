<?
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
$purse = $db_exchange->sel_purse('EasyPay');
$purse_card = $db_pay_desk->exch_value($demand_info[0]['output']);

echo "<br />
<div style=\"display: none;\" id=\"d1\">
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"user_check_cash.aspx\" onSubmit=\"return Check_report()\">
	� ������ : <input type=\"text\" name=\"did\" size=\"12\" maxlength=\"10\" value=\"{$demand_info[0]['did']}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report_cash\"  value=\"��������\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div><br />
<div id=\"report\" align=\"left\">
<div class=\"text\" id=padding>
<div class=\"red\">���������� � ������ :</div><br />
						&bull; ������������ ������ ������������� � ������� <b>12 �����</b><br />
						&bull; ����� ������ ��������� ��� �� E-Mail<br />";
						if ($demand_info[0]['status'] == "n") {
switch ($demand_info[0]['output']) :

	case ("pochta") :
		if($demand_info[0]['purse_payment'] == 0) { echo $demand_info[0]["did"];
		$EP_purse = $db_exchange->EP_purse_input($edit_out_val);
		$db_pay_desk->edit_purse_input($demand_info[0]["did"],$EP_purse[0]['acount'],'demand_cash');
		}else {$EP_purse[0]['acount'] = $demand_info[0]['purse_payment'];}

		echo "<br /><div class='red'>��������!!! �������������� �������� ������!</div><br />
			<center><b>��������, ����������� ����, �����������.</b></center><br />

			&bull; ��������� ���� <b>EasyPay {$EP_purse[0]['acount']}</b> �� ����� <b>".$edit_out." BYR</b> ����� ��������
����� � ��������� ��������������� � � ����� �������� ��������� ��������.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���������� ������ �������� ���������, ��� ����� ���������� ���������� ����� ����� �� ���� <a href=\"https://ssl.easypay.by/input/post_office/\" target=\"_blank\">��������</a>.<br /><br />
			<b>��������!!!</b><br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>��� ���������� ��������</u> ��������� �� ��� �������� � ����������� ������ ����� <a href=\"javascript:show_hide(1)\">�����</a> ��� �� �������� \"<a href=\"http://wm-rb.net/user_check_cash.aspx\">�������� ������</a>\", ����� ������ �� ����� �����������.";

	break;
	case ("VISA") :
echo "<div style=\"margin-top:10px;\" class=\"red\">��������!!!</div>
	������ �� ������ �������������� �� ���� ��������� ������� liqPAY. ��� �������� ������ �������� �����������, ����������� �� ����� ��������� ������� liqPAY.
";
	break;
	default:
echo "&bull; ����������� ��������� ����� �� ���� ���������� ����� <b>{$purse_card[0]['desc_val']}� {$purse_card[0]['name_card']}</b> (���� �������� {$purse_card[0]['period']}) , ����� ������ <u>��������</u> ����� <a href=\"javascript:show_hide(1)\"><b>�����</b></a> ��� �� �������� \"<a href=\"http://wm-rb.net/user_check_cash.aspx\">�������� ������</a>\"<br />";
endswitch;

						}
						echo "</div>
</div>
<br />

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
						{$demand_info[0]['out_val']} BYR
                        </td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\"><b>��������� :</b>&nbsp;</td>
                        <td align=\"left\" height=\"4\">{$demand_info[0]['in_val']} {$cur_in_info[0]['desc_val']}
                        </td>";
						/*
if($demand_info[0]['output'] != "pochta" && $demand_info[0]['output'] != 'VISA') {
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
*/
					  echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>���� ���������� :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]['purse_in']}
                        </td>
						</tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
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
						<td colspan=\"2\" align=\"center\">
						</form>
			</td>
                      </tr>
						<tr class=\"text\" bgColor=\"#ffffff\">
						<td colspan=\"2\" align=\"center\">";

				if ($demand_info[0]['status'] == "n" && $demand_info[0]['output'] == 'VISA') {
					$sel_idpay = $db_admin->sel_idpay($demand_info[0]['did']);
$Constructor->Payment_uslugi($demand_info[0]['output'],$purse[0]['purse'],$demand_info[0]['out_val'],$demand_info[0]['in_val'],$sel_idpay[0]["id_pay"],$desc_pay,$demand_info[0]['partner_id'],$demand_info[0]['did']);
				}
			echo "
			</td>
                      </tr>";
if($demand_info[0]['output'] != 'VISA') {
					  echo "<tr class=\"text\" bgColor=\"#ffffff\">
					   <td colspan=\"2\"><b>����� ���������� �������� :</b><br />
<u>��-��</u> (12:00 - 22:00),
<u>��-��</u> (18:00 - 23:00)<br />
                        </td>
						</tr>";
}
                    echo "</table><br /><br />";
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
?>
