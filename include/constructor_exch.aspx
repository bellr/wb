<?

class Constructor {

    function check_js($output,$input) {

        switch ($output) :
            case ("RBK Money") :
                echo "if (!document.form_exch.p_output.value.match('^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-mail RBKmoney указан не верно');
document.form_exch.p_output.focus();
return false;
}";
                break;
            case ("EasyPay") :
                echo "if (!document.form_exch.p_output.value.match('^[0-9]{8}$')) {
alert('EasyPay счет указан не верно');
document.form_exch.p_output.focus();
return false;
}";
                break;
            case ("YaDengi") :
                echo "if (!document.form_exch.p_output.value.match('^[0-9]{13}$') && !document.form_exch.p_output.value.match('^[0-9]{14}$')) {
alert('Yandex.Money счет указан не верно');
document.form_exch.p_output.focus();
return false;
}";
                break;
            default:
        endswitch;

        switch ($input) :
            case ("WMZ") :
                echo "if (!document.form_exch.p_input.value.match('^[Z,z]{1}[0-9]{12}$')) {
alert('Z-кошелек указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("WMR") :
                echo "if (!document.form_exch.p_input.value.match('^[R,r]{1}[0-9]{12}$')) {
alert('R-кошелек указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("WME") :
                echo "if (!document.form_exch.p_input.value.match('^[E,e]{1}[0-9]{12}$')) {
alert('E-кошелек указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("WMG") :
                echo "if (!document.form_exch.p_input.value.match('^[G,g]{1}[0-9]{12}$')) {
alert('G-кошелек указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("WMU") :
                echo "if (!document.form_exch.p_input.value.match('^[U,u]{1}[0-9]{12}$')) {
alert('U-кошелек указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("WMY") :
                echo "if (!document.form_exch.p_input.value.match('^[Y,y]{1}[0-9]{12}$')) {
alert('Y-кошелек указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("WMB") :
                echo "if (!document.form_exch.p_input.value.match('^[B,b]{1}[0-9]{12}$')) {
alert('B-кошелек указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("RBK Money") :
                echo "if (!document.form_exch.p_input.value.match('^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-mail RBKmoney указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("EasyPay") :
                echo "if (!document.form_exch.p_input.value.match('^[0-9]{8}$')) {
alert('EasyPay счет указан не верно');
document.form_exch.p_input.focus();
return false;
}
if (parseFloat(document.form_exch.out_val.value) > 2950000) {
alert('Вы превысили доступную сумму для одной транзакции. Максимальная сумма - 2 950 000 рулей.');
document.form_exch.out_val.focus();
return false;
}
";
                break;
            case ("YaDengi") :
                echo "if (!document.form_exch.p_input.value.match('^[0-9]{13}$') && !document.form_exch.p_input.value.match('^[0-9]{14}$')) {
alert('Yandex.Money счет указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            case ("Z-PAYMENT") :
                echo "if (!document.form_exch.p_input.value.match('^[ZP,zp]{2}[0-9]{8}$')) {
alert('ZP-кошелек указан не верно');
document.form_exch.p_input.focus();
return false;
}";
                break;
            default:
        endswitch;
    }

    function check_uslugi($oplata) {

        switch ($oplata) :
            case ("RBK Money") :
                echo "if (!document.check_demand.p_output.value.match('^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-mail RBKmoney указан не верно');
document.check_demand.p_output.focus();
return false;
}";
                break;
            case ("EasyPay") :
                echo "if (!document.check_demand.p_output.value.match('^[0-9]{8}$')) {
alert('EasyPay счет указан не верно');
document.check_demand.p_output.focus();
return false;
}";
                break;
            case ("YaDengi") :
                echo "if (!document.check_demand.p_output.value.match('^[0-9]{13}$') && !document.check_demand.p_output.value.match('^[0-9]{14}$')) {
alert('Yandex.Money счет указан не верно');
document.check_demand.p_output.focus();
return false;
}";
                break;
            default:
        endswitch;
    }

    function check_inside_input($usluga) {
        if ($usluga == "BF" || $usluga == "BF15" || $usluga == "BF16" || $usluga == "BF17" || $usluga == "BF21" || $usluga == "BF22" || $usluga == "BF23") {$usluga = "ByFlyBel";}
        //if ($usluga == "TEL" || $usluga == "TEL17" || $usluga == "TEL15" || $usluga == "TEL16" || $usluga == "TEL21" || $usluga == "TEL22" || $usluga == "TEL022" || $usluga == "TEL23") {$usluga = "Beltelecom";}
        switch ($usluga) :
            case ("ByFlyBel") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{13}$')) {
alert('Номер договора указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("ATLANT") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{7}$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("BIN") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{6}$')) {
alert('Номер контракта указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("DSET") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер контракта указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("SOLO") :
                echo "if (!document.check_demand.pole1.value.match('^[a-zA-Z0-9\ \_\-]{6}$')) {
alert('Номер договора указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("TcmBY") :
                echo "if (!document.check_demand.pole1.value.match('^[a-zA-Z0-9\ \_\-]{7}$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("AchinaPlus") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("ShaparkiDamavik") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("ANITEX") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер договора указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("IPT") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
            case ("Beros") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("STStelekom") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер контракта указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("SFERATV") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер контракта указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("SERVER") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Логин указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("NTPP") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("NTTO") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("NTTVAP") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("NTTVPP") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("NOSTRA") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("MTIS") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер договора указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("GLEL") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("ALTOLAN") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер договора указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("VELCOM") :
                echo "if (!document.check_demand.wmid.value.match('^[0-9]{12}$')) {
alert('WMID указан не верно');
document.check_demand.wmid.focus();
return false;
}
if (!document.check_demand.pole1.value.match('^[0-9]{7}$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("MTS") :
                echo "if (!document.check_demand.wmid.value.match('^[0-9]{12}$')) {
alert('WMID указан не верно');
document.check_demand.wmid.focus();
return false;
}
if (!document.check_demand.pole1.value.match('^[0-9]{7}$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("LIFE") :
                echo "if (!document.check_demand.wmid.value.match('^[0-9]{12}$')) {
alert('WMID указан не верно');
document.check_demand.wmid.focus();
return false;
}
if (!document.check_demand.pole1.value.match('^[0-9]{7}$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("Dialog") :
                echo "if (!document.check_demand.wmid.value.match('^[0-9]{12}$')) {
alert('WMID указан не верно');
document.check_demand.wmid.focus();
return false;
}
if (!document.check_demand.pole1.value.match('^[0-9]{7}$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("TEL") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{9}+$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";	break;
            case ("TEL17") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{9}+$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";	break;
            case ("TEL15") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{7}+$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";	break;
            case ("TEL16") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{7}+$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";	break;
            case ("TEL21") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{7}+$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";	break;
            case ("TEL22") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{7}+$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";	break;
            case ("TEL022") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{7}+$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";	break;
            case ("TEL23") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]{7}+$')) {
alert('Номер телефона указан не верно');
document.check_demand.pole1.focus();
return false;
}";	break;
            case ("KTV") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер контракта указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("TVSAT") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер договора указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("TMEDIA21") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("ZKH") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("VODA") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("GAZ") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("ZKH16") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("ZKH21") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("ZKH22") :
                echo "if (!document.check_demand.pole1.value.match('^[0-9]+$')) {
alert('Номер лицевого счета указан не верно');
document.check_demand.pole1.focus();
return false;
}";
                break;
            case ("bpsb") :
                echo "if (!document.check_demand.number_card.value.match('^[0-9]{16}$')) {
alert('Номер карты указан не верно');
document.check_demand.number_card.focus();
return false;
}
if (!document.check_demand.period.value.match('^[0-9]{4}$')) {
alert('Срок действия карты указан не верно');
document.check_demand.period.focus();
return false;
}";
                break;
            case ("belbank") :
                echo "if (!document.check_demand.number_card.value.match('^[0-9]{16}$')) {
alert('Номер карты указан не верно');
document.check_demand.number_card.focus();
return false;
}
if (!document.check_demand.period.value.match('^[0-9]{4}$')) {
alert('Срок действия карты указан не верно');
document.check_demand.period.focus();
return false;
}";
            case ("deltabank") :
                echo "if (!document.check_demand.number_card.value.match('^[0-9]{8}$')) {
alert('Номер карт-счета');
document.check_demand.number_card.focus();
return false;
}";

                break;
            case ("CARDUSD") :
                echo "if (!document.check_demand.number_card.value.match('^[0-9]{16}$')) {
alert('Номер карты указан не верно');
document.check_demand.number_card.focus();
return false;
}
if (!document.check_demand.period.value.match('^[0-9]{4}$')) {
alert('Срок действия карты указан не верно');
document.check_demand.period.focus();
return false;
}";
                break;
            default:
        endswitch;
    }
    function check_info_user() {
        echo "if (!document.check_demand.wmid.value.match('^[0-9]{12}$')) {
alert('WMID указан не верно');
document.check_demand.wmid.focus();
return false;
}
if (!document.check_demand.user_surname.value.match('^[a-zA-Zа-яА-Я]+$')) {
alert('Фамилия указана не верно');
document.check_demand.user_surname.focus();
return false;
}
if (!document.check_demand.user_name.value.match('^[a-zA-Zа-яА-Я]+$')) {
alert('Имя указано не верно');
document.check_demand.user_name.focus();
return false;
}
if (!document.check_demand.name_bank.value.match('^[a-zA-Zа-яА-Я,\"]+$')) {
alert('Название банка указано не верно');
document.check_demand.name_bank.focus();
return false;
}";
    }
    function check($output,$input,$purse_cook_out,$purse_cook_in,$wmid) {
        //$output_cook = "purse_".$output;
        $input_cook = "purse_".$input;
        switch ($output) :
            case ("RBK Money") :
                echo "<td align=\"right\">RBK Money E-mail :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_output\" id=\"p_output\" value=\"".$purse_cook_out."\" size=\"17\">";
                break;
            case ("EasyPay") :
                echo "<td align=\"right\">Ваш EasyPay счет :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_output\" id=\"p_output\" maxlength=\"8\" value=\"".$purse_cook_out."\" size=\"14\">";
                break;
            case ("YaDengi") :
                echo "<td align=\"right\">Ваш Yandex.Money счет :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_output\" id=\"p_output\" maxlength=\"14\" value=\"".$purse_cook_out."\" size=\"17\">";
                break;
            default:
        endswitch;

        switch ($input) :
            case ("WMZ") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\">Ваш Z-кошелек :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" maxlength=\"13\" size=\"14\" value=\""; if($input == "WMZ") echo $purse_cook_in; else echo "Z"; echo "\"></td>
</tr>";
                break;
            case ("WMR") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">R-кошелек :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" maxlength=\"13\" size=\"14\" value=\""; if($input == "WMR") echo $purse_cook_in; else echo "R"; echo "\"></td>
</tr>";
                break;
            case ("WME") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">E-кошелек :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" maxlength=\"13\" size=\"14\" value=\""; if($input == "WME") {echo $purse_cook_in;} else {echo "E";} echo "\"></td>
</tr>";
                break;
            case ("WMG") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">G-кошелек :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" maxlength=\"13\" size=\"14\" value=\""; if($input == "WMG") echo $purse_cook_in; else echo "G"; echo "\"></td>
</tr>";
                break;
            case ("WMU") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">U-кошелек :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" maxlength=\"13\" size=\"14\" value=\""; if($input == "WMU") echo $purse_cook_in; else echo "U"; echo "\"></td>
</tr>";
                break;
            case ("WMY") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">Y-кошелек :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" maxlength=\"13\" size=\"14\" value=\""; if($input == "WMY") echo $purse_cook_in; else echo "Y"; echo "\"></td>
</tr>";
                break;
            case ("WMB") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">B-кошелек :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" maxlength=\"13\" size=\"14\" value=\""; if($input == "WMB") echo $purse_cook_in; else echo "B"; echo "\"></td>
</tr>";
                break;
            case ("RBK Money") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">RBK Money E-mail :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" value=\"".$purse_cook_in."\" size=\"17\"></td>
</tr>";
                break;
            case ("EasyPay") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">Ваш WMID :&nbsp;<br>
</td>
<td align=\"center\">
	<input type=\"text\" name=\"wmid\" id=\"wmid\" maxlength=\"15\" value=\"".$wmid."\" size=\"14\">
</td>
</tr>
<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">Ваш EasyPay счет :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" value=\"".$purse_cook_in."\" maxlength=\"8\" size=\"14\"></td>
</tr>";
                break;
            case ("YaDengi") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
	<td align=\"right\">Ваш Yandex.Money счет :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" value=\"".$purse_cook_in."\" maxlength=\"14\" size=\"17\"></td>
</tr>";
                break;
            case ("Z-PAYMENT") :
                echo "<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\">Ваш ZP-кошелек :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"p_input\" id=\"p_input\" maxlength=\"10\" size=\"11\" value=\""; if($input == "Z-PAYMENT") echo $purse_cook_in; else echo "ZP"; echo "\" ></td>
</tr>";
                break;
            default:
        endswitch;
    }

    function inside_input($usluga,$pole1,$pole2) { global $_COOKIE;
        if ($usluga == "BF" || $usluga == "BF15" || $usluga == "BF16" || $usluga == "BF17" || $usluga == "BF21" || $usluga == "BF22" || $usluga == "BF23") {$usluga = "ByFlyBel";}
        //if ($usluga == "TEL" || $usluga == "TEL17" || $usluga == "TEL15" || $usluga == "TEL16" || $usluga == "TEL21" || $usluga == "TEL22" || $usluga == "TEL022" || $usluga == "TEL23") {$usluga = "Beltelecom";}

        switch ($usluga) :
            case ("ByFlyBel") :
                echo "
<td align=\"right\">№ договора ByFly :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"13\" size=\"14\">";
                break;
            case ("ATLANT") :
                echo "
<td align=\"right\">Номер л/с :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"14\">";
                break;
            case ("BIN") :
                echo "
<td align=\"right\">№ контракта :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"6\" size=\"14\">";
                break;
            case ("DSET") :
                echo "
<td align=\"right\">№ контракта :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"6\" size=\"14\">";
                break;
            case ("SOLO") :
                echo "
<td align=\"right\">№ договора :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"6\" size=\"14\">";
                break;
            case ("TcmBY") :
                echo "
<td align=\"right\">Номер телефона :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("NetSys") :
                echo "
<td align=\"right\">Уникальный индефикатор (UID) :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("AchinaPlus") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("ShaparkiDamavik") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("ANITEX") :
                echo "
<td align=\"right\">Номер контракта :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("IPT") :
                echo "
<td align=\"right\">Номер счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("Beros") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("STStelekom") :
                echo "
<td align=\"right\">Номер контракта :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("SFERATV") :
                echo "
<td align=\"right\">Номер контракта :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("SERVER") :
                echo "
<td align=\"right\">Ваш логин :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("NTPP") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("NTTO") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("NTTVAP") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("NTTVPP") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("NOSTRA") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("MTIS") :
                echo "
<td align=\"right\">Номер договора :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("GLEL") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("ALTOLAN") :
                echo "
<td align=\"right\">Номер договора :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("VELCOM") :
                echo "
<td align=\"right\">Ваш WMID :&nbsp;<br>
</td>
<td align=\"center\">
<input name=\"wmid\" id=\"wmid\" maxlength=\"12\" value=\"".$_COOKIE['uslugi_wmid']."\" size=\"13\" type=\"text\">
</td></tr>
<tr class=\"text\" bgcolor=\"#ffffff\">
<td align=\"right\">Номер телефона :&nbsp;<br>
</td>
<td align=\"center\">
		<select name=\"pole2\"  id=\"pole2\" >
			<option value=\"29\" selected=\"selected\">029</option>
			<option value=\"44\">044</option>
		</select>
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\">";
                break;
            case ("MTS") :
                echo "
<td align=\"right\">Ваш WMID :&nbsp;<br>
</td>
<td align=\"center\">
<input name=\"wmid\" id=\"wmid\" maxlength=\"12\" value=\"".$_COOKIE['uslugi_wmid']."\" size=\"13\" type=\"text\">
</td></tr>
<tr class=\"text\" bgcolor=\"#ffffff\">
<td align=\"right\">Номер телефона :&nbsp;<br>
</td>
<td align=\"center\">
		<select name=\"pole2\"  id=\"pole2\" >
			<option value=\"29\" selected=\"selected\">029</option>
			<option value=\"33\">033</option>
		</select>
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\">";
                break;
            case ("LIFE") :
                echo "
<td align=\"right\">Ваш WMID :&nbsp;<br>
</td>
<td align=\"center\">
<input name=\"wmid\" id=\"wmid\" maxlength=\"12\" value=\"".$_COOKIE['uslugi_wmid']."\" size=\"13\" type=\"text\">
</td></tr>
<tr class=\"text\" bgcolor=\"#ffffff\">
<td align=\"right\">Номер телефона :&nbsp;<br>
</td>
<td align=\"center\">025 -
<input type=\"hidden\" name=\"pole2\"  value=\"25\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\">";
                break;
            case ("Dialog") :
                echo "
<td align=\"right\">Ваш WMID :&nbsp;<br>
</td>
<td align=\"center\">
<input name=\"wmid\" id=\"wmid\" maxlength=\"12\" value=\"".$_COOKIE['uslugi_wmid']."\" size=\"13\" type=\"text\">
</td></tr>
<tr class=\"text\" bgcolor=\"#ffffff\">
<td align=\"right\">Номер телефона :&nbsp;<br>
</td>
<td align=\"center\">29 -
<input type=\"hidden\" name=\"pole2\"  value=\"29\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\">";
                break;
            case ("TEL") :
                echo "
<td align=\"right\">Номер телефона:&nbsp;<br>
</td>
<td align=\"center\"><input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"9\" size=\"10\"><br />
<div align=\"left\"><small><b>г.Минск</b> - номер телефона<br />
<b>область:</b> две последних цифры кода региона + номер телефона</small></div>";
                break;
            case ("TEL17") :
                echo "
<td align=\"right\">Номер телефона:&nbsp;<br>
</td>
<td align=\"center\"><input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"9\" size=\"10\"><br />
<div align=\"left\"><small><b>г.Минск</b> - номер телефона<br />
<b>область:</b> две последних цифры кода региона + номер телефона</small></div>";
                break;
            case ("TEL15") :
                echo "
<td align=\"right\">Номер телефона:&nbsp;<br>
</td>
<td align=\"center\"><input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\"><br />
<div align=\"left\"><small><b>областной центр:</b> 2 + номер телефона<br />
<b>районные центры:</b> две последних цифры кода региона + номер телефона</small></div>";
                break;
            case ("TEL16") :
                echo "
<td align=\"right\">Номер телефона:&nbsp;<br>
</td>
<td align=\"center\"><input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\"><br />
<div align=\"left\"><small><b>областной центр:</b> 2 + номер телефона<br />
<b>районные центры:</b> две последних цифры кода региона + номер телефона</small></div>";
                break;
            case ("TEL21") :
                echo "
<td align=\"right\">Номер телефона:&nbsp;<br>
</td>
<td align=\"center\"><input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\"><br />
<div align=\"left\"><small><b>областной центр:</b> 2 + номер телефона<br />
<b>районные центры:</b> две последних цифры кода региона + номер телефона</small></div>";
                break;
            case ("TEL22") :
                echo "
<td align=\"right\">Номер телефона:&nbsp;<br>
</td>
<td align=\"center\"><input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\"><br />
<div align=\"left\"><small><b>областной центр:</b> 2 + номер телефона<br />
<b>районные центры:</b> две последних цифры кода региона + номер телефона</small></div>";
                break;
            case ("TEL022") :
                echo "
<td align=\"right\">Номер телефона:&nbsp;<br>
</td>
<td align=\"center\"><input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\"><br />
<div align=\"left\"><small><b>областной центр:</b> 2 + номер телефона<br />
<b>районные центры:</b> две последних цифры кода региона + номер телефона</small></div>";
                break;
            case ("TEL23") :
                echo "
<td align=\"right\">Номер телефона:&nbsp;<br>
</td>
<td align=\"center\"><input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"7\" size=\"8\"><br />
<div align=\"left\"><small><b>областной центр:</b> 2 + номер телефона<br />
<b>районные центры:</b> две последних цифры кода региона + номер телефона</small></div>";
                break;
            case ("KTV") :
                echo "
<td align=\"right\">Номер контракта :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("TVSAT") :
                echo "
<td align=\"right\">Номер договора :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("TMEDIA21") :
                echo "
<td align=\"right\">Номер лиц. счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"20\" size=\"14\">";
                break;
            case ("ZKH") :
                echo "
<td align=\"right\">Номер л/с :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("VODA") :
                echo "
<td align=\"right\">Номер л/с :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("GAZ") :
                echo "
<td align=\"right\">Номер л/с :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("ZKH16") :
                echo "
<td align=\"right\">Номер л/с :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("ZKH21") :
                echo "
<td align=\"right\">Номер л/с :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("ZKH22") :
                echo "
<td align=\"right\">Номер л/с :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"pole1\" id=\"pole1\" value=\"".$pole1."\" maxlength=\"18\" size=\"14\">";
                break;
            case ("bpsb") :
                echo "
<td align=\"right\">Номер карты :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"number_card\" id=\"name_card\" value=\"".$pole1."\" maxlength=\"16\" size=\"17\" onmouseover=\"javascript:showTitle('n_card');\" onmouseout=\"javascript:hideTitle('n_card');\">
<div id=\"n_card\" class=\"atl\" style=\"display:none; POSITION: absolute;\">Пример: 111122223333</div>
</td></tr>
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\">Срок действия :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"period\" id=\"period\" maxlength=\"4\" size=\"4\" value=\"".$pole2."\"  onmouseover=\"javascript:showTitle('t_period');\" onmouseout=\"javascript:hideTitle('t_period');\">
<div id=\"t_period\" class=\"atl\" style=\"display:none; POSITION: absolute;\">Пример: 0912</div>";
                break;
            case ("CARDUSD") :
                echo "
<td align=\"right\">Номер карты :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"number_card\" id=\"name_card\" value=\"".$pole1."\" maxlength=\"16\" size=\"17\" onmouseover=\"javascript:showTitle('n_card');\" onmouseout=\"javascript:hideTitle('n_card');\">
<div id=\"n_card\" class=\"atl\" style=\"display:none; POSITION: absolute;\">Пример: 111122223333</div>
</td></tr>
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\">Срок действия :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"period\" id=\"period\" maxlength=\"4\" size=\"4\" value=\"".$pole2."\"  onmouseover=\"javascript:showTitle('t_period');\" onmouseout=\"javascript:hideTitle('t_period');\">
<div id=\"t_period\" class=\"atl\" style=\"display:none; POSITION: absolute;\">Пример: 0912</div>";
                break;
            case ("belbank") :
                echo "
<script language='JavaScript'>
<!--
function showTitle(element) {
	document.getElementById(element).style.display = 'block';
}
function hideTitle(element) {
document.getElementById(element).style.display = 'none';
}
// -->
</script>
<td align=\"right\">Номер карты :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"number_card\" id=\"name_card\" maxlength=\"16\" value=\"".$pole1."\" size=\"17\" onmouseover=\"javascript:showTitle('n_card');\" onmouseout=\"javascript:hideTitle('n_card');\">
<div id=\"n_card\" class=\"atl\" style=\"display:none; POSITION: absolute;\">Пример: 111122223333</div>
</td></tr>
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\">Срок действия :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"period\" id=\"period\" value=\"".$pole2."\" maxlength=\"4\" size=\"4\" onmouseover=\"javascript:showTitle('t_period');\" onmouseout=\"javascript:hideTitle('t_period');\">
<div id=\"t_period\" class=\"atl\" style=\"display:none; POSITION: absolute;\">Пример: 0912</div>";
                break;
            case ("deltabank") :
                echo "
<td align=\"right\">Номер карт-счета :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"number_card\" id=\"name_card\" value=\"".$pole1."\" maxlength=\"8\" size=\"9\" onmouseover=\"javascript:showTitle('n_card');\" onmouseout=\"javascript:hideTitle('n_card');\">
<div id=\"n_card\" class=\"atl\" style=\"display:none; POSITION: absolute;\">Пример: ХХХХХХХХ, где Х - цифра</div>
</td></tr>";
                break;
            default:
        endswitch;
    }
