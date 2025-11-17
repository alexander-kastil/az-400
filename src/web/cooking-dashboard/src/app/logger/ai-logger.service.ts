import { Injectable, OnDestroy } from '@angular/core';
import { ApplicationInsights } from '@microsoft/applicationinsights-web';
import { Subscription } from 'rxjs';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class AILoggerService implements OnDestroy {
  private routerSubscription!: Subscription;
  private static logger: ApplicationInsights;

  constructor() {
    AILoggerService.initAppInsights();
  }

  static getInstance(): ApplicationInsights {
    this.initAppInsights();
    return this.logger;
  }

  static initAppInsights() {
    if (environment.loggingEnabled) {
      this.logger = new ApplicationInsights({
        config: {
          instrumentationKey: environment.azure.applicationInsights,
          enableAutoRouteTracking: true,
        },
      });
      this.logger.loadAppInsights();
      this.logger.addTelemetryInitializer((envelope) => {
        let itemTags = envelope.tags;
        if (itemTags) {
          itemTags = itemTags || [];
          itemTags['ai.cloud.role'] = environment.title;
        }
        this.logger.trackEvent({ name: 'app instance started' });
      }
      );
    }
  }

  ngOnDestroy(): void {
    this.routerSubscription.unsubscribe();
  }

  logEvent(name: string, properties?: { [key: string]: any }, writeToConsole = false) {
    if (environment.loggingEnabled) {
      AILoggerService.logger.trackEvent({ name, properties });
    }
    if (writeToConsole) {
      console.log(name, properties);
    }
  }
}
