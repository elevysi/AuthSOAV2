package com.elevysi.site.auth.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elevysi.site.auth.entity.User;
import com.elevysi.site.auth.service.UserService;
import com.elevysi.site.auth.utils.ActiveUser;
import com.elevysi.site.commons.pojo.ReturnValue;
import com.elevysi.site.commons.pojo.SessionMessage;

@Controller
public class LoginController extends AbstractController{
	
	private UserService userService;
	
	@Autowired
	public LoginController(UserService userService) {
		this.userService = userService;
	}
	
	
	@RequestMapping(value = {"/modal/login"}, method = RequestMethod.GET)
	public String loginModal(Model model, @RequestParam(required = false) String message, HttpServletRequest request){
		model.addAttribute("message", message);
		
		return "dialogLogin";
	}
	
	
	@RequestMapping(value = {"/loginExpired"}, method = RequestMethod.GET)
	public String loginExpired(Model model, @RequestParam(required = false) String message, HttpServletRequest request){
		model.addAttribute("message", message);
		
		String referrer = request.getHeader("Referer");
	    if(referrer!=null){
	        request.getSession().setAttribute("url_prior_login", referrer);
	    }
		
		return "userLogin";
	}
	
	
	@RequestMapping(value = "/ui/auth/successlogin")
 	public String loginSuccess(RedirectAttributes redirectAttributes) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		ActiveUser activeUser = (ActiveUser)auth.getPrincipal();
		
		String username = activeUser.getUsername();
		User domainUser = userService.loadUserByUsername(username);
		
		String message = "Welcome "+domainUser.getFirst_name()+". You have successfully logged in.";
		SessionMessage sessionMessage = new SessionMessage(message);
		sessionMessage.setSuccessClass();
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		
		return "redirect:/ui/admin/dashboard";
	}
	
	@RequestMapping(value = {"/ui/auth/failure"})
 	public String loginFailure(RedirectAttributes redirectAttributes) {
		
		SessionMessage sessionMessage = new SessionMessage("Invalid username or password!");
		sessionMessage.setDangerClass();
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		return "redirect:/login";
	}
	
	@RequestMapping(value = {"/auth/failure"})
 	public String requestedloginFailure(RedirectAttributes redirectAttributes) {
		
		SessionMessage sessionMessage = new SessionMessage("Invalid username or password!");
		sessionMessage.setDangerClass();
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		return "redirect:/auth/rqstd/login";
	}
	
	@RequestMapping(value = "/ui/auth/modal/failure")
 	public @ResponseBody Boolean modalLoginFailure(RedirectAttributes redirectAttributes) {
		
		return false;
	}
	
	@RequestMapping(value = "/ui/auth/rqstd/failure")
 	public String requestedLoginFailure(RedirectAttributes redirectAttributes) {
		
		SessionMessage sessionMessage = new SessionMessage("Invalid username or password!");
		sessionMessage.setDangerClass();
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		
		return "redirect:/auth/rqstd/login";
	}
	
	@RequestMapping(value = "/ui/logout/success")
 	public String logoutSuccess(RedirectAttributes redirectAttributes) {
		SessionMessage sessionMessage = new SessionMessage("Successfully logged out !");
		sessionMessage.setDangerClass();
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		return "redirect:/";
	}
	
	@RequestMapping(value = "/ui/logout/ajax/success")
	public @ResponseBody ReturnValue ajaxLogout(){
		ReturnValue returnValue = new ReturnValue();
		returnValue.setCode(1);
		returnValue.setMessage("Successfully logged out");
		return returnValue;
		
	}
	
	@RequestMapping(value="/login/issessionvalid", method = RequestMethod.GET)
	public @ResponseBody Boolean isSessionValid(Principal principal){
		boolean returnValue = false;
		
		
		if(principal != null){
			returnValue = true;
		}
		return returnValue;
	}
	
	@RequestMapping(value="/users/dialoglogin", method = RequestMethod.GET)
	public String dialogLogin(){
		
		return "dialogLogin";
		
	}
	
	
//	@RequestMapping(value = {"/users/login", "/users/login/", "/login", "login/", "/auth/rqstd/login"}, method = RequestMethod.GET)
//	public String 	login(Model model, @RequestParam(required = false) String message, RedirectAttributes redirectAttributes, final HttpServletRequest request, @ModelAttribute("sessionMessage") SessionMessage sessionMessage){
//		
//		/**
//		 * Check if not logged in already
//		 */
//		ActiveUser activeUser = userService.getActiveUser();
//		
//		if(activeUser != null){
//			
//			SessionMessage sessionWarning = new SessionMessage("A user is already logged in!");
//			sessionWarning.setWarmingClass();
//			
//			redirectAttributes.addFlashAttribute("sessionMessage", sessionWarning);
//			final String referer = request.getHeader("referer");
////			return "redirect:"+referer;
//			
//			return "redirect:/";
//			
//		}
//		
//		if(sessionMessage != null){
//			model.addAttribute("sessionMessage", sessionMessage);
//		}
//		Integer loginRequestMapCode = 0;
//		
//		String pattern = (String)request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE);
//		
//		if(pattern.equalsIgnoreCase("/auth/rqstd/login")){
//			loginRequestMapCode = 1;
//		}
//		
//		model.addAttribute("loginRequestMapCode", loginRequestMapCode);
//		model.addAttribute("message", message);		
//		return "userLogin";
//	}
	
	
//	@RequestMapping(value = {"/login"}, method = RequestMethod.GET)
	@RequestMapping(value = {"/users/login", "/users/login/", "/login", "login/", "/auth/rqstd/login"}, method = RequestMethod.GET)
	public String oauth2login(Model model){
		return "userLogin";
	}

}
