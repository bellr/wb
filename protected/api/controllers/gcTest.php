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

    public function curl($P) {


        $curl = Extension::Rest('https://datm.bezkassira.by/api/auth/scannerLogin/');
        $curl->post([
            'login' => 'chubakov.oleg@gmail.com',
            'password' => '19f7b7a23ab17d80e3a64e686a3d32e5',
            'registration_id' => 'APA91bFxuv22N-9fPqPn3dXoMte_Y7uQ900InJyFDFmzwW8fX5scLrU5p0KuQ_f5mVLgbiy94FkKtAaEM_ZAVDhR7fLagmvRf79fPCGf6K6uKFPZWc0ylVewp24YFStBRNpcWco2adtEBQUrjQ9kFotHhrvigGwKlg',
            //'auth_key' => '2943ad57c9023e90810902b4620aad5a2a80a83ba654b8ec15737f86af18f0d0'
        ]);
        /*$curl->post([
            'registration_id' => 'APA91bFxuv22N-9fPqPn3dXoMte_Y7uQ900InJyFDFmzwW8fX5scLrU5p0KuQ_f5mVLgbiy94FkKtAaEM_ZAVDhR7fLagmvRf79fPCGf6K6uKFPZWc0ylVewp24YFStBRNpcWco2adtEBQUrjQ9kFotHhrvigGwKlg',

        ]);*/
        $curl->ssl(false);
        d($curl->execute());
        //$curl->execute();
        $curl->debug();


    }


}
