<?php

require("const.inc.aspx");
require("dbsql.inc.aspx");

function wm_ReqID(){
    $time=microtime();
    $int=substr($time,11);
    $flo=substr($time,2,3);
	$f=substr($int,0,7);
    return $f.$flo;
}
function edit_balance($parm) {
$parm = trim(sprintf("%8.0f ",$parm));
$invers_balance = '';
$balance = '';
	$string_len = strlen($parm);
	$c=0;
	for($i=$string_len;$i>=0;$i--) {
		$invers_balance .= $parm[$i];
		if($c == 3) $invers_balance .= " ";
		if($c == 6) $invers_balance .= " ";
		$c++;
	}
	$string_len = strlen($invers_balance);
	for($i=$string_len;$i>=0;$i--) {
		$balance .= $invers_balance[$i];
	}
return $balance;
}
function truncation_amount($amount) {
	$part = explode(".",$amount);
$result = strlen($part[0]);
$last = round($part[0]*0.1)*10;
return $last;
}
function cheak_ref($http_ref) {
if(!preg_match("/[http:\/\/]+[a-zA-Z0-9\.\-]*wm-rb\.net/i",$http_ref))	{
	header("Location: http://wm-rb.net");
	exit;
}
}

//����� ��� ������ � ������� �����
Class CustomSQL extends DBSQL
{
   // the constructor
   function CustomSQL($DBName = "")
   {
      $this->DBSQL($DBName);
   }
//���������� ������� ��� �������������� ������
   function add_auto_pay($did,$summa,$percent,$part_summa,$purse,$partner)
   {
      $sql = "insert into auto_pay (did,terminal,summa,percent,part_summa,purse) values ('$did','$partner','$summa','$percent','$part_summa','$purse')";
      $result = $this->insert($sql);
	  return $result;
   }
//��������� � ������� ��� �������������� ������
   function edit_auto_pay($did,$oplata,$summa_pay,$purse)
   {
      $sql = "update auto_pay set oplata='$oplata',summa_pay='$summa_pay',purse_pay='$purse' where did='$did'";
		$this->update($sql);
   }
//���� �� shop
   function sel_shop($name_shop)
   {
	$sql = "select percent,purse,part_summa,remainder from terminal where name_shop='$name_shop'";
	$result = $this->select($sql);
	return $result;
   }
//���� �� ������������� �����
   function info_check($did)
   {
	$sql = "select * from auto_pay where did ='$did '";
	$result = $this->select($sql);
	return $result;
   }
//��������� �������
   function content_reklama($count)
   {
	$sql = "select contents from content_reklama where status='1' order by id DESC LIMIT $count,1";
	$result = $this->select($sql);
	return $result;
   }
//����� ���� ��������
   function news($page,$record)
   {
	$start = $page*$record;
	$sql = "select * from news order by id DESC LIMIT $start,$record";
	$result = $this->select($sql);
	return $result;
   }
//����� �������� �� �������
   function news_top($page)
   {
	$start = $page*$record;
	$sql = "select * from news order by id DESC LIMIT 3";
	$result = $this->select($sql);
	return $result;
   }
//���������� �����
   function count($table_name)
   {
    $sql = "select count(id) as stotal from $table_name";
	$result = $this->select($sql);
	return $result;
   }
//���������� ��������
   function add_partner($email,$pass,$name,$host,$date_pay)
   {
      $sql = "insert into partner (email,password,username,host,data) values ('$email','$pass','$name','$host','$date_pay')";
      $result = $this->insert($sql);
	  return $result;
   }
//�������� �� ��������� � �������
   function dubl_email($email)
   {
	$sql = "select id from partner where email='$email'";
	$result = $this->select($sql);
	return $result;
   }
//�������� �� ��������� � �������
   function dubl_host($host)
   {
	$sql = "select id from partner where host='$host'";
	$result = $this->select($sql);
	return $result;
   }
//�������� �� ������������� ������� ������������
   function sel_id_partner($email,$pass)
   {
	$sql = "select id,password from partner where email='$email' and password='$pass' and status='1'";
	$result = $this->select($sql);
	return $result;
   }
//�������� �� ������������� ������� ������������
   function sel_status($email)
   {
	$sql = "select status from partner where email='$email'";
	$result = $this->select($sql);
	return $result;
   }
//�������� �� ��������� � �������
   function info_akk($id)
   {
	$sql = "select * from partner where id='$id'";
	$result = $this->select($sql);
	return $result;
   }
//���������� ����
function update_partner($balance,$email)
   {
      $sql = "update partner set balance='$balance' where email='$email'";
		$this->update($sql);
   }
//����� �� ������������� ����������� ����� � �������
   function ref_host($http_refer)
   {
	$sql = "select id from partner where host like '%$http_refer'";
	$result = $this->select($sql);
	return $result;
   }
//���������� �� 1 ���������� ��������
   function summ_refer($id)
   {
	$sql = "update partner set refer=refer+1 where id='$id' and status='1'";
	$this->update($sql);
   }
//�������� �� ������������� ip
   function sel_refer_ip($id,$ip,$proxy)
   {
	$sql = "select id from ip_partner_refer where partner_id='$id' and addr_remote='$ip' and proxy='$proxy'";
	$result = $this->select($sql);
	return $result;
   }
//���������� ip ��������
   function add_ip($id,$ip,$proxy)
   {
	$sql = "insert into ip_partner_refer (partner_id,addr_remote,proxy) values ('$id','$ip','$proxy')";
	$this->insert($sql);
   }
//���������� ������ ��� ��������
   function update_pass($email,$pass)
   {
	$sql = "update partner set password='$pass' where email='$email'";
	$result = $this->update($sql);
	return $result;
   }
//����� ������ �� shop�(���������� ��� �������������� �������� �������)
   function autoPay_shop($name_shop)
   {
	$sql = "select percent,purse,refresh_url from terminal where name_shop='$name_shop'";
	$result = $this->select($sql);
	return $result;
   }
//������� ������������ ������
   function sel_discount($indef)
   {
      $sql = "select amount,size_d from discount where indef='$indef' and status='1' order by amount asc";
      $result = $this->select($sql);
      return $result;
   }
//������� ������ �� ��������� �����, �������� �� ������������ �����
   function check_discount($indef,$out_val)
   {
      $sql = "select size_d from discount where amount<'$out_val' and indef='$indef' and status='1' order by amount desc limit 1";
      $result = $this->select($sql);
      return $result;
   }
}


