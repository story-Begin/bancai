package com.baosight.base.config;

import com.github.pagehelper.PageHelper;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import tk.mybatis.spring.mapper.MapperScannerConfigurer;

import javax.sql.DataSource;
import java.util.Properties;

/**
 * @author huang
 * @Title: DataSourceConfig
 * @ProjectName iplat4j
 * @Description: TODO
 * @date 2020/7/26 0:22
 */
@Configuration
public class DataSourceConfig {

//    @Bean(name = "myDataSource")
//    @ConfigurationProperties("spring.datasource.druid")
//    public DruidDataSource dataSource() {
//        return new DruidDataSource();
//    }

    @Autowired
    private DataSource dataSource;

    @Bean
    // @Qualifier(value = "myDataSource") DataSource dataSource
    public SqlSessionFactory sqlSessionFactoryBean() throws Exception {
        SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
        bean.setDataSource(dataSource);

        //添加XML目录  注意: resource目录下必须要有mapper文件夹  否则报错,此处也是坑
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        bean.setMapperLocations(resolver.getResources("mybatis/*/*.xml"));
        return bean.getObject();
    }

    //注意此类的加载必须要在MybatisConfig之后在加载
    @Configuration
    @AutoConfigureAfter(DataSourceConfig.class)
    public static class MyBatisMapperScannerConfig {

        @Bean
        public MapperScannerConfigurer mapperScannerConfig() {
            MapperScannerConfigurer mapperScannerConfigurer = new MapperScannerConfigurer();
            mapperScannerConfigurer.setSqlSessionFactoryBeanName("sqlSessionFactory");
            //扫描mapper位置
            mapperScannerConfigurer.setBasePackage("com.baosight.base.entity.*");
            //配置通用mappers
            Properties properties = new Properties();
            //注册自定义mapper
            properties.setProperty("mappers", "com.baosight.base.entity.BaseEntity");
            properties.setProperty("notEmpty", "false");
            properties.setProperty("IDENTITY", "MYSQL");
            mapperScannerConfigurer.setProperties(properties);

            return mapperScannerConfigurer;
        }

    }

    /**
     * 配置mybatis的分页插件pageHelper
     *
     * @return
     */
    @Bean
    public PageHelper pageHelper() {
        PageHelper pageHelper = new PageHelper();
        Properties properties = new Properties();
        properties.setProperty("offsetAsPageNum", "true");
        properties.setProperty("rowBoundsWithCount", "true");
        properties.setProperty("reasonable", "true");
        //指定为MySQL数据库
        properties.setProperty("helperDialect", "mysql");
        pageHelper.setProperties(properties);
        return pageHelper;
    }

}