//Вставка полей для ввода инфы пользователей, для дальнейшей проверки
    function info_card($wmid,$user_surname,$user_name,$name_bank) {
        echo "<td align=\"right\">Ваш WMID :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"wmid\" id=\"wmid\" maxlength=\"12\" value=\"".$wmid."\" size=\"13\">
</td></tr>
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\">Фамилия :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"user_surname\" id=\"user_surname\" value=\"".$user_surname."\" maxlength=\"32\" size=\"20\"
onmouseover=\"javascript:showTitle('user_info');\" onmouseout=\"javascript:hideTitle('user_info');\">
</td></tr>
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\">Имя :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"user_name\" id=\"user_name\" value=\"".$user_name."\" maxlength=\"32\" size=\"20\"
onmouseover=\"javascript:showTitle('user_info');\" onmouseout=\"javascript:hideTitle('user_info');\">
</td></tr>
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\">Название банка :&nbsp;<br>
</td>
<td align=\"center\">
<input type=\"text\" name=\"name_bank\" id=\"name_bank\" value=\"".$name_bank."\" maxlength=\"32\" size=\"20\" onmouseover=\"javascript:showTitle('user_info');\" onmouseout=\"javascript:hideTitle('user_info');\">
<div id=\"user_info\" class=\"report\" style=\"display:none; POSITION: absolute; width: 250px;\">Вводите данные в соответствии с введенными данными на сервере центра аттестации.</div>
";
    }
    function disp_nal_uslugi($disp_var) {

        switch ($disp_var) :

            case ("NAL") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш EasyPay счет :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_out}
