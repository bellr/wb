<?
class news_main extends Template {

    public function block($P) {

        if($P->controller == 'news') {
            $news = dataBase::DBmain()->select('news',
                '*',
                'order by id desc'
            );

        } else {
            $news = dataBase::DBmain()->select('news',
                '*',
                'order by id desc',
                'limit 5'
            );
            $this->vars['all_news_link'] = $this->iterate_tmpl('info',__CLASS__,'all_news_link');
        }


        foreach($news as $n) {
            $this->vars['iterate'] .= $this->iterate_tmpl('info',__CLASS__,'iterate',$n);
        }

        return $this;
    }
}

?>