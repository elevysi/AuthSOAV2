package com.elevysi.site.auth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController extends AbstractController{
	
	@RequestMapping(value = "/")
	public String home() {
		
		return "home";
	}
	
	@RequestMapping(value = "/denied")
 	public String denied() {
		
		return "pageDenied";
	}

}