//����� ��� ������ � ����� EXCHENGE
Class CustomSQL_exchange extends DBSQL_exchange
{

   // the constructor
   function CustomSQL_exchange($DBName_exchange = "")
   {
      $this->DBSQL_exchange($DBName_exchange);
   }
//�������� ������������ �����
	function CheckRate($in_val,$out_val,$n,$indef) {
		global $db; $sd=1;
		$db = new CustomSQL($DBName);
		$sel_d = $db->check_discount($indef,$out_val);
		$sd = 1+$sel_d [0]['size_d']/100;
	$u = $this->get_kurs($n);

	if($u[0]["direct"] == "y") $format_out_val = ($in_val*$u[0]["konvers"]*$sd*100)/100;
	if($u[0]["direct"] == "n") $format_out_val = ($in_val/$u[0]["konvers"]*$sd*100)/100;
	/*$ResOut_val = sprintf("%8.0f ",$format_out_val);
	$out_val = sprintf("%8.0f ",$out_val);*/
	$ResOut_val = round($format_out_val);
	$out_val = round($out_val);
	if($ResOut_val == $out_val) {return 0;}
	else {vsLog::add($n.' '.$in_val.'->'.$out_val.'=='.$ResOut_val.'('.$format_out_val.')','bad_rate'); return 1;}
   }
   //����� ����� ��������� �����
   function konst_currency($table)
   {
      $sql = "select name,balance,desc_val,st_exch,com_seti,name_s from balance where $table=1 ORDER BY `id` ASC ";
      $result = $this->select($sql);
      return $result;
   }
   //����� ����� ��������� ����� �� ������� ��������
   function index_currency($table)
   {
      $sql = "select name,balance,desc_val from balance where $table='1' ORDER BY `id` ASC";
      $result = $this->select($sql);
      return $result;
   }
   //����� ����� ��������� �����
   function cur_oplata($table)
   {
      $sql = "select name,balance from balance where $table='1' ORDER BY `id` ASC";
      $result = $this->select($sql);
      return $result;
   }
//������������ ������
   function exch_cur($currency)
   {
      $sql = "select desc_val from balance where name='$currency'";
      $result = $this->select($sql);
      return $result;
   }
//����� �����
   function sel_purse($currency)
   {
      $sql = "select purse from balance where name='$currency'";
      $result = $this->select($sql);
      return $result;
   }
//������� �������� ��� ������(������ �����)
   function sel_purse_service($currency)
   {
      $sql = "select purse from balance where name_s='$currency'";
      $result = $this->select($sql);
      return $result;
   }
//����� ����� ��������� �����
   function sel_cur_exch($currency)
   {
      $sql = "select name,balance,desc_val,st_exch,com_seti from balance where name !='$currency' and st_exch='1' ORDER BY `id` ASC ";
      $results = $this->select($sql);
      return $results;
   }
//����� ������
   function info_direct($n)
   {
	$sql = "select konvers,direct from kurs where direction='$n'";
	$result = $this->select($sql);
	return $result;
   }
//����� ����������� ������ � ������ ��� ���
   function sel_direct($cur)
   {
	$sql = "select direction,konvers,direct from kurs where status='1' and main='$cur' and (`direction` NOT LIKE '%usluga'
AND `direction` NOT LIKE '%merch')";
	$result = $this->select($sql);
	return $result;
   }
