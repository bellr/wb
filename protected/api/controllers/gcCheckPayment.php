<?
class gcCheckPayment {

    private static function _checkTypePyrse($curency) {
        if ($curency == "WMZ" || $curency == "WMR" || $curency == "WMB" || $curency == "WME" || $curency == "WMG" || $curency == "WMU" || $curency == "WMY") {
           return "WMT";
        } else {
            return $curency;
        }
    }

	public static function resultCheckPayment($ar) {
	
	$ar = (array)$ar;

	/* input params
	ex_input - type curency
	in_val - amount pay
	id_pay - ID payment
	purse_in - purse for transfer
	desc_pay - description payment
	type_object  - params for detected
	direct - derection exchange for select working WM purse
	*/
        $PP = (array)Extension::Payments()->getParam('payments');

        $ar['purse_type'] = self::_checkTypePyrse($ar['ex_input']);
		
		$comission = $PP['com_'.$ar['purse_type']];
		$amount_output = $ar['in_val'] + $ar['in_val'] * $comission / 100;
		//dataBase::DBexchange()->query('balance',"update balance set balance=balance-{$amount_output} where name='".$ar['ex_input']."'");
        Model::Balance()->updateBalance($ar['ex_input'],'-'.$amount_output);

		$func = 'to'.$ar['purse_type'];
		
		return static::$func($ar);
	}
    
	public static function RepetPayment($ar) {
	
		$ar = (array)$ar;

		$ar['purse_type'] = self::_checkTypePyrse($ar['ex_input']);
		
		$func = 'to'.$ar['purse_type'];
		static::$func($ar);
	}
	
	private static function toWMT($ar) {

		$r = Extension::Payments()->Webmoney()->x2(array('id_pay'=>$ar['id_pay'],'purse_in'=>$ar['purse_in'],'purse_type'=>$ar['ex_input'],'amount'=>floatval($ar['in_val']),'desc'=>$ar['desc_pay'],'direct'=>$ar['direct']));

		if(isset($r->retval)) {
			if($r->retval == 0) {
				$value['status'] = 'y';
	            $status = true;
			} else {
				$value['status'] = 'er';
				$value['coment'] = 'Error #'.$r->retval;
	            $status = false;
			}
			
			Model::Demand()->update($ar['did'],$ar['type_object'],$value);
		}		

        return $status;
	}
	
	private static function toEasyPay($ar) {

        $PP = (array)Extension::Payments()->getParam('payments');

		$comission = $PP['com_'.$ar['purse_type']];
		$amount_output = $ar['in_val'] + $ar['in_val'] * $comission / 100;

        $purse = Model::Acount_easypay()->getPurseOutput($amount_output);

		if(!empty($purse)) {

			$str_result = Extension::Payments()->EasyPay()->direct_translation($purse,$ar['purse_in'],trim(sprintf("%8.0f ",$ar['in_val'])),$ar['did']);
///////////////////

			if($str_result == 'ERROR_EXCESS_S') {
				dataBase::DBexchange()->update('acount_easypay',array('output'=>$PP['easypay']['limits']['EP_mouth'],'st_output'=>0),'where acount='.$purse);
				self::toEasyPay($ar);
			} else {
				$res = Extension::Payments()->EasyPay()->parseResEasypay($str_result);
				dataBase::DBexchange()->update('demand',array('status'=>$res['status'],'coment'=>$res['message'],'purse_payment'=>$purse),"where did=".$ar['did']);
	            
				if($res['status'] == 'y') {
                    Model::Acount_easypay()->updateAcountRemoval($purse,$ar['in_val'],$amount_output);
				}
			}
///////////////////
			$status = true;

		} else {
			dataBase::DBexchange()->update('demand',array('coment'=>Config::$sysMessage['L_empty_balance']),'where did='.$ar['did']);
            $status = false;
		}
		
        return $status;
	}
	
