package com.example.mansible;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class AnsibleConstants {

    public static final Set<String> ALLOWED_KEYS;

    static {
        Set<String> keys = new HashSet<>();
        keys.add("ansible_user");
        keys.add("ansible_host");
        keys.add("ansible_port");
        keys.add("ansible_password");
        keys.add("ansible_ssh_private_key_file");
        keys.add("ansible_become");
        keys.add("ansible_become_user");
        keys.add("ansible_python_interpreter");
        ALLOWED_KEYS = Collections.unmodifiableSet(keys);
    }

}
