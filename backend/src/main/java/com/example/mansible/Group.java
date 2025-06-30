package com.example.mansible;

import java.util.ArrayList;
import java.util.List;

public class Group {

    String groupName;

    List<Host> hosts = new ArrayList<>();

    @Override
    public String toString() {
        String group = "[" + groupName + "]";
        StringBuilder sb = new StringBuilder(group);
        for (Host host : hosts) {
            sb.append(host.toString())
                    .append("\n");
        }
        return sb.toString();
    }

    public String getGroupName() {
        return groupName;
    }

    public List<Host> getHosts() {
        return hosts;
    }

}
