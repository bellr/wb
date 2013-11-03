<?php
function smtpmail($mail_to,$subject,$message,$from_name,$headers='') {
$smtp_username = 'support@wm-rb.net';  //Смените на имя своего почтового ящика.
$smtp_port     = '25'; // Порт работы. Не меняйте, если не уверены.
$smtp_host     = 'wm-rb.net';  //сервер для отправки почты(для наших клиентов менять не требуется)
$smtp_password = '16201986';  //Измените пароль
$smtp_debug    = true;  //Если Вы хотите видеть сообщения ошибок, укажите true вместо false
$smtp_charset  = 'Windows-1251';   //кодировка сообщений. (или UTF-8, итд)
$smtp_from     = 'Support Team WM-RB.net'; //Ваше имя - или имя Вашего сайта. Будет показывать при прочтении в поле "От кого"
        $SEND =   "Date: ".date("D, d M Y H:i:s") . " UT\r\n";
        $SEND .=   'Subject: '.$subject."\r\n";
        if ($headers) $SEND .= $headers."\r\n\r\n";
        else
        {
                $SEND .= "Reply-To: ".$smtp_username."\r\n";
				$SEND .= 'Return-Path: <' . $smtp_username . ">\n";
				$SEND .= 'Sender: <' . $smtp_username . ">\n";
                $SEND .= "MIME-Version: 1.0\r\n";
				$SEND .= "Precedence: bulk\r\n";
                $SEND .= "Content-Type: text/html; charset=\"".$smtp_charset."\"\r\n";
                $SEND .= "Content-Transfer-Encoding: 8bit\r\n";
                $SEND .= "From: \"".$from_name."\" <".$smtp_username.">\r\n";
                $SEND .= "To: $mail_to <$mail_to>\r\n";
                $SEND .= "X-Priority: 3\r\n\r\n";
        }
        $SEND .=  $message."\r\n";
         if( !$socket = fsockopen($smtp_host, 25, $errno, $errstr, 30) ) {
            if ($smtp_debug) echo $errno."&lt;br&gt;".$errstr;
            return false;
         }
	fputs($socket, "HELO " . $smtp_host . "\r\n");
	fputs($socket, "AUTH LOGIN\r\n");
	fputs($socket, base64_encode($smtp_username) . "\r\n");
	fputs($socket, base64_encode($smtp_password) . "\r\n");
	fputs($socket, "MAIL FROM: <".$smtp_username.">\r\n");
	fputs($socket, "RCPT TO: <" . $mail_to . ">\r\n");
	fputs($socket, "DATA\r\n");
	fputs($socket, $SEND."\r\n.\r\n");
	fputs($socket, "QUIT\r\n");
	fclose($socket);
	return TRUE;
/*
            if (!server_parse($socket, "220", __LINE__)) return false;

            fputs($socket, "HELO " . $smtp_host . "\r\n");
            if (!server_parse($socket, "250", __LINE__)) {
               if ($smtp_debug) echo '<p>Не могу отправить HELO!</p>';
               fclose($socket);
               return false;
            }
            fputs($socket, "AUTH LOGIN\r\n");
            if (!server_parse($socket, "334", __LINE__)) {
               if ($smtp_debug) echo '<p>Не могу найти ответ на запрос авторизаци.</p>';
               fclose($socket);
               return false;
            }
            fputs($socket, base64_encode($smtp_username) . "\r\n");
            if (!server_parse($socket, "334", __LINE__)) {
               if ($smtp_debug) echo '<p>Логин авторизации не был принят сервером!</p>';
               fclose($socket);
               return false;
            }
            fputs($socket, base64_encode($smtp_password) . "\r\n");
            if (!server_parse($socket, "235", __LINE__)) {
               if ($smtp_debug) echo '<p>Пароль не был принят сервером как верный! Ошибка авторизации!</p>';
               fclose($socket);
               return false;
            }
            fputs($socket, "MAIL FROM: <".$smtp_username.">\r\n");
            if (!server_parse($socket, "250", __LINE__)) {
               if ($smtp_debug) echo '<p>Не могу отправить комманду MAIL FROM: </p>';
               fclose($socket);
               return false;
            }
            fputs($socket, "RCPT TO: <" . $mail_to . ">\r\n");

            if (!server_parse($socket, "250", __LINE__)) {
               if ($smtp_debug) echo '<p>Не могу отправить комманду RCPT TO: </p>';
               fclose($socket);
               return false;
            }
            fputs($socket, "DATA\r\n");

            if (!server_parse($socket, "354", __LINE__)) {
               if ($smtp_debug) echo '<p>Не могу отправить комманду DATA</p>';
               fclose($socket);
               return false;
            }
            fputs($socket, $SEND."\r\n.\r\n");

            if (!server_parse($socket, "250", __LINE__)) {
               if ($smtp_debug) echo '<p>Не смог отправить тело письма. Письмо не было отправленно!</p>';
               fclose($socket);
               return false;
            }
            fputs($socket, "QUIT\r\n");
            fclose($socket);
            return TRUE;
}
function server_parse($socket, $response, $line = __LINE__) {
        global $config;
    while (substr($server_response, 3, 1) != ' ') {
        if (!($server_response = fgets($socket, 256))) {
                   if ($smtp_debug) echo "<p>Проблемы с отправкой почты!</p>$response<br>$line<br>";
                   return false;
                }
    }
    if (!(substr($server_response, 0, 3) == $response)) {
           if ($smtp_debug) echo "<p>Проблемы с отправкой почты!</p>$response<br>$line<br>";
           return false;
        }
    return true;
*/
}
?>
