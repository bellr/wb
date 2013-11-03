function ajaxVs(parms) {
    var optReq = {
        type: parms.type || "POST",
        timeout: parms.timeout || 5000,
        onComplete: parms.onComplete || function(){ajaxComplete(optReq);},
        onError: parms.onError || function(){},
        endComplete: parms.endComplete || true, //команда на вывод сообщения об успешном завершении операции или не очень успешном. Для того, что бы не выводить сообщение об успешном выполнении операции в параметрах указать endComplete:'false'
        //onSuccess: parms.onSuccess || function(){alert('dasdasdadd');endComplete(optReq.req.responseText)},
        onSwitch: parms.onSwitch || false, //указываем на необходимость обработки данных после окончания запроса
        typeResponse: parms.typeResponse || "json",
        block: parms.block || "block", //метод обработки данных внутри блока, block - вывод данных в браузер, process - так выводит данные, но используется для обработки данных
        act: parms.act || "", //действие, имя операция или функции
        p: parms.p || "", //дополнительные параметры
        sl: parms.sl || true, //отображения процесса загрузки. поумолчанию load(показывать, что бы отключить необходимо в объекте передать параметр sl:"fon")
        extra: parms.extra
    };

    var name_block = optReq.act.split('.')[1];

    if(optReq.block == 'block' && document.getElementById(name_block)) {
        show(name_block);
        return false;
    }
    var req = loadXMLDoc();

    if(optReq.sl == true) {show('loadingblock');}

    if (req) {
        req.open(optReq.type, 'index.aspx', true);
		if(optReq.type == 'POST') {
			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			if (req.overrideMimeType ) req.setRequestHeader("Connection", "close");
		}
        req.onreadystatechange = function() {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    optReq.req = req;
                    optReq.onComplete();
                    req = null;
                    if(optReq.sl == true) {hide('loadingblock');}
                }
                else {hide('loadingblock');showError('loadError','Error: '+req.statusText); return false;}
            }
        };
        req.send(optReq.block+'='+optReq.act+'&'+optReq.p);
    } else {alert('no req'); return false;}
	return false;
}

