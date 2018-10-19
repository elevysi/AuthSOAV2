package com.elevysi.site.auth.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.elevysi.site.auth.entity.OauthClientDetail;
import com.elevysi.site.auth.entity.OauthClientDetail_;
import com.elevysi.site.auth.entity.Role;
import com.elevysi.site.auth.entity.Role_;
import com.elevysi.site.auth.entity.User;
import com.elevysi.site.auth.entity.User_;
import com.elevysi.site.auth.service.OauthClientDetailService;
import com.elevysi.site.auth.service.RoleService;
import com.elevysi.site.auth.service.UserService;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.ReturnValue;
import com.elevysi.site.commons.pojo.Page.SortDirection;

@Controller
@RequestMapping(value="/ui/ajax/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AjaxApiAdminController extends AbstractController{
	
	private UserService userService;
	private RoleService roleService;
	private OauthClientDetailService oauthClientDetailService;
	
	@Autowired
	public AjaxApiAdminController(UserService userService, RoleService roleService, OauthClientDetailService oauthClientDetailService) {
		this.userService = userService;
		this.roleService = roleService;
		this.oauthClientDetailService = oauthClientDetailService;
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
	
	@RequestMapping(value = {"/user"}, method = RequestMethod.GET)
	public String users(
			Model model,
			@RequestParam(value="page", defaultValue="1", required=false)int pageIndex,
			@RequestParam(value="term", defaultValue="", required=false)String term
	){
		
		OffsetPage page = userService.buildOffsetPage(pageIndex, NUMBER_ITEMS_PER_PAGE, User_.created, SortDirection.DESC);
		
		List<User> users = new ArrayList<User>();
		if(term.equals("")) {
			users = userService.findPaginatedItems(page);
		}else {
			users = userService.findMatching(term, page);
		}
		
		long totalRecords = page.getTotalRecords();
		int totalPages = Math.round(totalRecords / NUMBER_ITEMS_PER_PAGE);
		model.addAttribute("page", page);
		model.addAttribute("users", users);
		model.addAttribute("totalPages", totalPages);
		
		return "indexUserAjax";
	}
	
	
	@RequestMapping(value="/user/modalView/{id}")
	public String viewUser(@PathVariable("id")Integer id, Model model){
		
		User user = userService.findByID(id);
		
		model.addAttribute("user", user);
		return "modalUserView";
	}

	
	@RequestMapping(value="/user/modalEdit/{id}")
	public String editUser(@PathVariable("id")Integer id, Model model){
		
		User user = userService.findByID(id);
		List<Role> roles = roleService.findAll();
		
		List<String> activeFlags = new ArrayList<String>();
		activeFlags.add("true");
		activeFlags.add("false");
		
		model.addAttribute("user", user);
		model.addAttribute("activeFlags", activeFlags);
		model.addAttribute("roles", roles);
		
		return "modalUserEdit";
	}
	
	@RequestMapping(value = {"/user/modalDelete"}, method = RequestMethod.POST)
	public @ResponseBody ReturnValue doUserDeleteAjax(@RequestParam("userID") Integer id){
		
		userService.delete(id);
		ReturnValue returnValue = new ReturnValue();
		returnValue.setCode(1);
		returnValue.setMessage("The user was successfully deleted!");
		
		return returnValue;
	}
	
	@RequestMapping(value = {"/user/modalEdit/{id}"}, method = RequestMethod.POST)
	public @ResponseBody ReturnValue doUserEditAjax(
			@ModelAttribute("user") User user, 
			BindingResult result
	){
		
		ReturnValue returnValue = new ReturnValue();
		returnValue.setCode(0);
		returnValue.setMessage("Failed to edit this user");
		
		if(! result.hasErrors()){
			
			User updatedUser = userService.updateUserFieldsAdmin(user);
			if(updatedUser != null){
				returnValue.setCode(1);
				returnValue.setMessage("Successfully updated user!");
			}
		}
		
		return returnValue;
	}
	
	
//	Roles
	
	@RequestMapping(value = {"/role"}, method = RequestMethod.GET)
	public String roles(Model model, @RequestParam(value="page", defaultValue="1", required=false)int pageIndex){
		
		OffsetPage page = roleService.buildOffsetPage(pageIndex, NUMBER_ITEMS_PER_PAGE, Role_.id, SortDirection.DESC);
		List<Role> roles = roleService.findPaginatedItems(page);
		long totalRecords = page.getTotalRecords();
		int totalPages = Math.round(totalRecords / NUMBER_ITEMS_PER_PAGE);
		model.addAttribute("page", page);
		model.addAttribute("roles", roles);
		model.addAttribute("totalPages", totalPages);
		
		return "indexRoleAjax";
	}
	
	@RequestMapping(value="/role/modalEdit/{id}")
	public String editRole(@PathVariable("id")Integer id, Model model){
		
		Role role = roleService.findByID(id);
		model.addAttribute("role", role);
		return "modalRoleEdit";
	}
	
	@RequestMapping(value = {"/role/modalDelete"}, method = RequestMethod.POST)
	public @ResponseBody ReturnValue doRoleDeleteAjax(@RequestParam("roleID") Integer id){
		
		roleService.delete(id);
		ReturnValue returnValue = new ReturnValue();
		returnValue.setCode(1);
		returnValue.setMessage("The role was successfully deleted!");
		
		return returnValue;
	}
	
	@RequestMapping(value = {"/role/modalEdit/{id}"}, method = RequestMethod.POST)
	public @ResponseBody ReturnValue doRoleEditAjax(
			@ModelAttribute("role") Role role, 
			BindingResult result
	){
		
		ReturnValue returnValue = new ReturnValue();
		returnValue.setCode(0);
		returnValue.setMessage("Failed to edit this role");
		
		if(! result.hasErrors()){
			
			Role updatedRole = roleService.saveEdited(role);
			if(updatedRole != null){
				returnValue.setCode(1);
				returnValue.setMessage("Successfully updated role!");
			}
		}
		
		return returnValue;
	}
	
	//OauthClients
	
	
	@RequestMapping(value = {"/oauthClientDetail"}, method = RequestMethod.GET)
	public String oauthClientDetails(Model model, @RequestParam(value="page", defaultValue="1", required=false)int pageIndex){
		
		OffsetPage page = oauthClientDetailService.buildOffsetPage(pageIndex, NUMBER_ITEMS_PER_PAGE, OauthClientDetail_.client_id, SortDirection.DESC);
		List<OauthClientDetail> oauthClients = oauthClientDetailService.findPaginatedItems(page);
		
		long totalRecords = page.getTotalRecords();
		int totalPages = Math.round(totalRecords / NUMBER_ITEMS_PER_PAGE);
		model.addAttribute("page", page);
		model.addAttribute("oauthClients", oauthClients);
		model.addAttribute("totalPages", totalPages);
		
		return "indexOauthClientAjax";
	}
	
	@RequestMapping(value="/oauthClientDetail/modalEdit/{id}")
	public String editOauthClient(@PathVariable("id")Integer id, Model model){
		
		OauthClientDetail oauthClientDetail = oauthClientDetailService.findByID(id);
		model.addAttribute("oauthClientDetail", oauthClientDetail);
		return "modalOauthClientDetailEdit";
	}
	
	@RequestMapping(value = {"/oauthClientDetail/modalEdit/{id}"}, method = RequestMethod.POST)
	public @ResponseBody ReturnValue doOauthClientEditAjax(
			@ModelAttribute("oauthClientDetail") OauthClientDetail oauthClientDetail, 
			BindingResult result
	){
		
		ReturnValue returnValue = new ReturnValue();
		returnValue.setCode(0);
		returnValue.setMessage("Failed to edit this client");
		
		if(! result.hasErrors()){
			
			OauthClientDetail updatedClient = oauthClientDetailService.updateClientDetailsAdmin(oauthClientDetail);
			if(updatedClient != null){
				returnValue.setCode(1);
				returnValue.setMessage("Successfully updated client!");
			}
		}
		
		return returnValue;
	}
	
	@RequestMapping(value = {"/oauthClientDetail/modalDelete/{clientID}"}, method = RequestMethod.DELETE)
	public @ResponseBody ReturnValue doClientDeleteAjax(@PathVariable(value="clientID", required=true)Integer id){
		
		oauthClientDetailService.delete(id);
		ReturnValue returnValue = new ReturnValue();
		returnValue.setCode(1);
		returnValue.setMessage("The client was successfully deleted!");
		
		return returnValue;
	}
	
	@RequestMapping(value="/oauthClientDetail/modalView/{id}")
	public String viewOauthClient(@PathVariable("id")Integer id, Model model){
		
		OauthClientDetail oauthClientDetail = oauthClientDetailService.findByID(id);
		
		model.addAttribute("client", oauthClientDetail);
		
		return "modalOauthClientDetailView";
	}
	

}
