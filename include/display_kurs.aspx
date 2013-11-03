<?
//$ar_valuta = array("WMZ","WMR","WME","WMG","WMU","WMY","WMB","EasyPay","YaDengi","Z-PAYMENT");
 ?>
<script language='JavaScript'>
<!--
<?
echo "

function show_out() {
	d = document.form_exch.output.value;
	document.getElementById('out_img').innerHTML = '<img src=img/'+d+'.gif width=88 height=31 alt='+d+' />';
	if (document.form_exch.output.value == document.form_exch.input.value) {
		document.getElementById('kurs').innerHTML = '<b>Недопустимое направление</b>';

	}
}";
echo "
function show_in() {
	er = '<b>Недопустимое направление</b>';
	d = document.form_exch.input.value;
	document.getElementById('in_img').innerHTML = '<img src=img/'+d+'.gif width=88 height=31 alt='+d+' />';
switch(d) {";
	foreach($currency as $arr) {
		if($arr[0] == 'Z-Payment') {$arr[0] = 'Z-PAYMENT';}
		echo "
case '{$arr[0]}': ";
$balance = edit_balance($arr['1']);
echo "
document.getElementById('balance').innerHTML = '{$balance} <b>{$arr[2]}</b>';";
echo "
	break;";
	}
	echo "
endswitch;
}

}


function get_kurs() {
	er = '<b>Недопустимое направление</b>';
	var button = document.getElementById('ex_sel');
	direct = document.form_exch.output.value+'_'+document.form_exch.input.value;
switch(direct) {";

foreach($currency as $ar) {
	$arr_direct = $db_exchange->sel_direct($ar[0]);
	foreach($arr_direct as $ar_info) {
echo "
case '{$ar_info[0]}': ";
if($ar_info[2] == "n") echo "document.getElementById('kurs').innerHTML = '{$ar_info[1]} <b>'+document.form_exch.output.value+'</b> = 1 <b>'+document.form_exch.input.value+'</b>';";
if($ar_info[2] == "y") echo "document.getElementById('kurs').innerHTML = '1 <b>'+document.form_exch.output.value+'</b> = {$ar_info[1]} <b>'+document.form_exch.input.value+'</b>';";
echo "
button.disabled = false;
break;
";
	}
}
echo "
default:
	document.getElementById('kurs').innerHTML = er;

	button.disabled = true;
break;
endswitch;
}
}";
?>
// -->
</script>