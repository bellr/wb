<?
class info extends Template {

    public function block($P) {

        $this->vars['data'] = $this->iterate_tmpl('info',__CLASS__,$P->controller);


        return $this;
    }
}

?>