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


function processCheckHistory() {
l = document.getElementById('load');
submit = document.getElementById('submit_check');
if (req.readyState == 4) {
	if (req.status == 200) {
		data = req.responseText;
	//alert(data);
	req = null;
		if(data == 'Payment_successfully') {
			l.innerHTML = '<b>��� ������ ������� ��������.<br>�������� ���������� ��������.</b><br><br>������� ��� ������� ��� ������';
			submit.style.display = 'none';
		}
		if(data == 'Payment_not_executed') {l.innerHTML = '<div class="red" style="margin-bottom:10px">��� ������ �� ������!</div><div class="button" onclick=hide_box("load")>�������</div>';}
		if(data == 'Pay_paid') {l.innerHTML = '<div class="red" style="margin-bottom:10px">���� ������ ��� ���������!</div><div class="button" onclick=hide_box("load")>�������</div>';}
		if(data == 'ERROR_connect') {l.innerHTML = '<div class="red" style="margin-bottom:10px">������ ����������� � ������� ��������� �������!</div><div class="button" onclick=hide_box("load")>�������</div>';}
	}
	else {alert("���������� ��������� ��������:\n" + req.statusText);}
}
else {
	l.style.display = 'block';
	l.innerHTML = '��������� ����������, ���� �������� �������...';
	}
}
function hide_box(box) {
document.getElementById(box).style.display = 'none';
}