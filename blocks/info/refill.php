<?
class refill extends Template {
    function __construct($action_method,$vars=array()) {
        $this->$action_method();
    }

    private function block() {
        //$controller = inputData::init()->controller;

        //$this->vars['data'] = $this->iterate_tmpl('info',__CLASS__,$controller);


        return $this->vars;
    }
}

?>