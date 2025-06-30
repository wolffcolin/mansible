package com.example.mansible;

import java.util.HashMap;
import java.util.Map;

public class Host {

    String address;

    Map<String, String> vars = new HashMap<>();

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(address);
        for (Map.Entry<String, String> entry : vars.entrySet()) {
            sb.append(" ")
                    .append(entry.getKey())
                    .append("=")
                    .append(entry.getValue());
        }
        return sb.toString();
    }

}
