<?php
class Id_payment extends Model {

    public function add($did=null) {

        if(is_null($did)) $did = swDemand::wm_ReqID();

        return dataBase::DBadmin()->insert('id_payment',array(
            'did'           => $did,
            'addr_remote'   => sSystem::getIp('ip'),
            'proxy'         => sSystem::getIp('proxy')
        ));

    }

}
