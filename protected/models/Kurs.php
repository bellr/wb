<?
class Kurs extends Model {

    public $prop;
    protected function getInfoModel($obj) {}

    public static function checkKurs($direction,$out_val,$in_val,$ex_out) {
        $u = dataBase::DBexchange()->select('kurs','konvers,direct',"where direction='{$direction}'");
        $sel_d = dataBase::DBmain()->select('discount','size_d',"where amount<".$out_val." and indef='".$ex_out."' and status='1'",'order by amount desc','limit 1');

        $sd = 1+$sel_d [0]['size_d']/100;

        if($u[0]["direct"] == "y") $format_out_val = $in_val*$u[0]["konvers"]*$sd;
        if($u[0]["direct"] == "n") $format_out_val = $in_val/$u[0]["konvers"]*$sd;

        $format_out_val = round($format_out_val,2);
        if($format_out_val != $out_val) {
            vsLog::add($direction.' '.$in_val.'->'.$out_val.'=='.$format_out_val.'('.$format_out_val.')','bad_rate');
            return $format_out_val;
        }

    }
}
