package com.rpozzi.kafka.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.rpozzi.kafka.service.MessageService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("messages")
public class MessageController {

	@Autowired
    private MessageService messageService;

    @PutMapping
    public void publish(@RequestBody String message) {
        messageService.publish(message);
    }
}