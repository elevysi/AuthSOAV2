package com.elevysi.site.auth.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elevysi.site.auth.entity.User;
import com.elevysi.site.auth.service.UserService;
import com.elevysi.site.commons.pojo.SessionMessage;


@Controller
@RequestMapping(value="/register")
public class RegisterController {
	
	
	private UserService userService;
	
	@Autowired
	public RegisterController(UserService userService) {
		this.userService = userService;
	}
	
	@ModelAttribute("user")
	public User constructUser(){
		User user = new User();
		
		return user;
	}
	

	@RequestMapping(value = {""}, method = RequestMethod.GET)
	public String register(){
	
		return "userRegister";
	}
	
	@RequestMapping(value = {""}, method = RequestMethod.POST)
	public String doRegister(@Valid @ModelAttribute("user") User user, BindingResult result, final RedirectAttributes redirectAttributes){
		
		if(result.hasErrors()){
			return "userRegister";
		}
				
		userService.registerUser(user);
		
		SessionMessage sessionMessage = new SessionMessage("Successfully Registered!");
		sessionMessage.setSuccessClass();
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);	
		
		return "redirect:/";
	}
}
