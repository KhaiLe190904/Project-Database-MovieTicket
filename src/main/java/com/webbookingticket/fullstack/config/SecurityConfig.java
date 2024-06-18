//package com.webbookingticket.fullstack.config;
//
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.http.HttpMethod;
//import org.springframework.security.config.Customizer;
//import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
//import org.springframework.security.config.annotation.web.builders.HttpSecurity;
//import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
//import org.springframework.security.config.annotation.web.configurers.CorsConfigurer;
//import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.security.provisioning.JdbcUserDetailsManager;
//import org.springframework.security.provisioning.UserDetailsManager;
//import org.springframework.security.web.SecurityFilterChain;
//import org.springframework.security.web.access.AccessDeniedHandlerImpl;
//import org.springframework.web.cors.CorsConfiguration;
//import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
//
//import javax.sql.DataSource;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.List;
//
//@Configuration
//@EnableWebSecurity
//@EnableMethodSecurity
//
//public class SecurityConfig {
//
//    @Bean
//    PasswordEncoder getPasswordEncoder() {
//        return new BCryptPasswordEncoder();
//    }
//
//    @Bean
//    public UserDetailsManager userDetailsManager(DataSource dataSource) {
//        JdbcUserDetailsManager theUserDetailsManager = new JdbcUserDetailsManager(dataSource);
//        theUserDetailsManager.setUsersByUsernameQuery(
//                "SELECT username, password, 1 as enabled FROM users WHERE username = ?"
//        );
//
//        theUserDetailsManager.setAuthoritiesByUsernameQuery(
//                "SELECT u.username, r.role_name as authority " +
//                        "FROM users u " +
//                        "JOIN users_roles ur ON u.id = ur.user_id " +
//                        "JOIN roles r ON ur.role_id = r.id " +
//                        "WHERE u.username = ?"
//        );
//        return theUserDetailsManager;
//    }
//
////    @Bean
////    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
////        AccessDeniedHandlerImpl accessDeniedHandler = new AccessDeniedHandlerImpl();
////        accessDeniedHandler.setErrorPage("/access-denied");
////        http
////                .authorizeHttpRequests(authorize -> authorize
////                        .requestMatchers("/css/**", "/js/**", "/images/**", "/signin", "/signup").permitAll()
////                        .requestMatchers (HttpMethod.POST, "/admin/**").permitAll()
////                        .anyRequest().hasAnyRole("ADMIN", "USER")
////                )
////                .formLogin(form -> form
////                        .loginPage("/signin")
////                        .loginProcessingUrl("/authenticateTheUser")
////                        .defaultSuccessUrl("/home", true)
////                        .permitAll()
////                )
////                .logout(logout -> logout.permitAll())
////                .exceptionHandling(exception -> exception
////                        .accessDeniedHandler(accessDeniedHandler)
////                        .accessDeniedPage("/access-denied")
////                );
////        http
////            .cors(new Customizer<CorsConfigurer<HttpSecurity>>() {
////            @Override
////            public void customize(CorsConfigurer<HttpSecurity> httpSecurityCorsConfigurer) {
////                CorsConfiguration configuration = new CorsConfiguration();
////                configuration.setAllowedOrigins(List.of("*"));
////                configuration.setAllowedMethods(Arrays.asList("GET","POST","PATCH","DELETE","OPTIONS"));
////                configuration.setAllowedHeaders(Arrays.asList("authorization","content-type","x-auth-token"));
////                UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
////                source.registerCorsConfiguration("/**",configuration);
////                httpSecurityCorsConfigurer.configurationSource(source);
////            }
////        });
////        return http.build();
////    }
//}
