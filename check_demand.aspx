<?
session_start();

if($_SESSION['id'] == md5('1620'.session_id())) {

    require("customsql.inc.aspx");
    cheak_ref($_SERVER['HTTP_REFERER']);

    require("include/constructor_exch.aspx");
    require("include/class_error.aspx");
    require($home_dir."mailer/smtp-func.aspx");

    $db = new CustomSQL($DBName);
    $db_admin = new CustomSQL_admin($DBName_admin);
    $Constructor = new Constructor();
    $CheckError = new Error();

    //Обработка заявки на обмен
    if (!empty($_POST['ex_demand'])) {
        if (empty($_POST['ex_demand'])) {
            header("Location: http://wm-rb.net/exchange.aspx");
        }
        else {
            $db_exchange = new CustomSQL_exchange($DBName_exchange);
            //форматирование данных
            $in_val = substr(trim(stripslashes(htmlspecialchars($_POST['in_val']))),0,10);
            $out_val = substr(trim(stripslashes(htmlspecialchars($_POST['out_val']))),0,10);
            $ex_out = substr(trim(stripslashes(htmlspecialchars($_POST['ex_out']))),0,16);
            $ex_in = substr(trim(stripslashes(htmlspecialchars($_POST['ex_in']))),0,16);
            $p_output = substr(trim(stripslashes(htmlspecialchars($_POST['p_output']))),0,36);
            $p_input = substr(trim(stripslashes(htmlspecialchars($_POST['p_input']))),0,36);
            //$did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10);
            $email = substr(trim(stripslashes(htmlspecialchars($_POST['email']))),0,64);
            $wmid = substr(trim(stripslashes(htmlspecialchars($_POST['wmid']))),0,64);

			$bal = dataBase::DBexchange()->select('balance','balance,com_seti','where name="'.$ex_in.'"');
            //$ar_error = $CheckError->Did($did);
            if($bal[0]['balance'] < $out_val*(1+$bal[0]['com_seti'])) {$ar_error .=1;} else {$ar_error .=0;}
            $ar_error .= $CheckError->Inval($in_val);
            $ar_error .= $CheckError->Inval($out_val);
            $ar_error .= $CheckError->Email($email);
            $ar_error .= $db_exchange->CheckRate($in_val,$out_val,$ex_out."_".$ex_in,$ex_in);

            if($ar_error > 0) {header("Location: http://wm-rb.net"); exit('er');}
            setcookie("partner_id", "", time() + 31104000, "/", "wm-rb.net");
            //Добавление завки
			$data['did'] = time();
			$data['ex_output'] = $ex_out;
			$data['ex_input'] = $ex_in;
			$data['out_val'] = $in_val;
			$data['in_val'] = $out_val;
			$data['purse_out'] = $p_output;
			$data['purse_in'] = $p_input;
			$data['email'] = $email;
			$data['add_date'] = time();
			$data['partner_id'] = $_COOKIE['partner_id'];
			$did = dataBase::DBexchange()->insert('demand',$data);

            setcookie("purse_".$ex_out, $p_output, time() + 31104000, "/", "wm-rb.net");
            setcookie("purse_".$ex_in, $p_input, time() + 31104000, "/", "wm-rb.net");
			setcookie("wmid", $wmid, time() + 31104000, "/", "wm-rb.net");
            setcookie("email", $email, time() + 31104000, "/", "wm-rb.net");
            //Добавление номера платежа
			dataBase::DBadmin()->insert('id_payment',array('did'=>$did,'addr_remote'=>$_SERVER['REMOTE_ADDR'],'proxy'=>$_SERVER['HTTP_X_FORWARDED_FOR']));
			
            //$db_admin->add_id_pay($did,$_SERVER['REMOTE_ADDR'],$_SERVER['HTTP_X_FORWARDED_FOR']);

            if($ex_in == 'EasyPay') {
                //проверка вводимых данных о владельце счета в центре аттестации
                //$ext = new eWebmoney('slave_wmid');
				$res = eWebmoney::x19(array('purse_type'=>$ex_out,'amount'=>$in_val,'wmid'=>$wmid,'emoney_name'=>'easypay.by','emoney_id'=>$p_input,'direct'=>$ex_out.'_'.$ex_in));
                //$res = $ext->x19(array('purse_type'=>$ex_out,'amount'=>$in_val,'wmid'=>$wmid,'emoney_name'=>'easypay.by','emoney_id'=>$p_input));

                if($res->retval != "0") {
                    $values['coment'] = "Ваш кошелек не привязан в WMID".$wmid;
                    $values['status'] = 'er';
                    //Vitalis::db()->update('demand',$values,"where did=".$did);
                }
            }

            $from_name = "Robot exchange, WM-RB.net";
            $subject = "Номер заявки";
            $body = "
            <center>Здравствуйте</center><br />
            Номер Вашей заявки : <b>{$did}</b><br />
            Проверить статус заявки Вы можете узнать <a href='http://wm-rb.net/user_check_demand.aspx'>здесь</a>
            <br />
            Мы будем благодарны Вам за любые предложения, высказанные по поводу того,
            какой Вы хотите видеть сервис платежей WM-RB.net.<br /><br />

            Благодарим Вас за использование нашего сервиса.<br />
            Это письмо отправлено роботом, ответа не требует.<br />
            <br />--<br />
            С уважением,<br />
            Администрация WM-RB.net<br />
            <br />
            <a href='http://wm-rb.net'>Сервис платежей WebMoney в Республике Беларусь</a><br />
            Mail: <a href='mailto:$support'>$support</a><br />
            ICQ: $icq";
            smtpmail($email,$subject,$body,$from_name);
            header("Location: http://wm-rb.net/user_check_demand.aspx?d=$did");
        }
    }



//Обработка заявки на оплату услуги
    elseif (!empty($_POST['usluga'])) {
        if (empty($_POST['usluga'])) {
            header("Location: http://service.wm-rb.net/services_list.aspx");
        }
        else {
            $db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
            //форматирование данных
            $in_val = substr(trim(stripslashes(htmlspecialchars($_POST['in_val']))),0,16);
            $out_val = substr(trim(stripslashes(htmlspecialchars($_POST['out_val']))),0,16);
            $output = substr(trim(stripslashes(htmlspecialchars($_POST['oplata']))),0,16);
            $name_uslugi = substr(trim(stripslashes(htmlspecialchars($_POST['name_uslugi']))),0,16);
            $p_output = substr(trim(stripslashes(htmlspecialchars($_POST['p_output']))),0,32);
            $pole1 = substr(trim(stripslashes(htmlspecialchars($_POST['pole1']))),0,16);
            $pole2 = substr(trim(stripslashes(htmlspecialchars($_POST['pole2']))),0,16);
            $did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10);
            $email = substr(trim(stripslashes(htmlspecialchars($_POST['email']))),0,64);

            $ar_error = $CheckError->Did($did);
            $ar_error .= $CheckError->Inval($in_val);
            $ar_error .= $CheckError->Inval($out_val);
            $ar_error .= $CheckError->Email($email);

            if($ar_error > 0) {header("Location: http://service.wm-rb.net"); exit();}
            //Добавление завки
            $db_pay_desk->add_demand($did,$output,$name_uslugi,$p_output,$in_val,$out_val,$pole1,$pole2,$email,$date_pay,$time_pay,$_COOKIE['partner_id']);
            //установка куков для номера карты и срока действия
            setcookie("partner_id", "", time() + 31104000, "/", "service.wm-rb.net");
            setcookie($name_uslugi."_1", $pole1, time() + 31104000, "/", "service.wm-rb.net");
            setcookie($name_uslugi."_2", $pole2, time() + 31104000, "/", "service.wm-rb.net");
            setcookie("email", $email, time() + 31104000, "/", "service.wm-rb.net");
            //Добавление номера платежа
            $db_admin->add_id_pay($did,$_SERVER['REMOTE_ADDR'],$_SERVER['HTTP_X_FORWARDED_FOR']);

            $from_name = "Robot exchange, WM-RB.net";
            $subject = "Номер заявки";
            $body = "
<center>Здравствуйте</center><br /><br />
Номер Вашей заявки : <b>{$did}</b><br />
Проверить статус заявки Вы можете узнать <a href='http://service.wm-rb.net/user_check_usluga.aspx'>здесь</a>
<br />
Мы будем благодарны Вам за любые предложения, высказанные по поводу того,
какой Вы хотите видеть сервис платежей WM-RB.net.<br /><br />

Благодарим Вас за использование нашего сервиса.<br />
Это письмо отправлено роботом, ответа не требует.<br />
<br />--<br />
С уважением,<br />
Администрация WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>Сервис платежей WebMoney в Республике Беларусь<br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq
";
            smtpmail($email,$subject,$body,$from_name);
            header("Location: http://service.wm-rb.net/user_check_usluga.aspx?d=$did");
        }
    }

