package com.project.eduapp.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.github.javafaker.Faker;
import com.project.eduapp.components.LocalizationUtils;
import com.project.eduapp.components.SecurityUtils;
import com.project.eduapp.dtos.*;
import com.project.eduapp.models.Lesson;
import com.project.eduapp.models.LessonMedia;
import com.project.eduapp.models.LessonVideo;
import com.project.eduapp.models.User;
import com.project.eduapp.responses.ResponseObject;
import com.project.eduapp.responses.lesson.LessonListResponse;
import com.project.eduapp.responses.lesson.LessonResponse;
import com.project.eduapp.services.lesson.ILessonRedisService;
import com.project.eduapp.services.lesson.ILessonService;
import com.project.eduapp.utils.MessageKeys;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.*;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("${api.prefix}/lessons")
@RequiredArgsConstructor
public class ProductController {
    private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
    private final ILessonService lessonService;
    private final LocalizationUtils localizationUtils;
    private final ILessonRedisService productRedisService;
    private final SecurityUtils securityUtils;
    @PostMapping("")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    //POST http://localhost:8088/v1/api/products
    public ResponseEntity<ResponseObject> createProduct(
            @Valid @RequestBody ProductDTO productDTO,
            BindingResult result
    ) throws Exception {
        if(result.hasErrors()) {
            List<String> errorMessages = result.getFieldErrors()
                    .stream()
                    .map(FieldError::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(
                    ResponseObject.builder()
                            .message(String.join("; ", errorMessages))
                            .status(HttpStatus.BAD_REQUEST)
                            .build()
            );
        }
        Lesson newProduct = lessonService.createProduct(productDTO);
        return ResponseEntity.ok(
                ResponseObject.builder()
                        .message("Create new product successfully")
                        .status(HttpStatus.CREATED)
                        .data(newProduct)
                        .build());
    }

    @PostMapping(value = "uploads/images/{id}",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    //POST http://localhost:8088/v1/api/products
    public ResponseEntity<ResponseObject> uploadImages(
            @PathVariable("id") Long lessonId,
            @ModelAttribute("files") List<MultipartFile> files
    ) throws Exception {
        Lesson existingLesson = lessonService.getProductById(lessonId);
        files = files == null ? new ArrayList<MultipartFile>() : files;
        if(files.size() > LessonMedia.MAXIMUM_IMAGES_PER_PRODUCT) {
            return ResponseEntity.badRequest().body(
                    ResponseObject.builder()
                            .message(localizationUtils
                                    .getLocalizedMessage(MessageKeys.UPLOAD_IMAGES_MAX_5))
                            .build()
            );
        }
        List<LessonMedia> productImages = new ArrayList<>();
        for (MultipartFile file : files) {
            if(file.getSize() == 0) {
                continue;
            }
            // Kiểm tra kích thước file và định dạng
            if(file.getSize() > 10 * 1024 * 1024) { // Kích thước > 10MB
                return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
                        .body(ResponseObject.builder()
                                .message(localizationUtils
                                        .getLocalizedMessage(MessageKeys.UPLOAD_IMAGES_FILE_LARGE))
                                .status(HttpStatus.PAYLOAD_TOO_LARGE)
                                .build());
            }
            String contentType = file.getContentType();
            if(contentType == null || !contentType.startsWith("image/")) {
                return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                        .body(ResponseObject.builder()
                                .message(localizationUtils
                                        .getLocalizedMessage(MessageKeys.UPLOAD_IMAGES_FILE_MUST_BE_IMAGE))
                                .status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                                .build());
            }
            // Lưu file và cập nhật thumbnail trong DTO
            String filename = lessonService.storeFile(file); // Thay thế hàm này với code của bạn để lưu file
            //lưu vào đối tượng product trong DB
            LessonMedia productImage = lessonService.createProductImage(
                    existingLesson.getId(),
                    ProductImageDTO.builder()
                            .imageUrl(filename)
                            .build()
            );
            productImages.add(productImage);
        }

        return ResponseEntity.ok().body(ResponseObject.builder()
                        .message("Upload image successfully")
                        .status(HttpStatus.CREATED)
                        .data(productImages)
                .build());
    }

    @PostMapping(value = "uploads/videos/{id}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public ResponseEntity<ResponseObject> uploadVideos(
            @PathVariable("id") Long lessonId,
            @ModelAttribute("files") List<MultipartFile> files
    ) throws Exception {
        Lesson existingProduct = lessonService.getProductById(lessonId);
        files = files == null ? new ArrayList<MultipartFile>() : files;

        if (files.size() > LessonVideo.MAXIMUM_VIDEOS_PER_PRODUCT) {
            return ResponseEntity.badRequest().body(
                    ResponseObject.builder()
                            .message(localizationUtils
                                    .getLocalizedMessage(MessageKeys.UPLOAD_VIDEOS_MAX_LIMIT))
                            .build()
            );
        }

        List<LessonVideo> lessonVideos = new ArrayList<>();
        for (MultipartFile file : files) {
            if (file.getSize() == 0) {
                continue;
            }

            // Check file size and format
            if (file.getSize() > 512 * 1024 * 1024) { // Size > 0.5GB// Size > 100MB
                return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
                        .body(ResponseObject.builder()
                                .message(localizationUtils
                                        .getLocalizedMessage(MessageKeys.UPLOAD_VIDEOS_FILE_LARGE))
                                .status(HttpStatus.PAYLOAD_TOO_LARGE)
                                .build());
            }

            String contentType = file.getContentType();
            if (contentType == null || !contentType.startsWith("video/")) {
                return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                        .body(ResponseObject.builder()
                                .message(localizationUtils
                                        .getLocalizedMessage(MessageKeys.UPLOAD_VIDEOS_FILE_MUST_BE_VIDEO))
                                .status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                                .build());
            }

            // Save the video file and update the DTO
            String filename = lessonService.storeVideoFile(file); // Use the method for saving video files

            // Save the video file info to the product in the database
            LessonVideo productVideo = lessonService.createProductVideo(
                    existingProduct.getId(),
                    ProductVideoDTO.builder()
                            .videoUrl(filename)
                            .build()
            );
            lessonVideos.add(productVideo);
        }

        return ResponseEntity.ok().body(ResponseObject.builder()
                .message("Upload video successfully")
                .status(HttpStatus.CREATED)
                .data(lessonVideos)
                .build());
    }

    @GetMapping("/images/{imageName}")
    public ResponseEntity<?> viewImage(@PathVariable String imageName) {
        try {
            java.nio.file.Path imagePath = Paths.get("uploads/images/"+imageName);
            UrlResource resource = new UrlResource(imagePath.toUri());

            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            } else {
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(new UrlResource(Paths.get("uploads/images/.jpeg").toUri()));
                //return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/videos/{videoName}")
    public ResponseEntity<?> viewVideo(@PathVariable String videoName) {
        try {
            java.nio.file.Path videoPath = Paths.get("uploads/videos/" + videoName);
            UrlResource resource = new UrlResource(videoPath.toUri());

            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.valueOf("video/mp4")) // Hoặc kiểu MIME video khác
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("")
    public ResponseEntity<ResponseObject> getProducts(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "0", name = "category_id") Long categoryId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int limit
    ) throws JsonProcessingException {
        int totalPages = 0;
        PageRequest pageRequest;

        try {
            // Tạo Pageable từ thông tin trang và giới hạn
            pageRequest = PageRequest.of(
                    page, limit,
                    Sort.by("name").ascending()
            );
        } catch (Exception e) {
            // Ghi lại thông tin lỗi và trả về phản hồi lỗi
            logger.error("Failed to create PageRequest with sorting by 'name'.", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                    ResponseObject.builder()
                            .message("Failed to create PageRequest with sorting by 'name': " + e.getMessage())
                            .status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .data(null)
                            .build()
            );
        }

        logger.info(String.format("keyword = %s, category_id = %d, page = %d, limit = %d",
                keyword, categoryId, page, limit));

        List<LessonResponse> productResponses = productRedisService.getAllProducts(keyword, categoryId, pageRequest);

        if (productResponses != null && !productResponses.isEmpty()) {
            totalPages = productResponses.get(0).getTotalPages();
        }

        if (productResponses == null) {
            Page<LessonResponse> productPage = lessonService.getAllProducts(keyword, categoryId, pageRequest);
            // Lấy tổng số trang
            totalPages = productPage.getTotalPages();
            productResponses = productPage.getContent();
            // Bổ sung totalPages vào các đối tượng ProductResponse
            for (LessonResponse product : productResponses) {
                product.setTotalPages(totalPages);
            }
            productRedisService.saveAllProducts(
                    productResponses,
                    keyword,
                    categoryId,
                    pageRequest
            );
        }

        LessonListResponse productListResponse = LessonListResponse
                .builder()
                .lessons(productResponses)
                .totalPages(totalPages)
                .build();

        return ResponseEntity.ok().body(
                ResponseObject.builder()
                        .message("Get products successfully")
                        .status(HttpStatus.OK)
                        .data(productListResponse)
                        .build()
        );
    }
    //http://localhost:8088/api/v1/products/6
    @GetMapping("/{id}")
    public ResponseEntity<ResponseObject> getProductById(
            @PathVariable("id") Long productId
    ) throws Exception {
        Lesson existingProduct = lessonService.getProductById(productId);
        return ResponseEntity.ok(ResponseObject.builder()
                        .data(LessonResponse.fromProduct(existingProduct))
                        .message("Get detail product successfully")
                        .status(HttpStatus.OK)
                .build());

    }
    @GetMapping("/by-ids")
    public ResponseEntity<ResponseObject> getProductsByIds(@RequestParam("ids") String ids) {
        //eg: 1,3,5,7
        // Tách chuỗi ids thành một mảng các số nguyên
        List<Long> productIds = Arrays.stream(ids.split(","))
                .map(Long::parseLong)
                .collect(Collectors.toList());
        List<Lesson> products = lessonService.findProductsByIds(productIds);
        return ResponseEntity.ok(ResponseObject.builder()
                .data(products)
                .message("Get products successfully")
                .status(HttpStatus.OK)
                .build()
        );
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<ResponseObject> deleteProduct(@PathVariable long id) {
        lessonService.deleteProduct(id);
        return ResponseEntity.ok(ResponseObject.builder()
                .data(null)
                .message(String.format("Product with id = %d deleted successfully", id))
                .status(HttpStatus.OK)
                .build());
    }
    //@PostMapping("/generateFakeProducts")
    private ResponseEntity<ResponseObject> generateFakeProducts() throws Exception {
        Faker faker = new Faker();
        for (int i = 0; i < 1_000_000; i++) {
            String productName = faker.commerce().productName();
            if(lessonService.existsByName(productName)) {
                continue;
            }
            ProductDTO productDTO = ProductDTO.builder()
                    .name(productName)
                    .price((float)faker.number().numberBetween(10, 90_000_000))
                    .description(faker.lorem().sentence())
                    .thumbnail("")
                    .categoryId((long)faker.number().numberBetween(2, 5))
                    .build();
            lessonService.createProduct(productDTO);
        }
        return ResponseEntity.ok(ResponseObject.builder()
                        .message("Insert fake products succcessfully")
                        .data(null)
                        .status(HttpStatus.OK)
                .build());
    }
    //update a product
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    //@SecurityRequirement(name="bearer-key")
    @Operation(security = { @SecurityRequirement(name = "bearer-key") })
    public ResponseEntity<ResponseObject> updateProduct(
            @PathVariable long id,
            @RequestBody ProductDTO productDTO) throws Exception {
        Lesson updatedProduct = lessonService.updateProduct(id, productDTO);
        return ResponseEntity.ok(ResponseObject.builder()
                .data(updatedProduct)
                .message("Update product successfully")
                .status(HttpStatus.OK)
                .build());
    }

    @PostMapping("/like/{productId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<ResponseObject> likeProduct(@PathVariable Long productId) throws Exception {
        User loginUser = securityUtils.getLoggedInUser();
        Lesson likedProduct = lessonService.likeProduct(loginUser.getId(), productId);
        return ResponseEntity.ok(ResponseObject.builder()
                .data(LessonResponse.fromProduct(likedProduct))
                .message("Like product successfully")
                .status(HttpStatus.OK)
                .build());
    }
    @PostMapping("/unlike/{productId}")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<ResponseObject> unlikeProduct(@PathVariable Long productId) throws Exception {
        User loginUser = securityUtils.getLoggedInUser();
        Lesson unlikedProduct = lessonService.unlikeProduct(loginUser.getId(), productId);
        return ResponseEntity.ok(ResponseObject.builder()
                .data(LessonResponse.fromProduct(unlikedProduct))
                .message("Unlike product successfully")
                .status(HttpStatus.OK)
                .build());
    }
    @PostMapping("/favorite-products")
    @PreAuthorize("hasRole('ROLE_ADMIN') or hasRole('ROLE_USER')")
    public ResponseEntity<ResponseObject> findFavoriteProductsByUserId() throws Exception {
        User loginUser = securityUtils.getLoggedInUser();
        List<LessonResponse> favoriteProducts = lessonService.findFavoriteProductsByUserId(loginUser.getId());
        return ResponseEntity.ok(ResponseObject.builder()
                .data(favoriteProducts)
                .message("Favorite products retrieved successfully")
                .status(HttpStatus.OK)
                .build());
    }
}
