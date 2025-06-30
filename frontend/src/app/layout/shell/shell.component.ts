import { Component } from '@angular/core';
import { MaterialModule }    from '../../shared/material.module';
import { Router, RouterOutlet } from '@angular/router';
import { RouterLink } from '@angular/router';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatIconModule } from '@angular/material/icon';
import { MatToolbar, MatToolbarModule } from '@angular/material/toolbar';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-shell',
  imports: [
    MaterialModule,
    MatSidenavModule,
    MatToolbarModule,
    RouterOutlet,
    RouterLink,
    MatIconModule,
    CommonModule
  ],
  templateUrl: './shell.component.html',
  styleUrl: './shell.component.scss'
})
export class ShellComponent {
  drawerOpen = true;

    commands = [
    { text: 'ng build', status: 'success' },
    { text: 'ng test', status: 'error' },
    { text: 'ng lint', status: 'pending' }
  ];

  toggleDrawer() {
    this.drawerOpen = !this.drawerOpen;
  }
}
