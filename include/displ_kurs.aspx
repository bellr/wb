<script language='JavaScript'>
<!--
<?
echo "
function ShowboxPay(summa) {
d = document.form_check.oplata.value;
switch(d) {";
	foreach($currency as $arr) {

$u = $db_exchange->get_kurs($arr[5].'_merch');
		echo "
case '{$arr[5]}': ";
echo "
	kurs = {$u[0]['konvers']};
	amount = Math.round(summa/{$u[0]['konvers']}*100-0.000001)/100;
	document.getElementById('box_kurs').innerHTML = '<b>Для оплаты :</b> '+amount+' '+d;
	document.form_check.summa_pay.value=amount;";
echo "
	break;";
	}
	echo "
endswitch;
}
if(d == 'EasyPay' || d == 'YaDengi') {
 document.getElementById('purse').style.display = 'block';
 document.getElementById('form_purse').innerHTML = '<input type=text name=purse id=purse maxlength=14 style=width:110px;><a href=# class=q><span  class=red></span><div class=title>С данного счета вы выполните оплату товара.</div></a>';
}
else  {document.getElementById('purse').style.display = 'none';}
}
";
?>
// -->
</script>