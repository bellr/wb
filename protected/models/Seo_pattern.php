<?php
class Seo_pattern extends Model {

    public $is_mCache = false;

    public function getInfoModel() {
        $P = inputData::init();

        if($_SERVER['REQUEST_URI'] != '/') {
            $url = str_replace('//','/',$P->controller.'/'.$P->object.'/');
        }

        $url = '/'.$url;

        $res = Cache::mysql('main','seo_pattern',
            "select title, description, keywords
            from seo_pattern
            where project='".strtolower(PROJECT)."' and pattern='{$url}'"
        );

        return $res[0];
    }
}