//Обработка заявки на пополнение наличными
    elseif (!empty($_POST['NAL'])) {
        if (empty($_POST['NAL'])) {
            header("Location: http://wm-rb.net/output_nal.aspx");
        }
        else {
            $db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
            //форматирование данных
            $did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10);
            $output = substr(trim(stripslashes(htmlspecialchars($_POST['name_uslugi']))),0,16);
            $input = substr(trim(stripslashes(htmlspecialchars($_POST['oplata']))),0,16);
            $card = substr(trim(stripslashes(htmlspecialchars($_POST['number_card']))),0,16);
            $period = substr(trim(stripslashes(htmlspecialchars($_POST['period']))),0,16);
            $purse_in = substr(trim(stripslashes(htmlspecialchars($_POST['p_input']))),0,32);
            $out_val = substr(trim(stripslashes(htmlspecialchars($_POST['in_val']))),0,16);
            $in_val = substr(trim(stripslashes(htmlspecialchars($_POST['out_val']))),0,16);
            $email = substr(trim(stripslashes(htmlspecialchars($_POST['email']))),0,64);

            $ar_error = $CheckError->Did($did);
            $ar_error .= $CheckError->Inval($in_val);
            $ar_error .= $CheckError->Inval($out_val);

            if($_POST['name_uslugi'] != 'pochta' && $_POST['name_uslugi'] != 'VISA') {
                $ar_error .= $CheckError->N_card($card);
                $ar_error .= $CheckError->P_card($period);
            }
            $ar_error .= $CheckError->Email($email);

            if($ar_error > 0) {header("Location: http://wm-rb.net"); exit();}
            //Добавление завки
            $db_pay_desk->add_demand_nal($did,$output,$input,$card,$period,$purse_in,$out_val,$in_val,$email,$date_pay,$time_pay,$_COOKIE['partner_id']);
            setcookie("partner_id", "", time() + 31104000, "/", "wm-rb.net");
            setcookie($output."_1", $card, time() + 31104000, "/", "wm-rb.net");
            setcookie($output."_2", $period, time() + 31104000, "/", "wm-rb.net");
            setcookie("purse_".$input, $purse_in, time() + 31104000, "/", "wm-rb.net");
            setcookie("email", $email, time() + 31104000, "/", "wm-rb.net");
            //Добавление номера платежа
            $db_admin->add_id_pay($did,$_SERVER['REMOTE_ADDR'],$_SERVER['HTTP_X_FORWARDED_FOR']);

            $from_name = "Robot exchange, WM-RB.net";
            $subject = "Номер заявки";
            $body = "
<center>Здравствуйте</center><br /><br />
Номер Вашей заявки : <b>{$did}</b><br />
Проверить статус заявки Вы можете узнать <a href='http://wm-rb.net/user_check_cash.aspx'>здесь</a>
<br />
Мы будем благодарны Вам за любые предложения, высказанные по поводу того,
какой Вы хотите видеть сервис платежей WM-RB.net.<br /><br />

Благодарим Вас за использование нашего сервиса.<br />
Это письмо отправлено роботом, ответа не требует.<br />
<br />--<br />
С уважением,<br />
Администрация WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>Сервис платежей WebMoney в Республике Беларусь<br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq
";
            smtpmail($email,$subject,$body,$from_name);
            header("Location: http://wm-rb.net/user_check_cash.aspx?d_cash=$did");
        }
    }

