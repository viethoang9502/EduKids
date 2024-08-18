import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgForm } from '@angular/forms';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { inject } from '@angular/core';

import { Observable } from 'rxjs';
import { environment } from '../../../../environments/environment';
import { ProgressDTO } from '../../../dtos/progress/order.dto';
import { ProgressResponse } from '../../../responses/progress/progress.response';
import { ProgressService } from '../../../services/progress.service';
import { ApiResponse } from '../../../responses/api.response';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-detail-progress-admin',
  templateUrl: './detail.progress.admin.component.html',
  styleUrls: ['./detail.progress.admin.component.scss'],
  standalone: true,
  imports: [   
    CommonModule,
    FormsModule,
  ]
})

export class DetailProgressAdminComponent implements OnInit{    
  progressId:number = 0;
  progressResponse: ProgressResponse = {
    id: 0, // Hoặc bất kỳ giá trị số nào bạn muốn
    user_id: 0,
    fullname: '',
    phone_number: '',
    email: '',
    address: '',
    note: '',
    order_date: new Date(),
    status: '',
    total_money: 0, 
    shipping_method: '',
    shipping_address: '',
    shipping_date: new Date(),
    payment_method: '',
    progress_details: [],
    
  };  
  private progressService = inject(ProgressService);
  constructor(    
    private route: ActivatedRoute,
    private router: Router
    ) {}

  ngOnInit(): void {
    this.getOrderDetails();
  }
  
  getOrderDetails(): void {
    debugger
    this.progressId = Number(this.route.snapshot.paramMap.get('id'));
    this.progressService.getOrderById(this.progressId).subscribe({
      next: (apiResponse: ApiResponse) => {        
        debugger;       
        const response = apiResponse.data    
        this.progressResponse.id = response.id;
        this.progressResponse.user_id = response.user_id;
        this.progressResponse.fullname = response.fullname;
        this.progressResponse.email = response.email;
        this.progressResponse.phone_number = response.phone_number;
        this.progressResponse.address = response.address; 
        this.progressResponse.note = response.note;
        this.progressResponse.total_money = response.total_money;
        if (response.order_date) {
          this.progressResponse.order_date = new Date(
            response.order_date[0], 
            response.order_date[1] - 1, 
            response.order_date[2]
          );        
        }        
        this.progressResponse.progress_details = response.order_details
          .map((order_detail:any) => {
          order_detail.product.thumbnail = `${environment.apiBaseUrl}/Lessons/images/${order_detail.product.thumbnail}`;
          order_detail.number_of_Lessons = order_detail.numberOfLessons
          //order_detail.total_money = order_detail.totalMoney
          return order_detail;
        });        
        this.progressResponse.payment_method = response.payment_method;
        if (response.shipping_date) {
          this.progressResponse.shipping_date = new Date(
            response.shipping_date[0],
            response.shipping_date[1] - 1,
            response.shipping_date[2]
          );
        }         
        this.progressResponse.shipping_method = response.shipping_method;        
        this.progressResponse.status = response.status;     
        debugger   
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
  
  saveOrder(): void {    
    debugger        
    this.progressService
      .updateOrder(this.progressId, new ProgressDTO(this.progressResponse))
      .subscribe({
      next: (response: ApiResponse) => {
        debugger
        // Handle the successful update
        //console.log('Order updated successfully:', response);
        // Navigate back to the previous page
        //this.router.navigate(['/admin/orders']);       
        this.router.navigate(['../'], { relativeTo: this.route });
      },
      complete: () => {
        debugger;        
      },
      error: (error: HttpErrorResponse) => {
        debugger;
        console.error(error?.error?.message ?? '');
        this.router.navigate(['../'], { relativeTo: this.route });
      }       
    });   
  }
}