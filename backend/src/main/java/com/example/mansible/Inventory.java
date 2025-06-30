package com.example.mansible;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class Inventory {

    private final ObjectMapper objectMapper;
    Map<String, Group> groups = new HashMap<>();
    List<Host> ungroupedHosts = new ArrayList<>();
    ObjectMapper mapper = new ObjectMapper();

    public Inventory(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    String toIni() {
        StringBuilder sb = new StringBuilder();
        for (Host host : ungroupedHosts) {
            sb.append(host.toString());
        }

        for (Group group : groups.values()) {
            sb.append(group.toString());
        }

        return sb.toString();
    }

    Host parseLineToHost(String line) {
        String[] parts = line.split(" ");
        String address = parts[0];

        Map<String, String> vars = new HashMap<>();

        for (int i = 1; i < parts.length; i++) {
            String[] pieces = parts[i].split("=");
            vars.put(pieces[0], pieces[1]);
        }

        Host host = new Host();
        host.address = address;
        host.vars = vars;
        return host;
    }

    Inventory fromIni(String ini) throws IOException {
        List<String> lines = Files.readAllLines(Paths.get(ini));

        Map<String, Group> readGroups = new HashMap<>();
        List<Host> readUngroupedHosts = new ArrayList<>();

        String currentGroupName = null;
        for (String line : lines) {
            if (!(line.charAt(0) == '#' || line.charAt(0) == ';' || line.isBlank())) {
                if (currentGroupName == null) {
                    if (line.charAt(0) == '[') {
                        String groupName = line.substring(1, line.length() - 1);
                        currentGroupName = groupName;
                    } else {
                        Host host = this.parseLineToHost(line);
                        readUngroupedHosts.add(host);
                    }
                }
            }
        }

        Inventory inv = new Inventory(objectMapper);
        inv.groups = readGroups;
        inv.ungroupedHosts = readUngroupedHosts;

        return inv;
    }

    public List<Host> getUngroupedHosts() {
        return this.ungroupedHosts;
    }

    public Map<String, Group> getGroups() {
        return this.groups;
    }

    public JsonNode getDevices() {
        ObjectNode root = mapper.createObjectNode();

        ArrayNode ungroupedArray = mapper.valueToTree(this.getUngroupedHosts());
        root.set("ungrouped", ungroupedArray);

        ArrayNode groupsArray = mapper.createArrayNode();
        for (Group group : this.getGroups().values()) {
            ObjectNode groupNode = mapper.createObjectNode();
            groupNode.put("groupName", group.getGroupName());
            groupNode.set("hosts", objectMapper.valueToTree(group.getHosts()));
            groupsArray.add(groupNode);
        }

        root.set("groups", groupsArray);
        return root;
    }


}
