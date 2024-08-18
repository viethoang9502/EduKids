import { ProgressDetail } from "../../models/progress.detail";

export interface ProgressResponse {
    id: number;
    user_id: number;
    fullname: string;
    email: string;
    phone_number: string;
    address: string;
    note: string;
    order_date: Date; // Dạng chuỗi ISO 8601
    status: string;
    total_money: number;
    shipping_method: string;
    shipping_address: string;
    shipping_date: Date; // Dạng chuỗi ISO 8601
    payment_method: string;
    progress_details: ProgressDetail[];
  }
  
  