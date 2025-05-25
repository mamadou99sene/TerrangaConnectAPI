import { Component, OnInit } from '@angular/core';
import { DeclarationService } from '../../services/declaration.service';
import { CommonModule } from '@angular/common';
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

interface DeclarationStats {
  urgencesSociales: number;
  demandesSang: number;
  evenements: number;
  total: number;
}

interface InterventionStats {
  especeCount: number;
  materielCount: number;
  sangCount: number;
  month: string;
}

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule ],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css',
})
export class DashboardComponent implements OnInit {
   declarationStats: DeclarationStats = {
    urgencesSociales: 0,
    demandesSang: 0,
    evenements: 0,
    total: 0
  };

  interventionData: InterventionStats[] = [
    { month: 'Jan', especeCount: 15, materielCount: 5, sangCount: 20 },
    { month: 'Fév', especeCount: 52, materielCount: 35, sangCount: 28 },
    { month: 'Mar', especeCount: 48, materielCount: 40, sangCount: 32 },
    { month: 'Avr', especeCount: 55, materielCount: 38, sangCount: 35 },
    { month: 'Mai', especeCount: 10, materielCount: 5, sangCount: 21 },
  ];

  constructor(private declarationService: DeclarationService) {}

  ngOnInit(): void {
    this.loadDeclarationData();
    setTimeout(() => {
      this.createDeclarationTypeChart();
      this.createInterventionTrendChart();
      this.createValidationStatusChart();
    }, 500);
  }

  loadDeclarationData(): void {
    this.declarationService.getAdminAllUrgencesSociale().subscribe({
      next: urgences => {
        this.declarationStats.urgencesSociales = urgences.length;
        this.updateTotalDeclarations();
      },
      error(err) {
        console.log(err);
      },
    });

    this.declarationService.getAdminAllDemandeDonSang().subscribe({
      next: demandes => {
        this.declarationStats.demandesSang = demandes.length;
        this.updateTotalDeclarations();
      }, 
      error(err) {
        console.log(err);
      },
    });

    this.declarationService.getAdminAllEvenement().subscribe({
      next: events => {
        this.declarationStats.evenements = events.length;
        this.updateTotalDeclarations();
      }, 
      error(err) {
        console.log(err);
      },
    });
  }

  updateTotalDeclarations(): void {
    this.declarationStats.total = 
      this.declarationStats.urgencesSociales + 
      this.declarationStats.demandesSang + 
      this.declarationStats.evenements;
  }

  createDeclarationTypeChart(): void {
    const ctx = document.getElementById('declarationTypeChart') as HTMLCanvasElement;
    new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: ['Urgences Sociales', 'Demandes de Sang', 'Événements'],
        datasets: [{
          data: [
            this.declarationStats.urgencesSociales,
            this.declarationStats.demandesSang,
            this.declarationStats.evenements
          ],
          backgroundColor: [
            'rgba(255, 99, 132, 0.8)',
            'rgba(54, 162, 235, 0.8)',
            'rgba(255, 206, 86, 0.8)'
          ],
          borderWidth: 1
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          title: {
            display: true,
            text: 'Répartition des Types de Déclarations',
            font: { size: 16 }
          },
          legend: {
            position: 'bottom'
          }
        }
      }
    });
  }

  createInterventionTrendChart(): void {
    const ctx = document.getElementById('interventionTrendChart') as HTMLCanvasElement;
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: this.interventionData.map(data => data.month),
        datasets: [
          {
            label: 'Dons en Espèces',
            data: this.interventionData.map(data => data.especeCount),
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.3
          },
          {
            label: 'Dons Matériels',
            data: this.interventionData.map(data => data.materielCount),
            borderColor: 'rgb(153, 102, 255)',
            tension: 0.3
          },
          {
            label: 'Dons de Sang',
            data: this.interventionData.map(data => data.sangCount),
            borderColor: 'rgb(255, 99, 132)',
            tension: 0.3
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          title: {
            display: true,
            text: 'Évolution des Types d\'Interventions',
            font: { size: 16 }
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            title: {
              display: true,
              text: 'Nombre d\'interventions'
            }
          }
        }
      }
    });
  }

  createValidationStatusChart(): void {
    const ctx = document.getElementById('validationStatusChart') as HTMLCanvasElement;
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Urgences Sociales', 'Demandes de Sang', 'Événements'],
        datasets: [
          {
            label: 'Validées',
            data: [35, 28, 42],
            backgroundColor: 'rgba(75, 192, 192, 0.7)'
          },
          {
            label: 'En Attente',
            data: [15, 12, 8],
            backgroundColor: 'rgba(255, 206, 86, 0.7)'
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          title: {
            display: true,
            text: 'Statut des Validations par Type',
            font: { size: 16 }
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            title: {
              display: true,
              text: 'Nombre de déclarations'
            }
          }
        }
      }
    });
  }
}