//Обработка заявки на пополнение наличными
    elseif (!empty($_POST['output_NAL'])) {

        $db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
        $db_exchange = new CustomSQL_exchange($DBName_exchange);
        //форматирование данных
        $in_val = substr(trim(stripslashes(htmlspecialchars($_POST['in_val']))),0,16);
        $out_val = substr(trim(stripslashes(htmlspecialchars($_POST['out_val']))),0,16);
        $output = substr(trim(stripslashes(htmlspecialchars($_POST['oplata']))),0,16);
        $p_output = substr(trim(stripslashes(htmlspecialchars($_POST['p_output']))),0,32);
        $name_card = substr(trim(stripslashes(htmlspecialchars($_POST['name_uslugi']))),0,16);
        $number_card = substr(trim(stripslashes(htmlspecialchars($_POST['number_card']))),0,32);
        $period = substr(trim(stripslashes(htmlspecialchars($_POST['period']))),0,32);
        $did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10);
        $email = substr(trim(stripslashes(htmlspecialchars($_POST['email']))),0,64);
        $wmid = substr(trim(stripslashes(htmlspecialchars($_POST['wmid']))),0,12);
        $user_surname = substr(trim(stripslashes(htmlspecialchars($_POST['user_surname']))),0,32);
        $user_name = substr(trim(stripslashes(htmlspecialchars($_POST['user_name']))),0,32);
        $name_bank = substr(trim(stripslashes(htmlspecialchars($_POST['name_bank']))),0,32);

        $info_card = $db_pay_desk->exch_balance($name_card);
        $us = $db_pay_desk->info_card($name_card);

        $ar_error = $CheckError->Did($did);
        $ar_error .= $CheckError->Inval($in_val);
        $ar_error .= $CheckError->Inval($out_val);
        if($out_val < $info_card[0]['min_pay']) {$ar_error .=1;} else {$ar_error .=0;}
        if(empty($period)) {
            $ar_error .= $CheckError->checkN($number_card,"8");
        } else {
            $ar_error .= $CheckError->checkN($number_card,"16");
            $ar_error .= $CheckError->checkN($period,"4");
        }

        $ar_error .= $CheckError->Email($email);
        $ar_error .= $db_exchange->CheckRate($in_val-$info_card[0]['obligatory_payment'],$out_val,$output."_".$name_card,$name_card);
        if($output == "WMZ" || $output == "WMR" || $output == "WME" || $output == "WMG" || $output == "WMU" || $output == "WMY" || $output == "WMB") {
            $ar_error .= $CheckError->WMID($wmid);
            $ar_error .= $CheckError->UserSurname($user_surname);
            $ar_error .= $CheckError->UserName($user_name);
            $ar_error .= $CheckError->NameBank($name_bank);
        }
        //echo $ar_error;
        if($ar_error > 0) {header("Location: http://wm-rb.net"); exit();}

        //Добавление завки
        $db_pay_desk->add_dem_nal_out($did,$output,$number_card,$in_val,$out_val,$p_output,$name_card,$period,$email,$date_pay,$time_pay,$_COOKIE['partner_id'],$wmid,$user_surname,$user_name,$name_bank);
        //Добавление номера платежа
        $db_admin->add_id_pay($did,$_SERVER['REMOTE_ADDR'],$_SERVER['HTTP_X_FORWARDED_FOR']);
        //установка куков для номера карты и срока действия
        setcookie("partner_id", "", time() + 31104000, "/", "wm-rb.net");
        setcookie($name_card."_1", $number_card, time() + 31104000, "/", "wm-rb.net");
        setcookie($name_card."_2", $period, time() + 31104000, "/", "wm-rb.net");
        if($output == "WMZ" || $output == "WMR" || $output == "WME" || $output == "WMG" || $output == "WMU" || $output == "WMY" || $output == "WMB") {
            setcookie("wmid", $wmid, time() + 31104000, "/", "wm-rb.net");
            setcookie("user_surname", $user_surname, time() + 31104000, "/", "wm-rb.net");
            setcookie("user_name", $user_name, time() + 31104000, "/", "wm-rb.net");
            setcookie("name_bank", $name_bank, time() + 31104000, "/", "wm-rb.net");
            setcookie("email", $email, time() + 31104000, "/", "wm-rb.net");

            //проверка вводимых данных о владельце карты в центре аттестации
            include($atm_dir."nncron/xml/conf.php");
            include($atm_dir."nncron/xml/wmxiparser.php");
            $parser = new WMXIParser();
            $response = $wmxi->X19(
                $_POST["operation_type"],				# operation_type
                $output, 					# pursetype
                floatval($in_val),				# Сумма
                $wmid,'',$user_surname,$user_name,$name_bank,'',$number_card,'','');
            $structure = $parser->Parse($response, DOC_ENCODING);
            $transformed = $parser->Reindex($structure, true);
            $kod_error = htmlspecialchars(@$transformed["passport.response"]["retval"], ENT_QUOTES);
            $desc_error = htmlspecialchars(@$transformed["passport.response"]["retdesc"], ENT_QUOTES);
            if($kod_error != "0") {
                $db_pay_desk->dem_coment_output($desc_error,$did);
                $db_pay_desk->demand_edit_cash_out('er',$did);}

        }
        /*
        $res = $db_pay_desk->search_card($number_card,$period);
            if(empty($res)) {$db_pay_desk->dem_coment_output("Севис отказал Вам в выполнении данной операции. За разъяснениями обратитесь в Службу поддержки.",$did);
            $db_pay_desk->demand_edit_cash_out('er',$did);}
        */

        $from_name = "Robot exchange, WM-RB.net";
        $subject = "Номер заявки";
        $body = "
