package com.elevysi.site.auth.service;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.metamodel.SingularAttribute;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.elevysi.site.auth.dao.UserDAO;
import com.elevysi.site.auth.entity.User;
import com.elevysi.site.auth.utils.ActiveUser;
import com.elevysi.site.commons.dto.RoleDTO;
import com.elevysi.site.commons.dto.UserDTO;
import com.elevysi.site.commons.pojo.OffsetPage;
import com.elevysi.site.commons.pojo.Page;
import com.elevysi.site.commons.pojo.Page.SortDirection;
import com.google.common.reflect.TypeToken;


@Service
public class UserService extends AbstractServiceImpl<User, Integer>{
	
	private UserDAO userDAO;
	private PasswordEncoder passwordEncoder;
	private ModelMapper modelMapper;
	
	@Autowired
	public UserService(UserDAO userDAO, PasswordEncoder passwordEncoder, ModelMapper modelMapper){
		this.userDAO = userDAO;
		this.passwordEncoder = passwordEncoder;
		this.modelMapper = modelMapper;
	}
	
	@PostAuthorize("returnObject.username == principal.username || hasRole('ADMIN')")
	public User saveUser(User user){
		
		Date now = new Date();
		user.setActive(true);
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		user.setPassword(encoder.encode(user.getPassword()));
		user.setCreated(now);
		user.setModified(now);
		return userDAO.save(user);
	}
	
	public User loadUserByUsernameForLogin(String username){
		return userDAO.loadByUsername(username);
	}
	
	
	
	@PostAuthorize("returnObject.username == principal.username || hasRole('ADMIN')")
	public User loadUserByUsername(String username){
		return userDAO.loadByUsername(username);
	}
	
	public User findByEmail(String email) {
		return userDAO.findByEmail(email);
	}
	
	public User findByUsername(String username) {
		return userDAO.loadByUsername(username);
	}
	
//	@PreAuthorize("hasRole('ROLE_SOA_CLIENT')")
	public UserDTO findUserDTOByUsername(String username){
		User user = userDAO.loadByUsername(username);
		UserDTO userDTO = null;
		if(user != null){
			userDTO = modelMapper.map(user, UserDTO.class);
			
			java.lang.reflect.Type targetListType = new TypeToken<Set<RoleDTO>>() {}.getType();
			Set<RoleDTO> rolesDTOs = modelMapper.map(user.getRoles(), targetListType);
			
			userDTO.setRoles(rolesDTOs);
		}
		return userDTO;
	}
	
	
	public boolean comparePasswords(String givenPassword){
		
		ActiveUser activeUser = this.getActiveUser();
		String username = activeUser.getUsername();
		
		User dbUser = userDAO.loadByUsername(username);
		if(dbUser != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if(encoder.matches(givenPassword, dbUser.getPassword())){
				return true;
			}
		}
		
		return false;
	}
	
