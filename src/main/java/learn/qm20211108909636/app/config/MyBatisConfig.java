package learn.qm20211108909636.app.config;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.apache.ibatis.session.SqlSessionFactory;
import javax.sql.DataSource;

/**
 * 作者：2021110890 张广福
 * MyBatis 配置类
 */
@Configuration
@MapperScan("learn.qm20211108909636.app.dao")
public class MyBatisConfig {

    // 配置 MyBatis 的 SqlSessionFactory
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
        sessionFactory.setDataSource(dataSource);
        sessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mapper/*.xml"));
        return sessionFactory.getObject();
    }

    // 配置 MyBatis 的 MapperScannerConfigurer，扫描 Mapper 接口
    @Bean
    public MapperScannerConfigurer mapperScannerConfigurer() {
        MapperScannerConfigurer scannerConfigurer = new MapperScannerConfigurer();
        scannerConfigurer.setBasePackage("learn.qm20211108909636.app.dao");
        return scannerConfigurer;
    }
}
