package com.daigou.sg.rpc.shipforme;

import com.google.gson.annotations.SerializedName;

/**
 * This file is auto-generated by tgen
 * Don't change manually
 */

<<<<<<< HEAD
public enum TShipType implements java.io.Serializable {
<<<<<<< HEAD
=======
public enum TShipType implements java.io.Serializable, DeserializerEnum {
>>>>>>> a846c86... modify Java template
	@SerializedName("1")
	AA(1),
=======
>>>>>>> 8cbe625... delete useless java files
	@SerializedName("2")
	BB(2),
	@SerializedName("1")
	AA(1);


	int type;

    TShipType(int type) {
        this.type = type;
    }

	@Override
    public String toString() {
        return Integer.toString(type);
    }

    @Override
    public int getValue() {
        return type;
    }
}
