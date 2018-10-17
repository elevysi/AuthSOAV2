package com.elevysi.site.auth.controller;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.elevysi.site.auth.entity.User;
import com.elevysi.site.auth.service.UserService;
import com.elevysi.site.auth.utils.ActiveUser;
import com.elevysi.site.commons.pojo.SessionMessage;



@Controller
public class UserController extends AbstractController{
	
	
	
	private UserService userService;
	
	@Autowired
	public UserController(UserService userService) {
		this.userService = userService;
	}
	
	@ModelAttribute("user")
	public User constructUser(){
		User user = new User();
		
		return user;
	}
	
	
	@RequestMapping(value="/ui/user/updatePassword")
	public String updatePassword(Model model, @ModelAttribute("sessionMessage") 
	SessionMessage sessionMessage){
		
		return "userPasswordUpdate";
	}
	
	@RequestMapping(value="/ui/user/updatePassword", method=RequestMethod.POST)
	public String doUpdatePassword(Model model, RedirectAttributes redirectAttributes, 
			@RequestParam("currentPassword")String currentPassword,
			@RequestParam("newPassword")String newPassword,
			@RequestParam("passwordAgain")String passwordAgain
	){
		
		SessionMessage sessionMessage = new SessionMessage();
		sessionMessage.setMsgText("Failed to update the password!");
		sessionMessage.setDangerClass();
		boolean successOperation = false;
		
		ActiveUser activeUser = userService.getActiveUser();
		if(activeUser != null) {
		
			if(currentPassword != null && !currentPassword.isEmpty()){
				if(userService.comparePasswords(currentPassword)){
					if(newPassword != null && !newPassword.isEmpty() && newPassword.length() >=5 ){
						
						if(newPassword.equals(passwordAgain)){
							User savedUser = userService.updatePassword(activeUser.getUsername(), newPassword);
							if(savedUser != null){						
								successOperation = true;
								sessionMessage.setMsgText("The password was successfully updated!");
								sessionMessage.setSuccessClass();
							}else{
								sessionMessage.setMsgText("Failed to update the password.");
								sessionMessage.setDangerClass();
							}
						}else{
							sessionMessage.setMsgText("The password confirmation does not match.");
							sessionMessage.setDangerClass();
						}
						
					}else{
						sessionMessage.setMsgText("You must provide a new password with at least 5 characters");
						sessionMessage.setDangerClass();
					}
				}else{
					sessionMessage.setMsgText("Your supplied password does not match the stored password.");
					sessionMessage.setDangerClass();
				}
			}else{
				sessionMessage.setMsgText("You must provide your current password first.");
				sessionMessage.setDangerClass();
			}
		}
		
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		
		if(successOperation){
			return "redirect:/";
		}else{
			return "redirect:/ui/user/updatePassword";
		}
	}
	
	@RequestMapping(value="/ui/user/profile")
	public String editUser(
			Model model,
			final RedirectAttributes redirectAttributes
	){
		
		ActiveUser activeUser = userService.getActiveUser();
		if(activeUser != null) {
			//Find the db user
			User user = userService.loadUserByUsername(activeUser.getUsername());
			if(user != null) {
				model.addAttribute("user", user);
				return "userProfile";
			}
		}
		SessionMessage sessionMessage = new SessionMessage("Could not identify the logged in user");
		sessionMessage.setDangerClass();
		
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		
		return "redirect:/";
		
	}
	
	
	@RequestMapping(value = {"/ui/user/profile"}, method = RequestMethod.POST)
	public String doEdit(
			@ModelAttribute("user") User user, 
			BindingResult result,
			@RequestParam(value="oldUsername", required=true)String oldUsername,
			final RedirectAttributes redirectAttributes
	){
		
		SessionMessage sessionMessage = new SessionMessage();
		if(! result.hasErrors()){
			
			User updatedUser = userService.updateUserFields(user, oldUsername);
			if(updatedUser != null){
				
				sessionMessage.setSuccessClass();
				sessionMessage.setMsgText("Successfully updated the account details");
				
				redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
				return "redirect:/";
			}
		}
		
		sessionMessage.setDangerClass();
		sessionMessage.setMsgText("Failed to edit the account details!");
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		
		return "redirect:/ui/user/profile";
	}
	
}
