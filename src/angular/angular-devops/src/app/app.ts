import { Component, signal } from '@angular/core';

@Component({
  selector: 'app-root',
  imports: [],
  templateUrl: './app.html',
  styleUrl: './app.scss'
})
export class App {
  protected readonly title = signal('angular-devops');

  count = 0;

  increment() {
    this.count++;
    console.log(`Button clicked ${this.count} times`);
  }
}