	public static function resultPayService($ar) {

        $ar = (array)$ar;

		$data_model = Model::Uslugi()->getStaticData('uslugi','form',$ar['name_uslugi']);

		//if($ar['name_uslugi'] == 'BF' && preg_match("/1760[0-9]*/i",$ar['pole1']) || preg_match("/1705[0-9]*/i",$ar['pole1']) || preg_match("/1706[0-9]*/i",$ar['pole1']) || preg_match("/1704[0-9]*/i",$ar['pole1']) || preg_match("/1703[0-9]*/i",$ar['pole1']) || preg_match("/1701[0-9]*/i",$ar['pole1']) || preg_match("/1700[0-9]*/i",$ar['pole1'])) {$mass_oper[$ar['name_uslugi']] = '14521';}

		if(!empty($data_model)) {
			//выбор счета с которого будет производиться перевод
			$purse = Model::Acount_easypay()->getPurseService($ar['in_val']);

			if (!empty($purse)) {
				$str_result = Extension::Payments()->EasyPay()->pay_usluga($purse,$ar['pole2'].$ar['pole1'],trim(round($ar['in_val'])),$data_model['erip']);
				$result = Extension::Payments()->EasyPay()->parseResEasypay($str_result);

                if($result['status'] == 'y') {

                    Model::Acount_easypay()->updateAcountService($purse,$ar['in_val']);
                    echo "Payment_successfully";

                } else if($result['status'] == 'er') {

                    Model::Acount_easypay()->resetDataAcount($purse);
                    $result['status'] = 'yn';

                }

			} else {

                $result['status'] = 'er'; $result['message'] = Config::$sysMessage['L_UNDEFINED_PURSE'];
				
			}

			dataBase::DBpaydesk()->update('demand_uslugi',array(
                'status'        => $result['status'],
                'coment'        => $result['message'],
                'purse_payment' => $purse
            ),"where did=".$ar['did']);
		}
	}

    /**
     * @param $demand
     * @return array
     */

    public static function checkPaymentEasypay($demand) {

        $P = inputData::init();
        sValidate::isIntWidth($P->did,10,'L_bad_did');

        if(!sValidate::$code) {

            $check_out_val = trim(number_format($demand['out_val'], 0, '.', ' '));
            $str = Extension::Payments()->EasyPay()->connect_history_easypay($demand['purse_payment'],'4');

            if(preg_match("/200 OK/i",$str)) {
                $check_summe = Extension::Payments()->EasyPay()->parserHistorySum($check_out_val,$P->did,$str);

                if($check_summe == "AMOUNT_CORRESPONDS") {
                    dataBase::DBexchange()->query('balance',"update balance set balance=balance+".$demand['out_val']." where name='".$demand['ex_output']."'");
                    Model::Acount_easypay()->updateAcountRefill($demand['purse_payment'],$demand['out_val']);
                    dataBase::DBexchange()->update('demand',array('status'=>'yn'),'where did='.$P->did);
                    $id_pay = dataBase::DBadmin()->select('id_payment','id_pay',"where did={$P->did}");
                    $demand['direct'] = $demand['ex_output'].'_'.$demand['ex_input'];
                    $demand["id_pay"] = $id_pay[0]['id_pay'];
                    $demand['desc_pay'] = "Direction of the exchange: {$demand['ex_output']}->{$demand['ex_input']}, ID:{$P->did}";
                    $demand['did'] = $P->did;
                    $demand['type_object'] = 'demand';

                    if(self::resultCheckPayment($demand)) {
                        $status = 0; $message = Config::$sysMessage['L_pay_ok'];
                    } else {
                        $status = 1; $message = Config::$sysMessage['L_pay_error'];
                    }
                }
                else {$status = 1; $message = Config::$sysMessage['L_payment_not_executed'];}
            }
            else {$status = 1; $message = Config::$sysMessage['L_connect_systempay'];}

        } else {
            $status = 1; $message = sValidate::$message;
        }

        return array(
            'status'    => $status,
            'message'   => $message
        );
    }
}
