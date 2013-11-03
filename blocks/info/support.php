<?
class support extends Template {
    function __construct($action_method,$vars=array()) {
        $this->lang = $vars;
        $this->$action_method();
    }

    private function block() {
        $P = inputData::init();

        if($P->controller != 'support' || empty($P->object)) {
           $this->vars['email'] = $this->iterate_tmpl('info',__CLASS__,'email');
           $this->vars['owner_id'] = '0';
           $this->vars['action'] = 'add_message';
		   $this->vars['placeholder'] = 'Описывайте подробно Вашу проблему. Если вопрос касается выполнения заявки, указывайте ОБЯЗАТЕЛЬНО ее номер.';
        } else {
            $support = dataBase::DBadmin()->select('support',
                '*',
                "where indeficator='".$P->object."' and upd_date >= DATE_ADD(now(),INTERVAL -3 day)"
            );

			if(!empty($support)) {
	            $support_owner = dataBase::DBadmin()->select('support',
	                '*',
	                "where owner_id=".$support[0]['id'],
	                'order by add_date asc');

	            $this->vars['owner_id'] = $support[0]['id'];
	            $support[0]['who'] = '-user';
	            $support[0]['word'] = $this->lang['L_send_in'];
	            $support[0]['i'] = $this->lang['L_here_mail'];
	            $support[0]['date'] = date('d.m.Y в H:i',$support[0]['add_date']);

	            $this->vars['main_message'] = $this->iterate_tmpl('info',__CLASS__,'iterate',$support[0]);

	            if(!empty($support_owner)) {

	                foreach($support_owner as $sw) {
	                    $sw['date'] = date('d.m.Y в H:i',$sw['add_date']);
	                    $sw['who'] = $sw['author'] == 0 ? '-user' : '-support';
	                    $sw['i'] = $sw['author'] == 0 ? $this->lang['L_here_mail'] : $this->lang['L_answer_mail'];
	                    $sw['word'] = $sw['author'] == 0 ? $this->lang['L_send_in'] : $this->lang['L_send_from'];
	                    $this->vars['html'] .= $this->iterate_tmpl('info',__CLASS__,'iterate',$sw);
	                }
	            }
	            $this->vars['action'] = 'update_message';
			} else {
				$this->tmplName = 'empty';
				$this->vars['email'] = $this->iterate_tmpl('info',__CLASS__,'email');
				$this->vars['owner_id'] = '0';
				$this->vars['action'] = 'add_message';
			}
        }

        return $this->vars;
    }

    private function process() {
        $P = inputData::init();
        $status = 0;

        switch ($P->action) {
            case "add_message":

            sValidate::Email($P->email);
            sValidate::isInt($P->owner_id);
            sValidate::BodyMess($P->message);

            if(!sValidate::$code) {
                $indeficator = strtoupper(substr(md5($P->email.time()),0,16));
                dataBase::DBadmin()->insert('support',array(
                	'email'=>$P->email,
                	'message'=>$P->message,
                	'ip'=>$_SERVER['REMOTE_ADDR'],
                	'proxy' => $_SERVER['HTTP_X_FORWARDED_FOR'],
                	'add_date'=>time(),
                	'indeficator'=>$indeficator,
                	'upd_date'=>date('Y-m-d H:i:s',time())
                ));
                $message = $this->lang['L_send_ok'];

                $mail = mailSender::init();
                $mail->to = $P->email;
                $mail->subject = "[WM-RB.net] ".$this->lang['L_subject_mail'];
                $mail->message = parent::iterate_tmpl('emails',Config::getLang(),'add_message_support',array(
                    'bottom_support' => parent::iterate_tmpl('emails',Config::getLang(),'bottom_support'),
                    'indeficator' => $indeficator,
                    'url' => Config::$base['STATIC_URL'].'/support/'.$indeficator.'/',
                ));
                $mail->smtpmail();

            } else {
                $status = 1; $message = sValidate::$message;
            }

            break;
            case 'update_message';
                sValidate::isInt($P->owner_id);
                sValidate::BodyMess($P->message);

                if(!sValidate::$code) {
					dataBase::DBadmin()->update('support',array('status'=>0),'where id='.$P->owner_id);
                    dataBase::DBadmin()->insert('support',array(
                    	'message'=>$P->message,
                    	'ip'=>$_SERVER['REMOTE_ADDR'],
                    	'proxy'=>$_SERVER['HTTP_X_FORWARDED_FOR'],
                    	'add_date'=>time(),
                    	'owner_id'=>$P->owner_id
                    ));
                    $message = $this->lang['L_send_ok'];

                    /*$support_owner = dataBase::DBadmin()->select('support',
                        '*',
                        "where owner_id=".$support[0]['id'],
                        'order by add_date asc');*/

                    $sw['date'] = date('d.m.Y в H:i',time());
                    $sw['who'] = '-user';
                    $sw['i'] = $this->lang['L_here_mail'];
                    $sw['word'] = $this->lang['L_send_in'];
                    $sw['message'] = $P->message;
                    $html = $this->iterate_tmpl('info',__CLASS__,'iterate',$sw);

                } else {
                    $status = 1; $message = sValidate::$message;
                }
                break;
            case 'enter';

            break;
        }



        echo json_encode(array('status'=>$status,'message'=>$message,'html'=>$html,'appendElement'=>'support_content'));
    }
}

?>
