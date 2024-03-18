package com.admr.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController

public class Controller {
	@GetMapping("/home")
	public String getHome() {
		return "Home";
		
	}
	@GetMapping("/test")
	public String getTest() {
		return "Test";
	}

}