//��������� �����
   function get_kurs($n)
   {
	$sql = "select konvers,direct from kurs where direction='$n'";
	$result = $this->select($sql);
	return $result;
   }
   //����� ������� ��������� ������
   function exch_balance($input)
   {
      $sql = "select * from balance where name ='$input'";
      $results = $this->select($sql);
      return $results;
   }
//����� ������� ��������� ������(������� ������� � ��������)
   function exch_balance_service($output)
   {
      $sql = "select balance from balance where name_s ='$output'";
      $results = $this->select($sql);
      return $results;
   }
//update ������� ������(������� ������� � ��������)
	function demand_update_bal_service($balance_out,$ex_output)
	{
	$sql = "update balance set balance='$balance_out' where name_s='$ex_output'";
	$results = $this->update($sql);
	return $results;
	}
   //����� ����� ��������� �����
   function cur_out_info($name_cur)
   {
      $sql = "select desc_val from balance where name='$name_cur'";
      $result = $this->select($sql);
      return $result;
   }
   //����� ������ ����� ��� ������������� ������� �������� ��� �����������
   function EP_purse_input($s_input) {
	global $limitday,$limitmouth;
	$sql = "select acount from acount_easypay where st_input=1 and status=1 and inputday+'$s_input'<{$limitday} and input+'$s_input'<{$limitmouth} order by id ASC LIMIT 1";
	$result = $this->select($sql);return $result;
   }
   //����� ������ ����� ��� ������������� ������ �����
   function EP_purse_service()
   {
      $sql = "select max(balance) as balance from acount_easypay where st_output='0' and status=1 order by id ASC LIMIT 1";
      $result = $this->select($sql);
      return $result;
   }
