package com.project.eduapp.services.comment;

import com.project.eduapp.dtos.CommentDTO;
import com.project.eduapp.exceptions.DataNotFoundException;
import com.project.eduapp.models.Comment;
import com.project.eduapp.responses.comment.CommentResponse;

import java.util.List;

public interface ICommentService {
    Comment insertComment(CommentDTO comment);

    void deleteComment(Long commentId);
    void updateComment(Long id, CommentDTO commentDTO) throws DataNotFoundException;

    List<CommentResponse> getCommentsByUserAndProduct(Long userId, Long productId);
    List<CommentResponse> getCommentsByProduct(Long productId);
}
