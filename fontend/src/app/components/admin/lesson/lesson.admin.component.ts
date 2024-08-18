import { Component, Inject, OnInit, inject } from '@angular/core';
import { Router } from '@angular/router';
import { DOCUMENT, Location, CommonModule } from '@angular/common';
import { environment } from '../../../../environments/environment';
import { Lesson } from '../../../models/lesson';
import { LessonService } from '../../../services/lesson.service';
import { FormsModule } from '@angular/forms';
import { ApiResponse } from '../../../responses/api.response';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-lesson-admin',
  templateUrl: './lesson.admin.component.html',
  styleUrls: ['./lesson.admin.component.scss'],
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
  ]
})
export class LessonAdminComponent implements OnInit {
  selectedCategoryId: number = 0; // Giá trị category được chọn
  lessons: Lesson[] = [];
  currentPage: number = 0;
  itemsPerPage: number = 12;
  pages: number[] = [];
  totalPages: number = 0;
  visiblePages: number[] = [];
  keyword: string = "";
  localStorage?: Storage;

  private lessonService = inject(LessonService);
  private router = inject(Router);
  private location = inject(Location);

  constructor(@Inject(DOCUMENT) private document: Document) {
    this.localStorage = document.defaultView?.localStorage;
  }

  ngOnInit() {
    this.currentPage = Number(this.localStorage?.getItem('currentProductAdminPage')) || 0;
    this.getLessons(this.keyword, this.selectedCategoryId, this.currentPage, this.itemsPerPage);
  }

  searchLessons() {
    this.currentPage = 0;
    this.itemsPerPage = 12;
    this.getLessons(this.keyword.trim(), this.selectedCategoryId, this.currentPage, this.itemsPerPage);
  }

  getLessons(keyword: string, selectedCategoryId: number, page: number, limit: number) {
    this.lessonService.getLessons(keyword, selectedCategoryId, page, limit).subscribe({
      next: (apiResponse: ApiResponse) => {
        const lessonData = apiResponse?.data?.lessons || []; // Access lessons from data object
        console.log('Lesson Data:', lessonData); // Add this line to inspect the data
        this.totalPages = apiResponse?.data?.totalPages || 0;
  
        lessonData.forEach((lesson: Lesson) => {
          if (lesson) {
            lesson.url = `${environment.apiBaseUrl}/lessons/images/${lesson.thumbnail}`;
          }
        });
        this.lessons = lessonData;
        this.visiblePages = this.generateVisiblePageArray(this.currentPage, this.totalPages);
      },
      complete: () => {
        console.log('Lessons loaded successfully');
      },
      error: (error: HttpErrorResponse) => {
        console.error(error?.error?.message ?? 'Error loading lessons');
      }
    });
  }
  
  onPageChange(page: number) {
    this.currentPage = page < 0 ? 0 : page;
    this.localStorage?.setItem('currentProductAdminPage', String(this.currentPage));
    this.getLessons(this.keyword, this.selectedCategoryId, this.currentPage, this.itemsPerPage);
  }

  generateVisiblePageArray(currentPage: number, totalPages: number): number[] {
    const maxVisiblePages = 5;
    const halfVisiblePages = Math.floor(maxVisiblePages / 2);

    let startPage = Math.max(currentPage - halfVisiblePages, 1);
    let endPage = Math.min(startPage + maxVisiblePages - 1, totalPages);

    if (endPage - startPage + 1 < maxVisiblePages) {
      startPage = Math.max(endPage - maxVisiblePages + 1, 1);
    }

    return new Array(endPage - startPage + 1).fill(0)
      .map((_, index) => startPage + index);
  }

  insertProduct() {
    this.router.navigate(['/admin/lessons/insert']);
  }

  updateProduct(lessonId: number) {
    this.router.navigate(['/admin/lessons/update', lessonId]);
  }

  deleteProduct(lesson: Lesson) {
    const confirmation = window.confirm('Are you sure you want to delete this product?');
    if (confirmation) {
      this.lessonService.deleteProduct(lesson.id).subscribe({
        next: (apiResponse: ApiResponse) => {
          console.log('Lesson deleted successfully');
          this.getLessons(this.keyword, this.selectedCategoryId, this.currentPage, this.itemsPerPage);
        },
        error: (error: HttpErrorResponse) => {
          console.error(`Error deleting lesson: ${error?.error?.message ?? ''}`);
        }
      });
    }
  }
}
