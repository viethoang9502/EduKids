import { Injectable, Inject } from '@angular/core';
import { Lesson } from '../models/lesson';
import { CommonModule, DOCUMENT } from '@angular/common';

@Injectable({
  providedIn: 'root'
})

export class CartService {
  private cart: Map<number, { quantity: number, favorite: boolean }> = new Map<number, { quantity: number, favorite: boolean }>();
  localStorage?:Storage;

  constructor(@Inject(DOCUMENT) private document: Document) {
    this.localStorage = document.defaultView?.localStorage;
    // Lấy dữ liệu giỏ hàng từ localStorage khi khởi tạo service            
    this.refreshCart()
  }

  public refreshCart() {
    const storedCart = this.localStorage?.getItem(this.getCartKey());
    if (storedCart) {
      const parsedCart = new Map<number, { quantity: number, favorite: boolean }>(JSON.parse(storedCart));
      this.cart = new Map<number, { quantity: number, favorite: boolean }>(parsedCart);
    } else {
      this.cart = new Map<number, { quantity: number, favorite: boolean }>();
    }
  }

   private getCartKey(): string {
    const userResponseJSON = this.localStorage?.getItem('user');
    const userResponse = JSON.parse(userResponseJSON!);
    return `cart:${userResponse?.id ?? ''}`;
  }

  addToCart(lessonId: number, quantity: number, favorite: boolean ): void {
    let cart = this.getCart();
    cart.set(lessonId, { quantity, favorite });
    this.setCart(cart);
  } 
  
  getCart(): Map<number, { quantity: number, favorite: boolean }> {
    return this.cart;
  }
  // Lưu trữ giỏ hàng vào localStorage
  private saveCartToLocalStorage(): void {
    debugger
    this.localStorage?.setItem(this.getCartKey(), JSON.stringify(Array.from(this.cart.entries())));
  }   
  setCart(cart: Map<number, { quantity: number, favorite: boolean }>) {
    this.cart = cart ?? new Map<number, { quantity: number, favorite: boolean }>();
    this.saveCartToLocalStorage();
  }
  // Hàm xóa dữ liệu giỏ hàng và cập nhật Local Storage
  clearCart(): void {
    this.cart.clear(); // Xóa toàn bộ dữ liệu trong giỏ hàng
    this.saveCartToLocalStorage(); // Lưu giỏ hàng mới vào Local Storage (trống)
  }

  clearLocalStorageCart(): void {
    const cartKey = this.getCartKey();
    this.localStorage?.removeItem(cartKey);
  }
}