</td>
</tr>";
                break;
            case ("uslugi") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш Yandex.Money счет :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_out}
</td>
</tr>";
                break;
            default:
        endswitch;

    }

    function demand($output,$input,$purse_out,$purse_in) {

        switch ($output) :
            case ("RBK Money") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш RBK Money счет :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_out}
</td>
</tr>";
                break;
            case ("EasyPay") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш EasyPay счет :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_out}
</td>
</tr>";
                break;
            case ("YaDengi") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш Yandex.Money счет :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_out}
</td>
</tr>";
                break;
            default:
        endswitch;

        switch ($input) :

            case ("WMZ") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш Z-кошелек :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("WMR") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>R-кошелек :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("WME") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>E-кошелек :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("WMG") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>G-кошелек :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("WMU") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>U-кошелек :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("WMY") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Y-кошелек :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("WMB") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>B-кошелек :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("RBK Money") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш RBK Money E-mail :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("EasyPay") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш EasyPay счет :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            case ("YaDengi") :
                echo "
<tr class=\"text\" bgColor=\"#ffffff\">
<td align=\"right\"><b>Ваш Yandex.Money счет :</b>&nbsp;<br>
</td>
<td align=\"left\">{$purse_in}
</td>
</tr>";
                break;
            default:
        endswitch;
    }

    function demand_sevices($name_uslugi) {
        if ($name_uslugi == "BF" || $name_uslugi == "BF15" || $name_uslugi == "BF16" || $name_uslugi == "BF17" || $name_uslugi == "BF21" || $name_uslugi == "BF22" || $name_uslugi == "BF23") {$name_uslugi = "ByFlyBel";}
        if ($name_uslugi == "TEL" || $name_uslugi == "TEL17" || $name_uslugi == "TEL15" || $name_uslugi == "TEL16" || $name_uslugi == "TEL21" || $name_uslugi == "TEL22" || $name_uslugi == "TEL022" || $name_uslugi == "TEL23") {$name_uslugi = "Beltelecom";}
        switch ($name_uslugi) :
            case ("ATLANT") :
                echo "Номер лиц. счета :";	break;
            case ("Beltelecom") :
                echo "Номер телефона :";	break;
            case ("ByFlyBel") :
                echo "Номер договора ByFly : ";	break;
            case ("BIN") :
                echo "Номер контракта : ";	break;
            case ("DSET") :
                echo "Номер контракта : ";	break;
            case ("SOLO") :
                echo "Номер договора : ";	break;
            case ("TcmBY") :
                echo "Номер телефона : ";	break;
            case ("NetSys") :
                echo "Уникальный индефикатор (UID) : ";	break;
            case ("AchinaPlus") :
                echo "Номер лиц. счета : ";	break;
            case ("ShaparkiDamavik") :
                echo "Номер лиц. счета : ";	break;
            case ("ANITEX") :
                echo "Номер контракта : ";	break;
            case ("IPT") :
                echo "Номер счета : ";	break;
            case ("Beros") :
                echo "Номер лиц. счета : ";	break;
            case ("STStelekom") :
                echo "Номер контракта : ";	break;
            case ("SFERATV") :
                echo "Номер контракта : ";	break;
            case ("SERVER") :
                echo "Логин : ";	break;
            case ("NTPP") :
                echo "Номер лицевого счета : ";	break;
            case ("NTTO") :
                echo "Номер лицевого счета : ";	break;
            case ("NTTVAP") :
                echo "Номер лицевого счета : ";	break;
            case ("NTTVPP") :
                echo "Номер лицевого счета : ";	break;
            case ("NOSTRA") :
                echo "Номер лицевого счета : ";	break;
            case ("MTIS") :
                echo "Номер договора : ";	break;
            case ("GLEL") :
                echo "Номер лицевого счета : ";	break;
            case ("ALTOLAN") :
                echo "Номер договора : ";	break;
            case ("VELCOM") :
                echo "Номер телефона : ";	break;
            case ("MTS") :
                echo "Номер телефона : ";	break;
            case ("LIFE") :
                echo "Номер телефона : ";	break;
            case ("Dialog") :
                echo "Номер телефона : ";	break;
            case ("KTV") :
                echo "Номер контракта : ";	break;
            case ("TVSAT") :
                echo "Номер договора : ";	break;
            case ("TMEDIA21") :
                echo "Номер лицевого счета : ";	break;
            case ("ZKH") :
                echo "Номер л/с : ";	break;
            case ("VODA") :
                echo "Номер л/с : ";	break;
            case ("GAZ") :
                echo "Номер л/с : ";	break;
            case ("ZKH16") :
                echo "Номер л/с : ";	break;
            case ("ZKH21") :
                echo "Номер л/с : ";	break;
            case ("ZKH22") :
                echo "Номер л/с : ";	break;
            case ("Megashare") :
                echo "Номер заказа : ";	break;
            case ("vkontakte") :
                echo "ID контакта : ";	break;
            default:
        endswitch;
    }

