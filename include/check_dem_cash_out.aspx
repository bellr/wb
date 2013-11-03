<?
echo "
<div style=\"display: none;\" id=\"d1\"><br />
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"user_check_cash.aspx\" onSubmit=\"return Check_report()\">
	№ заявки : <input type=\"text\" name=\"did\" size=\"12\" maxlength=\"10\" value=\"{$demand_info[0]['did']}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report_cash\"  value=\"Сообщить\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div><br />
<div id=\"report\" align=\"left\">
<div class=\"text\" id=padding>
<div class=\"red\">Инструкции к заявке :</div><br />
						&bull; <u>Неоплаченная заявка действительна в течении <b>12 часов</b></u><br />
						&bull; Если заявка не будет выполнена в течение 12 часов, по каким либо причинам, оплаченная сумма будет возвращена обратно на Ваш счет за исключением комиссии платежной системы.</u><br />
						&bull; Номер данной заявки отправлен Вам на E-Mail<br />";
$Constructor->InstructService($demand_info[0]['status'],$demand_info[0]['output'],$edit_out_val,$demand_info[0]['in_val'],$demand_info[0]["did"],'demand_nal_out');

						/*if ($demand_info[0]['status'] == "n") {

						if ($demand_info[0]['output'] == "EasyPay") {
							$EP_purse = $db_exchange->EP_purse_input($edit_out_val);
							$db_pay_desk->edit_purse_input($demand_info[0]["did"],$EP_purse[0]['acount'],'demand_nal_out');
						echo "<br /><div class='red'>Внимание!!! Автоматическая проверка оплаты!</div><br />
							<center><b>Следуйте, приведенным ниже, инструкциям.</b></center><br />
						&bull; Оплачивайте <b>".$edit_out_val."</b> на счет <b>EasyPay {$EP_purse[0]['acount']}</b>, в примечании к платежу обязательно указать <u>ТОЛЬКО</u> номер заявки <b>{$demand_info[0]['did']}</b>.<br /><br />
						<b>ВНИМАНИЕ!!!</b> Оплата должна производиться ТОЛЬКО со счета <b>{$demand_info[0]['purse_out']}</b>.<br />
						Иначе проверка не будет производиться.<br /><br />
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Для завершения операции вернитесь на эту страницу и подтвердите оплату, нажав на кнопку \"<b>Проверить оплату</b>\".<br />";
						}

						if ($demand_info[0]['output'] == "YaDengi") {
						echo "&bull; Оплачивайте указанную сумму на счет <b>Yandex.Money {$purse[0]['purse']}</b>, в примечании к платежу обязательно указать номер заявки, после оплаты сообщить через <a href=\"javascript:show_hide(1)\"><b>форму</b></a> или на странице \"<a href=\"http://wm-rb.net/user_check_demand.aspx\"><b>Проверка заявки</b></a>\"<br />";
						}
						if ($demand_info[0]['output'] == "RBK Money"){
						echo "&bull; Оплачивайте указанную сумму на счет <b>RBK Money {$purse[0]['purse']}</b>, в примечании к платежу обязательно указать номер заявки, после оплаты сообщить через <a href=\"javascript:show_hide(1)\"><b>форму</b></a> или на странице \"<a href=\"http://wm-rb.net/user_check_demand.aspx\"><b>Проверка заявки</b></a>\"<br />";
						}
						}*/
						echo "</div>
</div>
<br /><br />
                   <table width=\"400\" border=\"0\" cellspacing=\"0\" cellpadding=\"10\" bgColor=\"#ebebeb\" class=\"form_bord\">
                      <tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"center\" class=\"text\"><font color=\"#2d496e\"><b>Заявка  № {$demand_info[0]['did']}</b></font></td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>Статус :</b>&nbsp;</td>
                        <td align=\"left\">";
switch ($demand_info[0]['status']) :

	case ("n") :
echo "<font color=\"#FF0000\"><b>Не оплачена</b></font>";
	break;
	case ("yn") :
echo "<font color=\"#0000FF\"><b>Оплачена</b></font>";
	break;
	case ("y") :
echo "<font color=\"#008000\"><b>Выполнена</b></font>";
	break;
	case ("er") :
echo "<font color=\"#CC0000\"><b>ОШИБКА</b></font>";
	break;
	default:
endswitch;

						echo "</td>
                      </tr>";
                      if (!empty($demand_info[0]['coment']) && $demand_info[0]['status'] != 'y') { echo "<tr bgColor=\"#ffffff\">
                        <td colspan=\"2\" align=\"left\" class=\"text\"><font color=\"red\"><b>Комментарий : </b></font><span class=\"text_log\">{$demand_info[0]['coment']}</span></td>
                      </tr>";
					  }
                      echo "
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>Отправляете :</b>&nbsp;</td>
                        <td align=\"left\">
						{$demand_info[0]['in_val']} {$cur_in_info_out[0]['desc_val']}
                        </td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\"><b>Получаете :</b>&nbsp;</td>
                        <td align=\"left\" height=\"4\">{$demand_info[0]['out_val']} BYR
                        </td>";
if(empty($demand_info[0]['period'])) {
					  echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>Номер карт-счета :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]['card']}
                        </td>
						</tr>";
} else {
					  echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>Номер карты :</b>&nbsp;<br>
                        </td>
                        <td align=\"left\">{$demand_info[0]['card']}
                        </td>
						</tr>
					  <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>Срок действия :</b>&nbsp;<br>
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
                        <td align=\"right\"><b>Дата платежа :</b>&nbsp;<br>
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
