<?
class creat_demand_widget extends Template {

    public function block() {

        $this->vars['creat_demand'] = Vitalis::tmpl('Widgets')->load_tmpl_block('exchanger.creat_demand');

        return $this;
    }
}

?>