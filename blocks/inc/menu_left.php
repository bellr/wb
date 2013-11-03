<?
class menu_left extends Template {
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

        $kurs = dataBase::DBexchange()->select('kurs',
            'direction, main',
            'where status=1',
            'order by id asc');

        foreach($balance as $b) {
            $name_cur[$b['name']] = $b['desc_val'];
        }

        foreach($balance as $b) {

            foreach($kurs as $k) {
                if($b['name'] == $k['main']) {
                    $p = explode('_',$k['direction']);
                    $k['output_min'] = $p[0];
                    $k['input_min'] = $p[1];
                    $k['output'] = $p[0];
                    $k['input'] = $name_cur[$p[1]];
                    $b['item'] .= $this->iterate_tmpl('inc',__CLASS__,'item',$k);
                }
            }
            $this->vars['iterate'] .= $this->iterate_tmpl('inc',__CLASS__,'iterate',$b);
            $b['item'] = '';
        }


        return $this->vars;
    }
}

?>