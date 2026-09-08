package com.codespacesdemo.dto;

public class DemoResponse {

    private String status;
    private String message;
    private String environment;
    private String version;
    private String timestamp;

    public DemoResponse() {
    }

    public DemoResponse(String status, String message, String environment, String version, String timestamp) {
        this.status = status;
        this.message = message;
        this.environment = environment;
        this.version = version;
        this.timestamp = timestamp;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public String getEnvironment() {
        return environment;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setEnvironment(String environment) {
        this.environment = environment;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}