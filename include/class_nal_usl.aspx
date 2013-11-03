<?

class cons_uslugi {

function name_oper($disp_var,$name_usluga) {
switch ($disp_var) :
	case ("NAL") :
$result = "<b>Пополнение наличными</b>";
	break;
	case ("output_NAL") :
$result = "<b>Пополнение карты {$name_usluga}</b>";
	break;
	case ("uslugi") :
$result = "<b>Оплата услуги :</b> {$name_usluga}";
	break; endswitch;
return $result;
}

function output($disp_var,$oplata) {
switch ($disp_var) :
	case ("NAL") :
$result = "BLR";
	break;
	case ("output_NAL") :
$result = $oplata;
	break;
	case ("uslugi") :
$result = $oplata;
	break; endswitch;
return $result;
}

function input($disp_var,$oplata) {
switch ($disp_var) :
	case ("NAL") :
$result = $oplata;
	break;
	case ("output_NAL") :
$result = "BLR";
	break;
	case ("uslugi") :
$result = "BLR";
	break; endswitch;
return $result;
}
function bal($disp_var,$oplata) {
switch ($disp_var) :
	case ("NAL") :
$result = $oplata;
	break;
	case ("output_NAL") :
$result = $oplata;
	break;
	case ("uslugi") :
$result = $oplata;
	break; endswitch;
return $result;
}

function kurs_n($disp_var,$oplata) {
switch ($disp_var) :
	case ("NAL") :
$result = "NAL_{$oplata}";
	break;
	case ("output_NAL") :
$result = "{$oplata}_NAL";
	break;
	case ("uslugi") :
$result = "{$oplata}_usluga";
	break; endswitch;
return $result;
}
//Название формы отправки в cheak_demand
function name_submit($disp_var) {
switch ($disp_var) :
	case ("NAL") :
$result = "NAL";
	break;
	case ("output_NAL") :
$result = "output_NAL";
	break;
	case ("uslugi") :
$result = "usluga";
	break; endswitch;
return $result;
}
function check_nal_purse($input) {

switch ($input) :
	case ("WMZ") :
		echo "if (!document.check_demand.p_input.value.match('^[Z,z]{1}[0-9]{12}$')) {
alert('Z-кошелек указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("WMR") :
		echo "if (!document.check_demand.p_input.value.match('^[R,r]{1}[0-9]{12}$')) {
alert('R-кошелек указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("WME") :
		echo "if (!document.check_demand.p_input.value.match('^[E,e]{1}[0-9]{12}$')) {
alert('E-кошелек указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("WMG") :
		echo "if (!document.check_demand.p_input.value.match('^[G,g]{1}[0-9]{12}$')) {
alert('G-кошелек указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("WMU") :
		echo "if (!document.check_demand.p_input.value.match('^[U,u]{1}[0-9]{12}$')) {
alert('U-кошелек указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("WMY") :
		echo "if (!document.check_demand.p_input.value.match('^[Y,y]{1}[0-9]{12}$')) {
alert('Y-кошелек указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("WMB") :
		echo "if (!document.check_demand.p_input.value.match('^[B,b]{1}[0-9]{12}$')) {
alert('B-кошелек указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("RBK Money") :
		echo "if (!document.check_demand.p_input.value.match('^([a-zA-Z0-9\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-mail RBK Money указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("EasyPay") :
		echo "if (!document.check_demand.p_input.value.match('^[0-9]{8}$')) {
alert('EasyPay счет указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	case ("YaDengi") :
		echo "if (!document.check_demand.p_input.value.match('^[0-9]{13}$') && !document.check_demand.p_input.value.match('^[0-9]{14}$')) {
alert('Yandex.Money счет указан не верно');
document.check_demand.p_input.focus();
return false;
}";
	break;
	default:
endswitch;
}
}
//<input type=\"hidden\" name=\"eshopAccount\" value=\"{$purse_out}\" readonly=\"readonly\">
//http://atomly.wm-rb.net/nncron/exchange_pay.aspx
//http://atomly.wm-rb.net/nncron/uslugi_pay.aspx
//https://merchant.webmoney.ru/lmi/payment.asp
//https://rupay.com/acceptpurchase.aspx
//Параметры автоматической оплаты услуг

?>