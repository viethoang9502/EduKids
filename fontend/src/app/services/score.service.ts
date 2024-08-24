// score.service.ts
import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ScoreService {
  private scoreSubject = new BehaviorSubject<number>(0);
  score$ = this.scoreSubject.asObservable();

  setScore(score: number): void {
    this.scoreSubject.next(score);
  }

  getScore(): number {
    return this.scoreSubject.getValue();
  }
}
