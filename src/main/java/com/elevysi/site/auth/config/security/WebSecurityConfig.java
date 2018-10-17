package com.elevysi.site.auth.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;

import com.elevysi.site.auth.config.CustomUserDetailsService;

//https://stackoverflow.com/questions/28900681/can-spring-boot-application-have-separate-security-for-rest-apis
//https://github.com/spring-projects/spring-security-oauth/blob/master/samples/oauth2/sparklr/src/main/java/org/springframework/security/oauth/examples/sparklr/config/OAuth2ServerConfig.java

@Configuration
@EnableGlobalMethodSecurity(securedEnabled=true, jsr250Enabled=true, prePostEnabled=true)
public class WebSecurityConfig {
	
	private static final String RESOURCE_ID = "authorizationResourceApi";
	
    
    
    @Order(1)
    @Configuration
    @EnableResourceServer
    protected static class ResourceServerConfiguration extends ResourceServerConfigurerAdapter {
    	
	    	@Override 
	    	public void configure(ResourceServerSecurityConfigurer resources) {
	    		resources.resourceId(RESOURCE_ID).stateless(false); 
	    	}
    	
    		@Override
        public void configure(HttpSecurity http) throws Exception{
            http
            .requestMatchers().antMatchers("/api/**")
            .and()
            .authorizeRequests()
//            	  .antMatchers("/api/user").permitAll()
              .antMatchers(HttpMethod.DELETE, "/v1/organizations/**").hasRole("ADMIN")
              .anyRequest().authenticated();
        }
    }
    
    @Order(2)
    @Configuration
    public static class FormWebSecurityConfig extends WebSecurityConfigurerAdapter {
    	
	    	@Autowired
	    	@Qualifier("customUserDetailsService")
	    	private CustomUserDetailsService userDetailsService;
	    	
	    	@Bean
	    	public PasswordEncoder passwordEncoder(){
	    		return new BCryptPasswordEncoder();
	    	}
    	
	    	@Bean
        public DaoAuthenticationProvider authenticationProvider() {
            DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
            authenticationProvider.setUserDetailsService(userDetailsService);
            authenticationProvider.setPasswordEncoder(passwordEncoder());
            return authenticationProvider;
        }
    	
    		@Override
        protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        	auth.userDetailsService(userDetailsService);
            auth.authenticationProvider(authenticationProvider());
        }
    
	    @Override
	    protected void configure(HttpSecurity http) throws Exception {
	    	
	    	/**
	    	 * Differentiate Resource Server and Authentication Server
	    	 * https://stackoverflow.com/questions/28908946/spring-security-oauth2-and-form-login-configuration
	    	 */
	    	
	    	
        http
	        	.requestMatchers()
	        		.antMatchers("/", "/denied", "/login", "/logout", "/oauth/authorize", "/ui/**") //If the context is not defined here, xml response with Full Authentication required
    		.and()
	    		.authorizeRequests()
	    			.antMatchers("/").permitAll()
	    			.antMatchers("/ui/auth/**").permitAll()
		    		.antMatchers("/ui/public/**").permitAll()
		    		.antMatchers("/ui/logout/**").permitAll()
		    		.anyRequest().authenticated()
    		.and()
		          .formLogin().permitAll()
		          .loginPage("/login") //Redirection Problem described here https:stackoverflow.com/questions/28197941/spring-oauth2-not-redirecting-back-to-client-on-form-login
		          .failureUrl("/ui/auth/failure")
		          .defaultSuccessUrl("/ui/auth/successlogin")
	     .and()
		          	.rememberMe()
	            		.rememberMeParameter("remember-me")
	                .tokenValiditySeconds(86400)
            .and()
	            		.csrf()
            	.and()
	        			.exceptionHandling()
	        			.accessDeniedPage("/denied")
            .and()
	            		.logout()
//	            			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
	            		.logoutSuccessUrl("/ui/logout/success")
	            		.logoutUrl("/logout")
	            		.invalidateHttpSession(true)
//  	            		.deleteCookies(cookieNamesToClear).permitAll()
	        ;
	    }
	    
	    @Override
	    public void configure(WebSecurity webSecurity) throws Exception
	    {	
	        webSecurity
	            .ignoring()
	            .antMatchers("/resources/**")
	            .antMatchers("/resources_1_8/**")
	            .antMatchers("/js/**")
	            .antMatchers("/css/**")
	            .antMatchers("/img/**")
	            .antMatchers("/ng/**")
	            .antMatchers("/assets/**")
	            .antMatchers("/resources_1_9/**")
	            .antMatchers("/resources_1_9_5/**")
	            .antMatchers("/thematic_1_9/**");
	        
	    }
    }
    
    
    @Configuration
    @Order(3)
    public static class RequestedFormWebSecurityConfig extends WebSecurityConfigurerAdapter {
    	
    		@Autowired
        RoleUrlAuthenticationSuccessHandler roleUrlAuthenticationSuccessHandler;
    	
        protected void configure(HttpSecurity http) throws Exception {

        	
        	http
        		.antMatcher("/auth/rqstd/**")
        		.authorizeRequests()
				.antMatchers("/auth/rqstd/failure").permitAll()
				.and()
				 .formLogin()
				 	.loginPage("/auth/rqstd/login") //Redirection Problem described here https:stackoverflow.com/questions/28197941/spring-oauth2-not-redirecting-back-to-client-on-form-login
				 	.loginProcessingUrl("/auth/rqstd/doLogIn")
		         .failureUrl("/auth/failure")
		         .successHandler(roleUrlAuthenticationSuccessHandler)
		         .usernameParameter("username")
	             .passwordParameter("password")
              .and()
            .csrf();
        }
    }
}