<?
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp

echo "
<div style=\"display: none;\" id=\"d1\"><br />
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"user_check_usluga.aspx\" onSubmit=\"return Check_report()\">
	� ������ : <input type=\"text\" name=\"did\" size=\"12\" maxlength=\"10\" value=\"{$demand_info[0]['did']}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report_usluga\"  value=\"��������\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div><br />
<div id=\"report\" align=\"left\">
<div class=\"text\" id=padding>
<div class=\"red\">���������� � ������ :</div><br />
						&bull; <u>������������ ������ ������������� � ������� <b>12 �����</b></u><br />
						&bull; ���� ������ �� ����� ��������� � ������� 12 �����, �� �����, ���� ��������, ���������� �����, ����� ���������� ������� �� ��� ���� �� ����������� �������� ��������� �������.</u><br />
						&bull; ����� ������ ������ ��������� ��� �� E-Mail<br />";
$Constructor->InstructService($demand_info[0]['status'],$demand_info[0]['output'],$edit_out_val,$out_val,$demand_info[0]["did"],'demand_uslugi');
						echo "</div>
</div><br />
                   <table width=\"450\" border=\"0\" cellspacing=\"0\" cellpadding=\"10\" bgColor=\"#ebebeb\" class=\"form_bord\">
                      <tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"center\" class=\"text\"><font color=\"#2d496e\"><b>������  � {$demand_info[0]['did']}</b></font></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>������ :</b>&nbsp;</td>
                        <td align=\"left\">";
						echo sFormatData::formatStatus($demand_info[0]["status"]);
						echo "</td>
                      </tr>";
                      if (!empty($demand_info[0]['coment']) && $demand_info[0]['status'] != 'y') { echo "<tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"left\" class=\"text\"><font color=\"red\"><b>����������� : </b></font><span class=\"text_log\">{$demand_info[0]['coment']}</span></td>
                      </tr>";
					  }
                      echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>������ ������ :</b>&nbsp;</td>
                        <td align=\"left\">{$us[0]['desc_val']}
                        </td>
                      </tr>";
					  //����� ���� �� ��������� ������
					  if($des_cat[0]['name_cat'] == 'shop'){
                      echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>������� :</b>&nbsp;</td>
                        <td align=\"left\">
						{$demand_info[0]['in_val']} {$cur_out_info[0]['desc_val']}
                        </td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\"><b>��������� :</b>&nbsp;</td>
                        <td align=\"left\" height=\"4\">{$demand_info[0]['out_val']} BYR
                        </td>
						<tr class=\"text\" bgColor=\"#ffffff\">
						<td align=\"right\"><b>";
					  }
					  else {
                      echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>������� :</b>&nbsp;</td>
                        <td align=\"left\">
						{$out_val} {$cur_out_info[0]['desc_val']}
                        </td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\"><b>��������� :</b>&nbsp;</td>
                        <td align=\"left\" height=\"4\">{$demand_info[0]['in_val']} BYR
                        </td>
						<tr class=\"text\" bgColor=\"#ffffff\">
						<td align=\"right\"><b>";
					  }
					$Constructor->demand_sevices($demand_info[0]['name_uslugi']);
					  echo "</b>&nbsp;<br>
						</td>
							<td align=\"left\">{$demand_info[0]['pole1']}
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
                        <td align=\"left\">".date('d.m.Y H:i:s',$demand_info[0]['add_date'])."
                        </td>
						</tr>
						<tr class=\"text\" bgColor=\"#ffffff\">
						<td colspan=\"2\" align=\"center\">";

				if ($demand_info[0]['status'] == "n") {
					$sel_idpay = $db_admin->sel_idpay($demand_info[0]['did']);
				if($demand_info[0]['output'] == "EasyPay") {
$Constructor->Payment_uslugi($demand_info[0]['output'],$demand_info[0]['purse_out'],$demand_info[0]['out_val'],$demand_info[0]['in_val'],$sel_idpay[0]["id_pay"],$desc_pay,$demand_info[0]['partner_id'],$demand_info[0]['did']);
				}
				else {
			        echo Vitalis::tmpl('Widgets')->load_tmpl_block('webmoney.paramerty_payment',array(
			            'output'=>$demand_info[0]['output'],
			            'input'=>sConstructor::name_submit('uslugi'),
			            'in_val'=>$demand_info[0]['in_val'],
			            'purse_out'=>$demand_info[0]['purse_out'],
			            'purse_in'=>$demand_info[0]['purse_in'],
			            'out_val'=>$demand_info[0]['out_val'],
			            'id_pay'=>$sel_idpay[0]["id_pay"],
			            'desc_pay'=>$desc_pay,
			            'did'=>$demand_info[0]['did'],
						'type_wmid'=>$type_wmid,
						'type_action'=>'paydesk'
			        ));
				}

				}
			echo "
			</td>
                      </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
					   <td colspan=\"2\"><center><u>��� ������� ����������� �������������</u></center><br />
                        </td>
						</tr>
                    </table>";
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
?>
