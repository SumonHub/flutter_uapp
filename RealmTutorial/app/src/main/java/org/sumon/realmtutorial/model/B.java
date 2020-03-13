package org.sumon.realmtutorial.model;

import io.realm.RealmObject;

public class B extends RealmObject {

    String Model_id, brand_id, item_id, qty;

    public B() {
    }

    public B(String model_id, String brand_id, String item_id, String qty) {
        Model_id = model_id;
        this.brand_id = brand_id;
        this.item_id = item_id;
        this.qty = qty;
    }

    public String getModel_id() {
        return Model_id;
    }

    public void setModel_id(String model_id) {
        Model_id = model_id;
    }

    public String getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(String brand_id) {
        this.brand_id = brand_id;
    }

    public String getItem_id() {
        return item_id;
    }

    public void setItem_id(String item_id) {
        this.item_id = item_id;
    }

    public String getQty() {
        return qty;
    }

    public void setQty(String qty) {
        this.qty = qty;
    }

    @Override
    public String toString() {
        return "\n" + "B{" +
                "Model_id='" + Model_id + '\'' +
                ", brand_id='" + brand_id + '\'' +
                ", item_id='" + item_id + '\'' +
                ", qty='" + qty + '\'' +
                '}';
    }
}
