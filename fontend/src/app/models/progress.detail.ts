import { Lesson } from "./lesson";
import {Progress} from './progress'
export interface ProgressDetail {
    id: number;
    progress: Progress;
    lesson: Lesson;
    price: number;
    number_of_lessons: number;
    total_money: number;
    color?: string; // Dấu "?" cho biết thuộc tính này là tùy chọn
}