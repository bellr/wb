<?
class wm_example extends Template {

    public function block($P) {

        $PP = (array)Extension::Payments()->getParam('payments');

		foreach($PP['all_wmid'] as $k=>$ar) {
			$html .= '<option value="'.$k.'">'.$ar.'</option>';
		}
		$vars['interface'] = parent::iterate_tmpl('webmoney',__CLASS__,$P->interface,array('option'=>$html,'interface'=>$P->interface));
	
        return $this->vars = $vars;
    }




    public function process($P) {

		$name_interface = $P->interface;

		switch ($P->interface) {
            case 'x9':
                $res = Extension::Payments()->Webmoney()->x9(null,$P->type_wmid);
                foreach($res->purses->purse as $r) {
                    echo $r->pursename.' - '.$r->amount.' '.$r->desc.'<br>';
                }

            break;
            case 'x1':
                $res = Extension::Payments()->Webmoney()->x1((array)$P,$P->type_wmid);
                d($res);
            break;
            case '2':echo('автор');break;
            case '3':echo('клиент');break;
            case '4':echo('посредник');break;
		}; 
		

	}
}

?>