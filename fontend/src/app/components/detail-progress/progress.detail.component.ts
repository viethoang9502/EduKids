import { Component, OnInit } from '@angular/core';
import { Lesson } from '../../models/lesson';
import { CartService } from '../../services/cart.service';
import { LessonService } from '../../services/lesson.service';
import { ProgressService } from '../../services/progress.service';
import { ProgressDTO } from '../../dtos/progress/order.dto';
import { ActivatedRoute } from '@angular/router';
import { ProgressResponse } from '../../responses/progress/progress.response';
import { environment } from '../../../environments/environment';
import { ProgressDetail } from '../../models/progress.detail';
import { FooterComponent } from '../footer/footer.component';
import { HeaderComponent } from '../header/header.component';
import { CommonModule } from '@angular/common';
import { ApiResponse } from '../../responses/api.response';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-progress-detail',
  templateUrl: './progress.detail.component.html',
  styleUrls: ['./progress.detail.component.scss'],
  standalone: true,
  imports: [
    FooterComponent,
    HeaderComponent,
    CommonModule
  ]
})
export class ProgressDetailComponent implements OnInit {  
  orderResponse: ProgressResponse = {
    id: 0, // Hoặc bất kỳ giá trị số nào bạn muốn
    user_id: 0,
    fullname: '',
    phone_number: '',
    email: '',
    address: '',
    note: '',
    order_date: new Date(),
    status: '',
    total_money: 0, // Hoặc bất kỳ giá trị số nào bạn muốn
    shipping_method: '',
    shipping_address: '',
    shipping_date: new Date(),
    payment_method: '',
    progress_details: [] // Một mảng rỗng
  };  
  constructor(
    private progressService: ProgressService,
    private route: ActivatedRoute
    ) {}

  ngOnInit(): void {
    this.getOrderDetails();
  }
  
  getOrderDetails(): void {
    debugger
    const orderId = Number(this.route.snapshot.paramMap.get('orderId'));
    this.progressService.getOrderById(orderId).subscribe({
      next: (apiResponse: ApiResponse) => {        
        debugger;   
        const response = apiResponse.data    
        this.orderResponse.id = response.id;
        this.orderResponse.user_id = response.user_id;
        this.orderResponse.fullname = response.fullname;
        this.orderResponse.email = response.email;
        this.orderResponse.phone_number = response.phone_number;
        this.orderResponse.address = response.address; 
        this.orderResponse.note = response.note;
        this.orderResponse.order_date = new Date(
          response.order_date[0], 
          response.order_date[1] - 1, 
          response.order_date[2]
        );        
        
        this.orderResponse.progress_details = response.order_details
          .map((order_detail: ProgressDetail) => {
          order_detail.lesson.thumbnail = `${environment.apiBaseUrl}/lessons/images/${order_detail.lesson.thumbnail}`;
          return order_detail;
        });        
        this.orderResponse.payment_method = response.payment_method;
        this.orderResponse.shipping_date = new Date(
          response.shipping_date[0], 
          response.shipping_date[1] - 1, 
          response.shipping_date[2]
        );
        
        this.orderResponse.shipping_method = response.shipping_method;
        
        this.orderResponse.status = response.status;
        this.orderResponse.total_money = response.total_money;
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
}

