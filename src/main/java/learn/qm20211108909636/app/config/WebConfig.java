package learn.qm20211108909636.app.config;

import jakarta.servlet.MultipartConfigElement;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.*;

/**
 * 作者：2021110890 张广福
 * Web 配置类
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "learn.qm20211108909636.app")
public class WebConfig implements WebMvcConfigurer {

    // 配置视图解析器
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.jsp("/WEB-INF/view/", ".jsp");
    }

    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }



    // 配置静态资源访问路径
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 配置 /resources/ 下的静态资源
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("classpath:/resources/");
    }


    // 配置拦截器
    @Override
    public void addInterceptors(InterceptorRegistry registry) {

    }
}
