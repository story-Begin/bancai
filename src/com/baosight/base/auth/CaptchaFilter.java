package com.baosight.base.auth;

import com.google.code.kaptcha.Constants;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CaptchaFilter extends OncePerRequestFilter {

    static final Logger LOGGER = LoggerFactory.getLogger(CaptchaFilter.class);

    private static final String LOGIN_URL = "/login";

    @Override
    protected void doFilterInternal(HttpServletRequest servletRequest, HttpServletResponse servletResponse,
                                    FilterChain filterChain) throws ServletException, IOException {
        String uri = servletRequest.getRequestURI();
        servletRequest.setAttribute("captchaMessage", null);
        boolean needFilter = isNeedFilter(uri);
        if (needFilter) {
            String sessionCaptcha = (String) servletRequest.getSession().getAttribute(Constants.KAPTCHA_SESSION_KEY);
            if (StringUtils.isBlank(sessionCaptcha)) {
                LOGGER.info("验证码已经失效");
//                servletRequest.setAttribute("captchaMessage", "验证码已经失效");
                RequestDispatcher rd = servletRequest.getRequestDispatcher("/iPlatV6-login.jsp");
                rd.forward(servletRequest, servletResponse);
                // servletResponse.sendRedirect(servletRequest.getContextPath() + "/iPlatV6-login.jsp");
            } else {
                String reqCaptcha = (String) servletRequest.getParameter("captcha");
                if (StringUtils.isBlank(reqCaptcha)) {
                    LOGGER.info("验证码不能为空");
                    servletRequest.setAttribute("captchaMessage", "验证码不能为空");
                    // servletResponse.sendRedirect(servletRequest.getContextPath() + "/iPlatV6-login.jsp");
                    RequestDispatcher rd = servletRequest.getRequestDispatcher("/iPlatV6-login.jsp");
                    rd.forward(servletRequest, servletResponse);
                } else if (reqCaptcha.equals(sessionCaptcha)) {
                    filterChain.doFilter(servletRequest, servletResponse);
                } else {
                    LOGGER.info("验证码不正确");
                    servletRequest.setAttribute("captchaMessage", "验证码不正确");
                    // servletResponse.sendRedirect(servletRequest.getContextPath() + "/iPlatV6-login.jsp");
                    RequestDispatcher rd = servletRequest.getRequestDispatcher("/iPlatV6-login.jsp");
                    rd.forward(servletRequest, servletResponse);
                }
            }
        } else {
        filterChain.doFilter(servletRequest, servletResponse);
        }
    }

    /**
     * 是否需要过滤
     *
     * @param uri
     * @return
     */
    public boolean isNeedFilter(String uri) {
        if (uri.endsWith(LOGIN_URL)) {
            return true;
        }
        return false;
    }

}
