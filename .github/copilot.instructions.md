# Code Instructions

## Angular

When implementing new artifacts always prefer functional implementations over class-based implementations.

Always use standalone components. In the CLI do not use --standalone=true as this is the default for Angular 19+ Example:

```typescript
@Component({
  selector: 'app-about',
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.scss']
})
export class AboutComponent { }
```

Do not bootstrap the app using AppModule. Always use `app.config.ts` to configure the application and register providers. Example:

```typescript
export const appConfig: ApplicationConfig = {
    providers: [
        provideZoneChangeDetection({ eventCoalescing: true }),
        provideRouter(routes, withComponentInputBinding()),
        provideHttpClient(),
    ],
};
```

When implementing models use camelCase for the properties and property initialization. For optional properties, use a question mark (`?`) to indicate that they are not required and specify the type. Example:

```typescript
export class User {
  id = '';  // GUID string
  userName = '';
  email = '';
  password = '';
  birthDate? : Date;
}
```

Do not use directives like ngModel, ngFor, ngIf, etc. in the HTML template. Instead, use the Angular Control Flow. Example:

```typescript
@if (store.isPending()) {
    <mat-progress-bar mode="indeterminate"></mat-progress-bar>
}
```

Always check if the artifacts that you are using is imported in the current file. If not, import it. Example:

```typescript
import { inject, Injectable } from '@angular/core';
```

Always use the Angular inject function instead of the constructor to inject services and other artifacts into components. Example:

```typescript
 http = inject(HttpClient);
```

When implementing Services always use the url properties in the angular environment files

Example:

```typescript
getUsers() {
    return this.http.get<User[]>(environment.api + 'users');
}
```

When loading data in a component always use a service. Convert the Observable result from the get-method to a Signal using the `toSignal` function from the `@angular/core/rxjs-interop` package und use a declarative approach. Provide an intial value to the `toSignal` function.

Example:

```typescript
export class UserComponent {
  userService = inject(UserService);
  users = toSignal(this.userService.getUsers(), { initialValue: [] });
```

## .NET

Using should always be on top followed by any namespaces declaration.

When modifying appsettings.json always check if there are corresponding changes in the `appsettings.Development.json` file. If not, add them. If there is a strong typed configuration class, always add the corresponding properties to the `appsettings.Development.json` file.

Use explicit controllers in .NET. Do not use the Minimal API approach. Instead create explicit Controller files

For dependency injection use the following code snippet as a reference:

```csharp
public class UserController(FitnessDBContext dbContext) : ControllerBase
{

}
```
