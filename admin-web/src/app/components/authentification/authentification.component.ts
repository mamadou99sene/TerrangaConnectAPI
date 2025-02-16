import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthentificationService } from '../../services/authentification.service';

@Component({
  selector: 'app-authentification',
  imports: [ReactiveFormsModule],
  templateUrl: './authentification.component.html',
  styleUrl: './authentification.component.css'
})
export class AuthentificationComponent implements OnInit{
  loginForm: FormGroup;
  showPassword = false;
  isLoading = false;

  constructor(
    private fb: FormBuilder,
    private authService: AuthentificationService,
    private router: Router
  ) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      remember: [false]
    });
  }

  ngOnInit(): void {}

  isFieldInvalid(fieldName: string): boolean {
    const field = this.loginForm.get(fieldName);
    return field ? (field.invalid && (field.dirty || field.touched)) : false;
  }

  togglePasswordVisibility(): void {
    this.showPassword = !this.showPassword;
  }

  forgotPassword(event: Event): void {
    event.preventDefault();
    // Naviguer vers la page de réinitialisation du mot de passe
    this.router.navigate(['/reset-password']);
  }

  async onSubmit(): Promise<void> {
    if (this.loginForm.valid) {
      this.isLoading = true;
      try {
        const { email, password, remember } = this.loginForm.value;
        //await this.authService.login({email:email, password:password});
        this.router.navigate(['/dashboard']);
      } catch (error) {
        console.error('Erreur de connexion:', error);
        // Gérer l'erreur (afficher un message, etc.)
      } finally {
        this.isLoading = false;
      }
    } else {
      Object.keys(this.loginForm.controls).forEach(key => {
        const control = this.loginForm.get(key);
        if (control) {
          control.markAsTouched();
        }
      });
    }
  }
}
