package com.mizore.utils;

import org.apache.commons.dbutils.BasicRowProcessor;
import org.apache.commons.dbutils.GenerousBeanProcessor;
import org.apache.commons.dbutils.RowProcessor;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

public class DbUtilsConfig {

    private static final RowProcessor ROW_PROCESSOR = new BasicRowProcessor(new GenerousBeanProcessor());

    public static <T> BeanHandler<T> newBeanHandler(Class<T> type) {
        return new BeanHandler<>(type, ROW_PROCESSOR);
    }

    public static <T> BeanListHandler<T> newBeanListHandler(Class<T> type) {
        return new BeanListHandler<>(type, ROW_PROCESSOR);
    }
}
