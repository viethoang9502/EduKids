package com.project.eduapp.controllers;

import com.project.eduapp.models.Role;
import com.project.eduapp.responses.ResponseObject;
import com.project.eduapp.services.role.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/roles")
@RequiredArgsConstructor
@CrossOrigin("*")
public class RoleController {
    private final RoleService roleService;
    @GetMapping("")
    public ResponseEntity<ResponseObject> getAllRoles() {
        List<Role> roles = roleService.getAllRoles();
        return ResponseEntity.ok().body(ResponseObject.builder()
                        .message("Get roles successfully")
                        .status(HttpStatus.OK)
                        .data(roles)
                .build());
    }
}
