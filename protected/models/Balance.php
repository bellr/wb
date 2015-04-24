<?php
class Balance extends Model {

    public function get($SqlParam) {

        $res = dataBase::DBexchange()->select('balance','*',dataBase::where($SqlParam));

        return $res[0];
    }

    public function updateBalance($name,$amount_output) {

        //$res = dataBase::DBmain()->query('balance','update',dataBase::where($SqlParam));
        dataBase::DBexchange()->query('balance',"update balance set balance=balance + {$amount_output} where name='".$name."'");

    }

    private static $transform = array(
        'instaforex' => array(
            'usd'=>'WMZ', 'rur'=>'WMR', 'eur'=>'WME'
        )
    );

    public static function getTransform($type,$currency) {
        return self::$transform[$type][$currency];
    }

    public static function getPurse($currency) {
        $result = dataBase::DBexchange()->select('balance','purse',"where name='{$currency}'");
        return $result[0]['purse'];
    }

    public static function getCurrencyPay($type) {
        return dataBase::DBexchange()->select('balance','name,desc_val',"where {$type}=1",'order by id asc');
    }

    public static function getBalanceForPay($currency) {
        $balance = dataBase::DBexchange()->select('balance','balance-(balance*com_seti) as balance',"where name='{$currency}'");
       /* if(empty($balance)) {
            //$currency = self::$transform[$currency][$params['currency']];
            return self::getBalanceForPay($currency);
        }*/
        return $balance[0]['balance'];
    }

    public static function getPurseService() {

        $PP = (array)Extension::Payments()->getParam('payments');

        $result = dataBase::DBexchange()->select('acount_easypay','max(balance) as balance',"where st_output=0 and status=1",'order by id','LIMIT 1');
        return $balance = $result[0]['balance'] - $result[0]['balance'] * $PP['com_EasyPay'] / 100;
    }

}
