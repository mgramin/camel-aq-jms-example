package com.github.mgramin.cml_aq_jms.mq;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Component;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

/**
 * Created by maksim on 21.04.16.
 */

@Component("messageSender")
public class SimpleMessageSender implements IMessageSender {

    @Autowired
    private JmsTemplate jmsTemplate;

    public void sendMessage(final String message) {
        this.jmsTemplate.send(new MessageCreator() {
            public Message createMessage(Session session) throws JMSException {
                Message textMessage = session.createTextMessage(message);
                textMessage.setStringProperty("hello", "World");
                textMessage.setStringProperty("prop1", "val1");
                textMessage.setStringProperty("prop2", "val2");
                return textMessage;
            }
        });
    }

}
