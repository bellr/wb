
<?
if($input == "EasyPay") {
    echo "<div class=red align=\"left\">��������!!! �������������� �����!</div><br />
						<div class=\"text\">��� ��������� ���������� ������, ��� ������ � ������� <b>EasyPay</b> ������ ���� �� ���� \"<b>������������</b>\" <u>��� �������� ������ ������� <a href=\"https://ssl.easypay.by/status/\">�����</a></u></div><br />";
}

if($output == "EasyPay") {
    echo "<div class=red align=\"left\">��������!!! </div>
						<div align=\"left\" class=\"text\">&nbsp;&nbsp;&nbsp;&nbsp;��� ���������� �������� ����������� ����� �� ������ ������������ <b>��������</b>.
						<br />��������� ������� <a href=\"http://wm-rb.net/input_nal.aspx\">������</a></div><br /><br />";
}
if(!empty($sel_d)) {
    echo "<div class=\"text\" align=\"left\"><b>������� ��������������� ������ ��� ����������� ������ :</b> {$cur_out_info[0]["desc_val"]} ��� {$cur_in_info[0]["desc_val"]}
<ul>";
    foreach($sel_d as $ar) {echo "<li>����� ������ ������ ".edit_balance($ar[amount])." {$cur_in_info[0]["desc_val"]} - ".$ar[size_d]."%</li>";}
    echo "</ul>";
    echo "</div><br /><br />";
}
echo "
<form name=\"form_exch\" id=\"form_exch\" method=\"post\" action=\"http://wm-rb.net/check_demand.aspx\" onSubmit=\"return Check()\">
                    <table width=\"380\" border=\"0\" cellspacing=\"1\" cellpadding=\"10\" bgColor=\"#ebebeb\">
                      <tr>
                        <td colspan=\"2\" align=\"center\" class=\"text\"  height=\"40\" background=\"http://wm-rb.net/img/linet.gif\"><b>{$cur_out_info[0]["desc_val"]} ��� {$cur_in_info[0]["desc_val"]}</b></td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"center\" class=\"text_log\"><b>������  � $reqID</b></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\">�������, {$cur_out_info[0]["desc_val"]} :&nbsp;</td>
                        <td align=\"center\">

                          <input type=\"text\" name=\"in_val\" size=\"13\" value=\"0\" id=\"in_val\"
                  onblur=i_o(true) onkeyup=i_o() onchange=i_o()>
                        </td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"left\" class=\"text_log\"><b>�� ������ �����, {$cur_out_info[0]["desc_val"]} : </b>
                          <SPAN id=kom_08>0</SPAN>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\">���������, {$cur_in_info[0]["desc_val"]} :&nbsp;<br /><span class=\"redin\" id=\"discont\"></span></td>
                        <td align=\"center\" height=\"4\">
                          <input type=\"text\" name=\"out_val\" size=\"13\" value=\"0\" id=\"out_val\"
                  onblur=o_i(true) onkeyup=o_i() onchange=o_i()>
                        </td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"left\" class=\"text_log\"><b>�������� ��� ������, {$cur_in_info[0]["desc_val"]} : {$format_balance}</b></td>
			          </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">";
$Constructor->check($output,$input,$_COOKIE['purse_'.$output],$_COOKIE['purse_'.$input],$_COOKIE['wmid']);
echo "</td>
                      </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\">E-Mail :&nbsp;<br>
                        </td>
                        <td align=\"center\">
			  <input type=\"text\" name=\"email\" id=\"email\" value=\"".$_COOKIE['email']."\" size=\"20\">
                        </td>
                      </tr>
                    </table>
                    <br />
			<div class=\"text\">C <a href=\"http://wm-rb.net/rules.aspx\" target=\"_blank\" title=\"������� �������������� �����\">���������</a> �������������� ����� �������� <input type=\"checkbox\" name=\"rules\"></div>
                    <br />
					<input type=\"hidden\" name=\"ex_out\" value=\"$output\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"ex_in\" value=\"$input\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"$reqID\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"hesh\" value=\""; echo md5($reqID.'1620'); echo "\" readonly=\"readonly\">
                    <input type=\"submit\" name=\"ex_demand\" value=\"����������\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">
                    </form>";

?>
