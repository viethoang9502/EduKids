import { NgModule, importProvidersFrom } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CommonModule } from '@angular/common';
import { HomeComponent } from './components/home/home.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { DetailProductComponent } from './components/detail-lesson/detail-lesson.component';
import { ProgressComponent } from './components/progress/progress.component';
import { ProgressDetailComponent } from './components/detail-progress/progress.detail.component';
import { UserProfileComponent } from './components/user-profile/user.profile.component';
import { AdminComponent } from './components/admin/admin.component';
import { AuthGuardFn } from './guards/auth.guard';
import { AdminGuardFn } from './guards/admin.guard';
// import { GameSoccerComponent } from './components/game-soccer/game-soccer.component';
//import { ProgressAdminComponent } from './components/admin/order/order.admin.component';

export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'login', component: LoginComponent },  
  { path: 'register', component: RegisterComponent },
  { path: 'lessons/:id', component: DetailProductComponent },  
  { path: 'progresses', component: ProgressComponent,canActivate:[AuthGuardFn] },
  { path: 'user-profile', component: UserProfileComponent, canActivate:[AuthGuardFn] },
  { path: 'progresses/:id', component: ProgressDetailComponent },
  // { path: 'gamesocers/:id', component: GameSoccerComponent },
  //Admin   
  { 
    path: 'admin', 
    component: AdminComponent, 
    canActivate:[AdminGuardFn] 
  },      
];
