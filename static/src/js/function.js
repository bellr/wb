function Exchange(direct,konvers,comission) {
    var sd=1;

    if(direct == 'y') {
        i_o = function(is_true) {
            var in_v = document.form_exch.in_val.value;
            var out_val = in_v*konvers;
            var sd = ConditionsDisc(out_val);
            document.form_exch.out_val.value = (in_v*konvers*sd).toFixed(2);
            if(is_true) {o_i();}
            document.getElementById('kom_08').innerHTML = (parseFloat(document.form_exch.in_val.value)*(1+comission)).toFixed(2);
            //document.getElementById('kom_08').innerHTML = Math.round(document.form_exch.in_val.value*(1+comission));
        }
        o_i = function(is_true) {
            var out_1 = parseFloat(document.form_exch.out_val.value);
            var sd = ConditionsDisc(out_1);
            document.form_exch.in_val.value = (out_1/konvers/sd).toFixed(2);
            if (is_true) {i_o();}
            document.getElementById('kom_08').innerHTML = (parseFloat(document.form_exch.in_val.value)*(1+comission)).toFixed(2);
            //document.getElementById('kom_08').innerHTML = Math.round(document.form_exch.in_val.value*(1+comission));
        }
    } else {
        i_o = function(is_true) {
            in_v= document.form_exch.in_val.value;
            sd = ConditionsDisc(in_v/konvers);
            document.form_exch.out_val.value = (in_v/konvers/sd).toFixed(2);
            if(is_true) {o_i();}
            document.getElementById('kom_08').innerHTML = (parseFloat(document.form_exch.in_val.value)*(1+comission)).toFixed(2);
            //document.getElementById('kom_08').innerHTML = Math.round(document.form_exch.in_val.value*(1+comission));
        }
        o_i = function(is_true) {
            out_1 = document.form_exch.out_val.value;
            sd = ConditionsDisc(out_1);
            sum_in = (out_1*konvers/sd).toFixed(2);
            document.form_exch.in_val.value = (out_1*konvers/sd).toFixed(2)
            document.getElementById('kom_08').innerHTML = (parseFloat(document.form_exch.in_val.value)*(1+comission)).toFixed(2);
            //document.getElementById('kom_08').innerHTML = Math.round(document.form_exch.in_val.value*(1+comission));
        }
    }
}

function ConditionsDisc(val) {
    var sd=1; var disc=0; var d = document.getElementById('discont');
    for ( var i in discount ) {
        if(val > discount[i].amount) {disc=discount[i].size_d; sd=disc/100+1;
        }
    }

    if(disc>0) {d.style.display = 'block'; d.innerHTML = 'Ваша скидка '+disc+'%'; disc=0;}
    else {d.style.display = 'none';}
    return sd;
}

function creatShowDemand(parms) {
    if(parms.resData.status == 0) {
        hide('notifyblock');
        hide('form_exch');
        document.getElementById('forData').innerHTML = parms.resData.html;
        show('forData');
    }
}
function enterKabinet(parms) {var resJson = eval("(" + parms.req.responseText + ")");if(resJson.status == 0) {document.location.href = HOME_URL+'/partner/index.aspx';}}
function appendTo(parms) {append(document.getElementById(parms.resData.appendElement),parms.resData.html);}

function enter_form() {
    if(document.getElementById('enter_pertner').style.display == 'block') {
        show('rest_pass');
        hide('enter_pertner');
    } else {
        hide('rest_pass');
        show('enter_pertner');
    }
}

function showFormPay(parms) {
    append(document.getElementById('form_demand'),parms.resData.html);
    hide('select_cur');
    runScript(parms.resData.html);
}
