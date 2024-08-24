package com.project.eduapp.services.lesson;

import com.project.eduapp.dtos.ProductDTO;
import com.project.eduapp.dtos.ProductImageDTO;
import com.project.eduapp.dtos.ProductVideoDTO;
import com.project.eduapp.exceptions.DataNotFoundException;
import com.project.eduapp.exceptions.InvalidParamException;
import com.project.eduapp.models.*;
import com.project.eduapp.repositories.*;
import com.project.eduapp.responses.lesson.LessonResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class LessonService implements ILessonService {
    private final LessonRepository productRepository;
    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;
    private final ProductImageRepository productImageRepository;
    private final ProductVideoRepository productVideoRepository;
    private final FavoriteRepository favoriteRepository;
    private static String UPLOADS_FOLDER = "uploads";
    @Override
    @Transactional
    public Lesson createProduct(ProductDTO productDTO) throws DataNotFoundException {
        Category existingCategory = categoryRepository
                .findById(productDTO.getCategoryId())
                .orElseThrow(() ->
                        new DataNotFoundException(
                                "Cannot find category with id: "+productDTO.getCategoryId()));

        Lesson newProduct = Lesson.builder()
                .name(productDTO.getName())
                .price(productDTO.getPrice())
                .thumbnail(productDTO.getThumbnail())
                .description(productDTO.getDescription())
                .category(existingCategory)
                .build();
        return productRepository.save(newProduct);
    }

    @Override
    public Lesson getProductById(long productId) throws Exception {
        Optional<Lesson> optionalProduct = productRepository.getDetailProduct(productId);
        if(optionalProduct.isPresent()) {
            return optionalProduct.get();
        }
        throw new DataNotFoundException("Cannot find product with id =" + productId);
    }
    @Override
    public List<Lesson> findProductsByIds(List<Long> productIds) {
        return productRepository.findProductsByIds(productIds);
    }

    @Override
    public Page<LessonResponse> getAllProducts(String keyword,
                                               Long categoryId, PageRequest pageRequest) {
        // Lấy danh sách sản phẩm theo trang (page), giới hạn (limit), và categoryId (nếu có)
        Page<Lesson> productsPage;
        productsPage = productRepository.searchProducts(categoryId, keyword, pageRequest);
        return productsPage.map(LessonResponse::fromProduct);
    }
    @Override
    @Transactional
    public Lesson updateProduct(
            long id,
            ProductDTO productDTO
    )
            throws Exception {
        Lesson existingProduct = getProductById(id);
        if(existingProduct != null) {
            //copy các thuộc tính từ DTO -> Product
            //Có thể sử dụng ModelMapper
            Category existingCategory = categoryRepository
                    .findById(productDTO.getCategoryId())
                    .orElseThrow(() ->
                            new DataNotFoundException(
                                    "Cannot find category with id: "+productDTO.getCategoryId()));
            if(productDTO.getName() != null && !productDTO.getName().isEmpty()) {
                existingProduct.setName(productDTO.getName());
            }

            existingProduct.setCategory(existingCategory);
            if(productDTO.getPrice() >= 0) {
                existingProduct.setPrice(productDTO.getPrice());
            }
            if(productDTO.getDescription() != null &&
                    !productDTO.getDescription().isEmpty()) {
                existingProduct.setDescription(productDTO.getDescription());
            }
            if(productDTO.getThumbnail() != null &&
                    !productDTO.getThumbnail().isEmpty()) {
                existingProduct.setDescription(productDTO.getThumbnail());
            }
            return productRepository.save(existingProduct);
        }
        return null;
    }

    @Override
    @Transactional
    public void deleteProduct(long id) {
        Optional<Lesson> optionalProduct = productRepository.findById(id);
        optionalProduct.ifPresent(productRepository::delete);
    }

    @Override
    public boolean existsByName(String name) {
        return productRepository.existsByName(name);
    }
    @Override
    @Transactional
    public LessonMedia createProductImage(
            Long lessonId,
            ProductImageDTO productImageDTO) throws Exception {
        Lesson existingProduct = productRepository
                .findById(lessonId)
                .orElseThrow(() ->
                        new DataNotFoundException(
                                "Cannot find product with id: "+productImageDTO.getLessonId()));
        LessonMedia newProductImage = LessonMedia.builder()
                .lesson(existingProduct)
                .imageUrl(productImageDTO.getImageUrl())
                .build();
        //Ko cho insert quá 5 ảnh cho 1 sản phẩm
        int size = productImageRepository.findByLessonId(lessonId).size();
        if(size >= LessonMedia.MAXIMUM_IMAGES_PER_PRODUCT) {
            throw new InvalidParamException(
                    "Number of images must be <= "
                    + LessonMedia.MAXIMUM_IMAGES_PER_PRODUCT);
        }
        if (existingProduct.getThumbnail() == null ) {
            existingProduct.setThumbnail(newProductImage.getImageUrl());
        }
        productRepository.save(existingProduct);
        return productImageRepository.save(newProductImage);
    }

    @Override
    @Transactional
    public LessonVideo createProductVideo(
            Long lessonId,
            ProductVideoDTO productVideoDTO) throws Exception {
        Lesson existingProduct = productRepository
                .findById(lessonId)
                .orElseThrow(() ->
                        new DataNotFoundException(
                                "Cannot find product with id: "+ productVideoDTO.getLessonId()));
        LessonVideo newProductImage = LessonVideo.builder()
                .lesson(existingProduct)
                .videoUrl(productVideoDTO.getVideoUrl())
                .build();
        //Ko cho insert quá 5 ảnh cho 1 sản phẩm
        int size = productVideoRepository.findByLessonId(lessonId).size();
        if(size >= LessonVideo.MAXIMUM_VIDEOS_PER_PRODUCT) {
            throw new InvalidParamException(
                    "Number of images must be <= "
                            + LessonMedia.MAXIMUM_IMAGES_PER_PRODUCT);
        }

        productRepository.save(existingProduct);
        return productVideoRepository.save(newProductImage);
    }
    @Override
    public void deleteFile(String filename) throws IOException {
        // Đường dẫn đến thư mục chứa file
        java.nio.file.Path uploadDir = Paths.get(UPLOADS_FOLDER);
        // Đường dẫn đầy đủ đến file cần xóa
        java.nio.file.Path filePath = uploadDir.resolve(filename);

        // Kiểm tra xem file tồn tại hay không
        if (Files.exists(filePath)) {
            // Xóa file
            Files.delete(filePath);
        } else {
            throw new FileNotFoundException("File not found: " + filename);
        }
    }
    private boolean isImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        return contentType != null && contentType.startsWith("image/");
    }
    @Override
    @Transactional
    public Lesson likeProduct(Long userId, Long productId) throws Exception {
        // Check if the user and product exist
        if (!userRepository.existsById(userId) || !productRepository.existsById(productId)) {
            throw new DataNotFoundException("User or product not found");
        }

        // Check if the user has already liked the product
        if (favoriteRepository.existsByUserIdAndProductId(userId, productId)) {
            //throw new DataNotFoundException("Product already liked by the user");
        } else {
            // Create a new favorite entry and save it
            Favorite favorite = Favorite.builder()
                    .product(productRepository.findById(productId).orElse(null))
                    .user(userRepository.findById(userId).orElse(null))
                    .build();
            favoriteRepository.save(favorite);
        }
        // Return the liked product
        return productRepository.findById(productId).orElse(null);
    }
    @Override
    @Transactional
    public Lesson unlikeProduct(Long userId, Long productId) throws Exception {
        // Check if the user and product exist
        if (!userRepository.existsById(userId) || !productRepository.existsById(productId)) {
            throw new DataNotFoundException("User or product not found");
        }

        // Check if the user has already liked the product
        if (favoriteRepository.existsByUserIdAndProductId(userId, productId)) {
            Favorite favorite = favoriteRepository.findByUserIdAndProductId(userId, productId);
            favoriteRepository.delete(favorite);
        }
        return productRepository.findById(productId).orElse(null);
    }
    @Override
    @Transactional
    public List<LessonResponse> findFavoriteProductsByUserId(Long userId) throws Exception {
        // Validate the userId
        Optional<User> optionalUser = userRepository.findById(userId);
        if (optionalUser.isEmpty()) {
            throw new Exception("User not found with ID: " + userId);
        }
        // Retrieve favorite products for the given userId
        List<Lesson> favoriteProducts = productRepository.findFavoriteProductsByUserId(userId);
        // Convert Product entities to ProductResponse objects
        return favoriteProducts.stream()
                .map(LessonResponse::fromProduct)
                .collect(Collectors.toList());
    }

    public String storeFile(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get("uploads/images/");
        // Create the directory if it doesn't exist
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Generate a unique filename to prevent overwriting
        String filename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        Path filePath = uploadPath.resolve(filename);

        // Copy the file to the target location (replacing existing file with the same name)
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        return filename; // Return the filename to store in the database
    }


    public String storeVideoFile(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get("uploads/videos/");

        // Create the directory if it doesn't exist
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // Generate a unique filename to prevent overwriting
        String filename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
        Path filePath = uploadPath.resolve(filename);

        // Copy the file to the target location (replacing existing file with the same name)
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        return filename; // Return the filename to store in the database
    }
}