//��������� ����� �������� ��������
   function edit_bal_ep($acount,$summa) {
	$sql = "update acount_easypay set balance=balance+'$summa',input=input+'$summa',inputday=inputday+'$summa',time_payin=".time()."	where acount='$acount'";
	$results = $this->update($sql); return $results;
   }
//���������� ������� ������� � ����
   function upd_time_day($acount) {
	$sql = "update acount_easypay set firstpayin=".time()." where acount='$acount' and firstpayin=0";
	$results = $this->update($sql);return $results;
   }
//���������� ����� �� ������� ������������ ������ ��������
   function edit_purse_input($did,$purse) {
	$sql = "update demand set purse_payment='$purse' where did='$did' and status='n'";
	$results = $this->update($sql);
	return $results;
   }
//���������� ������
   function add_demand($did,$ex_out,$ex_in,$in_val,$out_val,$p_output,$p_input,$email,$date,$time_pay,$partner_id)
   {
      $sql = "insert into demand (did,ex_output,ex_input,out_val,in_val,purse_out,purse_in,email,data,time,partner_id) values ('$did','$ex_out','$ex_in','$in_val','$out_val','$p_output','$p_input','$email','$date','$time_pay','$partner_id')";
      $result = $this->insert($sql);
      return $result;
   }
//����� ������ �� ������
   function demand_info($did)
   {
      $sql = "select * from demand where did='$did'";
      $result = $this->select($sql);
      return $result;
   }
//����� ������ �� ������
   function demand_check($did)
   {
      $sql = "select ex_output,ex_input,out_val,in_val,purse_out,purse_in,email,desc_pay from demand where did='$did' and status='n'";
      $result = $this->select($sql);
      return $result;
   }
//update ������� ������
	function demand_update_bal($balance_out,$ex_output)
	{
	$sql = "update balance set balance='$balance_out' where name='$ex_output'";
	$results = $this->update($sql);
	return $results;
	}
//����� ������� ������
	function demand_edit($st,$did)
	{
	$sql = "update demand set status='$st' where did='$did'";
	$results = $this->update($sql);
	return $results;
	}
//��� ������������� 100% ������, ������ �����������
	function demand_add_coment($coment,$did)
	{
	$sql = "update demand set coment='$coment' where did='$did'";
	$results = $this->update($sql);
	return $results;
	}
//��������� �� ������ �� ������������
	function edit($st,$did)
	{
	$sql = "update demand set status='$st' where did='$did'";
	$results = $this->update($sql);
	return $results;
	}
//�������� ������� ������
   function empty_dem($did)
   {
      $sql = "select did from demand where did='$did' and status='n' and (ex_output='RBK Money' or ex_output='YaDengi')";
      $result = $this->select($sql);
	  return $result;
   }
//�������� ������ �� ����� EP, RP,YD
   function cheak_pay_ok($did)
   {
      $sql = "select ex_output from demand where did='$did' and ex_output='RBK Money' or ex_output='EasyPay' or ex_output='YaDengi'";
      $result = $this->select($sql);
	  return $result;
   }
//������� ����������� �����
   function sel_rates()
   {
	$sql = "select direction from kurs order by id ASC";
	$result = $this->select($sql);
	return $result;
   }
//����� ������ �������� ��������� ������(��� �������������� �������� ������� �������������)
   function sel_purse_out($output)
   {
      $sql = "select purse from balance where name ='$output'";
      $results = $this->select($sql);
      return $results;
   }
//�������� ������� �� ������(��� ���� �������� �������)
   function info_dem($did,$st)
   {
      $sql = "select ex_output,ex_input,out_val,in_val,purse_out,purse_in,purse_payment from demand where did='$did' and status='$st'";
      $result = $this->select($sql);
      return $result;
   }
}

