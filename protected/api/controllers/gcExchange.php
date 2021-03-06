<?
class gcExchange {

    /**
     * global call https://atm.wm-rb.net/api/exchange/webMoneyMerchant/
     * local call Vitalis::Controller('exchange','webMoneyMerchant',array(),'gc');
     */

    //public function wmExchangeMerchant($P) {
    public function webMoneyMerchant($P) {

        vsLog::add((array)$P,'webMoneyMerchant_request');

        $PP = Extension::Payments()->getParam('payments');

        $demand = Model::Demand('HOME')->getInfo(['did' => $P->did],'demand');

        if($demand['status'] == 'n') {

            $md5_value = strtoupper(md5(
                $P->LMI_PAYEE_PURSE .
                $demand['out_val'] .
                $P->LMI_PAYMENT_NO .
                '0' .
                $P->LMI_SYS_INVS_NO .
                $P->LMI_SYS_TRANS_NO .
                $P->LMI_SYS_TRANS_DATE .
                $PP->signature_key .
                $P->LMI_PAYER_PURSE .
                $P->LMI_PAYER_WM
            ));

            if($md5_value != $P->LMI_HASH) {

                $id_pay = dataBase::DBadmin()->update('id_payment',array('more_idpay' => $P->LMI_SYS_TRANS_NO),array(
                    'id_pay' => $P->LMI_PAYMENT_NO
                ));

                $r = Extension::Payments()->Webmoney()->x19(array(
                    'type_operation'        => 'emoney',
                    'direction'             => 'output',
                    'purse_type'            => $demand['ex_output'],
                    'amount'                => floatval($demand['out_val']),
                    'wmid'                  => $P->LMI_PAYER_WM,
                    'paysystem_name'        => 'easypay.by',
                    'id_another_paysystem'  => $demand['purse_in']
                ));

                if($r->retval != 0) {

                    Model::Demand()->update($P->did,'demand',array(
                        'purse_out' => $P->LMI_PAYER_PURSE,
                        'status' => 'yn',
                    ));

                    $ar['id_pay'] = $id_pay[0]['id_pay'];
                    $ar['more_idpay'] = $P->LMI_SYS_TRANS_NO;
                    $ar['direct'] = $demand['ex_output'].'_'.$demand['ex_input'];
                    $ar['type_object'] = 'demand';
                    $ar['desc_pay'] = swConstructor::descriptionPayment('exchange',$demand);

                    dataBase::DBexchange()->query('balance',"update balance set balance=balance+{$demand['out_val']} where name='{$demand['ex_output']}'");

                    gcCheckPayment::resultCheckPayment($ar);

                } else {

                    $order_data['status'] = 'er';
                    $order_data['coment'] = 'Error check. Code:'.$r->retval.', '.$r->retdesc;

                    $x14 = Extension::Payments()->Webmoney()->X14(array(
                        'id_pay'        => $id_pay[0]['id_pay'],
                        'amount'        => $demand['out_val']
                    ));

                    if($x14->retval != 0) {
                        $order_data['coment'] = 'X14. Code:'.$r->retval.', '.$r->retdesc;
                    }

                }

            } else {

                $order_data['status'] = 'er';
                $order_data['coment'] = Config::$sysMessage['L_error_signature'];

            }

            Model::Demand()->update($P->did,'demand',$order_data);

        }
    }

}