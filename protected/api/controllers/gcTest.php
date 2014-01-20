<?
class gcTest {

    public function payEasypay($P) {

        d($P);
        $ar['in_val'] = 110;
        $ar['did'] = swDemand::wm_ReqID();
        $ar['purse_in'] = '05609781';
        $amount_output = $ar['in_val'] + $ar['in_val'] * 0.02 / 100;
        $purse = Model::Acount_easypay()->getPurseOutput($amount_output);
d($purse);
        //exit;
        $str_result = Extension::Payments()->EasyPay()->direct_translation($purse,$ar['purse_in'],trim(sprintf("%8.0f ",$ar['in_val'])),$ar['did']);

        d($str_result);
    }
	
	    public function getPurseOutput($P) {

		        $PP = Extension::Payments()->getParam('payments','easypay');

		$purse = dataBase::DBexchange()->select('acount_easypay',
			'acount, balance',
			'where status=1 and st_output=1 and balance >= '.$P->amount.' and outputday+'.$P->amount.'<'.$PP->limits['EP_day'].' and output+'.$P->amount.'<'.$PP->limits['EP_mouth'],
			'order by balance asc');
		d($purse);	
		
        $purse = Model::Acount_easypay()->getPurseOutput($P->amount);
d($purse);
    }


}
