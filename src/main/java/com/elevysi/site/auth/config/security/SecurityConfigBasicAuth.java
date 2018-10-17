//http://websystique.com/spring-security/secure-spring-rest-api-using-basic-authentication/

//package com.elevysi.site.auth.config.security;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Qualifier;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.annotation.Order;
//import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
//import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
//import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.builders.WebSecurity;
//import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
//import org.springframework.security.config.http.SessionCreationPolicy;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
//
//import com.elevysi.site.auth.config.CustomUserDetailsService;
//
//
//@Configuration
//@EnableGlobalMethodSecurity(securedEnabled=true, jsr250Enabled=true, prePostEnabled=true)
////@Order(SecurityProperties.ACCESS_OVERRIDE_ORDER)
//public class SecurityConfigBasicAuth extends WebSecurityConfigurerAdapter{
//	
//	@Autowired
//	@Qualifier("customUserDetailsService")
//	private CustomUserDetailsService userDetailsService;
//	
//	@Bean
//    public DaoAuthenticationProvider authenticationProvider() {
//        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
//        authenticationProvider.setUserDetailsService(userDetailsService);
//        authenticationProvider.setPasswordEncoder(passwordEncoder());
//        return authenticationProvider;
//    }
//	
//	/**
//	 * configure Global vs. Configure
//	 * https://stackoverflow.com/questions/26348877/can-not-apply-daoauthenticationconfigurer-to-already-built-object
//	 */
//	
////	@Autowired
////    public void configure(AuthenticationManagerBuilder auth) throws Exception {
////        auth.userDetailsService(userDetailsService);
////        auth.authenticationProvider(authenticationProvider());
////    }
// 
//    
// 
//    @Override
//    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//    	auth.userDetailsService(userDetailsService);
//        auth.authenticationProvider(authenticationProvider());
//    }
//    
//    @Bean
//	public PasswordEncoder passwordEncoder(){
//		return new BCryptPasswordEncoder();
//	}
//    
//    
//    @Configuration
//    @Order(1)
//    public static class GloablSecurity extends WebSecurityConfigurerAdapter {
//    	
//    	private static String REALM="MY_TEST_REALM";
//    	
//    		@Bean
//        public CustomBasicAuthenticationEntryPoint getBasicAuthEntryPoint(){
//            return new CustomBasicAuthenticationEntryPoint();
//        }
//    
//	    @Override
//	    protected void configure(HttpSecurity http) throws Exception {
//	    	
//	    	/**
//	    	 * Differentiate Resource Server and Authentication Server
//	    	 * https://stackoverflow.com/questions/28908946/spring-security-oauth2-and-form-login-configuration
//	    	 */
//	    	
//	    	
////	    	http
////        	.requestMatchers()
////        		.antMatchers("/", "/denied", "/login", "/logout", "/oauth/authorize", "/ui/**") //If the context is not defined here, xml response with Full Authentication required
////		.and()
////    		.authorizeRequests()
////    			.antMatchers("/").permitAll()
////    			.antMatchers("/ui/auth/**").permitAll()
////	    		.antMatchers("/ui/public/**").permitAll()
////	    		.antMatchers("/ui/logout/**").permitAll()
////	    		.anyRequest().authenticated()
////		.and()
////	          .formLogin().permitAll()
////	          .loginPage("/login") //Redirection Problem described here https:stackoverflow.com/questions/28197941/spring-oauth2-not-redirecting-back-to-client-on-form-login
////	          .failureUrl("/ui/auth/failure")
////	          .defaultSuccessUrl("/ui/auth/successlogin")
////     .and()
////	          	.rememberMe()
////            		.rememberMeParameter("remember-me")
////                .tokenValiditySeconds(86400)
////        .and()
////            		.csrf()
////        	.and()
////        			.exceptionHandling()
////        			.accessDeniedPage("/denied")
////        .and()
////            		.logout()
//////            			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
////            		.logoutSuccessUrl("/ui/logout/success")
////            		.logoutUrl("/logout")
////            		.invalidateHttpSession(true)
//////	            		.deleteCookies(cookieNamesToClear).permitAll()
////        ;
//	    	
//	    	 http.csrf().disable()
//	    		.requestMatchers()
//        		.antMatchers("/", "/denied", "/login", "/logout", "/oauth/authorize", "/ui/**") //If the context is not defined here, xml response with Full Authentication required
//	        . and()
//	         .authorizeRequests()
//	         	.antMatchers("/").permitAll()
//	 			.antMatchers("/ui/auth/**").permitAll()
//		    		.antMatchers("/ui/public/**").permitAll()
//		    		.antMatchers("/ui/logout/**").permitAll()
//		    		.anyRequest().authenticated()
////	         .antMatchers("/user/**").hasRole("ADMIN")
//	         .and().httpBasic().realmName(REALM).authenticationEntryPoint(getBasicAuthEntryPoint())
//	         .and().sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);//We don't need sessions to be created.
//	    	
//	    	
////        http
////	        	.requestMatchers()
////	        		.antMatchers("/", "/denied", "/login", "/logout", "/oauth/authorize", "/ui/**") //If the context is not defined here, xml response with Full Authentication required
////    		.and()
////	    		.authorizeRequests()
////	    			.antMatchers("/").permitAll()
////	    			.antMatchers("/ui/auth/**").permitAll()
////		    		.antMatchers("/ui/public/**").permitAll()
////		    		.antMatchers("/ui/logout/**").permitAll()
////		    		.anyRequest().authenticated()
//////		    		.and().httpBasic()
//////    		.and()
//////		          .formLogin().permitAll()
//////		          .loginPage("/login") //Redirection Problem described here https:stackoverflow.com/questions/28197941/spring-oauth2-not-redirecting-back-to-client-on-form-login
//////		          .failureUrl("/ui/auth/failure")
//////		          .defaultSuccessUrl("/ui/auth/successlogin")
////	     .and()
////		          	.rememberMe()
////	            		.rememberMeParameter("remember-me")
////	                .tokenValiditySeconds(86400)
////            .and()
////	            		.csrf()
////            	.and()
////	        			.exceptionHandling()
////	        			.accessDeniedPage("/denied")
////            .and()
////	            		.logout()
//////	            			.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
////	            		.logoutSuccessUrl("/ui/logout/success")
////	            		.logoutUrl("/logout")
////	            		.invalidateHttpSession(true)
//////  	            		.deleteCookies(cookieNamesToClear).permitAll()
////	        ;
//        
//	    }
//	    
//	    @Override
//	    public void configure(WebSecurity webSecurity) throws Exception
//	    {	
//	        webSecurity
//	            .ignoring()
//	            .antMatchers("/resources/**")
//	            .antMatchers("/resources_1_8/**")
//	            .antMatchers("/js/**")
//	            .antMatchers("/css/**")
//	            .antMatchers("/img/**")
//	            .antMatchers("/ng/**")
//	            .antMatchers("/assets/**")
//	            .antMatchers("/resources_1_9/**")
//	            .antMatchers("/resources_1_9_5/**")
//	            .antMatchers("/thematic_1_9/**");
//	        
//	    }
//    }
//    
//    
////    @Configuration
////    @Order(2)
////    public static class RequestedAuthWebSecurityConfigurationAdapter extends WebSecurityConfigurerAdapter {
////    	
////    		@Autowired
////        RoleUrlAuthenticationSuccessHandler roleUrlAuthenticationSuccessHandler;
////    	
////        protected void configure(HttpSecurity http) throws Exception {
////
////        	
////        	http
////        		.antMatcher("/auth/rqstd/**")
////        		.authorizeRequests()
//////				.antMatchers("/auth/rqstd/login").permitAll()
////				.antMatchers("/auth/rqstd/failure").permitAll()
//////				.antMatchers("/auth/rqstd/**").permitAll()
////				.and()
////				 .formLogin()
////				 	.loginPage("/auth/rqstd/login") //Redirection Problem described here https:stackoverflow.com/questions/28197941/spring-oauth2-not-redirecting-back-to-client-on-form-login
////				 	.loginProcessingUrl("/auth/rqstd/doLogIn")
////		         .failureUrl("/auth/failure")
////		         .successHandler(roleUrlAuthenticationSuccessHandler)
////		         .usernameParameter("username")
////	             .passwordParameter("password")
////              .and()
////            .csrf();
////        }
////    }
//}