import { Component, OnInit } from '@angular/core';
import { Lesson } from '../../models/lesson';
import { CartService } from '../../services/cart.service';
import { LessonService } from '../../services/lesson.service';
import { ProgressService } from '../../services/progress.service';
import { TokenService } from '../../services/token.service';
import { environment } from '../../../environments/environment';
import { ProgressDTO } from '../../dtos/progress/order.dto';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { Progress } from '../../models/progress';

import { HeaderComponent } from '../header/header.component';
import { FooterComponent } from '../footer/footer.component';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { inject } from '@angular/core';
import { CouponService } from '../../services/coupon.service';
import { ApiResponse } from '../../responses/api.response';
import { HttpClient, HttpHeaders, HttpErrorResponse } from '@angular/common/http';
import { ScoreService } from '../../services/score.service';

@Component({
  selector: 'app-progress',
  templateUrl: './progress.component.html',
  styleUrls: ['./progress.component.scss'],
  standalone: true,
  imports: [
    FooterComponent,
    HeaderComponent,
    CommonModule,
    FormsModule,    
    ReactiveFormsModule,
  ]
})

export class ProgressComponent implements OnInit {
  private couponService = inject(CouponService);
  private cartService = inject(CartService);
  private lessonService = inject(LessonService);
  private progressService = inject(ProgressService);
  private tokenService = inject(TokenService);
  private formBuilder = inject(FormBuilder);
  private router = inject(Router);
  score: number = 0; // Add a property to hold the score

  orderForm: FormGroup;
  cartItems: { lesson: Lesson; quantity: number; favorite: boolean }[] = [];
  totalAmount: number = 0;
  couponDiscount: number = 0;
  couponApplied: boolean = false;
  cart: Map<number, { quantity: number; favorite: boolean }> = new Map();
  orderData: ProgressDTO = {
    user_id: 0,
    fullname: '',
    email: '',
    phone_number: '',
    address: '',
    status: 'pending',
    note: '',
    total_money: 0,
    payment_method: 'cod',
    shipping_method: 'express',
    coupon_code: '',
    cart_items: [],
  };
  showForm: boolean = false;
 
  constructor(
    private scoreService: ScoreService // Inject the service
  ) {
    this.orderForm = this.formBuilder.group({
      fullname: ['', Validators.required],
      email: ['', [Validators.email]],
      phone_number: ['', [Validators.required, Validators.minLength(6)]],
      address: ['', [Validators.required, Validators.minLength(5)]],
      note: [''],
      couponCode: [''],
      shipping_method: ['express'],
      payment_method: ['cod']
    });
    
  }

  ngOnInit(): void {
    
    this.orderData.user_id = this.tokenService.getUserId();
    this.cart = this.cartService.getCart();
    
    const lessonIds = Array.from(this.cart.keys());
    this.scoreService.score$.subscribe(score => {
      this.score = score;
    });
    if (lessonIds.length === 0) {
      return;
    }

    this.lessonService.getLessonsByIds(lessonIds).subscribe({
      next: (apiResponse: ApiResponse) => {
        const lessons: Lesson[] = apiResponse.data;
        this.cartItems = lessonIds.map((lessonId) => {
          const lesson = lessons.find((p) => p.id === lessonId);
          if (lesson) {
            lesson.thumbnail = `${environment.apiBaseUrl}/Lessons/images/${lesson.thumbnail}`;
          }
          return {
            lesson: lesson!,
            quantity: this.cart.get(lessonId)!.quantity,
            favorite: this.cart.get(lessonId)!.favorite // Ensure favorite status is retrieved
          };
        });
      },
      complete: () => {
        this.calculateTotal();
      },
      error: (error: HttpErrorResponse) => {
        console.error(error?.error?.message ?? '');
      }
    });
  }

  toggleForm(): void {
    this.showForm = !this.showForm;
  }

  placeOrder() {
    if (this.orderForm.errors == null) {
      this.orderData = {
        ...this.orderData,
        ...this.orderForm.value
      };
      this.orderData.cart_items = this.cartItems.map(cartItem => ({
        product_id: cartItem.lesson.id,
        quantity: cartItem.quantity
      }));
      this.orderData.total_money = this.totalAmount;

      this.progressService.placeOrder(this.orderData).subscribe({
        next: (response: ApiResponse) => {
          this.cartService.clearCart();
          this.router.navigate(['/home']);
        },
        complete: () => {
          this.calculateTotal();
        },
        error: (error: HttpErrorResponse) => {
          console.error(`Lỗi khi đặt hàng: ${error?.error?.message ?? ''}`);
        },
      });
    } else {
      console.error('Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.');
    }
  }

  calculateTotal(): void {
    this.totalAmount = this.cartItems.reduce(
      (total, item) => total + item.lesson.price * item.quantity,
      0
    );
  }

  confirmDelete(index: number): void {
    if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này?')) {
      this.cartItems.splice(index, 1);
      this.updateCartFromCartItems();
      this.calculateTotal();
    }
  }

  applyCoupon(): void {
    const couponCode = this.orderForm.get('couponCode')!.value;
    if (!this.couponApplied && couponCode) {
      this.calculateTotal();
      this.couponService.calculateCouponValue(couponCode, this.totalAmount)
        .subscribe({
          next: (apiResponse: ApiResponse) => {
            this.totalAmount = apiResponse.data;
            this.couponApplied = true;
          }
        });
    }
  }

private updateCartFromCartItems(): void {
  this.cart.clear();
  this.cartItems.forEach((item) => {
    this.cart.set(item.lesson.id, {
      quantity: item.quantity,
      favorite: item.favorite // Preserve the favorite status
    });
  });
  this.cartService.setCart(this.cart);
}

toggleFavorite(lessonId: number): void {
  const cartItem = this.cart.get(lessonId);
  console.log(`Toggling favorite for lesson ID: ${lessonId}`);
  if (cartItem) {
    cartItem.favorite = !cartItem.favorite; // Toggle the favorite status
    console.log(`Favorite status: ${cartItem.favorite}`);

    this.cart.set(lessonId, cartItem); // Update the cart with the new favorite status
    this.cartService.setCart(this.cart); // Persist the cart updates
    
    // Cập nhật lại `cartItems` để Angular render lại giao diện
    this.cartItems = this.cartItems.map(item => 
      item.lesson.id === lessonId ? { ...item, favorite: cartItem.favorite } : item
      );
    }
  }
}