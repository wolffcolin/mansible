package com.example.mansible;

import org.springframework.stereotype.Service;

@Service
public class OnboardingService {

    public String onboardDevice() {

        ProcessBuilder pb = new ProcessBuilder("onboard", "-p", "-d", "-v");

        pb.redirectOutput(ProcessBuilder.Redirect.INHERIT);
        pb.redirectError(ProcessBuilder.Redirect.INHERIT);

        Process process = pb.start();


    }

}
