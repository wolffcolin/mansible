package com.example.mansible;

import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import java.util.List;

@Controller
public class DeviceLifecycleController {

    @Autowired
    private Inventory inventory;

    @MessageMapping("/devices/list")
    @SendTo("/topic/devices")
    public JsonNode getDevices() {
        return inventory.getDevices();
    }

}
