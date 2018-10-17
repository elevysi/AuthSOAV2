//package com.elevysi.site.auth.config.security;
//
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.annotation.Order;
//import org.springframework.http.HttpMethod;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
//import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
//import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
//
//@Configuration
//@EnableResourceServer
//@Order(1)
//public class ResourceServerConfiguration extends ResourceServerConfigurerAdapter {
//	
//	private static final String RESOURCE_ID = "authorizationResourceApi";
//	
//	//Only APIs calls are considered as resource server i.e. needing token
////	@Override
////    public void configure(HttpSecurity http) throws Exception{
////        http
////        .requestMatchers().antMatchers("/api/**")
////        .and()
////        .authorizeRequests()
//////        	  .antMatchers("/api/user").permitAll()
////          .antMatchers(HttpMethod.DELETE, "/v1/organizations/**").hasRole("ADMIN")
////          .anyRequest().authenticated();
////    }
//	
//	@Override 
//	public void configure(ResourceServerSecurityConfigurer resources) {
//		resources.resourceId(RESOURCE_ID).stateless(false); 
//	}
//
//}
