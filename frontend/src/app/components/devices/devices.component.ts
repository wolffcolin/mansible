<<<<<<< HEAD
import { Component } from '@angular/core';

@Component({
  selector: 'app-devices',
  imports: [],
  templateUrl: './devices.component.html',
  styleUrl: './devices.component.scss'
})
export class DevicesComponent {

}
=======
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
>>>>>>> d60523741de4dc16fe3d993bece38fd30540703a
