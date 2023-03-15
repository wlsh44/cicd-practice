package com.example.cicd;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class VersionController {

    @Value("${application-env}")
    private String env;

    @GetMapping("/")
    public ResponseEntity<String> version() {
        String version = "1.0.0";
        return ResponseEntity.ok(env + " " + version);
    }
}
