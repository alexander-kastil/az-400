import { TestBed } from '@angular/core/testing';
import { App } from './app';

describe('App Component', () => {

  it('renders heading text', async () => {
    await TestBed.configureTestingModule({ imports: [App] });
    const fixture = TestBed.createComponent(App);
    fixture.detectChanges();

    const h1: HTMLHeadingElement | null = fixture.nativeElement.querySelector('h1');
    expect(h1).toBeTruthy();
    expect(h1!.textContent).toBe('It is all about food');
  });

  it('renders image with correct src', async () => {
    await TestBed.configureTestingModule({ imports: [App] });
    const fixture = TestBed.createComponent(App);
    fixture.detectChanges();

    const img: HTMLImageElement | null = fixture.nativeElement.querySelector('img');
    expect(img).toBeTruthy();
    // In jsdom, getAttribute('src') reflects the literal template value
    expect(img!.getAttribute('src')).toBe('food.png');
  });

  it('increments count on button click', async () => {
    await TestBed.configureTestingModule({ imports: [App] });
    const fixture = TestBed.createComponent(App);
    fixture.detectChanges();

    const button: HTMLButtonElement | null = fixture.nativeElement.querySelector('button');
    const p: HTMLParagraphElement | null = fixture.nativeElement.querySelector('p');

    expect(button).toBeTruthy();
    expect(p).toBeTruthy();
    expect(p!.textContent).toContain('Button clicked 0 times');

    // Simulate user click
    button!.click();
    // Manually trigger change detection to update the view
    fixture.detectChanges();

    expect(p!.textContent).toContain('Button clicked 1 times');
  });
});
