package com.elevysi.site.auth.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.elevysi.site.auth.entity.Role;
import com.elevysi.site.auth.service.UserService;
import com.elevysi.site.auth.utils.ActiveUser;

@Service("customUserDetailsService")
@Transactional(readOnly = true)
public class CustomUserDetailsService implements UserDetailsService{
	
	@Autowired
	private UserService userService;
	
	@Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		try{
	        com.elevysi.site.auth.entity.User domainUser = userService.loadUserByUsernameForLogin(username);
	        boolean enabled = domainUser.isActive();
	        boolean accountNonExpired = domainUser.isActive();
	        boolean credentialsNonExpired = domainUser.isActive();
	        boolean accountNonLocked = domainUser.isActive();
	        
	        Set<Role> roles = domainUser.getRoles();
	        
	        List<String> springSecurityRoles = treatRoles(roles);
	        List<GrantedAuthority> authList = getGrantedAuthorities(springSecurityRoles);
	
	        return new ActiveUser(
            		domainUser.getUsername(), 
                    domainUser.getPassword(), 
                    enabled, 
                    accountNonExpired, 
                    credentialsNonExpired, 
                    accountNonLocked,
                    authList,
                    domainUser.getFirst_name());
	        
	        
		}catch(UsernameNotFoundException e){
			throw new RuntimeException(e);
		}
    }
	
	/**
	 * Converts a numerical role to an equivalent list of roles
	 * @param role the numerical role
	 * @return list of roles as as a list of {@link String}
	 */
    public List<String> treatRoles(Set<Role> roles) {
    	List<String> security_roles = new ArrayList<String>();
    	
    	for (Role userRole : roles) {
    		security_roles.add(userRole.getName());
		}
    	
    	return security_roles;
    }
    
    /**
	 * Wraps {@link String} roles to {@link SimpleGrantedAuthority} objects
	 * @param roles {@link String} of roles
	 * @return list of granted authorities
	 */
    public static List<GrantedAuthority> getGrantedAuthorities(List<String> roles) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
         
        for (String role : roles) {
            authorities.add(new SimpleGrantedAuthority(role));
        }
        return authorities;
    }
	
}
