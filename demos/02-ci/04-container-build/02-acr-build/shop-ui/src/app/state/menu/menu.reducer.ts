import { createReducer, on } from '@ngrx/store';
import { SideNavActions } from './menu.actions';

export interface MenuState {
  sideNavEnabled: boolean;
  sideNavVisible: boolean;
  sideNavPosition: string;
}

const initialState: MenuState = {
  sideNavEnabled: true,
  sideNavVisible: true,
  sideNavPosition: 'side',
};

export const reducer = createReducer(
  initialState,
  on(SideNavActions.togglesidenav, (state) => ({
    ...state,
    sideNavVisible: !state.sideNavVisible,
  })),
  on(SideNavActions.setsidenavenabled, (state, action) => ({
    ...state,
    sideNavEnabled: action.enabled,
    sideNavVisible: action.enabled,
  })),
  on(SideNavActions.setsidenavvisible, (state) => ({
    ...state,
    sideNavVisible: !state.sideNavVisible,
  })),
  on(SideNavActions.setsidenavposition, (state, action) => ({
    ...state,
    sideNavPosition: action.position,
  }))
);