//Параметры автоматической оплаты для обменника
    function ParamertyPayment($output,$input,$in_val,$purse_out,$purse_in,$out_val,$id_pay,$desc_pay,$did,$type_wmid='primary_wmid') {

vsLog::add('appeal by old function - ParamertyPayment');

    }

//Параметры автоматической оплаты услуг
    function Payment_uslugi($output,$purse_out,$out_val,$in_val,$id_pay,$desc_pay,$partner,$did) {
        require("./const.inc.aspx");
        if ($output == "WMZ" || $output == "WMR" || $output == "WME" || $output == "WMG" || $output == "WMU" || $output == "WMY" || $output == "WMB") { $wmt_purse = $output; $output = "WMT";}
        switch ($output) :

            case ("WMT") :
                echo "
					<form method=\"post\" action=\"https://merchant.webmoney.ru/lmi/payment.asp\">
					<input type=\"hidden\" name=\"output\" value=\"{$wmt_purse}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"in_val\" value=\"{$in_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"{$purse_out}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">";
                if($partner != 'shop') {
                    echo "<input type=\"submit\" name=\"usluga_wm\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">"; }
                else {	echo "<input type=\"submit\" name=\"pay_shop\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">";
                }
                echo "</form>";
                break;
            case ("Z-Payment") :
                echo "
					<form method=\"post\" action=\"https://z-payment.ru/merchant.php\">
					<input type=\"hidden\" name=\"output\" value=\"{$output}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"in_val\" value=\"{$in_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"3064\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">";
                if($partner != 'shop') {	echo "<input type=\"submit\" name=\"usluga_wm\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">"; }
                else {	echo "<input type=\"submit\" name=\"pay_shop\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">";
                }
                echo "</form>";
                break;
            case ("EasyPay") :
                $edit_out_val = trim(sprintf("%8.0f ",$out_val));
                $hesh = md5($did.$purse_out.$edit_out_val.$s_k);
                //echo $did."|".$purse_out."|".$edit_out_val."|".$s_k;
//$edit_out_va l= trim(sprintf("%8.0f",$in_val));
                echo "<div align=\"center\" class=\"hidden\" id=\"load\"></div>
	<div class=\"button\" id='submit_check' onclick=\"checkEasyPay('check_pay_service','{$did}','{$hesh}','http://{$_SERVER['HTTP_HOST']}')\" onclick=hide_box(\"load\") style=\"width:200px;\">Проверить оплату</div>";
                break;
            case ("VISA") :
                $signature="GUufL6SHK7ZPIRDGUorsjIXoD8YIUoOc0SmXm";

                $xml="<request>
		<version>1.2</version>
		<result_url>http://www.megashare.by/regok.php?op=ok</result_url>
		<server_url>http://atm.wm-rb.net/nncron/liqpay.aspx</server_url>
		<merchant_id>i7638623293</merchant_id>
		<order_id>$id_pay</order_id>
		<amount>$out_val</amount>
		<currency>USD</currency>
		<description>Translation with cards Visa/MasterCard, ID:$did</description>
		<default_phone></default_phone>
		<pay_way>card</pay_way>
		</request>
		";


                $xml_encoded = base64_encode($xml);
                $lqsignature = base64_encode(sha1($signature.$xml.$signature,1));


                echo("<form action='https://liqpay.com/?do=clickNbuy' method='POST'>
      <input type='hidden' name='operation_xml' value='$xml_encoded' />
      <input type='hidden' name='signature' value='$lqsignature' />
	<input type=\"submit\" name=\"pay_shop\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\">
	</form>");
                break;
            default:
        endswitch;
    }

//Параметры автоматической пополнении карты
    function Payment_cash_out($output,$purse_out,$out_val,$in_val,$id_pay,$desc_pay,$did) {
        require("./const.inc.aspx");
        if ($output == "WMZ" || $output == "WMR" || $output == "WME" || $output == "WMG" || $output == "WMU" || $output == "WMY" || $output == "WMB") { $wmt_purse = $output; $output = "WMT";}
        switch ($output) :

            case ("WMT") :
                echo "
					<form method=\"post\" action=\"https://merchant.webmoney.ru/lmi/payment.asp\">
					<input type=\"hidden\" name=\"output\" value=\"{$wmt_purse}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"in_val\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"{$purse_out}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$in_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"output_NAL\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
                break;
            case ("Z-PAYMENT") :
                echo "
					<form method=\"post\" action=\"https://z-payment.ru/merchant.php\">
					<input type=\"hidden\" name=\"output\" value=\"{$output}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"in_val\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"3064\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$in_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$did}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"output_NAL\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
                break;
            case ("EasyPay") :
                $edit_out_val = trim(sprintf("%8.0f ",$in_val));
                $hesh = md5($did.$purse_out.$edit_out_val.$s_k);
                //echo $did.$purse_out.$edit_out_val.$s_k;
                echo "<div align=\"center\" class=\"hidden\" id=\"load\"></div>
	<div class=\"button\" id='submit_check' onclick=\"checkEasyPay('check_pay_cash_out','{$did}','{$hesh}','http://{$_SERVER['HTTP_HOST']}')\" onclick=hide_box(\"load\") style=\"width:200px;\">Проверить оплату</div>";
                break;
            default:
        endswitch;
    }

//Параметры автоматической оплаты в магазине
    function Payment_eshop($output,$purse_out,$amount,$id_pay,$desc_pay,$partner,$did) {
        require("./const.inc.aspx");
        if ($output == "WMZ" || $output == "WMR" || $output == "WME" || $output == "WMG" || $output == "WMU" || $output == "WMY" || $output == "WMB") { $wmt_purse = $output; $output = "WMT";}
        switch ($output) :

            case ("WMT") :
                echo "
					<form method=\"post\" action=\"https://merchant.webmoney.ru/lmi/payment.asp\">
					<input type=\"hidden\" name=\"output\" value=\"{$wmt_purse}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"{$purse_out}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$amount}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"eshop_pay\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
                break;
            case ("Z-PAYMENT") :
                echo "
					<form method=\"post\" action=\"https://z-payment.ru/merchant.php\">
					<input type=\"hidden\" name=\"output\" value=\"{$output}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"3064\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$amount}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"eshop_pay\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
                break;
            case ("EasyPay") :
                //$edit_out_val = trim(sprintf("%8.0f ",$amount));
                $hesh = md5($did.$amount.$s_k);
                echo "<div align=\"center\" class=\"hidden\" id=\"load\"></div>
	<div class=\"button\" id='submit_check' onclick=\"checkEPHistory('check_pay_eshop','{$did}','{$hesh}','http://{$_SERVER['HTTP_HOST']}')\" onclick=hide_box(\"load\") style=\"width:200px;\">Проверить оплату</div>";
                break;
            default:
        endswitch;
    }


//Параметры автоматической оплаты
    function ParamertyAutoPayment($output,$purse_out,$out_val,$id_pay,$desc_pay,$did) {
        require("./const.inc.aspx");
        if ($output == "WMZ" || $output == "WMR" || $output == "WME" || $output == "WMG" || $output == "WMU" || $output == "WMY" || $output == "WMB") { $wmt_purse = $output; $output = "WMT";}
        switch ($output) :

            case ("WMT") :
//http://atm.wm-rb.net/nncron/exchange_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
                echo "
					<form method=\"post\" action=\"https://merchant.webmoney.ru/lmi/payment.asp\">
					<input type=\"hidden\" name=\"output\" value=\"{$wmt_purse}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"{$did}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"{$purse_out}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"auto_processing\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
                break;
            case ("Z-PAYMENT") :
//https://atm.wm-rb.net/nncron/exchange_pay.aspx
//https://z-payment.ru/merchant.php
                echo "
					<form method=\"post\" action=\"https://z-payment.ru/merchant.php\">
					<input type=\"hidden\" name=\"output\" value=\"{$output}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"did\" value=\"{$did}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYEE_PURSE\" value=\"3064\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_AMOUNT\" value=\"{$out_val}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_NO\" value=\"{$id_pay}\" readonly=\"readonly\">
					<input type=\"hidden\" name=\"LMI_PAYMENT_DESC\" value=\"{$desc_pay}\" readonly=\"readonly\">
					<input type=\"submit\" name=\"auto_processing\" value=\"Оплатить\" style=\"width:100px;
		    \"onmouseover=\"this.style.backgroundColor='#E8E8FF';\" onmouseout=\"this.style.backgroundColor='#f3f7ff';\"
		    id=\"cursor\"></form>";
                break;
            case ("EasyPay") :
                $hesh = md5($did.$purse_out.$out_val.$s_k);
                //echo $did.$purse_out.$out_val.$s_k;
//$edit_out_val = trim(sprintf("%8.0f",$in_val));
                echo "
<div class=\"text\" align=\"left\">
<div class='red'>Внимание!!! Автоматическая проверка оплаты!</div><br />
<blockquote>Следуйте, приведенным ниже, инструкциям.</blockquote><br />
&nbsp;&nbsp;&nbsp;&nbsp;Оплачивайте <b>{$out_val} BYR</b> на счет <b>EasyPay {$purse_out}</b>, в примечании к платежу <u>обязательно</u> указать <u>ТОЛЬКО</u> номер счета <b>{$_POST['did']}</b>. После оплаты вернитесь на эту страницу и нажмите кнопку \"<b>Проверить оплату</b>\" для проверки оплаты и завершения операции. <br />
<br />
</div>
<div align=\"center\" class=\"hidden\" id=\"load\"></div>
	<div class=\"button\" id='submit_check' onclick=\"checkEasyPay('check_cheque_pay','{$_POST['did']}','{$hesh}','http://{$_SERVER['HTTP_HOST']}')\"  onclick=hide_box(\"load\") style=\"width:200px;\">Проверить оплату</div>";
                break;
            default:
        endswitch;
    }
//Параметры автоматической оплаты
    function InstructPay($status,$ex_output,$edit_out_val,&$out_val,$did) {
        global $db_exchange;
        if ($status == "n") {
            if ($ex_output == "EasyPay") {
                $out_val = $edit_out_val;
                $EP_purse = $db_exchange->EP_purse_input($edit_out_val);
                $db_exchange->edit_purse_input($did,$EP_purse[0]['acount']);
                echo "<br /><div class='red'>Внимание!!! Автоматическая проверка оплаты!</div><br />
							<center><b>Следуйте, приведенным ниже, инструкциям.</b></center><br />
						&bull; Оплачивайте <b>".$edit_out_val." BYR</b>  на счет <b>EasyPay {$EP_purse[0]['acount']}</b>, в примечании к платежу обязательно указать <u>ТОЛЬКО</u> номер заявки <b>{$did}</b><br />
						&bull; Для завершения операции вернитесь на эту страницу и подтвердите оплату, нажав на кнопку \"<b>Проверить оплату</b>\".<br />";
            }
            elseif ($ex_output == "YaDengi") {
                echo "&bull; Оплачивайте указанную сумму на счет <b>Yandex.Money {$purse[0]['purse']}</b>, в примечании к платежу обязательно указать номер заявки <b>{$did}</b>, после оплаты сообщить через <a href=\"javascript:show_hide(1)\"><b>форму</b></a> или на странице \"<a href=\"http://wm-rb.net/user_check_demand.aspx\"><b>Проверка заявки</b></a>\"<br />";
            }
            elseif ($ex_output == "RBK Money"){
                echo "&bull; Оплачивайте указанную сумму на счет <b>RBK Money {$purse[0]['purse']}</b>, в примечании к платежу обязательно указать номер заявки <b>{$did}</b>, после оплаты сообщить через <a href=\"javascript:show_hide(1)\"><b>форму</b></a> или на странице \"<a href=\"http://wm-rb.net/user_check_demand.aspx\"><b>Проверка заявки</b></a>\"<br />";
            }
        }
    }
    function InstructService($status,$output,$edit_out_val,&$out_val,$did,$table) {
        global $db_exchange,$db_pay_desk;
        if ($status == "n") {
            if ($output == "EasyPay") {
                $out_val = $edit_out_val;
                $EP_purse = $db_exchange->EP_purse_input($edit_out_val);
                $db_pay_desk->edit_purse_input($did,$EP_purse[0]['acount'],$table);
                echo $table;
                echo "<br /><div class='red'>Внимание!!! Автоматическая проверка оплаты!</div><br />
							<center><b>Следуйте, приведенным ниже, инструкциям.</b></center><br />
						&bull; Оплачивайте <b>".$edit_out_val." BYR</b> на счет <b>EasyPay {$EP_purse[0]['acount']}</b>, в примечании к платежу обязательно указать <u>ТОЛЬКО</u> номер заявки <b>{$did}</b>.<br />
						&bull; Для завершения операции вернитесь на эту страницу и подтвердите оплату, нажав на кнопку \"<b>Проверить оплату</b>\".<br />						";
            }
            if ($output == "YaDengi") {
                echo "&bull; Оплачивайте указанную сумму на счет <b>Yandex.Money {$purse[0]['purse']}</b>, в примечании к платежу обязательно указать номер заявки, после оплаты сообщить через <a href=\"javascript:show_hide(1)\"><b>форму</b></a> или на странице \"<a href=\"http://wm-rb.net/user_check_demand.aspx\"><b>Проверка заявки</b></a>\"<br />";
            }
            if ($output == "RBK Money"){
                echo "&bull; Оплачивайте указанную сумму на счет <b>RBK Money {$purse[0]['purse']}</b>, в примечании к платежу обязательно указать номер заявки, после оплаты сообщить через <a href=\"javascript:show_hide(1)\"><b>форму</b></a> или на странице \"<a href=\"http://wm-rb.net/user_check_demand.aspx\"><b>Проверка заявки</b></a>\"<br />";
            }
        }
    }
}
//https://liqpay.com/?do=clickNbuy
//https://atm.wm-rb.net/nncron/liqpay.aspx
//https://atm.wm-rb.net/nncron/exchange_pay.aspx
//https://atomly.wm-rb.net/nncron/uslugi_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
//https://rupay.com/acceptpurchase.aspx
//https://z-payment.ru/merchant.php
//Параметры автоматической оплаты услуг
?>