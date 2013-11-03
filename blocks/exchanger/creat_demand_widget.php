<?
class creat_demand_widget extends Template {
    function __construct($action_method,$vars='') {
        $this->$action_method();
    }

    private function block() {
        $this->vars['creat_demand'] = Vitalis::tmpl('Widgets')->load_tmpl_block('exchanger.creat_demand');
        return $this->vars;
    }
}

?>