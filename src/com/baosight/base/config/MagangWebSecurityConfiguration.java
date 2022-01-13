package com.baosight.base.config;

import com.baosight.base.auth.CaptchaFilter;
import com.baosight.iplat4j.config.WebSecurityConfiguration;
import com.baosight.iplat4j.core.security.SecurityTokenFilter;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;

@Configuration
@Order(99)
public class MagangWebSecurityConfiguration extends WebSecurityConfiguration {

    @Autowired
    private CaptchaFilter captchaFilter;

    @Override
    public void configure(WebSecurity web) {
        super.configure(web);
        web.ignoring().antMatchers("/api/**");
    }

    @SneakyThrows
    @Override
    protected void configure(HttpSecurity http) {
        super.configure(http);
        http.addFilterBefore(captchaFilter, SecurityTokenFilter.class);
    }
}
