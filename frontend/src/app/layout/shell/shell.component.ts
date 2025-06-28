import { Component } from '@angular/core';
import { MaterialModule }    from '../../shared/material.module';

@Component({
  selector: 'app-shell',
  imports: [MaterialModule],
  templateUrl: './shell.component.html',
  styleUrl: './shell.component.scss'
})
export class ShellComponent {

}
