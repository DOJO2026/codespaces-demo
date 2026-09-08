package com.codespacesdemo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codespacesdemo.dto.DemoResponse;
import com.codespacesdemo.service.DemoService;

@RestController
@RequestMapping("/api")
public class DemoController {

    private final DemoService demoService;

    public DemoController(DemoService demoService) {
        this.demoService = demoService;
    }

    @GetMapping("/demo")
    public DemoResponse demo() {
        return demoService.getDemoInformation();
    }

}