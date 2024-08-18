import { Component, OnInit, Inject } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { NgForm } from '@angular/forms';
import { NgModule } from '@angular/core';

import { Observable } from 'rxjs';
import { Location } from '@angular/common';
import { ProgressResponse } from '../../../responses/progress/progress.response';
import { ProgressService } from '../../../services/progress.service';
import { CommonModule,DOCUMENT } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiResponse } from '../../../responses/api.response';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';

@Component({
  selector: 'app-progress-admin',
  templateUrl: './progress.admin.component.html',
  styleUrls: ['./progress.admin.component.scss'],
  standalone: true,
  imports: [   
    CommonModule,
    FormsModule,
  ]
})
export class ProgressAdminComponent implements OnInit{  
  progresses: ProgressResponse[] = [];
  currentPage: number = 0;
  itemsPerPage: number = 12;
  pages: number[] = [];
  totalPages:number = 0;
  keyword:string = "";
  visiblePages: number[] = [];
  localStorage?:Storage;

  constructor(
    private progressService: ProgressService,
    private router: Router,
    private route: ActivatedRoute,
    private location: Location,
    @Inject(DOCUMENT) private document: Document
  ) {
    this.localStorage = document.defaultView?.localStorage;
  }
  ngOnInit(): void {
    debugger
    this.currentPage = Number(this.localStorage?.getItem('currentOrderAdminPage')) || 0; 
    this.getAllOrders(this.keyword, this.currentPage, this.itemsPerPage);
  }
  searchOrders() {
    this.currentPage = 0;
    this.itemsPerPage = 12;
    //Mediocre Iron Wallet
    debugger
    this.getAllOrders(this.keyword.trim(), this.currentPage, this.itemsPerPage);
  }
  getAllOrders(keyword: string, page: number, limit: number) {
    debugger
    this.progressService.getAllOrders(keyword, page, limit).subscribe({
      next: (apiResponse: ApiResponse) => {
        debugger        
        this.progresses = apiResponse.data.orders;
        this.totalPages = apiResponse.data.totalPages;
        this.visiblePages = this.generateVisiblePageArray(this.currentPage, this.totalPages);
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
  onPageChange(page: number) {
    debugger;
    this.currentPage = page < 0 ? 0 : page;
    this.localStorage?.setItem('currentOrderAdminPage', String(this.currentPage));         
    this.getAllOrders(this.keyword, this.currentPage, this.itemsPerPage);
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

  deleteProgress(id:number) {
    const confirmation = window
      .confirm('Are you sure you want to delete this order?');
    if (confirmation) {
      debugger
      this.progressService.deleteOrder(id).subscribe({
        next: (response: ApiResponse) => {
          debugger 
          location.reload();          
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
  
  viewDetails(progress:ProgressResponse) {
    debugger
    this.router.navigate(['/admin/orders', progress.id]);
  }
  
}