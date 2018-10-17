package com.elevysi.site.auth.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomCollectionEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Set;

import com.elevysi.site.auth.entity.Role;
import com.elevysi.site.auth.entity.Role_;
import com.elevysi.site.auth.entity.User;
import com.elevysi.site.auth.entity.User_;
import com.elevysi.site.auth.service.RoleService;
import com.elevysi.site.auth.service.UserService;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page.SortDirection;
import com.elevysi.site.commons.pojo.SessionMessage;

@Controller
@RequestMapping(value="/ui/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminController extends AbstractController{

	private UserService userService;
	private RoleService roleService;
	
	@Autowired
	public AdminController(UserService userService, RoleService roleService) {
		this.userService = userService;
		this.roleService = roleService;
	}
	
	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Set.class, "roles", new CustomCollectionEditor(Set.class)
		{
			@Override
			protected Object convertElement(Object element)
			{
				Integer id = null;

				if(element instanceof String && !((String)element).equals("")){
					//From the JSP 'element' will be a String
					try{
						id = Integer.parseInt((String) element);
					}
					catch (NumberFormatException e) {
						//                      System.out.println("Element was " + ((String) element));
						e.printStackTrace();
					}
				}
				else if(element instanceof Integer) {
					//From the database 'element' will be an Integer
					id = (Integer) element;
				}

				return id != null ? roleService.findByID(id) : null;
			}
		});
	}

	@RequestMapping(value ="/dashboard", method = RequestMethod.GET)
	public String dashboard(Model model, @RequestParam(value="page", defaultValue="1", required=false)int pageIndex){
		
		
		OffsetPage page = userService.buildOffsetPage(pageIndex, NUMBER_ITEMS_PER_PAGE, User_.created, SortDirection.DESC);
		List<User> users = userService.findPaginatedItems(page);
		long totalRecords = page.getTotalRecords();
		int totalPages = Math.round(totalRecords / NUMBER_ITEMS_PER_PAGE);
		model.addAttribute("page", page);
		model.addAttribute("users", users);
		model.addAttribute("totalPages", totalPages);
		
		List<Role> roles = roleService.findAll();
		model.addAttribute("roles", roles);
		
		return "adminDashboard";
	}
	
	
	@RequestMapping(value = {"/user/add", "/user/add/"}, method = RequestMethod.GET)
	public String addUser(Model model){
		
		User user = new User();
		model.addAttribute("user", user);
		model.addAttribute("roles", roleService.findAll());
		return "userAdd";
	}
	
	
	@RequestMapping(value = {"/user/add", "/user/add/"}, method = RequestMethod.POST)
	public String doAddUser(
			Model model,
			@ModelAttribute("user") User user, 
			BindingResult result,
			final RedirectAttributes redirectAttributes
	){
		
		if(! result.hasErrors()){
			
			User savedUser = userService.saveUser(user);
			if(savedUser != null){
				
				SessionMessage sessionMessage = new SessionMessage("Successfully saved user!");
				sessionMessage.setSuccessClass();
				redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
				
				return "redirect:/ui/admin/dashboard";
			}
		}
		
		SessionMessage sessionMessage = new SessionMessage("Please address the errors before saving.");
		sessionMessage.setDangerClass();
		
		model.addAttribute("user", user);
		model.addAttribute("roles", roleService.findAll());
		
		return "userAdd";
	}
	
	@RequestMapping(value="/updatePassword/{username}", method=RequestMethod.GET)
	public String updatePasswordAdmin(
			Model model,
			@PathVariable(value="username", required=true)String username,
			final RedirectAttributes redirectAttributes
	){
		
		//See if the user Exists
		User user = userService.loadUserByUsername(username);
		if(user != null) {
			model.addAttribute("username", username);
			model.addAttribute("user", user);
			return "adminUpdatePassword";
		}
		
		SessionMessage sessionMessage = new SessionMessage("Could not find the specified user");
		sessionMessage.setDangerClass();
		
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		return "redirect:/ui/admin/user";
		
	}
	
	
	@RequestMapping(value="/updatePassword/{username}", method=RequestMethod.POST)
	public String doUpdatePasswordAdmin(
			Model model,
			@PathVariable(value="username", required=true)String username,
			RedirectAttributes redirectAttributes,
			@RequestParam("id")String id,
			@RequestParam("newPassword")String newPassword,
			@RequestParam("passwordAgain")String passwordAgain
	){
		
		SessionMessage sessionMessage = new SessionMessage();
		sessionMessage.setMsgText("Failed to update the password!");
		sessionMessage.setDangerClass();
		boolean successOperation = false;
		
		if(newPassword != null && !newPassword.isEmpty() && newPassword.length() >=5 ){
			
			if(newPassword.equals(passwordAgain)){
				User savedUser = userService.updatePasswordAdmin(Integer.parseInt((String) id), newPassword);
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
		
		redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
		
		if(successOperation){
			return "redirect:/";
		}else{
			return "redirect:/ui/admin/updatePassword/"+username;
		}
	}
	
	@RequestMapping(value="/user/search", method=RequestMethod.POST)
	public String doSearchUser(
			Model model,
			@RequestParam(value="term", defaultValue="", required=false)String term
	){
		return "redirect:/ui/admin/user/search?term="+term;
	}
	
	@RequestMapping(value="/user/search", method=RequestMethod.GET)
	public String searchUser(
			Model model,
			@RequestParam(value="term", defaultValue="", required=false)String term,
			@RequestParam(value="page", defaultValue="1", required=false)int pageIndex
	){
		
		OffsetPage page = userService.buildOffsetPage(pageIndex, NUMBER_ITEMS_PER_PAGE, User_.created, SortDirection.DESC);
		List<User> users = userService.findMatching(term, page);
		
		long totalRecords = page.getTotalRecords();
		int totalPages = Math.round(totalRecords / NUMBER_ITEMS_PER_PAGE);
		model.addAttribute("page", page);
		model.addAttribute("users", users);
		model.addAttribute("totalPages", totalPages);
		
		model.addAttribute("term", term);
		
		return "userSearchResults";
	}

	
//	Roles
	
	@RequestMapping(value = {"/role/add"}, method = RequestMethod.GET)
	public String addRole(Model model){
		
		Role role = new Role();
		model.addAttribute("role", role);
		return "roleAdd";
	}
	
	
	@RequestMapping(value = {"/role/add"}, method = RequestMethod.POST)
	public String doAddRole(
			Model model,
			@ModelAttribute("role") Role role, 
			BindingResult result,
			final RedirectAttributes redirectAttributes
	){
		
		if(! result.hasErrors()){
			
			Role savedRole = roleService.save(role);
			if(savedRole != null){
				
				SessionMessage sessionMessage = new SessionMessage("Successfully saved role!");
				sessionMessage.setSuccessClass();
				redirectAttributes.addFlashAttribute("sessionMessage", sessionMessage);
				
				return "redirect:/ui/admin/dashboard";
			}
		}
		
		SessionMessage sessionMessage = new SessionMessage("Please address the errors before saving.");
		sessionMessage.setDangerClass();
		
		model.addAttribute("role", role);
		
		return "roleAdd";
	}

}