function loadXMLDoc() {
    try {
        req = new XMLHttpRequest();
    } catch (trymicrosoft) {
        try {
            req = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (othermicrosoft) {
            try {
                req = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (failed) {
                req = false;
            }
        }
    }
    return req;
}
function httpData(r,type) {
    var ct = r.getResponseHeader("content-type");
// Если не предоставлен тип по умолчанию, определение
// не возвращена ли с сервера какая-либо форма XML
    var data = !type && ct && ct.indexOf("xml") >= 0;
// Получение объекта XML-документа, если сервер вернул XML,
// если нет — возвращение полученного с сервера текстового
// содержимого
    data = type == "xml" || data ? r.responseXML : r.responseText;
// Если указан тип "script", выполнение возвращенного текста,
// реагируя на него, как на JavaScript
    if (type=="script")
        eval.call(window,data);
// Возвращение данных, полученных в ответе (или XML-документа, или
// текстовой строки)
    return data;
}
function CreatElement(element,id,classN) {
    var el = document.createElement(element);
    if(id) {el.id = id;}
    if(classN) {el.className = classN;}
    document.body.appendChild(el);
    return document.getElementById(id);
}
function cElem(element,id,classN,app) {
    var el = document.createElement(element);
    if(id) {el.id = id;}
    if(classN) {el.className = classN;}
    app.appendChild(el);
    return el;
}
function cElemData(element,id,classN,app,data) {
    var el = document.createElement(element);
    if(id) {el.id = id;}
    if(classN) {el.className = classN;}
    app.appendChild(el);
    el.appendChild(document.createTextNode(data));
    return el;
}
function cInput(element,type,name,classN,app) {
    var el = document.createElement(element);
    el.type = type;
    el.name = name;
    el.className = classN;
    el.size = '5';
    el.length = '5';
    app.appendChild(el);
    return el;
}
function remove(id) {
    if(typeof id != 'object') {
        var e=document.getElementById(id);
        if (e) e.parentNode.removeChild(e);
    } else {for(var i in id){remove(id[i]);}}
}

function CountSymbol(obj,count) {if(text(obj).length > count) {alert(mes['countError']);}}

function creatDate() {
    var t=new Date();
    var d=t.getDate();
    var m=t.getMonth();
    var y=t.getFullYear();
    var h=t.getHours()
    var min=t.getMinutes()
    if (d<=9) d='0'+d;
    if (m<=9) m='0'+m;
    if (h<=9) h='0'+h;
    if (min<=9) min='0'+min;
    return d+'.'+m+'.'+y+' '+h+':'+min;
}
function formatData(date) {
    var ar = date.split('-');
    return ar[2]+' '+mOffer[ar[1]]+' '+ar[0];
}
function setCookie(name,value,expires,domain) {
    var oneWeek = expires * 24 * 60 * 60 * 1000;
    var expDate = new Date () ;
    expDate.setTime (expDate.getTime() + oneWeek);
    document.cookie=name+"="+value+";expires="+expDate. toGMTString()+"; path=/; "+domain;
}

function getCookie(name) {
    var prefix = name + "="
    var cookieStartIndex = document.cookie.indexOf(prefix)
    if (cookieStartIndex == -1)
        return null
    var cookieEndIndex = document.cookie.indexOf
        (";", cookieStartIndex + prefix.length)
    if (cookieEndIndex == -1)
        cookieEndIndex = document.cookie.length
    return unescape(document.cookie.substring
        (cookieStartIndex + prefix.length, cookieEndIndex))
}

function deleteCookie(name, path, domain) {
    if (getCookie(name)) {
        document.cookie = name + "=" +
            ((path) ? "; path=" + path : "") +
            ((domain) ? "; domain=" + domain : "") +
            "; expires=Thu, 01-Jan-70 00:00:01 GMT"
    }
}

function pageX(elem) {
    return elem.offsetParent ?
        elem.offsetLeft + pageX( elem.offsetParent ) :
        elem.offsetLeft;
}
function pageY(elem) {
    return elem.offsetParent ?
        elem.offsetTop + pageY( elem.offsetParent ) :
        elem.offsetTop;
}

function parentX(elem) {
    return elem.parentNode == elem.offsetParent ?
        elem.offsetLeft :
        pageX( elem ) -pageX( elem.parentNode );
}
function parentY(elem) {
    return elem.parentNode == elem.offsetParent ?
        elem.offsetTop :
        pageY( elem ) -pageY( elem.parentNode );
}

function loadCSS(id) {
    var head = document.getElementsByTagName("head")[0];
    link = head.getElementsByTagName("link");
    flagcss = '0';
    if(flagcss == '0') {
        for ( var i = 0; i < link.length; i++ ) {
            if(link[i].getAttribute('id') == id+'_css') {flagcss = '1';}
        }
    }        if(flagcss == '0') {
        var el = document.createElement('link');
        el.id=id+'_css';
        el.rel='stylesheet';
        el.media='all';
        el.type='text/css';
        el.href='http://test.migom.by/css/'+id+'.css';
        head.appendChild(el);
    }
}
function loadScript(id) {
    var head = document.getElementsByTagName("head")[0];
    var script = head.getElementsByTagName("script");
    var flagjs = '0';
    if(flagjs == '0') {
        for (var i=0; i<script.length; i++) {
            if(script[i].getAttribute('id') == id+'_js') {flagjs = '1';}
        }
    }
    if(flagjs == '0') {
        var el = document.createElement('script');
        el.id=id+'_js';
        el.type='text/javascript';
        el.language='javascript';
        el.src=baseWeb+'/js/'+id+'.js';
        head.appendChild(el);
    }
}
function serialize(a) {
	var s = [];
	if ( a.constructor == Array || typeof a == 'object') {
	for ( var i = 0; i < a.length; i++ )
	s.push( a[i].name + "=" + encodeURIComponent( a[i].value ) );
	} else {
	for ( var j in a )
	s.push( j + "=" + encodeURIComponent( a[j] ) );
	}
	return s.join("&");
}
/*function getFomrValue(obj) {
    var str = "";
    var select = document.getElementsByTagName("select");
    if(select) {for(var i=0;i<select.length;i++){if(obj[select[i].getAttribute('name')]){if(obj[select[i].getAttribute('name')].value) {str += "&"+select[i].getAttribute('name')+"="+encodeURIComponent(obj[select[i].getAttribute('name')].value);}}}}
    var textarea=document.getElementsByTagName("textarea");
    if(textarea){for (var i=0;i<textarea.length;i++){if(obj[textarea[i].getAttribute('name')]){if(obj[textarea[i].getAttribute('name')].value) {str += "&"+textarea[i].getAttribute('name')+"="+encodeURIComponent(obj[textarea[i].getAttribute('name')].value);}}}}
    var input=document.getElementsByTagName("input");

    if(input){for(var i=0;i<input.length;i++){
	if(obj[input[i].getAttribute('name')]){
		if(obj[input[i].getAttribute('name')].value){
			if(input[i].getAttribute('type')=="checkbox"){
		var value=obj[input[i].getAttribute('name')].value;
		if(input[i].checked){
		str += "&"+input[i].getAttribute('name')+"="+value;
		}
		}else {
		str += "&"+input[i].getAttribute('name')+"="+obj[input[i].getAttribute('name')].value;}
		}
	}}}
    return str;
}*/
function clearFomrValue(obj) {
    var select=document.getElementsByTagName("select");
    if(select){for(var i=0;i<select.length;i++){if(obj[select[i].getAttribute('name')]){if(obj[select[i].getAttribute('name')].value) {obj[select[i].getAttribute('name')].value = 'none';}}}}
    var textarea=document.getElementsByTagName("textarea");
    if(textarea){for(var i=0;i<textarea.length; i++ ){if(obj[textarea[i].getAttribute('name')]){if(obj[textarea[i].getAttribute('name')].value) {obj[textarea[i].getAttribute('name')].value = '';}}}}
    var input=document.getElementsByTagName("input");
    if(input){for(var i=0;i<input.length;i++){if(obj[input[i].getAttribute('name')]) {if(obj[input[i].getAttribute('name')].value) {obj[input[i].getAttribute('name')].value = '';}}}}
}

function hide(id){if(typeof id != 'object') {id=document.getElementById(id);}id.style.display = 'none';}
function show(id){if(typeof id != 'object') {id=document.getElementById(id);}id.style.display = 'block';}
function hideOnmouse(id) {if(typeof id != 'object') {id=document.getElementById(id);}
    id.onmouseover = function(e){this.style.display = "block";};
    id.onmouseout = function(e){this.style.display = "none";};
}
function remove(id) {
    if(typeof id != 'object') {
        var e=document.getElementById(id);
        if (e) e.parentNode.removeChild(e);
    } else {for(var i in id){remove(id[i]);}}
}
function before(parent,before,elem) {
    if (elem==null) {
        elem = before;
        before = parent;
        parent = before.parentNode;
    }
    var elems = checkElem(elem);
    for(var i=elems.length-1;i>=0;i--) {
        parent.insertBefore(elems[i],before);
    }
}
function append(parent,elem) {
    var elems=checkElem(elem);
    for (var i=0;i<elems.length;i++) {
        parent.appendChild(elems[i]);
    }
}
function checkElem(a) {
    var r = [];
    if(a.constructor != Array) a=[a];
    for (var i=0;i<a.length;i++) {
        if (a[i].constructor == String) {
            var div=document.createElement("div");
            div.innerHTML=a[i];
            for ( var j=0; j<div.childNodes.length; j++)
                r[r.length] = div.childNodes[j];
        } else if(a[i].length ) {
            for (var j=0; j<a[i].length; j++)
                r[r.length] = a[i][j];
        } else {r[r.length] = a[i];}
    }
    return r;
}

//возвращает массив найденных елементов
function findElement(name,type) {
    //заменить на el.querySelector('.test') и на document.querySelectorAll('UL > LI:last-child');
    var r=[]; var re=new RegExp("(^|\\s)"+name+"(\\s|$)");
    if(typeof type=='object') {var e=type.getElementsByTagName("*");}
    else {var e=document.getElementsByTagName(type || "*");}
    for (var j=0;j<e.length;j++) {if(re.test(e[j].className)) {r.push(e[j]);}}
    if(r.length==1) {r=r[0];}
    return r;
}

function text(e) {var t="";var e=e.childNodes||e;for(var j=0;j<e.length;j++){t+=e[j].nodeType!=1?e[j].nodeValue : text(e[j].childNodes);}return t;}
function isDOMReady() {
    if (domReady.done) return false;
    if (document && document.getElementsByTagName && document.getElementById && document.body) {
        clearInterval(domReady.timer);
        domReady.timer = null;
        for (var i=0; i<domReady.ready.length;i++)
            domReady.ready[i]();
        domReady.ready = null;
        domReady.done = true;
    }
}
function domReady(f) {
    if (domReady.done) return f();
    if (domReady.timer) {
        domReady.ready.push(f);
    } else {
        //addEvent(window, "load", isDOMReady);
        domReady.ready = [f];
        domReady.timer = setInterval(isDOMReady, 13);
    }
}

//загрузка файла через ajax
function file_send(idForm,data) {
    sendForm(idForm, baseWeb+"/index.php?process="+idForm+"&"+data, callback);
    return false;
}
function sendForm(form, url, callfunc) {
    if (!document.createElement) return;
    if (typeof(form)=="string") form=document.getElementById(form);
    var frame=createIFrame();
    var act = form.getAttribute('action');
    frame.onSendComplete = function() {callfunc(form,act,getIFrameXML(frame));};
    form.setAttribute('target', frame.id);
    form.setAttribute('action', url);
    form.submit();
}

function createIFrame() {
    var id = 'f' + Math.floor(Math.random() * 99999);
    var div = document.createElement('div');
    div.innerHTML = "<iframe style=\"display:none\" src=\"about:blank\" id=\""+id+"\" name=\""+id+"\" onload=\"sendComplete('"+id+"')\"></iframe>";
    document.body.appendChild(div);
    return document.getElementById(id);
}

function sendComplete(id) {
    var iframe=document.getElementById(id);
    if (iframe.onSendComplete &&
        typeof(iframe.onSendComplete) == 'function') iframe.onSendComplete();
}

function getIFrameXML(iframe) {
    var doc=iframe.contentDocument;
    if (!doc && iframe.contentWindow) doc=iframe.contentWindow.document;
    if (!doc) doc=window.frames[iframe.id].document;
    if (!doc) return null;
    if (doc.location=="about:blank") return null;
    if (doc.XMLDocument) doc=doc.XMLDocument;
    return doc;
}

function callback(form,act,doc) {
    form.setAttribute('action', act);
    form.removeAttribute('target');

    //var ar = doc.body.innerHTML.split('');
//alert(doc.body.innerHTML);
    endComplete(doc.body.innerHTML);



    //if(ar[0] == 0) {operOk(ar[1],'lPrice');}
    //if(ar[0] == 1) {operOk(ar[1],'lPrice');}
    ///if(ar[0] == 2) {hide('lPrice');LoadWindowP('preLoadPrice','hidden',ar[2]);}
    //if(ar[0] == 10) {operOkClose(ar[1],'openNote');}
}
//загрузка файла через ajax

