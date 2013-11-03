<?
abstract class Monster {
    public  $size; // размер
    public  $weight; // вес
    public  $aggressive; // статус (аресивный, добрый)

    abstract public function  demeanor($action); //поведение
   
    public function  initialization($arr){ //инициализация
   
        $this->size       = $arr['size'];
        $this->weight     = $arr['weight'];        
        $this->aggressive = $arr['aggressive'];
    }
   
    public function  print_data(){// вывод данных       
        echo "<br/>";
        print_r($this);
    }
}

// Класс описывающий первого монстра (Зомби)
class Monster_Zombie  extends Monster{
    public function __construct($arr){     
        $this->initialization($arr);   
    }
    //Поведение зомби
    public function  demeanor($action){
        if($action==1){
        $this->aggressive="yes";
        }else
        {
        $this->aggressive="no";
        }
        return $action;
    }
 }

// Класс описывающий второго  монстра
 class Monster_Alien  extends Monster{
    public function __construct($arr){     
        $this->initialization($arr);   
    }
   
    public function  demeanor($action){
        if($action==1){
            echo "<br/>Злобный звук, призывающий к бою.";
        }
        return $action;
    }
 }

 $Zombie=new Monster_Zombie(array(
                "size"=>"big_size",
                "weight"=>"60kg",
                "aggressive"=>"no",
                ));

				$Zombie->print_data();
				$Zombie->demeanor(1);
				$Zombie->print_data();


exit;


 function getRemoteFileSize($url){
   $parse = parse_url($url);
   $host = $parse['host'];
   $fp = @fsockopen ($host, 80, $errno, $errstr, 20);
   if(!$fp){ 
     $ret = 0; 
   }else{
     $host = $parse['host'];
     fputs($fp, "HEAD ".$url." HTTP/1.1\r\n");
     fputs($fp, "HOST: ".$host."\r\n"); 
     fputs($fp, "Connection: close\r\n\r\n");
     $headers = "";
     while (!feof($fp)){ 
       $headers .= fgets ($fp, 128); 
     }
     fclose ($fp);
     $headers = strtolower($headers);
     $array = preg_split("|[\s,]+|",$headers);
     $key = array_search('content-length:',$array);
     $ret = $array[$key+1];
   }  
   if($array[1]==200) return $ret;
   else return -1*$array[1];
 }
 
 $url = 'http://wm-rb.net/3080_m.tgz';
 $size = getRemoteFileSize($url);
 if($size==0) echo "Не могу соединиться";
 elseif($size<0) echo "Ошибка. Код ответа HTTP: ".(-1*$size);
 else echo "Размер удалённого файла (bytes): ".$size; 

exit;
define('PROJECT','HOME');
define('VS_DEBUG',true);
require_once(dirname($_SERVER['DOCUMENT_ROOT'])."/core/vs.php");
phpinfo();
	//Vitalis::Mcache()->getStats();
//Vitalis::Mcache()->set('key', 'test', false, 10);

//d(Vitalis::Mcache()->get('key'));
//$memcache->set('key', $tmp_object, false, 10)

/*
$memcache = new Memcache;
$memcache->connect('localhost', 11211) or die ("?? ???? ????????????");

$version = $memcache->getVersion();
//$memcache->getStats();
echo "?????? ???????: ".$version."<br/>\n";*/