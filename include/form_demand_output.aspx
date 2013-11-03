
<?
//https://merchant.webmoney.ru/lmi/payment.asp
echo "
<form name=\"check_demand\" id=\"check_demand\" method=\"post\" action=\"http://wm-rb.net/check_demand.aspx\" onSubmit=\"return Check()\">
                    <table width=\"390\" border=\"0\" cellspacing=\"1\" cellpadding=\"10\" bgColor=\"#ebebeb\">
                      <tr>
                        <td colspan=\"2\" align=\"center\" class=\"text\"  height=\"40\" background=\"http://wm-rb.net/img/linet.gif\"><b>Пополнение карты {$us[0]['desc_val']}</b></td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"center\" class=\"text_log\"><b>Заявка  № $reqID</b></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\">Отдаете, {$oplata}:&nbsp;</td>
                        <td align=\"center\">

                          <input type=\"text\" name=\"in_val\" size=\"13\" value=\"0\" id=\"in_val\"
                  onblur=\"i_o(true)\" onkeyup=\"i_o()\" onchange=\"i_o()\">
                        </td>
                      </tr>
                      <tr bgColor=\"#FFFACD\">
                        <td colspan=\"2\" align=\"left\" class=\"text_log\"><b>Вы должны иметь, {$oplata} : </b>
                          <SPAN id=kom_08>0</SPAN>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\">Получаете, {$us[0]['equiv_cur']} :&nbsp;</td>
                        <td align=\"center\" height=\"4\">
                          <input type=\"text\" name=\"out_val\" size=\"13\" value=\"0\" id=\"out_val\"
                  onblur=\"o_i(true)\" onkeyup=\"o_i()\" onchange=\"o_i()\">
                        </td>
                      </tr>
                      <tr bgColor=\"#f3f7ff\">
                        <td colspan=\"2\" align=\"left\" class=\"text_log\"><b>Доступно для оплаты, {$us[0]['equiv_cur']} : {$format_balance}</b></td>
			          </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">";


	$Constructor->check($oplata,"",$_COOKIE['purse_'.$oplata],"");
	echo "<input type=\"hidden\" name=\"operation_type\" value=\"4\">";


					echo "</td>
					</tr>";
					if($oplata == "WMZ" || $oplata == "WMR" || $oplata == "WME" || $oplata == "WMG" || $oplata == "WMU" || $oplata == "WMY" || $oplata == "WMB") {
					echo "<tr class=\"text\" bgColor=\"#ffffff\">";
				echo $Constructor->info_card($_COOKIE['wmid'],$_COOKIE['user_surname'],$_COOKIE['user_name'],$_COOKIE['name_bank']);
					  echo "
					</td>
					</tr>";}
					echo "<tr class=\"text\" bgColor=\"#ffffff\">";
						$Constructor->inside_input($usluga,$_COOKIE[$usluga.'_1'],$_COOKIE[$usluga.'_2']);
						echo $usluga;
					  echo "
					</td>
					</tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\">E-Mail :&nbsp;<br>
                        </td>
                        <td align=\"center\">
			  <input type=\"text\" name=\"email\" id=\"email\" value=\"".$_COOKIE['email']."\" size=\"20\">
                        </td>
                      </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"center\">
			<div class=\"text\">C <a href=\"http://wm-rb.net/rules.aspx\" target=\"_blank\" title=\"Правила предоставления услуг\">правилами</a> предоставления услуг согласен <input type=\"checkbox\" name=\"rules\"></div></td>
                      </tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
						<td colspan=\"2\" align=\"center\">


					<input type=\"hidden\" name=\"oplata\" value=\"$oplata\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"name_uslugi\" value=\"$usluga\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"$reqID\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"hesh\" value=\""; echo md5($reqID.'1620'); echo "\" readonly=\"readonly\">
                    <input type=\"submit\" name=\"output_NAL\" value=\"Продолжить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    >
			</tr>
			</td>
</table>
                    </form>";
?>
