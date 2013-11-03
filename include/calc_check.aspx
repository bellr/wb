<script language='JavaScript'>
<!--
<?
echo "function ConditionsDisc(val) {sd='{$sd}'; disc='0';";
if(!empty($sel_d)) {echo "d = document.getElementById('discont');";
	foreach($sel_d as $ar) {
		$size_d = 1 + $ar[size_d]/100;
		echo "
		if(val > {$ar[amount]}) {sd='{$size_d}'; disc='{$ar[size_d]}';}";
	}
	echo "
	if(disc>0) {d.style.display = 'block'; d.innerHTML = 'Ваша скидка '+disc+'%'; disc=0;}
	else {d.style.display = 'none';}
	";
}
echo "

return sd;}";
if ($u[0]["direct"] == 'y') {
		echo "
function show() {
	wm_kom = Math.ceil(document.form_exch.in_val.value*(1+{$com_seti})*100)/100;
	document.getElementById('kom_08').innerHTML = wm_kom;
}
function i_o(is_true) {
	in_v= Math.round(document.form_exch.in_val.value*100 )/100;
	out_val = Math.round(in_v*{$u[0]["konvers"]}*100)/100;
	sd = ConditionsDisc(out_val);
	document.form_exch.out_val.value = Math.round(in_v*{$u[0]["konvers"]}*sd*100)/100;
	if(is_true) {o_i();}
	show();
}

function  o_i(is_true) {
	out_1 = Math.round(document.form_exch.out_val.value*100)/100;
	sd = ConditionsDisc(out_1);
	document.form_exch.in_val.value = Math.round(out_1/{$u[0]["konvers"]}/sd*100)/100;
	if (is_true) {i_o();}
	show();
}";
}

if ($u[0]["direct"] == 'n') {
echo "
function show() {
wm_kom = Math.ceil(document.form_exch.in_val.value*(1+{$com_seti})*100)/100;
document.getElementById('kom_08').innerHTML = wm_kom;
}

function i_o(is_true) {
	in_v= Math.round(document.form_exch.in_val.value*100)/100;
	sd = ConditionsDisc(Math.floor(in_v/{$u[0]["konvers"]}*100)/100);
	document.form_exch.out_val.value = Math.floor(in_v/{$u[0]["konvers"]}*sd*100)/100;
  if(is_true) {o_i();}
  show();
}

function  o_i(is_true)
{
	out_1 = Math.round(document.form_exch.out_val.value*100)/100;
	sd = ConditionsDisc(out_1);
	sum_in = Math.ceil(out_1*{$u[0]["konvers"]}/sd*100)/100;
	document.form_exch.in_val.value = Math.round(sum_in*100)/100;
show();
}";
}

echo "
function Check() {

if (parseFloat(document.form_exch.out_val.value) > {$balance}) {
alert('Вы превысили доступную сумму для обмена');
document.form_exch.out_val.focus();
return false;
}";
if($input == 'EasyPay') {
echo "
if (parseFloat(document.form_exch.out_val.value) < 100) {
alert('Минимальная сумма обмена 100 руб.');
document.form_exch.out_val.focus();
return false;
}";
}
echo "
if (document.form_exch.in_val.value <= 0 && document.form_exch.in_val.value <= '0') {
alert('Вы не ввели сумму для перевода');
document.form_exch.in_val.focus();
return false;
}
if (document.form_exch.out_val.value <= 0 && document.form_exch.out_val.value <= '0') {
alert('Вы не ввели получаемую сумму');
document.form_exch.out_val.focus();
return false;
}";

$Constructor->check_js($output,$input);
echo "
if (!document.form_exch.email.value.match('^([a-zA-Z0-9\.\ \_\-])+@([a-zA-Z0-9\.\-])+(.([a-zA-Z])+)+$')) {
alert('E-Mail указан не верно');
document.form_exch.email.focus();
return false;
}
if (!document.form_exch.rules.checked) {
alert('Вам необходимо ознакомиться и согласиться с правилами и условиями обмена');
document.form_exch.rules.focus();
return false;
}
return true;
}

"; ?>
// -->
</script>