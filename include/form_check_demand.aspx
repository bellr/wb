<?
echo "
<div style=\"display: none;\" id=\"d1\"><br />
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"user_check_demand.aspx\" onSubmit=\"return Check_report()\">
	� ������ : <input type=\"text\" name=\"did\" size=\"12\" maxlength=\"10\" value=\"{$demand_info[0]["did"]}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report\"  value=\"��������\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div><br />
<div id=\"report\" align=\"left\">
<div class=\"text\" id=padding>
<div class=\"red\">���������� � ������ :</div><br />
						&bull; <u>������������ ������ ������������� � ������� <b>12 �����</b></u><br />
						&bull; ���� ������ �� ����� ��������� � ������� 12 �����, �� �����, ���� ��������, ���������� �����, ����� ���������� ������� �� ��� ���� �� ����������� �������� ��������� �������.</u><br />
						&bull; ����� ������ ������ ��������� ��� �� E-Mail<br />";
$Constructor->InstructPay($demand_info[0]['status'],$demand_info[0]['ex_output'],$edit_out_val,$out_val,$demand_info[0]["did"]);
echo "</div>
</div>
<br />
<br />
                   <table width=\"450\" border=\"0\" cellspacing=\"0\" cellpadding=\"10\" bgColor=\"#ebebeb\" class=\"form_bord\">

                      <tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"center\" class=\"text\"><font color=\"#2d496e\"><b>������ � {$demand_info[0]["did"]}</b></font></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>������ :</b>&nbsp;</td>
                        <td align=\"left\">";
						echo sFormatData::formatStatus($demand_info[0]["status"]);

echo "</td>
                      </tr>";
if (!empty($demand_info[0]["coment"]) && $demand_info[0]['status'] != 'y') { echo "<tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"left\" class=\"text\"><font color=\"red\"><b>����������� : </b></font><span class=\"text_log\">{$demand_info[0]["coment"]}</span></td>
                      </tr>";
}
echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>����������� <br />������ :</b>&nbsp;</td>
                        <td align=\"left\">{$cur_out_info[0]["desc_val"]} -> {$cur_in_info[0]["desc_val"]}
                        </td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>������� :</b>&nbsp;</td>
                        <td align=\"left\">
						{$out_val} {$cur_out_info[0]["desc_val"]}
                        </td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\"><b>��������� :</b>&nbsp;</td>
                        <td align=\"left\" height=\"4\">{$demand_info[0]["in_val"]} {$cur_in_info[0]["desc_val"]}
                        </td>";
$Constructor->demand($demand_info[0]["ex_output"],$demand_info[0]["ex_input"],$demand_info[0]["purse_out"],$demand_info[0]["purse_in"]);
echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>E-Mail :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]["email"]}
                        </td>
						</tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>���� ������� :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">".date('d.m.Y H:i:s',$demand_info[0]['add_date'])."
                        </td>
						</tr>
						<tr class=\"text\" bgColor=\"#ffffff\">
						<td colspan=\"2\" align=\"center\">
                    <br />";
if ($demand_info[0]["status"] == "n") {
    $sel_idpay = $db_admin->sel_idpay($did);
	
	
    if($demand_info[0]['ex_output'] == "EasyPay") {
		$purse_out = $demand_info[0]["purse_out"];
        //$Constructor->ParamertyPayment($demand_info[0]["ex_output"],$demand_info[0]["ex_input"],$demand_info[0]["in_val"],$demand_info[0]["purse_out"],$demand_info[0]["purse_in"],$demand_info[0]["out_val"],$sel_idpay[0]["id_pay"],$desc_pay,$demand_info[0]["did"]);
		//$Constructor->ParamertyPayment($demand_info[0]["ex_output"],$demand_info[0]["ex_input"],$demand_info[0]["in_val"],$purse[0]['purse'],$demand_info[0]["purse_in"],$demand_info[0]["out_val"],$sel_idpay[0]["id_pay"],$desc_pay,$demand_info[0]["did"]);
    }
    else {
		$purse_out = $purse[0]['purse'];
//$Constructor->ParamertyPayment($demand_info[0]["ex_output"],$demand_info[0]["ex_input"],$demand_info[0]["in_val"],$purse[0]['purse'],$demand_info[0]["purse_in"],$demand_info[0]["out_val"],$sel_idpay[0]["id_pay"],$desc_pay,$demand_info[0]["did"]);

    }
	
			echo Vitalis::tmpl('Widgets')->load_tmpl_block('webmoney.paramerty_payment',array(
            'output'=>$demand_info[0]["ex_output"],
            'input'=>$demand_info[0]["ex_input"],
            'in_val'=>$demand_info[0]["in_val"],
            'purse_out'=>$purse_out,
            'purse_in'=>$demand_info[0]["purse_in"],
            'out_val'=>$demand_info[0]["out_val"],
            'id_pay'=>$sel_idpay[0]["id_pay"],
            'desc_pay'=>$desc_pay,
            'did'=>$did,
			'type_action'=>'exchange'
        ));
}
echo "
			</td>
                      </tr>
                    </table>";

?>
