import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { OnInit } from '@angular/core';
import { InsertProductDTO } from '../../../../dtos/product/insert.product.dto';
import { Category } from '../../../../models/category';
import { CategoryService } from '../../../../services/category.service';
import { LessonService } from '../../../../services/lesson.service';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiResponse } from '../../../../responses/api.response';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-insert.lesson.admin',
  templateUrl: './insert.lesson.admin.component.html',
  styleUrls: ['./insert.lesson.admin.component.scss'],
  standalone: true,
  imports: [   
    CommonModule,
    FormsModule,
  ]
})
export class InsertLessonAdminComponent implements OnInit {
  insertProductDTO: InsertProductDTO = {
    name: '',
    price: 0,
    description: '',
    category_id: 1,
    images: [],
    videos: []
  };
  categories: Category[] = []; // Dữ liệu động từ categoryService
  constructor(    
    private route: ActivatedRoute,
    private router: Router,
    private categoryService: CategoryService,    
    private lessonService: LessonService,    
  ) {
    
  } 
  ngOnInit() {
    this.getCategories(1, 100)
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

  onFileChange(event: any) {
    // Retrieve selected files from input element
    const files = event.target.files;
    // Limit the number of selected files to 5
    if (files.length > 5) {
      console.error('Please select a maximum of 5 images.');
      return;
    }
    // Store the selected files in the newProduct object
    this.insertProductDTO.images = files;
  }

  onVideoChange(event: any) {
    // Retrieve selected files from input element
    const files = event.target.files;
    // Limit the number of selected files to 5
    if (files.length > 5) {
      console.error('Please select a maximum of 5 images.');
      return;
    }
    // Store the selected files in the newProduct object
    this.insertProductDTO.videos = files;
  }

  insertProduct() {    
    this.lessonService.insertProduct(this.insertProductDTO).subscribe({
      next: (apiResponse: ApiResponse) => {
        debugger
        if (this.insertProductDTO.images.length > 0) {
          const productId = apiResponse.data.id; // Assuming the response contains the newly created product's ID
          this.lessonService.uploadImages(productId, this.insertProductDTO.images).subscribe({
            next: (imageResponse:ApiResponse) => {
              debugger
              // Handle the uploaded images response if needed              
              console.log('Images uploaded successfully:', imageResponse.data);
              // Navigate back to the previous page
              this.router.navigate(['../'], { relativeTo: this.route });
            },
            error: (error: HttpErrorResponse) => {
              debugger;
              console.error(error?.error?.message ?? '');
            }
          })          
        }
        if (this.insertProductDTO.videos.length > 0) {
          const productId = apiResponse.data.id; // Assuming the response contains the newly created product's ID
          this.lessonService.uploadVideos(productId, this.insertProductDTO.videos).subscribe({
            next: (videoResponse:ApiResponse) => {
              debugger
              // Handle the uploaded images response if needed              
              console.log('Images uploaded successfully:', videoResponse.data);
              // Navigate back to the previous page
              this.router.navigate(['../'], { relativeTo: this.route });
            },
            error: (error: HttpErrorResponse) => {
              debugger;
              console.error(error?.error?.message ?? '');
            }
          })          
        }
      },
      error: (error: HttpErrorResponse) => {
        debugger;
        console.error(error?.error?.message ?? '');
      } 
    });    
  }
}