<center>Здравствуйте</center><br /><br />
Номер Вашей заявки : <b>{$did}</b><br />
Проверить статус заявки Вы можете узнать <a href='http://wm-rb.net/user_check_cash.aspx'>здесь</a>
<br />
Мы будем благодарны Вам за любые предложения, высказанные по поводу того,
какой Вы хотите видеть сервис платежей WM-RB.net.<br /><br />

Благодарим Вас за использование нашего сервиса.<br />
Это письмо отправлено роботом, ответа не требует.<br />
<br />--<br />
С уважением,<br />
Администрация WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>Сервис платежей WebMoney в Республике Беларусь<br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq
";
        //smtpmail($email,$subject,$body,$from_name);
        header("Location: http://wm-rb.net/user_check_cash.aspx?d={$did}");
    }
}
//else {header("Location: http://wm-rb.net/output_nal.aspx");}


//оформление заявки для магазина
elseif (!empty($_POST['pay_eshop'])) {
    if (empty($_POST['pay_eshop']))  {header("Location: http://wm-rb.net/e-shop.aspx");}
    else {
        $db_pay_desk = new CustomSQL_pay_desk($DBName_pay_desk);
        $did = substr(trim(stripslashes(htmlspecialchars($_POST['did']))),0,10);
        $a_goods = substr(trim(stripslashes(htmlspecialchars($_POST['a_goods']))),0,5);
        $id_goods = substr(trim(stripslashes(htmlspecialchars($_POST['id_goods']))),0,5);
        $amount_goods = substr(trim(stripslashes(htmlspecialchars($_POST['amount_goods']))),0,5);
        $akk = substr(trim(stripslashes(htmlspecialchars($_POST['akk']))),0,25);
        $purse = substr(trim(stripslashes(htmlspecialchars($_POST['purse']))),0,32);
        $email = substr(trim(stripslashes(htmlspecialchars($_POST['email']))),0,64);

        $ar_error = $CheckError->Did($did);
        $ar_error .= $CheckError->numeral($amount_goods);
        $ar_error .= $CheckError->Email($email);

        if($ar_error > 0) {header("Location: http://wm-rb.net"); exit();}

        $goods = $db_pay_desk->goods_name($id_goods);
        if($goods[0]['price'] >= $amount_good) {
            $amount = $amount_goods * $goods[0]['price'];

            //Добавление завки
            $db_pay_desk->add_dem_eshop($did,$_POST['oplata'],$goods[0]['name_cat'],$purse,$amount,$amount_goods,$akk,$email,$date_pay,$time_pay,$_COOKIE['partner_id']);
            //установка куков для номера карты и срока действия
            setcookie("purse_eshop", $purse, time() + 31104000, "/", "wm-rb.net");
            setcookie("email", $email, time() + 31104000, "/", "wm-rb.net");
            setcookie("akk", $akk, time() + 31104000, "/", "wm-rb.net");
            //Добавление номера платежа
            $db_admin->add_id_pay($did,$_SERVER['REMOTE_ADDR'],$_SERVER['HTTP_X_FORWARDED_FOR']);
            $from_name = "Robot exchange, WM-RB.net";
            $subject = "Покупка товаров через Сервис электронных платежей WM-RB.net";
            $body = "
<center>Здравствуйте</center><br /><br />
Номер Вашей заявки : <b>{$did}</b><br />
Проверить статус заявки Вы можете узнать <a href='http://wm-rb.net/user_check_eshop.aspx?d={$did}'>здесь</a>
<br />
Мы будем благодарны Вам за любые предложения, высказанные по поводу того,
какой Вы хотите видеть сервис платежей WM-RB.net.<br /><br />

Благодарим Вас за использование нашего сервиса.<br />
Это письмо отправлено роботом, ответа не требует.<br />
<br />--<br />
С уважением,<br />
Администрация WM-RB.net<br />
<br />
<a href='http://wm-rb.net'>Сервис платежей WebMoney в Республике Беларусь<br />
Mail: <a href='mailto:$support'>$support</a><br />
ICQ: $icq
";
            smtpmail($email,$subject,$body,$from_name);
            header("Location: http://wm-rb.net/user_check_eshop.aspx?d=$did");
        }
    }
}

unset($_SESSION['id']);
session_destroy();

//else { header("Location: http://wm-rb.net/index.aspx"); exit(); }
?>