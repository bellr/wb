<?
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
$purse = $db_exchange->sel_purse('EasyPay');
$purse_card = $db_pay_desk->exch_value($demand_info[0]['output']);

echo "<br />
<div style=\"display: none;\" id=\"d1\">
<form name=\"check_report\" id=\"check_report\" method=\"post\" action=\"user_check_cash.aspx\" onSubmit=\"return Check_report()\">
	№ заявки : <input type=\"text\" name=\"did\" size=\"12\" maxlength=\"10\" value=\"{$demand_info[0]['did']}\"/>&nbsp;&nbsp;&nbsp;
	<input type=\"submit\" name=\"report_cash\"  value=\"Сообщить\" style=\"width:100px; \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\" id=\"cursor\" />
</form>
</div><br />
<div id=\"report\" align=\"left\">
<div class=\"text\" id=padding>
<div class=\"red\">Инструкции к заявке :</div><br />
						&bull; Неоплаченная заявка действительна в течении <b>12 часов</b><br />
						&bull; Номер заявки отправлен Вам на E-Mail<br />";
						if ($demand_info[0]['status'] == "n") {
switch ($demand_info[0]['output']) :

	case ("pochta") :
		if($demand_info[0]['purse_payment'] == 0) { echo $demand_info[0]["did"];
		$EP_purse = $db_exchange->EP_purse_input($edit_out_val);
		$db_pay_desk->edit_purse_input($demand_info[0]["did"],$EP_purse[0]['acount'],'demand_cash');
		}else {$EP_purse[0]['acount'] = $demand_info[0]['purse_payment'];}

		echo "<br /><div class='red'>Внимание!!! Автоматическая проверка оплаты!</div><br />
			<center><b>Следуйте, приведенным ниже, инструкциям.</b></center><br />

			&bull; Пополните счет <b>EasyPay {$EP_purse[0]['acount']}</b> на сумму <b>".$edit_out." BYR</b> через валютные
кассы и банкоматы Белгазпромбанка и в любом почтовом отделении Белпочта.<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Посмотреть список почтовых отделений, где можно произвести пополнение счета можно на этой <a href=\"https://ssl.easypay.by/input/post_office/\" target=\"_blank\">странице</a>.<br /><br />
			<b>ВНИМАНИЕ!!!</b><br />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>Для завершения операции</u> вернитесь на эту страницу и подтвердите оплату через <a href=\"javascript:show_hide(1)\">форму</a> или на странице \"<a href=\"http://wm-rb.net/user_check_cash.aspx\">Проверка заявки</a>\", иначе заявка не будет рассмотрена.";

	break;
	case ("VISA") :
echo "<div style=\"margin-top:10px;\" class=\"red\">Внимание!!!</div>
	Сейчас вы будете переадресованы на сайт платежной системы liqPAY. Для успешной оплаты следуйте инструкциям, приведенным на сайте платежной системы liqPAY.
";
	break;
	default:
echo "&bull; Оплачивайте указанную сумму на нашу банковскую карту <b>{$purse_card[0]['desc_val']}а {$purse_card[0]['name_card']}</b> (срок действия {$purse_card[0]['period']}) , после оплаты <u>сообщить</u> через <a href=\"javascript:show_hide(1)\"><b>форму</b></a> или на странице \"<a href=\"http://wm-rb.net/user_check_cash.aspx\">Проверка заявки</a>\"<br />";
endswitch;

						}
						echo "</div>
</div>
<br />

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
						{$demand_info[0]['out_val']} BYR
                        </td>
                      </tr>
                      <tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\" height=\"4\"><b>Получаете :</b>&nbsp;</td>
                        <td align=\"left\" height=\"4\">{$demand_info[0]['in_val']} {$cur_in_info[0]['desc_val']}
                        </td>";
						/*
if($demand_info[0]['output'] != "pochta" && $demand_info[0]['output'] != 'VISA') {
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
*/
					  echo "<tr class=\"text\" bgColor=\"#ffffff\">
                        <td align=\"right\"><b>Счет получателя :</b>&nbsp;<br>
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
                        <td align=\"right\"><b>Дата платежа :</b>&nbsp;<br>
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
					   <td colspan=\"2\"><b>Время зачисления платежей :</b><br />
<u>ПН-ПТ</u> (12:00 - 22:00),
<u>СБ-ВС</u> (18:00 - 23:00)<br />
                        </td>
						</tr>";
}
                    echo "</table><br /><br />";
//http://admin.noxpay.su/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
?>
