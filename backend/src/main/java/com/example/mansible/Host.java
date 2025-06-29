package com.example.mansible;

import java.util.HashMap;
import java.util.Map;

public class Host {

    String address;

    Map<String, String> vars = new HashMap<>();

    @Override
    public String toString() {
        String inventoryLine = address + " ";
        for (String key : vars.keySet()) {
            inventoryLine = inventoryLine + key + "=" + vars.get(key) + " ";
        }

        return inventoryLine;
    }

}
