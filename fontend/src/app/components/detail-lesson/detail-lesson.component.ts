import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Lesson } from '../../models/lesson';
import { LessonService } from '../../services/lesson.service';
import { CartService } from '../../services/cart.service';
import { environment } from '../../../environments/environment';
import { LessonImage } from '../../models/lesson.image';
import { HeaderComponent } from '../header/header.component';
import { FooterComponent } from '../footer/footer.component';
import { CommonModule } from '@angular/common';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { ApiResponse } from '../../responses/api.response';
import { HttpErrorResponse } from '@angular/common/http';
import { ScoreService } from '../../services/score.service';

@Component({
  selector: 'app-detail-lesson',
  templateUrl: './detail-lesson.component.html',
  styleUrls: ['./detail-lesson.component.scss'],
  standalone: true,
  imports: [
    FooterComponent,
    HeaderComponent,
    CommonModule,
    NgbModule
  ]
})

export class DetailProductComponent implements OnInit {
  lesson?: Lesson;
  productId: number = 0;
  quantity: number = 0;
  currentImageIndex: number = 0;
  currentVideoIndex: number = 0;
  progress: number = 0; // Phần trăm tiến trình video
  isPressedAddToCart: boolean = false;
  viewedImagesCount: number = 0; // Bộ đếm số ảnh đã xem
  totalVideoDuration: number = 0; // Total duration of all videos
  watchedDuration: number = 0; // Total watched duration
  videoProgress: number[] = []; // Array to track each video's progress
  isFavorite?: boolean; // New property to track favorite status

  constructor(
    private lessonService: LessonService,
    private cartService: CartService,
    private activatedRoute: ActivatedRoute,
    private router: Router,
    private scoreService: ScoreService // Inject the service
  ) { }

  ngOnInit() {
    const idParam = this.activatedRoute.snapshot.paramMap.get('id');
    if (idParam !== null) {
      this.productId = +idParam;
    }
    if (!isNaN(this.productId)) {
      this.lessonService.getDetailProduct(this.productId).subscribe({
        next: (apiResponse: ApiResponse) => {
          const response = apiResponse.data;
          if (response.lesson_images && response.lesson_images.length > 0) {
            response.lesson_images.forEach((lesson_image: LessonImage) => {
              if (lesson_image.image_url && !lesson_image.image_url.startsWith('http')) {
                lesson_image.image_url = `${environment.apiBaseUrl}/lessons/images/${lesson_image.image_url}`;
              }
            });
          }
          if (response.lesson_videos && response.lesson_videos.length > 0) {
            response.lesson_videos.forEach((lesson_video: any) => {
              if (lesson_video.video_url && !lesson_video.video_url.startsWith('http')) {
                lesson_video.video_url = `${environment.apiBaseUrl}/lessons/videos/${lesson_video.video_url}`;
              }
              // Add up the total video duration
            const videoElement = document.createElement('video');
            videoElement.src = lesson_video.video_url;
            videoElement.addEventListener('loadedmetadata', () => {
              lesson_video.duration = videoElement.duration;
              this.totalVideoDuration += lesson_video.duration || 0;
            });
          });
        }
          this.lesson = response;
          this.showImage(0);
          this.viewedImagesCount = 1;
        },
        error: (error: HttpErrorResponse) => {
          console.error(error?.error?.message ?? '');
        }
      });
    } else {
      console.error('Invalid productId:', idParam);
    }
  }

  showImage(index: number): void {
    if (this.lesson && this.lesson.lesson_images && this.lesson.lesson_images.length > 0) {
      index = Math.max(0, Math.min(index, this.lesson.lesson_images.length - 1));
      this.currentImageIndex = index;
    }
  }

  showVideo(index: number): void {
    if (this.lesson && this.lesson.lesson_videos && this.lesson.lesson_videos.length > 0) {
        index = Math.max(0, Math.min(index, this.lesson.lesson_videos.length - 1));
        this.currentVideoIndex = index;
        // Don't reset progress here
    }
  }

  nextImage(): void {
    if (this.lesson && this.lesson.lesson_images) {
      const nextIndex = (this.currentImageIndex + 1) % this.lesson.lesson_images.length;
      this.showImage(nextIndex);
    }
  }

  previousImage(): void {
    if (this.lesson && this.lesson.lesson_images) {
      const prevIndex = (this.currentImageIndex - 1 + this.lesson.lesson_images.length) % this.lesson.lesson_images.length;
      this.showImage(prevIndex);
    }
  }

  nextVideo(): void {
    if (this.lesson && this.lesson.lesson_videos) {
      const nextIndex = (this.currentVideoIndex + 1) % this.lesson.lesson_videos.length;
      this.showVideo(nextIndex);
    }
  }

  previousVideo(): void {
    if (this.lesson && this.lesson.lesson_videos) {
      const prevIndex = (this.currentVideoIndex - 1 + this.lesson.lesson_videos.length) % this.lesson.lesson_videos.length;
      this.showVideo(prevIndex);
    }
  }

  addToCart(): void {
    this.isPressedAddToCart = true;
    if (this.lesson) {
      const currentFavorite = this.cartService.getCart().get(this.lesson.id)?.favorite || false;
      this.cartService.addToCart(this.lesson.id, this.quantity, currentFavorite);
    } else {
      console.error('Không thể thêm sản phẩm vào giỏ hàng vì product là null.');
    }
  }

  onTimeUpdate(event: Event): void {
    const videoElement = event.target as HTMLVideoElement;
    if (videoElement && videoElement.duration > 0) {
        const currentProgress = videoElement.currentTime / videoElement.duration;

        // Update the progress for the current video
        this.videoProgress[this.currentVideoIndex] = currentProgress;

        // Recalculate the overall progress
        this.calculateOverallProgress();
    }
  }
  
  calculateOverallProgress(): void {
    let totalWatchedDuration = 0;
    if (this.lesson && this.lesson.lesson_videos) {
      for (let i = 0; i < this.lesson.lesson_videos.length; i++) {
        const videoDuration = this.lesson.lesson_videos[i].duration || 0;
        const watchedDuration = (this.videoProgress[i] || 0) * videoDuration;
        totalWatchedDuration += watchedDuration;
      }
      this.progress = (totalWatchedDuration / this.totalVideoDuration) * 100;
    }
  }

  increaseQuantity(): void {
    this.quantity++;
  }

  decreaseQuantity(): void {
    if (this.quantity > 1) {
      this.quantity--;
    }
  }

  getTotalPrice(): number {
    return this.lesson ? this.lesson.price * this.quantity : 0;
  }

  buyNow(): void {
    if (!this.isPressedAddToCart) {
      this.addToCart();
    }
    this.router.navigate(['/progresses']);
  }           

  startGame(): void {
    this.router.navigate([`/gamesocers/${this.productId}`]);
  }

  toggleFavorite(): void {
    if (this.lesson) {
      // Toggle the favorite status
      const currentFavorite = this.cartService.getCart().get(this.lesson.id)?.favorite || false;
      this.cartService.addToCart(this.lesson.id, this.quantity, !currentFavorite);
      this.isFavorite = !currentFavorite; // Update local state
    } else {
      console.error('Lesson is null.');
    }
  }
 
}
