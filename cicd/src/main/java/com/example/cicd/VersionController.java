package com.example.cicd;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class VersionController {

    @GetMapping("/")
    public ResponseEntity<String> version() {
        String version = "1.0.0";
        return ResponseEntity.ok(version);
    }
}
