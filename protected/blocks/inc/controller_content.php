<?
class controller_content extends Template {

    public function block($P) {

        $controller = $P->controller;
        $left = Config::$processorVars[$controller]['left'];
        $content = Config::$processorVars[$controller]['content'];
        $right = Config::$processorVars[$controller]['right'];

        if(isset($left) && count($left)) {

            foreach($left as $source => $block) {

                if(is_numeric($source)) $source = null;

                $l['content_left'] .= Vitalis::tmpl($source)->load_tmpl_block($block,array());
            }
            $this->vars['content_left'] = $this->iterate_tmpl('inc',__CLASS__,'left',$l);
        }

        if(isset($content) && count($content) > 0) {

            foreach($content as $source => $block) {

                if(is_numeric($source)) $source = null;

                $this->vars['content'] .= Vitalis::tmpl($source)->load_tmpl_block($block,array());
            }
        }

        if(isset($right) && count($right)) {

            foreach($right as $source => $block) {

                if(is_numeric($source)) $source = null;

                $r['content_right'] .= Vitalis::tmpl($source)->load_tmpl_block($block,array());
            }

             $this->vars['content_right'] = $this->iterate_tmpl('inc',__CLASS__,'right',$r);
        }

        return $this;
    }
}

?>