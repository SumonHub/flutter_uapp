package org.sumon.realmtutorial.model;

import java.util.List;

import io.realm.RealmList;
import io.realm.RealmObject;

public class A extends RealmObject {
    String created_by, territory_id, distributor_id;
    RealmList<B> bList;

    public A() {
    }

    public A(String created_by, String territory_id, String distributor_id, RealmList<B> bList) {
        this.created_by = created_by;
        this.territory_id = territory_id;
        this.distributor_id = distributor_id;
        this.bList = bList;
    }

    public String getCreated_by() {
        return created_by;
    }

    public void setCreated_by(String created_by) {
        this.created_by = created_by;
    }

    public String getTerritory_id() {
        return territory_id;
    }

    public void setTerritory_id(String territory_id) {
        this.territory_id = territory_id;
    }

    public String getDistributor_id() {
        return distributor_id;
    }

    public void setDistributor_id(String distributor_id) {
        this.distributor_id = distributor_id;
    }

    public List<B> getbList() {
        return bList;
    }

    public void setbList(RealmList<B> bList) {
        this.bList = bList;
    }

    @Override
    public String toString() {
        return "\n" + "A{" +
                "created_by='" + created_by + '\'' +
                ", territory_id='" + territory_id + '\'' +
                ", distributor_id='" + distributor_id + '\'' +
                ", bList=" + bList +
                '}';
    }
}
