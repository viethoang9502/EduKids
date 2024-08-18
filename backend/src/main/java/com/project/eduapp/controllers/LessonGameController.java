//package com.project.eduapp.controllers;
//
//import com.project.eduapp.models.LessonGame;
//import com.project.eduapp.responses.ResponseObject;
//import com.project.eduapp.services.lesson.ILessonGameService;
//import com.project.eduapp.utils.MessageKeys;
//import com.project.eduapp.components.LocalizationUtils;
//import jakarta.validation.Valid;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//
//import java.util.List;
//
//@RestController
//@RequestMapping("${api.prefix}/lesson_games")
//@RequiredArgsConstructor
//public class LessonGameController {
//    private final ILessonGameService lessonGameService;
//    private final LocalizationUtils localizationUtils;
//
//    @PostMapping("")
//    public ResponseEntity<ResponseObject> createGame(
//            @Valid @RequestBody LessonGame lessonGame
//    ) {
//        LessonGame newGame = lessonGameService.createGame(lessonGame);
//        return ResponseEntity.ok(
//                ResponseObject.builder()
//                        .message(localizationUtils.getLocalizedMessage(MessageKeys.CREATE_GAME_SUCCESS))
//                        .status(HttpStatus.CREATED)
//                        .data(newGame)
//                        .build()
//        );
//    }
//
//    @GetMapping("/{lessonId}")
//    public ResponseEntity<ResponseObject> getGamesByLessonId(
//            @PathVariable("lessonId") Long lessonId
//    ) {
//        List<LessonGame> games = lessonGameService.getGamesByLessonId(lessonId);
//        return ResponseEntity.ok(
//                ResponseObject.builder()
//                        .message(localizationUtils.getLocalizedMessage(MessageKeys.GET_GAMES_SUCCESS))
//                        .status(HttpStatus.OK)
//                        .data(games)
//                        .build()
//        );
//    }
//
//    @DeleteMapping("/{id}")
//    public ResponseEntity<ResponseObject> deleteGame(@PathVariable long id) {
//        lessonGameService.deleteGame(id);
//        return ResponseEntity.ok(
//                ResponseObject.builder()
//                        .data(null)
//                        .message(localizationUtils.getLocalizedMessage(MessageKeys.DELETE_GAME_SUCCESS, id))
//                        .status(HttpStatus.OK)
//                        .build()
//        );
//    }
//}
