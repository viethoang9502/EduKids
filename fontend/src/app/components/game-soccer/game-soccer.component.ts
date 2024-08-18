// import { Component, OnInit, AfterViewInit, ViewChild, ElementRef } from '@angular/core';
// import { ActivatedRoute } from '@angular/router';
// import { LessonService } from '../../services/lesson.service';
// import { HeaderComponent } from '../header/header.component';
// import { FooterComponent } from '../footer/footer.component';
// import { CommonModule } from '@angular/common';

// @Component({
//   selector: 'app-game-soccer',
//   templateUrl: './game-soccer.component.html',
//   styleUrls: ['./game-soccer.component.scss'],
//   standalone: true,
//   imports: [
//     FooterComponent,
//     HeaderComponent,
//     CommonModule
//   ]
// })
// export class GameSoccerComponent implements OnInit, AfterViewInit  {

//   @ViewChild('soccerCanvas') soccerCanvas!: ElementRef<HTMLCanvasElement>;
//   private ctx!: CanvasRenderingContext2D;
  
//   private backgroundImage = new Image();
//   private playerImage = new Image();
//   private ballImage = new Image();
//   private goalKeeperImage = new Image();
  
//   options: string[] = []; // Danh sách các lựa chọn
//   question: string = ''; // Câu hỏi
//   correctOption: number = 0; // Index của đáp án đúng
//   lessonId: number = 0;

//   constructor(
//     private lessonService: LessonService,
//     private route: ActivatedRoute
//   ) {}

//   ngOnInit(): void {
//     this.lessonId = +this.route.snapshot.paramMap.get('id')!;
//     this.lessonService.getDetailProduct(this.lessonId).subscribe({
//       next: (response) => {
//         if (response.data && response.data.lesson_games.length > 0) {
//           const gameData = response.data.lesson_games[0].game_data;
//           try {
//             const parsedData = JSON.parse(gameData);
//             this.correctOption = parsedData.correctOption;
//             this.options = parsedData.options; // Cập nhật danh sách options từ API
//             this.question = parsedData.question; // Cập nhật câu hỏi từ API
//           } catch (error) {
//             console.error('Error parsing game_data:', error);
//           }
//         }
//       },
//       error: (error) => {
//         console.error('Error fetching product details:', error);
//       }
//     });
//   }

//   ngAfterViewInit(): void {
//     this.ctx = this.soccerCanvas.nativeElement.getContext('2d')!;

//     // Load images and draw the initial scene once all images are loaded
//     this.loadImages().then(() => {
//       this.drawScene();
//     });
//   }

//   loadImages(): Promise<void> {
//     return new Promise((resolve) => {
//       let loadedImages = 0;
//       const totalImages = 4;

//       const checkLoaded = () => {
//         loadedImages++;
//         if (loadedImages === totalImages) {
//           resolve();
//         }
//       };

//       this.backgroundImage.src = 'assets/images/goal.png';
//       this.backgroundImage.onload = checkLoaded;

//       this.playerImage.src = 'assets/images/player.png';
//       this.playerImage.onload = checkLoaded;

//       this.ballImage.src = 'assets/images/ball.png';
//       this.ballImage.onload = checkLoaded;

//       this.goalKeeperImage.src = 'assets/images/goalkeeper.png';
//       this.goalKeeperImage.onload = checkLoaded;
//     });
//   }

//   drawScene(withBall: boolean = true, withGoalKeeper: boolean = true): void {
//     // Vẽ nền
//     this.ctx.drawImage(this.backgroundImage, 0, 0, 1200, 900);

//     // Vẽ khung thành và thủ môn nếu có
//     if (withGoalKeeper) {
//       this.ctx.drawImage(this.goalKeeperImage, 370, 350, 500, 330);
//     }

//     // Vẽ cầu thủ
//     this.ctx.drawImage(this.playerImage, 470, 620, 170, 340);

//     // Chỉ vẽ bóng nếu được yêu cầu
//     if (withBall) {
//         this.ctx.drawImage(this.ballImage, 600, 800, 70, 70);
//     }
// }

// shoot(optionIndex: number): void {
//   console.log('Selected Option:', optionIndex); // Kiểm tra giá trị người dùng chọn
//   console.log('Correct Option:', this.correctOption); // Kiểm tra giá trị correctOption

//   if (optionIndex === this.correctOption) {
//       // Nếu người chơi chọn đúng, bóng sẽ bay vào khung thành mà không có thủ môn bay
//       this.animateBall(optionIndex, false); // Thủ môn không bay, bóng bay vào
//   } else {
//       // Nếu người chơi chọn sai, bóng bay ra ngoài và thủ môn bay
//       this.animateGoalKeeperAndBall(optionIndex);
//   }
// }

// animateGoalKeeperAndBall(optionIndex: number): void {
//   let startXGoalkeeper = 370; // Vị trí bắt đầu của thủ môn
//   let startYGoalkeeper = 350;
//   let endXGoalkeeper: number;
//   let endYGoalkeeper: number;

//   let startXBall = 600;
//   let startYBall = 700;
//   let endXBall: number;
//   let endYBall: number;

