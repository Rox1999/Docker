package com.example.addressbook.controller;

import com.example.addressbook.model.Contact;
import com.example.addressbook.repository.AddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/contacts")
public class AddressController {
    
    @Autowired
    private AddressRepository addressRepository;

    @GetMapping
    public String listContacts(Model model) {
        model.addAttribute("contacts", addressRepository.findAll());
        return "contacts";
    }

    @GetMapping("/new")
    public String showAddForm(Model model) {
        model.addAttribute("contact", new Contact(null, null, null, null));
        return "add-contact";
    }

    @PostMapping("/save")
    public String saveContact(@ModelAttribute Contact contact) {
        addressRepository.save(contact);
        return "redirect:/contacts";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Contact contact = addressRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("Invalid contact Id:" + id));
        model.addAttribute("contact", contact);
        return "edit-contact";
    }

    @GetMapping("/delete/{id}")
    public String deleteContact(@PathVariable Long id) {
        addressRepository.deleteById(id);
        return "redirect:/contacts";
    }
}