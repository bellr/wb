<?php
class Partner extends Model {

    public function get($SqlParam) {

        $res = dataBase::DBmain()->select('partner','*',dataBase::where($SqlParam));

        return $res[0];
    }

    public function updateBalance($id,$withdraw_amount) {

        dataBase::DBmain()->query('partner',"update partner set balance=balance + {$withdraw_amount} where id={$id}");

    }
}