//   // Xác định vị trí thủ môn sẽ bay đến dựa trên lựa chọn của người dùng
//   switch(optionIndex) {
//       case 1: // Top Left
//           endXGoalkeeper = 100;
//           endYGoalkeeper = 200;
//           endXBall = 200;
//           endYBall = 300;
//           break;
//       case 2: // Top Right
//           endXGoalkeeper = 600;
//           endYGoalkeeper = 200;
//           endXBall = 900;
//           endYBall = 300;
//           break;
//       case 3: // Bottom Left
//           endXGoalkeeper = 100;
//           endYGoalkeeper = 400;
//           endXBall = 200;
//           endYBall = 500;
//           break;
//       case 4: // Bottom Right
//           endXGoalkeeper = 600;
//           endYGoalkeeper = 400;
//           endXBall = 900;
//           endYBall = 500;
//           break;
//       default:
//           endXGoalkeeper = startXGoalkeeper; // Nếu không có lựa chọn nào, thủ môn không bay
//           endYGoalkeeper = startYGoalkeeper;
//           endXBall = startXBall; // Nếu không có lựa chọn nào, bóng không bay
//           endYBall = startYBall;
//           break;
//   }

//   const duration = 1000; // Thời gian của hoạt hình
//   const startTime = performance.now(); // Thời điểm bắt đầu hoạt hình

//   const animate = (time: number) => {
//       const elapsedTime = time - startTime;
//       const progress = Math.min(elapsedTime / duration, 1); // Tiến trình của hoạt hình

//       // Tính toán vị trí mới của thủ môn và bóng dựa trên tiến trình
//       const currentXGoalkeeper = startXGoalkeeper + (endXGoalkeeper - startXGoalkeeper) * progress;
//       const currentYGoalkeeper = startYGoalkeeper + (endYGoalkeeper - startYGoalkeeper) * progress;
//       const currentXBall = startXBall + (endXBall - startXBall) * progress;
//       const currentYBall = startYBall + (endYBall - startYBall) * progress;

//       // Xóa toàn bộ canvas trước khi vẽ lại
//       this.ctx.clearRect(0, 0, this.ctx.canvas.width, this.ctx.canvas.height);

//       // Vẽ lại cảnh mà không hiển thị thủ môn và bóng ở vị trí ban đầu
//       this.drawScene(false, false); // Vẽ lại cảnh mà không có bóng và thủ môn

//       // Vẽ thủ môn tại vị trí mới
//       this.ctx.drawImage(this.goalKeeperImage, currentXGoalkeeper, currentYGoalkeeper, 500, 330);

//       // Vẽ quả bóng tại vị trí mới
//       this.ctx.drawImage(this.ballImage, currentXBall, currentYBall, 70, 70);

//       // Tiếp tục hoạt hình nếu chưa hoàn thành
//       if (progress < 1) {
//           requestAnimationFrame(animate);
//       } else {
//           // Hiển thị thông báo kết quả khi hoạt hình kết thúc
//           alert("Missed! Try again!");
//       }
//   };

//   requestAnimationFrame(animate); 
// }

// animateBall(optionIndex: number, goalkeeperShouldMove: boolean): void {
//   let startX = 600;
//   let startY = 700;
//   let endX: number;
//   let endY: number;

//   // Nếu chọn đúng, bóng sẽ sút vào khung thành
//   if (optionIndex === this.correctOption) {
//       switch(optionIndex) {
//           case 1: // Top Left
//               endX = 200;
//               endY = 300;
//               break;
//           case 2: // Top Right
//               endX = 900;
//               endY = 300;
//               break;
//           case 3: // Bottom Left
//               endX = 200;
//               endY = 500;
//               break;
//           case 4: // Bottom Right
//               endX = 900;
//               endY = 500;
//               break;
//           default:
//               return;
//       }
//   } else {
//       // Nếu chọn sai, bóng sẽ sút ra ngoài
//       switch(optionIndex) {
//           case 1: // Top Left (bóng đi ra ngoài bên trái)
//               endX = 100;
//               endY = 100;
//               break;
//           case 2: // Top Right (bóng đi ra ngoài bên phải)
//               endX = 1100;
//               endY = 100;
//               break;
//           case 3: // Bottom Left (bóng đi ra ngoài bên trái)
//               endX = 100;
//               endY = 500;
//               break;
//           case 4: // Bottom Right (bóng đi ra ngoài bên phải)
//               endX = 1100;
//               endY = 500;
//               break;
//           default:
//               return;
//       }
//   }

//   const duration = 1000; // Thời gian của hoạt hình
//   const startTime = performance.now(); // Thời điểm bắt đầu hoạt hình

//   const animate = (time: number) => {
//       const elapsedTime = time - startTime;
//       const progress = Math.min(elapsedTime / duration, 1); // Tiến trình của hoạt hình

//       // Tính toán vị trí mới của quả bóng dựa trên tiến trình
//       const currentX = startX + (endX - startX) * progress;
//       const currentY = startY + (endY - startY) * progress;

//       // Xóa toàn bộ canvas trước khi vẽ lại
//       this.ctx.clearRect(0, 0, this.ctx.canvas.width, this.ctx.canvas.height);

//       // Vẽ lại cảnh mà không hiển thị quả bóng ở vị trí ban đầu
//       this.drawScene(false, true); // Vẽ lại cảnh, với `goalkeeperShouldMove` là true, giữ nguyên thủ môn

//       // Vẽ quả bóng tại vị trí mới
//       this.ctx.drawImage(this.ballImage, currentX, currentY, 70, 70);

//       // Tiếp tục hoạt hình nếu chưa hoàn thành
//       if (progress < 1) {
//           requestAnimationFrame(animate);
//       }  else {
//             // Hiển thị thông báo kết quả khi hoạt hình kết thúc
//             if (optionIndex === this.correctOption) {
//                 alert("Goal! You scored!");
//                 window.location.reload(); // Reload lại trang khi người dùng bấm "OK"
//             } else {
//                 alert("Missed! Try again!");
//                 window.location.reload(); // Reload lại trang khi người dùng bấm "OK"
//             }
//         }
//   };

//     requestAnimationFrame(animate); 
//   }
// }