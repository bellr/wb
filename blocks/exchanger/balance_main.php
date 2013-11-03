<?
class balance_main extends Template {
    function __construct($action_method,$vars='') {
        $this->$action_method();
    }

    private function block() {

        $balance = Cache::mysql('exchange','balance',
            'select name, balance, desc_val
            from balance
            where st_exch=1
            order by id asc',
            60);


        foreach($balance as $b) {
            $b['bal'] = number_format($b['balance'], 0, '.', ' ');
            $this->vars['iterate'] .= $this->iterate_tmpl('exchanger',__CLASS__,'iterate',$b);
        }

        return $this->vars;
    }
}

?>