import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-devices',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './devices.component.html',
  styleUrl: './devices.component.scss'
})

export class DevicesComponent {
  columns = [
    ['Box 1', 'Box 2'],
    ['Box 3'],
    ['Box 4', 'Box 5']
  ];
}