//����� ��� ������ � ����� PAY-DESK
Class CustomSQL_pay_desk extends DBSQL_pay_desk
{

   // the constructor
   function CustomSQL_pay_desk($DBName_pay_desk = "")
   {
      $this->DBSQL_pay_desk($DBName_pay_desk);
   }
   function selpas()
   {
    $sql = "SELECT @password:='dbnfkbq1986'";
	$result = $this->select($sql);
	return $result;
   }
//���������� ����� � ������ �� ������� ������������ ������ ��������
   function edit_purse_input($did,$purse,$table)
   {
	$sql = "update $table set purse_payment='$purse' where did='$did' and  purse_payment IS NULL";
	$results = $this->update($sql);
	return $results;
   }
//�������� ������� ����� � ����
   function search_card($number_card,$period)
   {
      $sql = "select id from list_card where card='$number_card' and period='$period'";
      $result = $this->select($sql);
      return $result;
   }
//����� �������� ������ �������
	function oplata($name_cat)
   {
	$sql = "select cur_pay,price from e_shop where status='1' and name_cat='$name_cat' order by id ASC";
	$result = $this->select($sql);
	return $result;
   }
//����� ����� �� �������
	function sel_uslugi($name_cat)
   {
	$sql = "select desc_uslugi,name,desc_val from uslugi where status='1' and name_cat='$name_cat' order by id ASC";
	$result = $this->select($sql);
	return $result;
   }
//����� ������� � ��������
	function sel_goods()
   {
	$sql = "select id,cur_pay,price from e_shop where status='1' order by id ASC";
	$result = $this->select($sql);
	return $result;
   }
//����� �������� � ��������
	function goods_name($id_goods)
   {
	$sql = "select name_cat,price from e_shop where id='$id_goods' and status='1' order by id ASC";
	$result = $this->select($sql);
	return $result;
   }
//���������� ���� ������
	function sel_goods_price($id)
   {
	$sql = "select name_card,price from info_goods where id='$id'";
	$result = $this->select($sql);
	return $result;
   }
//���������� ������ ��� �������� �������
   function select_goods($id) {
	  $p = $this->selpas();
      $sql = "select id,AES_DECRYPT(info_goods,'$p[0][0]') from goods where id_goods='$id' and status='1' order by id DESC limit 1";
      $result = $this->select($sql);
      return $result;
   }
//��������� ������� ������
   function edit_st_goods($id)
   {
	$sql = "update goods set status='0' where id='$id'";
	$results = $this->update($sql);
   }
//��������� ������� ������(���������� �����)
   function edit_count($id)
   {
	$sql = "update info_goods set count=count-1,sale=sale+1 where id='$id'";
	$results = $this->update($sql);
   }
//��������� ������� ������
   function add_goods_dem($did,$id_goods)
   {
	$sql = "update demand_eshop set goods='$id_goods' where did='$did'";
	$results = $this->update($sql);
   }
//��������� ������� ������(�� ���������� �����)
   function edit_count_un($id)
   {
	$sql = "update info_goods set sale=sale+1 where id='$id'";
	$results = $this->update($sql);
   }
//���������� ������(ESHOP)
   function add_dem_eshop($did,$output,$name_goods,$purse_out,$amount,$amount_goods,$akk,$email,$date,$time_pay,$partner_id)
   {
      $sql = "insert into demand_eshop (did,output,name_goods,purse_out,amount,amount_goods,pole1,email,data,time,partner_id) values ('$did','$output','$name_goods','$purse_out','$amount','$amount_goods','$akk','$email','$date','$time_pay','$partner_id')";
      $result = $this->insert($sql);
      return $result;
   }
//����� ������ �� ID
	function sel_goods_ID($id)
   {
	$sql = "select id,name_cat,cur_pay,price from e_shop where id='$id' and status='1'";
	$result = $this->select($sql);
	return $result;
   }
//����� �������� ������ �� ���������
	function sel_goods_desc($name_cat)
   {
	$sql = "select desc_val from reserv_goods where name='$name_cat' and status='1'";
	$result = $this->select($sql);
	return $result;
   }
//����� ����� �� �������
	function reserv_eshop($name_goods)
   {
	$sql = "select balance,desc_val from reserv_goods where status='1' and name='$name_goods' order by id ASC";
	$result = $this->select($sql);
	return $result;
   }
//����� ��������� ������
	function select_usluga($usluga,$table)
   {
	$sql = "select name_cat,desc_val from $table where status='1' and name='$usluga'";
	$result = $this->select($sql);
	return $result;
   }
//����� ��������� ������
	function info_card($usluga)
   {
	$sql = "select desc_val,equiv_cur,min_pay from name_card where status='1' and name='$usluga'";
	$result = $this->select($sql);
	return $result;
   }
//����� �������� ��������� ������
	function select_cat($usluga)
   {
	$sql = "select name_cat from uslugi where status='1' and name='$usluga'";
	$result = $this->select($sql);
	return $result;
   }
   //������� ���������� �� ������
   function info_usluga($usluga)
   {
      $sql = "select commission from uslugi where name='$usluga' and status='y'";
      $results = $this->select($sql);
      return $results;
   }
   //����� ������� ����� �� ��������� ������
   function exch_balance($card_name)
   {
      $sql = "select balance,com_card,min_pay,bonus,obligatory_payment from name_card where name='$card_name'";
      $results = $this->select($sql);
      return $results;
   }
   //����� �������� ����� �� ��������� ������
   function exch_value($card_name)
   {
      $sql = "select desc_val,name_card,period from name_card where name='$card_name' and status='1'";
      $results = $this->select($sql);
      return $results;
   }
//���������� ������ ��� ������
   function add_demand($did,$output,$name_uslugi,$purse_out,$in_val,$out_val,$pole1,$pole2,$email,$date,$time_pay,$partner_id)
   {
      $sql = "insert into demand_uslugi (did,output,name_uslugi,purse_out,out_val,in_val,pole1,pole2,email,data,time,partner_id) values ('$did','$output','$name_uslugi','$purse_out','$in_val','$out_val','$pole1','$pole2','$email','$date','$time_pay','$partner_id')";
      $result = $this->insert($sql);
      return $result;
   }
//����� ������ �� ������
   function demand_info($did)
   {
      $sql = "select * from demand_uslugi where did='$did'";
      $result = $this->select($sql);
      return $result;
   }
//����� ������ �� ������(ESHOP)
   function demand_info_eshop($did)
   {
      $sql = "select * from demand_eshop where did='$did'";
      $result = $this->select($sql);
      return $result;
   }
//����� ������� ������
	function demand_edit($st,$did)
	{
	$sql = "update demand_uslugi set status='$st' where did='$did' and status='n' and (output='RBK Money' or output='YaDengi')";
	$results = $this->update($sql);
	return $results;
	}
//�������� ������� ������
   function empty_dem($did)
   {
      $sql = "select did from demand_uslugi where did='$did' and status='n' and (output='RBK Money' or output='YaDengi')";
      $result = $this->select($sql);
	  return $result;
   }
//�������� ������� ������ �� ��������
   function empty_dem_eshop($did)
   {
      $sql = "select did from demand_eshop where did='$did' and status='n' and (output='RBK Money' or output='YaDengi')";
      $result = $this->select($sql);
	  return $result;
   }
   /*
//�������� ������ �� ����� EP, RP,YD
   function cheak_pay_ok($did)
   {
      $sql = "select output from demand_uslugi where did='$did' and ex_output='EasyPay' or ex_output='YaDengi'";
      $result = $this->select($sql);
	  return $result;
   }
   */
//���������� ������(���������� ��������� �����)
   function add_demand_nal($did,$output,$input,$card,$period,$purse_in,$out_val,$in_val,$email,$date_pay,$time_pay,$partner_id)
   {
      $sql = "insert into demand_cash (did,output,input,card,period,purse_in,out_val,in_val,email,data,time,partner_id) values ('$did','$output','$input','$card','$period','$purse_in','$out_val','$in_val','$email','$date_pay','$time_pay','$partner_id')";
      $result = $this->insert($sql);
     }
//����� ������ �� ������(���������� ��������� �����)
   function demand_info_nal($did,$table)
   {
      $sql = "select * from $table where did='$did'";
      $result = $this->select($sql);
      return $result;
   }
//�������� ������� ������(���������� ��������� �����)
   function empty_dem_nal($did)
   {
      $sql = "select did from demand_cash where did='$did' and status='n'";
      $result = $this->select($sql);
	  return $result;
   }
//����� ������� ������(���������� ��������� ����� � ������, �������)
	function demand_edit_nal($st,$did,$table)
	{
	$sql = "update $table set status='$st' where did='$did' and status='n'";
	$results = $this->update($sql);
	return $results;
	}
//����� ����� ��������� ���� ��� ������
   function output_nal_card()
   {
      $sql = "select name,desc_val from name_card where status='1' ORDER BY `id` ASC";
      $result = $this->select($sql);
      return $result;
   }
//����� ��������� ���� ��� ����������� ��������
   function output_nal_card_info()
   {
      $sql = "select name,balance,desc_val,equiv_cur from name_card where status='1' ORDER BY `id` ASC";
      $result = $this->select($sql);
      return $result;
   }
//���������� ������(����� �� �����)
 function add_dem_nal_out($did,$output,$number_card,$in_val,$out_val,$p_output,$name_card,$period,$email,$date_pay,$time_pay,$partner_id,$wmid,$user_surname,$user_name,$name_bank)
   {
      $sql = "insert into demand_nal_out (did,output,card,period,out_val,in_val,purse_out,name_card,email,data,time,partner_id,wmid,user_surname,user_name,name_bank) values ('$did','$output','$number_card','$period','$out_val','$in_val','$p_output','$name_card','$email','$date_pay','$time_pay','$partner_id','$wmid','$user_surname','$user_name','$name_bank')";
      $this->insert($sql);
     }
//�������� ������� ������(����� �� �����)
   function empty_dem_out($did)
   {
      $sql = "select did from demand_nal_out where did='$did' and status='n' and (output='RBK Money' or output='YaDengi')";
      $result = $this->select($sql);
	  return $result;
   }
//�������� ������� �� ������(���� ��������)
   function info_dem($did,$st)
   {
      $sql = "select output,name_uslugi,purse_out,out_val,in_val,status from demand_uslugi where did='$did' and status='$st'";
      $result = $this->select($sql);
      return $result;
   }
//�������� ������� �� ������(���� ��������)
   function info_dem_eshop($did,$st)
   {
      $sql = "select * from demand_eshop where did='$did' and status='$st'";
      $result = $this->select($sql);
      return $result;
   }
//����� ������ �� ������(�������)
   function sel_amount_good($name_goods)
   {
      $sql = "select balance from reserv_goods where name='$name_goods'";
      $result = $this->select($sql);
      return $result;
   }
//����� ������� ������(�������)
	function upd_amount_good($name_goods,$balance)
	{
	$sql = "update reserv_goods set balance='$balance' where name='$name_goods'";
	$results = $this->update($sql);
	return $results;
	}
//����� ������� ������(�������)
	function demand_edit_eshop($st,$did)
	{
	$sql = "update demand_eshop set status='$st' where did='$did'";
	$results = $this->update($sql);
	return $results;
	}
//��� �������� ������� �� ������(��� ���� �������� �������)
   function info_dem_cash_out($did,$st)
   {
      $sql = "select output,card,period,out_val,in_val,purse_out,name_card,purse_payment from demand_nal_out where did='$did' and status='$st'";
      $result = $this->select($sql);
      return $result;
   }
//����� ������� ������
	function demand_edit_cash_out($st,$did)
	{
	$sql = "update demand_nal_out set status='$st' where did='$did'";
	$results = $this->update($sql);
	}
//����� ������� ��������� ������
   function sel_card_bal($card)
   {
      $sql = "select balance,com_card from name_card where name='$card'";
      $results = $this->select($sql);
      return $results;
   }
//update ������� �����
	function update_bal_card($balance_out,$card)
	{
	$sql = "update name_card set balance='$balance_out' where name='$card'";
	$this->update($sql);
	}
//��� ������������� 100% ���������� �����, ������ �����������
	function dem_coment_output($coment,$did)
	{
	$sql = "update demand_nal_out set coment='$coment' where did='$did'";
	$results = $this->update($sql);
	return $results;
	}
//����� ������ �� ������(��� ���� �������� ��������)
   function demand_check($did)
   {
      $sql = "select output,name_uslugi,out_val,in_val,pole1,email,data,time,status from demand_uslugi where did='$did'";
      $result = $this->select($sql);
      return $result;
   }
//��� ������������� 100% ������, ������ �����������
	function demand_add_coment($coment,$did)
	{
	$sql = "update demand_uslugi set coment='$coment' where did='$did'";
	$results = $this->update($sql);
	return $results;
	}
}
//����� ��� ������ � ����� ADMIN
Class CustomSQL_admin extends DBSQL_admin
{

   // the constructor
   function CustomSQL_admin($DBName_admin = "")
   {
      $this->DBSQL_admin($DBName_admin);
   }
//���������� ��������� � ������
   function support_mess($ip,$email,$mess,$date_pay,$time_pay)
   {
      $sql = "insert into support (ip,email,message,date,time) values ('$ip','$email','$mess','$date_pay','$time_pay')";
      $result = $this->insert($sql);
      return $result;
   }
//���������� ������ �������
   function add_id_pay($did,$addr_remote,$proxy)
   {
      $sql = "insert into id_payment (did,addr_remote,proxy) values ('$did','$addr_remote','$proxy')";
      $result = $this->insert($sql);
   }
//����� ����� ������
   function sel_idpay($did)
   {
      $sql = "select id_pay from id_payment where did='$did'";
      $result = $this->select($sql);
      return $result;
   }
//����� ����� ������
   function sel_did($id_pay)
   {
      $sql = "select did from id_payment where id_pay='$id_pay'";
      $result = $this->select($sql);
      return $result;
   }
}
//����� ��� ������ � ����� ������
Class CustomSQL_forum extends DBSQL_forum
{

   // the constructor
   function CustomSQL_forum($DBName_forum = "")
   {
      $this->DBSQL_forum($DBName_forum);
   }
//����� ��� � ������
   function theam_1($f2,$f3,$f4,$f5,$f6)
   {
      $sql = "select threadid, title from thread where forumid='$f2' or forumid='$f3' or forumid='$f4' or forumid='$f5' or forumid='$f6' order by threadid desc limit 2";
      $result = $this->select($sql);
      return $result;
   }
   function theam_7($f8,$f9,$f10,$f11,$f12,$f13)
   {
      $sql = "select threadid,title from thread where forumid='$f8' or forumid='$f9' or forumid='$f10' or forumid='$f11' or forumid='$f12' or forumid='$f13' order by threadid desc limit 2";
      $result = $this->select($sql);
      return $result;
   }
   function theam_14($f15,$f16,$f17)
   {
      $sql = "select threadid, title from thread where forumid='$f15' or forumid='$f16' or forumid='$f17' order by threadid desc limit 2";
      $result = $this->select($sql);
      return $result;
   }
   function theam_18($f19,$f20,$f21)
   {
      $sql = "select threadid, title from thread where forumid='$f19' or forumid='$f20' or forumid='$f21' order by threadid desc limit 2";
      $result = $this->select($sql);
      return $result;
   }
}
?>