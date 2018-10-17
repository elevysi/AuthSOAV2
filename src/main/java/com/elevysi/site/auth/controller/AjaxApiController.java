package com.elevysi.site.auth.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elevysi.site.auth.service.UserService;
import com.elevysi.site.commons.pojo.SessionMessage;

@Controller
@RequestMapping(value="/ui/ajax")
public class AjaxApiController extends AbstractController{
	
	private UserService userService;
	
	@Autowired
	public AjaxApiController(UserService userService) {
		this.userService = userService;
	}
	
	@RequestMapping("/user/usernameAvailable")
	@ResponseBody
	public String usernameAvailable(
			@RequestParam String username, 
			@RequestParam(value="update", required = false)String oldUsername)
	{
		Boolean available = false;
		boolean checkForNew = true;
		if(oldUsername != null){
			if(oldUsername.equalsIgnoreCase(username)){
				available = true;
				checkForNew = false;
			} 
		}
		
		if(checkForNew){
			available = userService.findByUsername(username) == null;
		}
		
		return available.toString();
	}
	
	@RequestMapping("/user/emailRegistered")
	@ResponseBody
	public String emailRegistered(
			@RequestParam String email, 
			@RequestParam(value="update", required = false)String oldEmail
	){
		Boolean available = false;
		boolean checkForNew = true;
		if(oldEmail != null){
			if(oldEmail.equalsIgnoreCase(email)){
				available = true;
				checkForNew = false;
			}
		}
		
		if(checkForNew){
			available = userService.findByEmail(email) == null;
		}
		
		return available.toString();
	}
	
	@RequestMapping(value="/login/issessionvalid", method = RequestMethod.GET)
	public @ResponseBody Boolean isSessionValid(Principal principal){
		boolean returnValue = false;
		
		
		if(principal != null){
			returnValue = true;
		}
		return returnValue;
	}
	
	
	@RequestMapping(value = {"/modal/login"}, method = RequestMethod.GET)
	public String loginModal(Model model, @RequestParam(required = false) String message, HttpServletRequest request){
		model.addAttribute("message", message);
		
		return "dialogLogin";
	}
	
	@RequestMapping(value = "/logout/page/success")
 	public String logoutSuccess(RedirectAttributes redirectAttributes) {
		SessionMessage sessionMessage = new SessionMessage("Successfully logged out !");
		sessionMessage.setDangerClass();
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		return "redirect:/login";
	}
	

}
