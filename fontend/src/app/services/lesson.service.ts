import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../environments/environment';
import { Lesson } from '../models/lesson';
import { UpdateProductDTO } from '../dtos/product/update.product.dto';
import { InsertProductDTO } from '../dtos/product/insert.product.dto';
import { ApiResponse } from '../responses/api.response';

@Injectable({
  providedIn: 'root'
})
export class LessonService {
  private apiBaseUrl = environment.apiBaseUrl;

  constructor(private http: HttpClient) { }

  getLessons(
    keyword: string,
    categoryId: number,
    page: number,
    limit: number
  ): Observable<ApiResponse> {
    const params = {
      keyword: keyword,
      category_id: categoryId.toString(),
      page: page.toString(),
      limit: limit.toString()
    };
    return this.http.get<ApiResponse>(`${this.apiBaseUrl}/lessons`, { params });
  }

  getDetailProduct(productId: number): Observable<ApiResponse> {
    return this.http.get<ApiResponse>(`${this.apiBaseUrl}/lessons/${productId}`);
  }

  getLessonsByIds(productIds: number[]): Observable<ApiResponse> {
    const params = new HttpParams().set('ids', productIds.join(','));
    return this.http.get<ApiResponse>(`${this.apiBaseUrl}/lessons/by-ids`, { params });
  }

  deleteProduct(productId: number): Observable<ApiResponse> {
    return this.http.delete<ApiResponse>(`${this.apiBaseUrl}/lessons/${productId}`);
  }

  updateProduct(productId: number, updatedProduct: UpdateProductDTO): Observable<ApiResponse> {
    return this.http.put<ApiResponse>(`${this.apiBaseUrl}/lessons/${productId}`, updatedProduct);
  }  

  insertProduct(insertProductDTO: InsertProductDTO): Observable<ApiResponse> {
    return this.http.post<ApiResponse>(`${this.apiBaseUrl}/lessons`, insertProductDTO);
  }

  uploadImages(lessonId: number, files: File[]): Observable<ApiResponse> {
    const formData = new FormData();
    for (let i = 0; i < files.length; i++) {
      formData.append('files', files[i]);
    }
    return this.http.post<ApiResponse>(`${this.apiBaseUrl}/lessons/uploads/images/${lessonId}`, formData);
  }

  uploadVideos(lessonId: number, files: File[]): Observable<ApiResponse> {
    const formData = new FormData();
    for (let i = 0; i < files.length; i++) {
      formData.append('files', files[i]);
    }
    return this.http.post<ApiResponse>(`${this.apiBaseUrl}/lessons/uploads/videos/${lessonId}`, formData);
  }


  deleteProductImage(id: number): Observable<any> {
    return this.http.delete<string>(`${this.apiBaseUrl}/lesson_images/${id}`);
  }
}
