<?
class wm_example extends Template {

    function __construct($action_method,$vars) {
        $this->vars = $vars;
        $this->$action_method();
    }


	
	
    private function block() {
        $P = inputData::init();
		foreach(Config::$wmBase['all_wmid'] as $k=>$ar) {
			$html .= '<option value="'.$k.'">'.$ar.'</option>';
		}
		$vars['interface'] = parent::iterate_tmpl('webmoney',__CLASS__,$P->interface,array('option'=>$html,'interface'=>$P->interface));
	
        return $this->vars = $vars;
    }
	
	
	
	
	private function process() {
        $P = inputData::init();

		$name_interface = $P->interface;

		switch ($P->interface) {
		case 'x9':
			$res = eWebmoney::x9(null,$P->type_wmid);
			foreach($res->purses->purse as $r) {
				echo $r->pursename.' - '.$r->amount.' '.$r->desc.'<br>';
			}

		break;
		case 'x1':
			$res = eWebmoney::x1((array)$P,$P->type_wmid);
			d($res);
		break;
		case '2':echo('автор');break;
		case '3':echo('клиент');break;
		case '4':echo('посредник');break;
		}; 
		

	}
}

?>