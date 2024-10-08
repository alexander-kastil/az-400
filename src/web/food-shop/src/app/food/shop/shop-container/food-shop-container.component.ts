import { AsyncPipe, NgFor } from '@angular/common';
import { Component, DestroyRef, OnInit, inject } from '@angular/core';
import { takeUntilDestroyed } from '@angular/core/rxjs-interop';
import {
  Subscription,
  combineLatestWith,
  map,
  skip,
  startWith
} from 'rxjs';
import { environment } from '../../../../environments/environment';
import { CartFacade } from '../../state/cart/cart.facade';
import { FoodEntityService } from '../../state/catalog/food-entity.service';
import { CartItem } from '../cart-item.model';
import { ShopItemComponent } from '../shop-item/shop-item.component';
import { AILoggerService } from 'src/app/logger/ai-logger.service';

@Component({
  selector: 'app-food-shop-container',
  templateUrl: './food-shop-container.component.html',
  styleUrls: ['./food-shop-container.component.scss'],
  standalone: true,
  imports: [
    NgFor,
    ShopItemComponent,
    AsyncPipe,
  ],
})
export class FoodShopContainerComponent implements OnInit {
  destroyRef = inject(DestroyRef);
  foodES = inject(FoodEntityService);
  cart = inject(CartFacade);
  food = this.foodES.entities$;
  cartItems = this.cart.getItems();
  cartSubs: Subscription | null = null;
  persistCart = environment.features.persistCart;
  logger = inject(AILoggerService);

  constructor() {
    if (this.persistCart) {
      this.ensureStorageFeature();
    }
  }

  ngOnInit(): void {
    this.foodES.loaded$
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe((loaded) => {
        if (!loaded) {
          this.foodES.getAll();
        }
      });
  }

  getItemsInCart(id: number) {
    return this.cartItems.pipe(
      map((items) => {
        let ct = items.find((i) => i.id === id);
        return ct ? ct.quantity : 0;
      })
    );
  }

  updateCart(f: CartItem) {
    this.cart.set(f);
    this.logger.logEvent('Cart updated', f);
  }

  ensureStorageFeature() {
    this.cartSubs = this.cart
      .getItems()
      .pipe(
        takeUntilDestroyed(this.destroyRef),
        skip(1),
        combineLatestWith(this.cart.getPersist().pipe(startWith(true))),
        map(([items, persist]) => {
          if (persist) {
            this.cart.saveToStorage(items);
          }
        }),
      )
      .subscribe();

    this.cart
      .getPersist()
      .pipe(takeUntilDestroyed(this.destroyRef))
      .subscribe((persist) => {
        if (persist) {
          this.cart.loadFromStorage();
        }
      });
  }
}
