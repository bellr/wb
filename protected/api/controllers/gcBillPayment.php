<?
class gcBillPayment {

    public static function billWM($params) {

        sValidate::isIntWidth($params['wmid'],12,'L_bad_wmid');
        sValidate::isInt($params['pay_id']);
        sValidate::isIntWidth($params['did'],10,'L_bad_did');

        if(!sValidate::$code) {

            $r = Extension::Payments()->Webmoney()->x1($params);

            if($r->retval == 0) {
			
                dataBase::DBadmin()->update('id_payment',array('more_idpay'=>$r->invoice['id']),array(
                    'id_pay' => $params['pay_id']
                ));
                $value['status'] = 'p';
                $status = 0; $message = 'Счет успешно выписан. Ожидайте выполнения операции.';
				
            } else {
			
                $message = 'По техническими причинам, заявка выполнена НЕ некорректно.<br />Наши специалисты уже работают над этой проблемой.<br />Воспользуйтесь сервисом немного позже.';
                $value['status'] = 'er';
                $value['coment'] = $message.' ERROR='.$r->retval;
                $status = 1;
            }

            Model::Demand()->update($params['did'],$params['type_action'],$value);

        } else {
            $status = 1; $message = sValidate::$message;
        }

		return array('status'=>$status,'message'=>$message);
	
    }


}
