<script language='JavaScript'>
<!--
<?
echo "
function cheak_null() {
if(document.form_eshop.amount_goods.value <= 0 || document.form_eshop.amount_goods.value < 0) document.form_eshop.amount_goods.value='0';
if(parseFloat(document.form_eshop.amount_goods.value) > parseFloat(document.form_eshop.a_goods.value)) {
alert('¬ы превысили допустимое количество товара!!!');
document.form_eshop.amount_goods.value='0';
return false;
}
}
function show_out() {
 document.getElementById('box_info').style.display = 'block';
}
function ShowPrice() {
	d = document.form_eshop.oplata.value;
	if(document.form_eshop.amount_goods.value == 0 || document.form_eshop.amount_goods.value == '0') am_goo = 0;
	else am_goo = document.form_eshop.amount_goods.value;
switch(d) {";
	foreach($goods as $arr) {
		echo "
case '{$arr[1]}': ";
echo "
if (document.form_eshop.amount_goods.value > 0) {
	s_goods = Math.round(document.form_eshop.amount_goods.value*{$arr[2]}*100-0.000001)/100;
	 document.getElementById('price').innerHTML = am_goo+' <b>гол.</b> = '+s_goods+' <b>'+d+'</b>';
	document.form_eshop.id_goods.value = '{$arr[0]}';}";
echo "
	break;";
	}
	echo "
case 'none':
document.getElementById('box_info').style.display = 'none';
	break
endswitch;
}
if (document.form_eshop.amount_goods.value < 0) document.getElementById('price').innerHTML = '0 <b>гол.</b> = 0 <b>'+d+'</b>';
if(d == 'EasyPay' || d == 'YaDengi') {
 document.getElementById('purse').style.display = 'block';
 document.getElementById('form_purse').innerHTML = '<input type=text name=purse id=purse maxlength=14 style=width:110px;><a href=# class=q><span  class=red>&nbsp;?</span><div class=title>— данного счета вы выполните оплату товара.</div></a>';
}
else  document.getElementById('purse').style.display = 'none';
}";
?>
// -->
</script>