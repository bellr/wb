<script language='JavaScript'>
<!--
function showTitle(element) {
	document.getElementById(element).style.display = 'block';
}
function hideTitle(element) {
document.getElementById(element).style.display = 'none';
}
<?
if ($u[0]["direct"] == 'y') {
	echo "
function show() {
wm_kom = Math.ceil(document.check_demand.in_val.value*(1+{$userinfo[0]["com_seti"]})*100-0.000001)/100;
document.getElementById('kom_08').innerHTML = wm_kom;
}

function i_o(is_true) {

  in_v= Math.round(document.check_demand.in_val.value*100)/100;
  document.check_demand.out_val.value= Math.floor((in_v*{$u[0]["konvers"]}*{$info_card[0]['bonus']}-{$info_card[0]['obligatory_payment']})*100+0.00001)/100;
  /*Math.floor((in_v*{$u[0]["konvers"]}*{$info_card[0]['bonus']})*100+0.00001)/100;*/
  if(is_true) {o_i();}
  show();
}

function  o_i(is_true) {
	/*out_1 = Math.round(document.check_demand.out_val.value*100)/100;*/
 out_1 = Math.round(document.check_demand.out_val.value*100)/100+{$info_card[0]['obligatory_payment']};
 res_inval = Math.round(out_1/{$u[0]["konvers"]}/{$info_card[0]['bonus']}*100-0.00001)/100;
 document.check_demand.in_val.value = res_inval;
 if (is_true) {i_o();}

 show();
}";
}
if ($u[0]["direct"] == 'n') {
	echo "
function show() {
wm_kom = Math.ceil(document.check_demand.in_val.value*(1+{$userinfo[0]["com_seti"]})*100-0.000001)/100;
document.getElementById('kom_08').innerHTML = wm_kom;
}";

echo "
function i_o(is_true)
{

  in_v= Math.round(document.check_demand.in_val.value*100 )/100;
    out_1 = Math.floor(in_v/{$u[0]["konvers"]}*100+0.00001)/100+{$info_card[0]['obligatory_payment']};

   		document.check_demand.out_val.value = Math.round(out_1*100)/100;

  if(is_true) {o_i();}
  show();
}

function  o_i(is_true)
{
 out_1 = Math.round(document.check_demand.out_val.value*100)/100;
    sum_in = Math.ceil(out_1*{$u[0]["konvers"]}*100-0.00001)/100;
   		document.check_demand.in_val.value = Math.round(sum_in*100)/100+{$info_card[0]['obligatory_payment']};
 show();
}";
}
echo "
function Check() {
if (parseFloat(document.check_demand.out_val.value) > {$balance}) {
alert('Вы превысили доступную сумму для обмена');
document.check_demand.out_val.focus();
return false;
}
if (document.check_demand.in_val.value <= 0 && document.check_demand.in_val.value <= '0') {
alert('Вы не ввели сумму для оплаты');
document.check_demand.in_val.focus();
return false;
}
if (document.check_demand.out_val.value <= 0 && document.check_demand.out_val.value <= '0') {
alert('Вы не ввели сумму для оплаты');
document.check_demand.out_val.focus();
return false;
}";
	//if($oplata == "WMZ" || $oplata == "WMR" || $oplata == "WME" || $oplata == "WMG" || $oplata == "WMU" || $oplata == "WMY" || $oplata == "WMB") {$Constructor->check_info_user();}
	echo "
if (parseFloat(document.check_demand.out_val.value) < {$info_card[0]['min_pay']}) {
alert('Сумма пополнения меньше минимальной! Миннимальная сумма - {$info_card[0]['min_pay']} {$us[0]['equiv_cur']}');
document.check_demand.out_val.focus();
return false;
}";

//$Constructor->check_inside_input($usluga);

echo "
if (!document.check_demand.email.value.match('^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-Mail указан не верно');
document.check_demand.email.focus();
return false;
}

if (!document.check_demand.rules.checked) {
alert('Вам необходимо ознакомиться и согласиться с правилами и условиями обмена');
document.check_demand.rules.focus();
return false;
}

}"; ?>
// -->
</script>