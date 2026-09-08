package com.codespacesdemo.service;

import java.time.LocalDateTime;

import org.springframework.stereotype.Service;

import com.codespacesdemo.dto.DemoResponse;

@Service
public class DemoService {

    public DemoResponse getDemoInformation() {

        return new DemoResponse(
                "OK",
                "Hola desde Spring Boot ejecutándose en Azure App Service",
                "DEV",
                "1.0.0",
                LocalDateTime.now().toString());

    }

}