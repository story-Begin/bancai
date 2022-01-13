package com.baosight.base.config;

import com.baosight.base.auth.CaptchaFilter;
import com.baosight.iplat4j.config.ServiceSecurityConfiguration;
import com.baosight.iplat4j.core.security.SecurityTokenFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;

@Configuration
@Order(100)
public class MagangServiceSecurityConfigurerAdapter extends ServiceSecurityConfiguration {

    @Autowired
    private CaptchaFilter captchaFilter;

    @Override
    protected void configure(HttpSecurity http) {
        super.configure(http);
        http.addFilterBefore(captchaFilter, SecurityTokenFilter.class);
    }
}
