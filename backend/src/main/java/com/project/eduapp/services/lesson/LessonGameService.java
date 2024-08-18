//package com.project.eduapp.services.lesson;
//
//import com.project.eduapp.models.LessonGame;
//import com.project.eduapp.repositories.LessonGameRepository;
//import lombok.RequiredArgsConstructor;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//
//@Service
//@RequiredArgsConstructor
//public class LessonGameService implements ILessonGameService {
//
//    private final LessonGameRepository lessonGameRepository;
//
//    @Override
//    public LessonGame createGame(LessonGame lessonGame) {
//        return lessonGameRepository.save(lessonGame);
//    }
//
//    @Override
//    public List<LessonGame> getGamesByLessonId(Long lessonId) {
//        return lessonGameRepository.findByLessonId(lessonId);
//    }
//
//    @Override
//    public void deleteGame(Long id) {
//        lessonGameRepository.deleteById(id);
//    }
//}
