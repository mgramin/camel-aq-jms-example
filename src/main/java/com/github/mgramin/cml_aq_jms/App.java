package com.github.mgramin.cml_aq_jms;

import com.github.mgramin.cml_aq_jms.mq.IMessageSender;
import org.springframework.context.support.GenericXmlApplicationContext;

import java.sql.SQLException;

/**
 * Created by maksim on 21.04.16.
 */
public class App {

    public static void main(String[] args) throws SQLException, InterruptedException {

        GenericXmlApplicationContext ctx = new GenericXmlApplicationContext("context.xml");

        ctx.start();

        Thread.currentThread().sleep(50000);

        ctx.stop();

    }

}