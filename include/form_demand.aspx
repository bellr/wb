
<?
if($input == "EasyPay") {
    echo "<div class=red align=\"left\">Внимание!!! Автоматический обмен!</div><br />
						<div class=\"text\">Для успешного выполнения заявки, ваш статус в системе <b>EasyPay</b> должен быть не ниже \"<b>Персональный</b>\" <u>Как повысить статус читайте <a href=\"https://ssl.easypay.by/status/\">здесь</a></u></div><br />";
}

if($output == "EasyPay") {
    echo "<div class=red align=\"left\">Внимание!!! </div>
						<div align=\"left\" class=\"text\">&nbsp;&nbsp;&nbsp;&nbsp;Для пополнения балансов электронных валют Вы можете использовать <b>наличные</b>.
						<br />Подробнее читайте <a href=\"http://wm-rb.net/input_nal.aspx\">здесь…</a></div><br /><br />";
}
if(!empty($sel_d)) {
    echo "<div class=\"text\" align=\"left\"><b>Таблица предоставляемых скидок для направления обмена :</b> {$cur_out_info[0]["desc_val"]} ››› {$cur_in_info[0]["desc_val"]}
<ul>";
    foreach($sel_d as $ar) {echo "<li>сумма обмена больше ".edit_balance($ar[amount])." {$cur_in_info[0]["desc_val"]} - ".$ar[size_d]."%</li>";}
    echo "</ul>";
    echo "</div><br /><br />";
}
echo "
<form name=\"form_exch\" id=\"form_exch\" method=\"post\" action=\"http://wm-rb.net/check_demand.aspx\" onSubmit=\"return Check()\">
                    <table width=\"380\" border=\"0\" cellspacing=\"1\" cellpadding=\"10\" bgColor=\"#ebebeb\">
                      <tr>
                        <td colspan=\"2\" align=\"center\" class=\"text\"  height=\"40\" background=\"http://wm-rb.net/img/linet.gif\"><b>{$cur_out_info[0]["desc_val"]} ››› {$cur_in_info[0]["desc_val"]}</b></td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"center\" class=\"text_log\"><b>Заявка  № $reqID</b></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\">Отдаете, {$cur_out_info[0]["desc_val"]} :&nbsp;</td>
                        <td align=\"center\">

                          <input type=\"text\" name=\"in_val\" size=\"13\" value=\"0\" id=\"in_val\"
                  onblur=i_o(true) onkeyup=i_o() onchange=i_o()>
                        </td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"left\" class=\"text_log\"><b>Вы должны иметь, {$cur_out_info[0]["desc_val"]} : </b>
                          <SPAN id=kom_08>0</SPAN>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\">Получаете, {$cur_in_info[0]["desc_val"]} :&nbsp;<br /><span class=\"redin\" id=\"discont\"></span></td>
                        <td align=\"center\" height=\"4\">
                          <input type=\"text\" name=\"out_val\" size=\"13\" value=\"0\" id=\"out_val\"
                  onblur=o_i(true) onkeyup=o_i() onchange=o_i()>
                        </td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"left\" class=\"text_log\"><b>Доступно для обмена, {$cur_in_info[0]["desc_val"]} : {$format_balance}</b></td>
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
			<div class=\"text\">C <a href=\"http://wm-rb.net/rules.aspx\" target=\"_blank\" title=\"Правила предоставления услуг\">правилами</a> предоставления услуг согласен <input type=\"checkbox\" name=\"rules\"></div>
                    <br />
					<input type=\"hidden\" name=\"ex_out\" value=\"$output\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"ex_in\" value=\"$input\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"$reqID\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"hesh\" value=\""; echo md5($reqID.'1620'); echo "\" readonly=\"readonly\">
                    <input type=\"submit\" name=\"ex_demand\" value=\"Продолжить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">
                    </form>";

?>
