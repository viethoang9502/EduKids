import { AdminComponent } from "./admin.component";
import { ProgressAdminComponent } from "./progress/progress.admin.component";
import { DetailProgressAdminComponent } from "./detail-progress/detail.progress.admin.component";
import { Route, Router,Routes } from "@angular/router";
import { NgModule } from "@angular/core";
import { RouterModule } from "@angular/router";
import { LessonAdminComponent } from "./lesson/lesson.admin.component";
import { CategoryAdminComponent } from "./category/category.admin.component";
import { UpdateLessonAdminComponent } from "./lesson/update/update.product.admin.component";
import { InsertLessonAdminComponent } from "./lesson/insert/insert.lesson.admin.component";
import { InsertCategoryAdminComponent } from "./category/insert/insert.category.admin.component";
import { UpdateCategoryAdminComponent } from "./category/update/update.category.admin.component";
import { UserAdminComponent } from "./user/user.admin.component";
// import { GameSoccerComponent } from "../game-soccer/game-soccer.component";

export const adminRoutes: Routes = [
    {
        path: 'admin',
        component: AdminComponent,
        children: [
            {
                path: 'progresses',
                component: ProgressAdminComponent
            },            
            {
                path: 'lessons',
                component: LessonAdminComponent
            },
            // {
            //     path: 'gamesocers',
            //     component: GameSoccerComponent
            // },
            {
                path: 'categories',
                component: CategoryAdminComponent
            },
            //sub path
            {
                path: 'progress/:id',
                component: DetailProgressAdminComponent
            },
            {
                path: 'lessons/update/:id',
                component: UpdateLessonAdminComponent
            },
            {
                path: 'lessons/insert',
                component: InsertLessonAdminComponent
            },
            //categories            
            {
                path: 'categories/update/:id',
                component: UpdateCategoryAdminComponent
            },
            {
                path: 'categories/insert',
                component: InsertCategoryAdminComponent
            },
            {
                path: 'users',
                component: UserAdminComponent
            },  
        ]
    }
];
/*
@NgModule({
    imports: [
        RouterModule.forChild(routes)
    ],
    exports: [RouterModule]
})
export class AdminRoutingModule { }
*/