	public ActiveUser getActiveUser(){
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (!(auth instanceof AnonymousAuthenticationToken)) {
			return (ActiveUser)auth.getPrincipal();	
		}
		
		
		return null;	
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	public List<User> findAll(){
		return userDAO.findAll();
	}
	
	@PostAuthorize("returnObject.username == principal.username || hasRole('ADMIN')")
	public User findByID(Integer id){
		return userDAO.findByID(id);
	}
	
	
	@PostAuthorize("returnObject.username == principal.username || hasRole('ADMIN')")
	public User findByID(int id){
		return userDAO.findByID(id);
	}
	
	@PreAuthorize("#user.username == principal.username || hasRole('ADMIN')")
	public User updateUser(User user){
		Date now = new Date();
		user.setModified(now);
		return userDAO.saveEdited(user);
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	public User updateUserFieldsAdmin(User editedUser){
		
		User dbUser = this.findByID(editedUser.getId());
		if(dbUser != null) {
			dbUser.setActive(editedUser.isActive());
			dbUser.setRoles(editedUser.getRoles());
			
			dbUser = copyUserFields(editedUser, dbUser);
			
			return userDAO.saveEdited(dbUser);
		}
		
		
		return null;
	}
	
	public User copyUserFields(User editedUser, User dbUser) {
		
		
		dbUser.setFirst_name(editedUser.getFirst_name());
		dbUser.setLast_name(editedUser.getLast_name());
		dbUser.setEmail(editedUser.getEmail());
		dbUser.setUsername(editedUser.getUsername());
		
		dbUser.setCountry(editedUser.getCountry());
		dbUser.setState(editedUser.getState());
		dbUser.setCountry_code(editedUser.getCountry_code());
		
		
		dbUser.setTown(editedUser.getTown());
		dbUser.setStreet(editedUser.getStreet());
		dbUser.setStreet_number(editedUser.getStreet_number());
		dbUser.setPostal_code(editedUser.getPostal_code());
		dbUser.setBio(editedUser.getBio());
		
		dbUser.setPhone_code(editedUser.getPhone_code());
		dbUser.setPhone_number(editedUser.getPhone_number());
		
		Date now = new Date();
		dbUser.setModified(now);
		
		return dbUser;
	}
	
	@PreAuthorize("#oldUsername == principal.username")
	public User updateUserFields(User editedUser, String oldUsername){
		
		User dbUser = this.findByID(editedUser.getId());
		if(dbUser != null) {
			dbUser = copyUserFields(editedUser, dbUser);
			return userDAO.saveEdited(dbUser);
		}
		
		return null;
	}
	
	@PreAuthorize("#username == principal.username")
	public User updatePassword(String username, String newPassword){
		
		User dbUser = userDAO.loadByUsername(username);
		if(dbUser != null){
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			dbUser.setPassword(encoder.encode(newPassword));
			Date now = new Date();
			dbUser.setModified(now);
			User savedUser = userDAO.saveEdited(dbUser);
			
			return savedUser;
		}
		
		return null;
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	public User updatePasswordAdmin(Integer id, String newPassword){
		
		User dbUser = userDAO.findByID(id);
		if(dbUser != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			dbUser.setPassword(encoder.encode(newPassword));
			Date now = new Date();
			dbUser.setModified(now);
			User savedUser = userDAO.saveEdited(dbUser);
			
			return savedUser;
		}
		return null;
	}
	
	public OffsetPage buildOffsetPage(int pageIndex, int size,  SingularAttribute sortField, SortDirection sortDirection){
		return userDAO.buildOffsetPage(pageIndex, size, sortField, sortDirection);
	}
	
	@PreAuthorize("hasRole('ADMIN')")
	public List<User> findPaginatedItems(Page page){
		return userDAO.findPaginatedItems(page);
	}
	
	public List<User> findMatching(String term, Page page) {
		return userDAO.findMatching(term, page);
	}
	
	
	public void registerUser(User user){
		
//		Date now = new Date();
//		
//		user.setActive(true);
//		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
//		user.setPassword(encoder.encode(user.getPassword()));
//		
//		user.setCreated(now);
//		user.setModified(now);
//		
//		Role userRole = roleRepository.findByName("ROLE_USER");
//		if(userRole != null) user.getRoles().add(userRole);
//		
//		
//		
//		//Add a profile for this user
//		Profile userProfile = new Profile();
//		userProfile.setUser(user);
//		ProfileType userProfileType = profileTypeService.findOne("user");
//		if(userProfileType != null)	userProfile.setProfileType(userProfileType);
//		
//		userProfile.setName(user.getUsername());
//		userProfile.setCreated(now);
//		userProfile.setModified(now);
//		
//		user.getProfiles().add(userProfile);
//		User savedUser = userRepository.save(user);
//		Profile savedUserProfile = profileService.findByUserAndProfileType(savedUser, userProfileType);
//		
//		if(savedUserProfile != null){
//		
//			Publication publication = savePublication(savedUserProfile, savedUserProfile.getName());
//			if(publication != null){
//				savedUserProfile.setPublication(publication);
//				//Resave the new User Profile with the publication ID
//				profileDAO.update(savedUserProfile);
//			}
//			
//			
//			String savingPath = this.relativePathToDefaultAvatar;
//			
//			/*
//			 * Give profile a default profile picture
//			 * Can't save upload directly with profile Owner because of multiple mappings on link_id and updatable, insertable is set to false for Profile in favor of Post
//			 */
//			
//			Upload profilePicture = new Upload();
//			profilePicture.setPath(savingPath);
//			profilePicture.setLinkTable("profilePicture");		
//			profilePicture.setLinkId(savedUserProfile.getId());
//			String uploadKey = Upload.generateUUID();
//			profilePicture.setKeyIdentification(uploadKey);
//			profilePicture.setDisplay(true);
//			profilePicture.setAltText("profilePicture");
////			profilePicture.setUploadOwner(savedUserProfile);
//			
//			uploadService.saveUpload(profilePicture);
//		}
		
	}


}
