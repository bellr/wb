<?php
class Demand extends Model {

    public function getInfo($SqlParam,$type) {

        switch ($type) {

            case 'demand':

                $res = dataBase::DBexchange()->select($type,
                    '*',
                    dataBase::where($SqlParam));

                break;
            case 'demand_cash';
                dataBase::DBpaydesk()->update('demand_cash',$params,array(
                    'did' => $did
                ));
                break;
            case 'oplata';
            case 'paydesk';
                dataBase::DBpaydesk()->update('demand_uslugi',$params,array(
                    'did' => $did
                ));
                break;
        }

        return $res[0];
    }

    //protected function getInfoModel($obj) {}

	public static function delete($did,$type) {
	
		switch ($type) {
             case 'demand_cash';
				dataBase::DBpaydesk()->delete('demand_cash',array(
                    'did' => $did
                ));
            break;
        }

		dataBase::DBadmin()->delete('id_payment',array(
            'did' => $did
        ));
	}
	
	
	public static function update($did,$type='demand',$params) {
	
		switch ($type) {
            case 'demand';
			case 'exchange';
				dataBase::DBexchange()->update('demand',$params,array(
                    'did' => $did
                ));
            break;
			case 'demand_cash';
				dataBase::DBpaydesk()->update('demand_cash',$params,array(
                    'did' => $did
                ));
            break;
			case 'oplata';
			case 'paydesk';
				dataBase::DBpaydesk()->update('demand_uslugi',$params,array(
                    'did' => $did
                ));
            break;
        }
	}

    public static function insert($did,$type,$data) {

        switch ($type) {
            case 'demand';
                dataBase::DBexchange()->insert($type,$data);
                break;
            case 'demand_uslugi';
                dataBase::DBpaydesk()->insert($type,$data);
                break;
            case 'demand_cash';
                dataBase::DBpaydesk()->insert($type,$data);
                break;
        }

        Model::Id_payment('HOME')->add($did);
    }

    public function createSignature($params,$method='md5') {

        $str =  $params['output'].
                $params['input'].
                $params['out_val'].
                $params['in_val'].
                $params['id_pay'].
                $params['did'].
                Extension::Payments()->getParam('payments')->signature_key;

        if($method == 'md5') {

            $str = md5($str);

        } else if($method == 'sha256') {

            $str = hash('sha256', $str);
        }

        return $str;
    }

    public function didHesh($did) {

        return strtoupper(sCrypt::enCrypt($did));

    }

    public function didFromHesh($did) {

        return sCrypt::deCrypt(strtolower($did));

    }
}
