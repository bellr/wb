function ajaxComplete(parms) {
    //var action = parms.act.split('.')[1];
    action = parms.act.split('.')[1];
    var data = parms.req.responseText.split('|');

    if(!document.getElementById(action) && parms.block == "block") {
        var l = CreatElement('div',action);
        l.innerHTML = parms.req.responseText;

        if(parms.onSwitch) 
            switchComplete(parms);
		
    } else {
        switchComplete(parms);
        if(parms.endComplete == true) {
            endComplete(parms.req.responseText);
        }
    }
}

function switchComplete(parms) {
    if(parms.typeResponse == 'json') {
        var resJson = eval("(" + parms.req.responseText + ")");
    } else if(parms.typeResponse == 'html') {
        var resHtml = parms.req.responseText;
    }


    switch (action) {
        case 'work_table_custm' :
            hide('footer');
            break;
        case 'order_stat_price' :
            document.getElementById('workbox').innerHTML = resJson.data;
            break;
        case 'is_reminder' :
            if(resJson.status) {
                $(".alertMbox").animate({opacity: "show", bottom: "5"}, "slow");
                document.title=resJson.title;
                document.getElementById('alertMbox').innerHTML = resJson.data;
            }
            break;
        case 'edit_user' :

            if(resJson.subAction == 'move_to_archive') {
                remove('box'+resJson.uid);
            } else if(resJson.subAction == 'delete_user') {
                remove('edit_user');
                remove('jobTable');
                remove('box'+resJson.uid);
                show('footer');
            } else if(resJson.subAction == 'move_table_customer') {

                var idBox = 'box'+resJson.uid;
                var cloneData = document.getElementById(idBox).cloneNode(true);
                append(document.getElementById('columnCustm'+parms.extra.columnInsert),cloneData);
                //alert(cloneData.innerText);
                remove(idBox);
                //setInterval(function(){remove(idBox)},1000);

            }

            break;
        case 'add_customer' :
            append(document.getElementById('columnCustm'+parms.extra.columnInsert),resJson.data);

            break;

        case 'move_table_customer' :
            alert('sdadasddd');

            break;
    }
}

function endComplete(successData) {
    var successData = eval("("+successData+")");

    if(successData.status == 0) {
        var boxClassName = 'loadingDoc';
        var waitTime = 2000;
    } else if(successData.status == 1) {
        var boxClassName = 'resError';
        var waitTime = 4000;
    } else if(successData.status == 10) {
        var boxClassName = 'loadingDoc';
        var waitTime = 1500;
        remove(action);
    }

    document.getElementById('notify').className = boxClassName;
	document.getElementById('notify').innerHTML = successData.message;
    show('notifyblock'); 
    setTimeout(function(){hide('notifyblock');}, waitTime);
}

function ajaxComplete_old(parms) {
    var action = parms.act;
    var data = parms.req.responseText.split('|');
    if(data[0] != 100) {
        if(!document.getElementById(action)) {
            l = CreatElement('div',action);
            l.innerHTML = parms.req.responseText;
        }
    }

    switch (action) {
        case 'restoreCustm' :
            if(typeof(data[2]) != 'undefined') {
                ar = data[2].split(':');
                remove('box'+ar[0]);
                cElem('div','box'+ar[0],'boxCustm',document.getElementById(ar[2]));
                document.getElementById('box'+ar[0]).innerHTML = '<IMG class="rightCustm" height="16" src="http://asop.su/asop/skin/default/images/empty16_16.png" width="16" border="0" /><div id="'+ar[0]+'" class="sc">&nbsp;</div><div onclick=ajaxVs({act:"members.work_table_custm",p:"cid='+ar[0]+'",onSwitch:true,typeResponse:"html"});>'+ar[3]+'</div>';
                operOk(ar[1],'');
            }
            break;
        case 'isreadReminder' :
            remove('br_'+data[1]);
            if($("div#alertMbox .strReminder").length == 0) {hide('alertMbox');document.title=oldTxt;}
            break;
        //default : alert(mes['errorTransfer']);

    }
}



//old function becourse work
function checkEasyPay(oper,did,sh,url) {
		url  = url+'/include/ajax.aspx?o='+oper+'&did='+did+'&sh='+sh;
		req = loadXMLDoc();
   if (req) {
     req.open("GET", url, true);
     req.onreadystatechange = processCheckHistory;
     req.send(null);
   }
}
function checkEPHistory(oper,did,sh,url) {
		url  = url+'/include/ajax.aspx?o='+oper+'&did='+did+'&sh='+sh;
		req = loadXMLDoc();
   if (req) {
     req.open("GET", url, true);
     req.onreadystatechange = processCheckHistory;
     req.send(null);
   }
}
function checkPayExchEP(oper,did,sh) {
		url  = 'http://wm-rb.net/include/ajax.aspx?o='+oper+'&did='+did+'&sh='+sh;
		req = loadXMLDoc();
   if (req) {
     req.open("GET", url, true);
     req.onreadystatechange = processCheckHistory;
     req.send(null);
   }
}


function processCheckHistory() {
l = document.getElementById('load');
submit = document.getElementById('submit_check');
if (req.readyState == 4) {
	if (req.status == 200) {
		data = req.responseText;
	//alert(data);
	req = null;
		if(data == 'Payment_successfully') {
			l.innerHTML = '<b>Ваш платеж успешно проверен.<br>Ожидайте завершения операции.</b><br><br>СПАСИБО ЧТО ВЫБРАЛИ НАШ СЕРВИС';
			submit.style.display = 'none';
		}
		if(data == 'Payment_not_executed') {l.innerHTML = '<div class="red" style="margin-bottom:10px">ВАШ ПЛАТЕЖ НЕ НАЙДЕН!</div><div class="button" onclick=hide_box("load")>Закрыть</div>';}
		if(data == 'Pay_paid') {l.innerHTML = '<div class="red" style="margin-bottom:10px">ВАША ЗАЯВКА УЖЕ ВЫПОЛНЕНА!</div><div class="button" onclick=hide_box("load")>Закрыть</div>';}
		if(data == 'ERROR_connect') {l.innerHTML = '<div class="red" style="margin-bottom:10px">ОШИБКА ПОДКЛЮЧЕНИЯ С СЕРВЕРУ ПЛАТЕЖНОЙ СИСТЕМЫ!</div><div class="button" onclick=hide_box("load")>Закрыть</div>';}
	}
	else {alert("Невозможно загрузить документ:\n" + req.statusText);}
}
else {
	l.style.display = 'block';
	l.innerHTML = 'Подождите пожалуйста, идет проверка платежа...';
	}
}
function hide_box(box) {
document.getElementById(box).style.display = 'none';
}