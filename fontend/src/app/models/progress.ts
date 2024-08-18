import {ProgressDetail} from './progress.detail'
export interface Progress {
    id: number;
    user_id: number;
    fullname: string; 
    email: string;
    phone_number: string; 
    address: string;
    note: string;
    order_date: Date; 
    status: string;
    total_money: number; 
    shipping_method: string; 
    shipping_address: string; 
    shipping_date: Date; 
    tracking_number: string; 
    payment_method: string; 
    active: boolean;
    progress_details: ProgressDetail[]; 
  }  
