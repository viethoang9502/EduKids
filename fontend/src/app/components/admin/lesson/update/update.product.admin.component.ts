import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Location } from '@angular/common';
import { Lesson } from '../../../../models/lesson';
import { Category } from '../../../../models/category';
import { LessonService } from '../../../../services/lesson.service';
import { CategoryService } from '../../../../services/category.service';
import { environment } from '../../../../../environments/environment';
import { LessonImage } from '../../../../models/lesson.image';
import { UpdateProductDTO } from '../../../../dtos/product/update.product.dto';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiResponse } from '../../../../responses/api.response';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-detail.product.admin',
  templateUrl: './update.product.admin.component.html',
  styleUrls: ['./update.product.admin.component.scss'],
  standalone: true,
  imports: [   
    CommonModule,
    FormsModule,
  ]
})

export class UpdateLessonAdminComponent implements OnInit {
  productId: number;
  lesson: Lesson;
  updatedProduct: Lesson;
  categories: Category[] = []; // Dữ liệu động từ categoryService
  currentImageIndex: number = 0;
  images: File[] = [];

  constructor(
    private lessonService: LessonService,
    private route: ActivatedRoute,
    private router: Router,
    private categoryService: CategoryService,    
    private location: Location,
  ) {
    this.productId = 0;
    this.lesson = {} as Lesson;
    this.updatedProduct = {} as Lesson;  
  }

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      this.productId = Number(params.get('id'));
      this.getProductDetails();
    });
    this.getCategories(1, 100);
  }
  getCategories(page: number, limit: number) {
    this.categoryService.getCategories(page, limit).subscribe({
      next: (apiResponse: ApiResponse) => {
        debugger;
        this.categories = apiResponse.data;
      },
      complete: () => {
        debugger;
      },
      error: (error: HttpErrorResponse) => {
        debugger;
        console.error(error?.error?.message ?? '');
      } 
    });
  }
  getProductDetails(): void {
    this.lessonService.getDetailProduct(this.productId).subscribe({
      next: (apiResponse: ApiResponse) => {

        this.lesson = apiResponse.data;
        this.updatedProduct = { ...apiResponse.data };                
        this.updatedProduct.lesson_images.forEach((lesson_image:LessonImage) => {
          if (lesson_image.image_url && !lesson_image.image_url.startsWith('http')) {
            lesson_image.image_url = `${environment.apiBaseUrl}/lessons/images/${lesson_image.image_url}`;
          }
        });
      },
      complete: () => {
        
      },
      error: (error: HttpErrorResponse) => {
        debugger;
        console.error(error?.error?.message ?? '');
      } 
    });     
  }
  updateProduct() {
    // Implement your update logic here
    const updateProductDTO: UpdateProductDTO = {
      name: this.updatedProduct.name,
      price: this.updatedProduct.price,
      description: this.updatedProduct.description,
      category_id: this.updatedProduct.category_id
    };
    this.lessonService.updateProduct(this.lesson.id, updateProductDTO).subscribe({
      next: (apiResponse: ApiResponse) => {  
        debugger        
      },
      complete: () => {
        debugger;
        this.router.navigate(['/admin/products']);        
      },
      error: (error: HttpErrorResponse) => {
        debugger;
        console.error(error?.error?.message ?? '');
      } 
    });  
  }
  showImage(index: number): void {
    debugger
    if (this.lesson && this.lesson.lesson_images && 
        this.lesson.lesson_images.length > 0) {
      // Đảm bảo index nằm trong khoảng hợp lệ        
      if (index < 0) {
        index = 0;
      } else if (index >= this.lesson.lesson_images.length) {
        index = this.lesson.lesson_images.length - 1;
      }        
      // Gán index hiện tại và cập nhật ảnh hiển thị
      this.currentImageIndex = index;
    }
  }
  thumbnailClick(index: number) {
    debugger
    // Gọi khi một thumbnail được bấm
    this.currentImageIndex = index; // Cập nhật currentImageIndex
  }  
  nextImage(): void {
    debugger
    this.showImage(this.currentImageIndex + 1);
  }

  previousImage(): void {
    debugger
    this.showImage(this.currentImageIndex - 1);
  }  
  onFileChange(event: any) {
    // Retrieve selected files from input element
    const files = event.target.files;
    // Limit the number of selected files to 5
    if (files.length > 5) {
      console.error('Please select a maximum of 5 images.');
      return;
    }
    // Store the selected files in the newProduct object
    this.images = files;
    this.lessonService.uploadImages(this.productId, this.images).subscribe({
      next: (apiResponse: ApiResponse) => {
        debugger
        // Handle the uploaded images response if needed              
        console.log('Images uploaded successfully:', apiResponse);
        this.images = [];       
        // Reload product details to reflect the new images
        this.getProductDetails(); 
      },
      error: (error: HttpErrorResponse) => {
        debugger;
        console.error(error?.error?.message ?? '');
      } 
    })
  }
  deleteImage(lessonImage: LessonImage) {
    if (confirm('Are you sure you want to remove this image?')) {
      // Call the removeImage() method to remove the image   
      this.lessonService.deleteProductImage(lessonImage.id).subscribe({
        next:(productImage: LessonImage) => {
          location.reload();          
        },        
        error: (error: HttpErrorResponse) => {
          debugger;
          console.error(error?.error?.message ?? '');
        } 
      });
    }   
  }
}
